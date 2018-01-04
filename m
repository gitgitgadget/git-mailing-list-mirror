Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2350A1F404
	for <e@80x24.org>; Thu,  4 Jan 2018 19:59:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752271AbeADT7k (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Jan 2018 14:59:40 -0500
Received: from siwi.pair.com ([209.68.5.199]:22953 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750990AbeADT7j (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jan 2018 14:59:39 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id B5CDD844C7;
        Thu,  4 Jan 2018 14:59:38 -0500 (EST)
Received: from [192.168.1.71] (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 37C1E844B0;
        Thu,  4 Jan 2018 14:59:37 -0500 (EST)
Subject: Re: [PATCH 01/40] Add initial external odb support
To:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <20180103163403.11303-1-chriscool@tuxfamily.org>
 <20180103163403.11303-2-chriscool@tuxfamily.org>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <96c60f40-052c-b098-f58f-e39e308694f0@jeffhostetler.com>
Date:   Thu, 4 Jan 2018 14:59:37 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20180103163403.11303-2-chriscool@tuxfamily.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 1/3/2018 11:33 AM, Christian Couder wrote:
> The external-odb.{c,h} files will contain the functions
> that are called by the rest of Git mostly from
> "sha1_file.c" to access the objects managed by the
> external odbs.
> 
> The odb-helper.{c,h} files will contain the functions to
> actually implement communication with either the internal
> functions or the external scripts or processes that will
> manage and provide external git objects.
> 
> For now only infrastructure to create helpers from the
> config and to manage a cache for the 'have' command is
> implemented.
> 
> Helped-by: Jeff King <peff@peff.net>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
[...]
> diff --git a/odb-helper.h b/odb-helper.h
> new file mode 100644
> index 0000000000..9395e606ce
> --- /dev/null
> +++ b/odb-helper.h
> @@ -0,0 +1,24 @@
> +#ifndef ODB_HELPER_H
> +#define ODB_HELPER_H
> +
> +struct odb_helper {
> +	const char *name;
> +	const char *dealer;
> +
> +	struct odb_helper_object {
> +		unsigned char sha1[20];

Should this be "struct object_id" ?

> +		unsigned long size;
> +		enum object_type type;
> +	} *have;
> +	int have_nr;
> +	int have_alloc;
> +	int have_valid;
> +
> +	struct odb_helper *next;
> +};
> +
> +extern struct odb_helper *odb_helper_new(const char *name, int namelen);
> +extern int odb_helper_has_object(struct odb_helper *o,
> +				 const unsigned char *sha1);
> +
> +#endif /* ODB_HELPER_H */

Jeff

