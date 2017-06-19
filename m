Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 982BE1FA7B
	for <e@80x24.org>; Mon, 19 Jun 2017 12:08:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752415AbdFSMIj (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Jun 2017 08:08:39 -0400
Received: from avasout08.plus.net ([212.159.14.20]:37857 "EHLO
        avasout08.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751054AbdFSMIi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jun 2017 08:08:38 -0400
Received: from [10.0.2.15] ([143.159.212.80])
        by avasout08 with smtp
        id ac8b1v0041keHif01c8cda; Mon, 19 Jun 2017 13:08:36 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=FLJr/6gs c=1 sm=1 tr=0
 a=n+zECcf3rkBNBoU0FNF4VQ==:117 a=n+zECcf3rkBNBoU0FNF4VQ==:17
 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8 a=EBOSESyhAAAA:8 a=M9-LbYC3As7KQQK61nEA:9
 a=QEXdDO2ut3YA:10 a=6kGIvZw6iX1k4Y-7sg4_:22 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH v2 1/3] config: create a function to format section
 headers
To:     Sahil Dua <sahildua2305@gmail.com>, git@vger.kernel.org
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <0102015ca23f0488-7423db93-b65f-4214-8221-af6a1bb4c2e5-000000@eu-west-1.amazonses.com>
 <1497820591-93434-1-git-send-email-sahildua2305@gmail.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <087c8d6e-10f0-2c1f-1974-a97f4f685288@ramsayjones.plus.com>
Date:   Mon, 19 Jun 2017 13:08:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <1497820591-93434-1-git-send-email-sahildua2305@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 18/06/17 22:16, Sahil Dua wrote:
> Factor out the logic which creates section headers in the config file,
> e.g. the 'branch.foo' key will be turned into '[branch "foo"]'.
> 
> This introduces no function changes, but is needed for a later change
> which adds support for copying branch sections in the config file.
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>

Adding my SOB isn't really appropriate here - I only made a very
very minor contribution. At _most_ you might consider 'Helped-by:',
but even that would probably be overkill. ;-)

Thanks.

ATB,
Ramsay Jones


> Signed-off-by: Sahil Dua <sahildua2305@gmail.com>
> ---
>  config.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/config.c b/config.c
> index 34a139c..32fd3c8 100644
> --- a/config.c
> +++ b/config.c
> @@ -2169,10 +2169,10 @@ static int write_error(const char *filename)
>  	return 4;
>  }
>  
> -static int store_write_section(int fd, const char *key)
> +static struct strbuf store_create_section(const char *key)
>  {
>  	const char *dot;
> -	int i, success;
> +	int i;
>  	struct strbuf sb = STRBUF_INIT;
>  
>  	dot = memchr(key, '.', store.baselen);
> @@ -2188,6 +2188,15 @@ static int store_write_section(int fd, const char *key)
>  		strbuf_addf(&sb, "[%.*s]\n", store.baselen, key);
>  	}
>  
> +	return sb;
> +}
> +
> +static int store_write_section(int fd, const char *key)
> +{
> +	int success;
> +
> +	struct strbuf sb = store_create_section(key);
> +
>  	success = write_in_full(fd, sb.buf, sb.len) == sb.len;
>  	strbuf_release(&sb);
>  
> 
