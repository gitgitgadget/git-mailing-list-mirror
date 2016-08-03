Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E4DAD1F40E
	for <e@80x24.org>; Wed,  3 Aug 2016 16:50:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755305AbcHCQuT (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 12:50:19 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54102 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752725AbcHCQuR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2016 12:50:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 07FA32EC37;
	Wed,  3 Aug 2016 12:45:55 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GvmfMLzR0MDg31xHoq7SwJ27mWg=; b=qonWIM
	3RwspJhKfIek93MbUFs9bB/r1SzFRnV0sf06qMlIzoFbLpvnI1HUu/9bikLwqnLc
	bcUpQUKImAWSoLuqSZM7l0krzy4PNV3cAGhE/upJJ7+H6e5vO8lQPbuUspYnS38A
	4k6Adsy10lgF6vAi8VR1vCOBe+iV/FLnk0Oa0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=izHQqEAV8obRiaLtsYcZ9+pw4CSdhhiO
	YqF5/oDKj3iV352w0j3+BW2vBW9Lwai4oAJ8d/pCqUKUegAo67Vv1KsvhsU09BC8
	J9iTRZB/V0hUqy2ZSc4ynbSMAZF7bsr9IWPty0pnIdCY7McGIAlQQwdqwYBFsxkt
	HaytkE+J8cc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 001E02EC36;
	Wed,  3 Aug 2016 12:45:54 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8E8962EC35;
	Wed,  3 Aug 2016 12:45:54 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:	git@vger.kernel.org
Subject: Re: [PATCH] import-tars: support hard links
References: <bb3b91403fae1964aa990fc16fd8a4e5f16885e6.1470230877.git.johannes.schindelin@gmx.de>
Date:	Wed, 03 Aug 2016 09:45:52 -0700
In-Reply-To: <bb3b91403fae1964aa990fc16fd8a4e5f16885e6.1470230877.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Wed, 3 Aug 2016 15:30:20 +0200
	(CEST)")
Message-ID: <xmqqinvhaji7.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BEB781A0-5999-11E6-B99D-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> Previously, we simply treated hard links as if they were plain files
> with size 0, ignoring the link type "1" and hence the link target.

Nicely spotted and explained.

> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> Published-As: https://github.com/dscho/git/releases/tag/import-tars-hardlink-v1

A link to a page that lets you download entire source tarball is not
very useful to most people, except for those who want "this exact
change on top of some unknown base which may or may not have other
things they need", which I think is a minority.

Can you also (or instead) point at a branch/tag that people can do

	git fetch $repo $branch

more easily?

>  contrib/fast-import/import-tars.perl | 31 ++++++++++++++++++++-----------
>  1 file changed, 20 insertions(+), 11 deletions(-)
>
> diff --git a/contrib/fast-import/import-tars.perl b/contrib/fast-import/import-tars.perl
> index 95438e1..d60b431 100755
> --- a/contrib/fast-import/import-tars.perl
> +++ b/contrib/fast-import/import-tars.perl
> @@ -96,18 +96,21 @@ foreach my $tar_file (@ARGV)
>  		$mtime = oct $mtime;
>  		next if $typeflag == 5; # directory
>  
> -		print FI "blob\n", "mark :$next_mark\n";
> -		if ($typeflag == 2) { # symbolic link
> -			print FI "data ", length($linkname), "\n", $linkname;
> -			$mode = 0120000;
> -		} else {
> -			print FI "data $size\n";
> -			while ($size > 0 && read(I, $_, 512) == 512) {
> -				print FI substr($_, 0, $size);
> -				$size -= 512;
> +		if ($typeflag != 1) { # handle hard links later
> +			print FI "blob\n", "mark :$next_mark\n";
> +			if ($typeflag == 2) { # symbolic link
> +				print FI "data ", length($linkname), "\n",
> +					$linkname;
> +				$mode = 0120000;
> +			} else {
> +				print FI "data $size\n";
> +				while ($size > 0 && read(I, $_, 512) == 512) {
> +					print FI substr($_, 0, $size);
> +					$size -= 512;
> +				}
>  			}
> +			print FI "\n";
>  		}
> -		print FI "\n";

The resulting if/else cascade initially looked a bit unnatural
(naively I would have expected that a new "elsif ($typeflag == 1)"
would be inserted before the final "else" currently is).  Because
you have to do avoid giving a new mark to hardlink entries, and that
fact would not change regardless of what values of $typeflag other
than 1 exists in the imported tars, so I think the resulting code
structure makes a lot of sense.  We may want to add more elsif to
notice and ignore/warn/substitute things like CHRTYPE/BLKTYPE by
enhancing the if/else cascade inside the "if ($typeflag != 1)"
introduced by this patch, but the code structure does not have to
change when such an enhancement happens.

Nicely done.

>  		my $path;
>  		if ($prefix) {
> @@ -115,7 +118,13 @@ foreach my $tar_file (@ARGV)
>  		} else {
>  			$path = "$name";
>  		}
> -		$files{$path} = [$next_mark++, $mode];
> +
> +		if ($typeflag == 1) { # hard link
> +			$linkname = "$prefix/$linkname" if $prefix;
> +			$files{$path} = [ $files{$linkname}->[0], $mode ];
> +		} else {
> +			$files{$path} = [$next_mark++, $mode];
> +		}
>  
>  		$author_time = $mtime if $mtime > $author_time;
>  		$path =~ m,^([^/]+)/,;
