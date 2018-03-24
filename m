Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B04C51F404
	for <e@80x24.org>; Sat, 24 Mar 2018 15:14:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752120AbeCXPOH (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Mar 2018 11:14:07 -0400
Received: from avasout01.plus.net ([84.93.230.227]:55510 "EHLO
        avasout01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752048AbeCXPOG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Mar 2018 11:14:06 -0400
Received: from [10.0.2.15] ([80.189.70.162])
        by smtp with ESMTPA
        id zkrrehaV9MLyGzkrse4Fs6; Sat, 24 Mar 2018 15:14:05 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=HInt6Llv c=1 sm=1 tr=0
 a=zzlqjQC3YyNvDZl/Gy+4mg==:117 a=zzlqjQC3YyNvDZl/Gy+4mg==:17
 a=IkcTkHD0fZMA:10 a=sUX920SBAAAA:8 a=ymOEfXBQXJyLRc08_mMA:9 a=QEXdDO2ut3YA:10
 a=egVJUTT-lD9PU5ZP4Sin:22
X-AUTH: ramsayjones@:2500
Subject: Re: [RFC PATCH 1/1] json-writer: incorrect format specifier
To:     Wink Saville <wink@saville.com>, git@vger.kernel.org
Cc:     gitster@pobox.com, jeffhost@microsoft.com
References: <cover.1521868951.git.wink@saville.com>
 <140b7646e7efa4175f9d82e6eb2909f2f94771fe.1521868951.git.wink@saville.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <4f4221d9-2ad9-2282-d26f-412ba0bfd719@ramsayjones.plus.com>
Date:   Sat, 24 Mar 2018 15:14:03 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <140b7646e7efa4175f9d82e6eb2909f2f94771fe.1521868951.git.wink@saville.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfIG93psfYsMS4uxmSpEmIDYxvfRyX6MajXBqh7IX1j6NdnhVnQ3xIauU+HfczBaZlwnK5ixqmK5BtKsyP9Jmk4HtwKxfFITyKkaDQ506jbEoFLrFOU+W
 VCn6cFfhKw13/ByKMax7brLtzypydI8ZDglKUnb880MwpOBy/IlvBcET
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 24/03/18 05:37, Wink Saville wrote:
> In routines jw_object_uint64 and jw_object_double strbuf_addf is
> invoked with strbuf_addf(&jw->json, ":%"PRIuMAX, value) where value
> is a uint64_t. This causes a compile error on OSX.
> 
> The correct format specifier is PRIu64 instead of PRIuMax.
> 
> Signed-off-by: Wink Saville <wink@saville.com>
> ---
>  json-writer.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/json-writer.c b/json-writer.c
> index 89a6abb57..04045448a 100644
> --- a/json-writer.c
> +++ b/json-writer.c
> @@ -120,7 +120,7 @@ void jw_object_uint64(struct json_writer *jw, const char *key, uint64_t value)
>  	maybe_add_comma(jw);
>  
>  	append_quoted_string(&jw->json, key);
> -	strbuf_addf(&jw->json, ":%"PRIuMAX, value);
> +	strbuf_addf(&jw->json, ":%"PRIu64, value);

In this code-base, that would normally be written as:

	strbuf_addf(&jw->json, ":%"PRIuMAX, (uintmax_t) value);

ATB,
Ramsay Jones
