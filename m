Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E6FD1F667
	for <e@80x24.org>; Wed, 16 Aug 2017 21:43:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752313AbdHPVnA (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Aug 2017 17:43:00 -0400
Received: from avasout06.plus.net ([212.159.14.18]:50874 "EHLO
        avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752233AbdHPVnA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Aug 2017 17:43:00 -0400
Received: from [10.0.2.15] ([143.159.212.52])
        by avasout06 with smtp
        id xxix1v00118PUFB01xiyUo; Wed, 16 Aug 2017 22:42:58 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=GetnpUfL c=1 sm=1 tr=0
 a=CKmocqUIrzA4K3l9YJ19NQ==:117 a=CKmocqUIrzA4K3l9YJ19NQ==:17
 a=IkcTkHD0fZMA:10 a=FQcsDvbEE3GYX54BhYsA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [Patch size_t V3 13/19] Convert index-pack to size_t
To:     Martin Koegler <martin.koegler@chello.at>, git@vger.kernel.org,
        gitster@pobox.com, Johannes.Schindelin@gmx.de
References: <1502914591-26215-1-git-send-email-martin@mail.zuhause>
 <1502914591-26215-14-git-send-email-martin@mail.zuhause>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <743056f2-da7b-5fe1-f0d7-2ee040479c69@ramsayjones.plus.com>
Date:   Wed, 16 Aug 2017 22:42:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <1502914591-26215-14-git-send-email-martin@mail.zuhause>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 16/08/17 21:16, Martin Koegler wrote:
> From: Martin Koegler <martin.koegler@chello.at>
> 
> Signed-off-by: Martin Koegler <martin.koegler@chello.at>
> ---
>  builtin/index-pack.c | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/builtin/index-pack.c b/builtin/index-pack.c
> index 7f3ccd0..bf2d728 100644
> --- a/builtin/index-pack.c
> +++ b/builtin/index-pack.c
> @@ -435,7 +435,7 @@ static int is_delta_type(enum object_type type)
>  	return (type == OBJ_REF_DELTA || type == OBJ_OFS_DELTA);
>  }
>  
> -static void *unpack_entry_data(off_t offset, unsigned long size,
> +static void *unpack_entry_data(off_t offset, size_t size,
>  			       enum object_type type, unsigned char *sha1)
>  {
>  	static char fixed_buf[8192];
> @@ -444,10 +444,10 @@ static void *unpack_entry_data(off_t offset, unsigned long size,
>  	void *buf;
>  	git_SHA_CTX c;
>  	char hdr[32];
> -	int hdrlen;
> +	size_t hdrlen;
>  
>  	if (!is_delta_type(type)) {
> -		hdrlen = xsnprintf(hdr, sizeof(hdr), "%s %lu", typename(type), size) + 1;
> +		hdrlen = xsnprintf(hdr, sizeof(hdr), "%s %" PRIuMAX, typename(type), (uintmax_t)size) + 1;
>  		git_SHA1_Init(&c);
>  		git_SHA1_Update(&c, hdr, hdrlen);
>  	} else
> @@ -489,7 +489,7 @@ static void *unpack_raw_entry(struct object_entry *obj,
>  			      unsigned char *sha1)
>  {
>  	unsigned char *p;
> -	unsigned long size, c;
> +	size_t size, c;
>  	off_t base_offset;
>  	unsigned shift;
>  	void *data;
> @@ -551,11 +551,11 @@ static void *unpack_raw_entry(struct object_entry *obj,
>  }
>  
>  static void *unpack_data(struct object_entry *obj,
> -			 int (*consume)(const unsigned char *, unsigned long, void *),
> +			 int (*consume)(const unsigned char *, size_t, void *),
>  			 void *cb_data)
>  {
>  	off_t from = obj[0].idx.offset + obj[0].hdr_size;
> -	off_t len = obj[1].idx.offset - from;
> +	size_t len = obj[1].idx.offset - from;

off_t -> size_t.

ATB,
Ramsay Jones

