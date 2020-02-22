Return-Path: <SRS0=hy0J=4K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE522C35671
	for <git@archiver.kernel.org>; Sat, 22 Feb 2020 17:43:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77629206E2
	for <git@archiver.kernel.org>; Sat, 22 Feb 2020 17:43:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="TfpthMm4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbgBVRnO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Feb 2020 12:43:14 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57653 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726198AbgBVRnN (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Feb 2020 12:43:13 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A74D355F81;
        Sat, 22 Feb 2020 12:43:08 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=EfEsbGHdfDsJaQXnAfT3bkDs/as=; b=TfpthM
        m4MR48VLx04INQ8VUySlwpCoZ5O/x710WSSty+XPa/Pwz0QiN5YF1Fwo0afJe57A
        rESfr6AiqjxNtC28B1ZtPFy6tvFH7dI2SzkDQLa1BDwdKPZS2rHpit/uvZc7+xCS
        DaOiAIACfk/GO23F03GAQmn/wCwDyFUaS0gPM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=KQMpiu5ryeOBi2VAdOv6MDN9R/LYGVTz
        gF4sAulYqjGX0fm8vFrBJ2ZLiN0Shy1GnaYeU1eVMc6mg6DgJ9vWPz8iUwOIVkSJ
        gdYYhgNUXTGnfm1aJTMPES3XD4gBjReRKioQ7N2jqaVdGyw6jyWk2sVdTQlA4lac
        Fk5R+x0lGqE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9F58C55F7F;
        Sat, 22 Feb 2020 12:43:08 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0BD7155F7E;
        Sat, 22 Feb 2020 12:43:07 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Rasmus Jonsson <wasmus@zom.bi>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org
Subject: Re: [GSoC][PATCH 1/1] t1050: clean up checks for file existence
References: <20200222071335.27292-1-wasmus@zom.bi>
        <20200222071335.27292-2-wasmus@zom.bi>
Date:   Sat, 22 Feb 2020 09:43:06 -0800
In-Reply-To: <20200222071335.27292-2-wasmus@zom.bi> (Rasmus Jonsson's message
        of "Sat, 22 Feb 2020 08:13:35 +0100")
Message-ID: <xmqqtv3i5xhx.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C968D710-559A-11EA-9B88-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rasmus Jonsson <wasmus@zom.bi> writes:

> Replace "test -f" with test_path_is_file, which gives more verbose
> and accurate output.
>
> Signed-off-by: Rasmus Jonsson <wasmus@zom.bi>
> ---
>  t/t1050-large.sh | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/t/t1050-large.sh b/t/t1050-large.sh
> index d3b2adb28b..667fc2a745 100755
> --- a/t/t1050-large.sh
> +++ b/t/t1050-large.sh
> @@ -53,7 +53,8 @@ test_expect_success 'add a large file or two' '
>  	for p in .git/objects/pack/pack-*.pack
>  	do
>  		count=$(( $count + 1 ))
> -		if test -f "$p" && idx=${p%.pack}.idx && test -f "$idx"
> +		if test_path_is_file "$p" && idx=${p%.pack}.idx &&
> +		   test_path_is_file "$idx"

This is not wrong per-se, but assignment to idx logically is tied
stronger to its use (i.e. the first test_path_is_file is about the
.pack half of the packfile, the assignment to idx *and* the second
test_path_is_file is about the corresponding .idx half), so either
write it like so:

        if test_path_is_file "$p" &&
           idx=${p%.pack}.idx && test_path_is_file "$idx"

or each piece on its own line, if the result becomes overly long:

        if test_path_is_file "$p" &&
           idx=${p%.pack}.idx &&
	   test_path_is_file "$idx"

All the changes in this patch make sense, otherwise.  Thanks.

> @@ -65,7 +66,7 @@ test_expect_success 'add a large file or two' '
>  	test $cnt = 2 &&
>  	for l in .git/objects/??/??????????????????????????????????????

It is totally an unrelated tangent, but brian, are the lines of this
kind on your radar?  The object names in SHA-256 world would not be
caught with the pattern right?  The fix probably belongs to next to
where OID_REGEX is defined in test-lib.sh (this is a glob and not a
regex, though).  Perhaps the original should have been written like

	# somewhere in test-lib.sh
	HEXGLOB='[0-9a-f]'
	HEXGLOB38=$HEXGLOB$HEXGLOB$HEXGLOB$HEXGLOB$HEXGLOB$HEXGLOB ;# 6
	HEXGLOB38=$HEXGLOB38$HEXGLOB38$HEXGLOB38$HEXGLOB38$HEXGLOB38$HEXGLOB38 ;# 36
	HEXGLOB38=$HEXGLOB$HEXGLOB$HEXGLOB38

	OBJFANOUTGLOB=$HEXGLOB$HEXGLOB
	OBJFILEGLOB=$HEXGLOB38

	...

	for l in .git/objects/$OBJFANOUTGLOB/$OBJFILEGLOB

and then SHA-256 series would just update OBJFANOUTGLOB and
OBJFILEGLOB patterns, or something like that?

>  	do
> -		test -f "$l" || continue
> +		test_path_is_file "$l" || continue
>  		bad=t
>  	done &&
>  	test -z "$bad" &&
> @@ -76,7 +77,8 @@ test_expect_success 'add a large file or two' '
>  	for p in .git/objects/pack/pack-*.pack
>  	do
>  		count=$(( $count + 1 ))
> -		if test -f "$p" && idx=${p%.pack}.idx && test -f "$idx"
> +		if test_path_is_file "$p" && idx=${p%.pack}.idx &&
> +		   test_path_is_file "$idx"
>  		then
>  			continue
>  		fi
> @@ -111,7 +113,7 @@ test_expect_success 'packsize limit' '
>  		count=0 &&
>  		for pi in .git/objects/pack/pack-*.idx
>  		do
> -			test -f "$pi" && count=$(( $count + 1 ))
> +			test_path_is_file "$pi" && count=$(( $count + 1 ))
>  		done &&
>  		test $count = 2 &&


