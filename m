Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 85AE01F437
	for <e@80x24.org>; Tue, 24 Jan 2017 20:26:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750828AbdAXU0o (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jan 2017 15:26:44 -0500
Received: from avasout06.plus.net ([212.159.14.18]:40704 "EHLO
        avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750787AbdAXU0n (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jan 2017 15:26:43 -0500
Received: from [10.0.2.15] ([143.159.212.40])
        by avasout06 with smtp
        id cLSg1u0030srQBz01LShq1; Tue, 24 Jan 2017 20:26:41 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=QoEu5R6d c=1 sm=1 tr=0
 a=8Z0saNXTz8GoXi/9Q5ysMA==:117 a=8Z0saNXTz8GoXi/9Q5ysMA==:17
 a=IkcTkHD0fZMA:10 a=PKzvZo6CAAAA:8 a=72HtC5_LVY3Sv9GOsbwA:9 a=QEXdDO2ut3YA:10
 a=q92HNjYiIAC_jH7JDaYf:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH 08/12] add oidset API
To:     Jeff King <peff@peff.net>, git@vger.kernel.org
References: <20170124003729.j4ygjcgypdq7hceg@sigill.intra.peff.net>
 <20170124004647.3o26ionfq3td2irf@sigill.intra.peff.net>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <944ea1f8-8f9c-cc17-02a5-a73cb6565b45@ramsayjones.plus.com>
Date:   Tue, 24 Jan 2017 20:26:40 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <20170124004647.3o26ionfq3td2irf@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 24/01/17 00:46, Jeff King wrote:
> This is similar to many of our uses of sha1-array, but it
> overcomes one limitation of a sha1-array: when you are
> de-duplicating a large input with relatively few unique
> entries, sha1-array uses 20 bytes per non-unique entry.
> Whereas this set will use memory linear in the number of
> unique entries (albeit a few more than 20 bytes due to
> hashmap overhead).
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> This may be overkill. You can get roughly the same thing by making
> actual object structs via lookup_unknown_object(). But see the next
> patch for some comments on that.
> 
>  Makefile |  1 +
>  oidset.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
>  oidset.h | 45 +++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 95 insertions(+)
>  create mode 100644 oidset.c
>  create mode 100644 oidset.h
> 
> diff --git a/Makefile b/Makefile
> index 27afd0f37..e41efc2d8 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -774,6 +774,7 @@ LIB_OBJS += notes-cache.o
>  LIB_OBJS += notes-merge.o
>  LIB_OBJS += notes-utils.o
>  LIB_OBJS += object.o
> +LIB_OBJS += oidset.o
>  LIB_OBJS += pack-bitmap.o
>  LIB_OBJS += pack-bitmap-write.o
>  LIB_OBJS += pack-check.o
> diff --git a/oidset.c b/oidset.c
> new file mode 100644
> index 000000000..6094cff8c
> --- /dev/null
> +++ b/oidset.c
> @@ -0,0 +1,49 @@
> +#include "cache.h"
> +#include "oidset.h"
> +
> +struct oidset_entry {
> +	struct hashmap_entry hash;
> +	struct object_id oid;
> +};
> +
> +int oidset_hashcmp(const void *va, const void *vb,

static int oidset_hashcmp( ...

ATB,
Ramsay Jones

