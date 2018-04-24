Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 973C51F404
	for <e@80x24.org>; Tue, 24 Apr 2018 07:53:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755997AbeDXHxk (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Apr 2018 03:53:40 -0400
Received: from zucker2.schokokeks.org ([178.63.68.90]:58229 "EHLO
        zucker2.schokokeks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755504AbeDXHxj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Apr 2018 03:53:39 -0400
Received: from localhost (localhost [::1])
  (AUTH: PLAIN simon@ruderich.org, TLS: TLSv1/SSLv3,256bits,ECDHE-RSA-AES256-GCM-SHA384)
  by zucker.schokokeks.org with ESMTPSA; Tue, 24 Apr 2018 09:54:05 +0200
  id 000000000000009B.000000005ADEE29D.00001C2F
Date:   Tue, 24 Apr 2018 09:53:37 +0200
From:   Simon Ruderich <simon@ruderich.org>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 23/41] upload-pack: replace use of several hard-coded
 constants
Message-ID: <20180424075337.GA24895@ruderich.org>
References: <20180423233951.276447-1-sandals@crustytoothpaste.net>
 <20180423233951.276447-24-sandals@crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <20180423233951.276447-24-sandals@crustytoothpaste.net>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 23, 2018 at 11:39:33PM +0000, brian m. carlson wrote:
> [snip]
>
> diff --git a/upload-pack.c b/upload-pack.c
> index 4a82602be5..0858527c5b 100644
> --- a/upload-pack.c
> +++ b/upload-pack.c
> @@ -450,7 +450,7 @@ static int get_common_commits(void)
>  				break;
>  			default:
>  				got_common = 1;
> -				memcpy(last_hex, oid_to_hex(&oid), 41);
> +				oid_to_hex_r(last_hex, &oid);
>  				if (multi_ack == 2)
>  					packet_write_fmt(1, "ACK %s common\n", last_hex);
>  				else if (multi_ack)
> @@ -492,7 +492,7 @@ static int do_reachable_revlist(struct child_process *cmd,
>  		"rev-list", "--stdin", NULL,
>  	};
>  	struct object *o;
> -	char namebuf[42]; /* ^ + SHA-1 + LF */
> +	char namebuf[GIT_MAX_HEXSZ + 2]; /* ^ + SHA-1 + LF */

I think this comment should be "^ + hash as hex + LF".

> @@ -561,15 +561,17 @@ static int get_reachable_list(struct object_array *src,
>  	struct child_process cmd = CHILD_PROCESS_INIT;
>  	int i;
>  	struct object *o;
> -	char namebuf[42]; /* ^ + SHA-1 + LF */
> +	char namebuf[GIT_MAX_HEXSZ + 2]; /* ^ + SHA-1 + LF */
> +	const unsigned hexsz = the_hash_algo->hexsz;

Dito.

Regards
Simon
-- 
+ privacy is necessary
+ using gnupg http://gnupg.org
+ public key id: 0x92FEFDB7E44C32F9
