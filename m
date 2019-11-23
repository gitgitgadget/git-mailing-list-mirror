Return-Path: <SRS0=Rptp=ZP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E45A5C43215
	for <git@archiver.kernel.org>; Sat, 23 Nov 2019 01:52:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA86D20726
	for <git@archiver.kernel.org>; Sat, 23 Nov 2019 01:52:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="s6/nI9co"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbfKWBtw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Nov 2019 20:49:52 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60325 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbfKWBtw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Nov 2019 20:49:52 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 00C8B19BF0;
        Fri, 22 Nov 2019 20:49:46 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LfelBQFWRTZNGIwkMTvszDWFmrQ=; b=s6/nI9
        coZqhqionhHr1jn4fhGY4MPWfwLTupkHKrc3AYqW4ZCdM4qN0f1l2L6XfpPraNfj
        /zgXfn/iyfXDub4Z+p+BkXlPbci08Ov0G9fChPLw7hyQlEmo/kXn2U/CINoiYCR5
        0FckHkF71+zsa/l6V7nR0CW1oh6k8IMpfRvhc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=tyn4P0BzGmuOZuSRRVPYYQ2W99CVDGCc
        8t65vkHwwIvRQpBuFW8ZVtzwTYkto28b+RhfHrIJRTCaYw5hPT+wVlR/weTG48Lp
        bwX49/iKoxyutsX+TBQ6ajmBZLDNsx4XMtVlrI+49voVmB7Xi8fbARetzSrI2WDv
        +lJZOwbUK1w=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EBE1C19BEE;
        Fri, 22 Nov 2019 20:49:45 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5787B19BED;
        Fri, 22 Nov 2019 20:49:45 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 22/22] t7700: stop losing return codes of git commands
References: <cover.1574296987.git.liu.denton@gmail.com>
        <cover.1574449072.git.liu.denton@gmail.com>
        <e9835b85427a3486e2dba136bbf34506e521d355.1574449072.git.liu.denton@gmail.com>
Date:   Sat, 23 Nov 2019 10:49:44 +0900
In-Reply-To: <e9835b85427a3486e2dba136bbf34506e521d355.1574449072.git.liu.denton@gmail.com>
        (Denton Liu's message of "Fri, 22 Nov 2019 11:00:35 -0800")
Message-ID: <xmqqftif2wg7.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 865BDA84-0D93-11EA-A1BB-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> -	objsha1=$(git verify-pack -v pack-$packsha1.idx | head -n 1 |
> -		sed -e "s/^\([0-9a-f]\{40\}\).*/\1/") &&
> +	git verify-pack -v pack-$packsha1.idx >packlist &&
> +	objsha1=$(head -n 1 packlist | sed -e "s/^\([0-9a-f]\{40\}\).*/\1/") &&

We probably should lose reference to SHA-1 and use $OID_REGEX; this
is obviously a #leftoverbits material that is outside the scope of
this series.

> @@ -91,7 +93,8 @@ test_expect_success 'loose objects in alternate ODB are not repacked' '
>  	git prune-packed &&
>  	for p in .git/objects/pack/*.idx
>  	do
> -		if git verify-pack -v $p | egrep "^$objsha1"
> +		git verify-pack -v $p >packlist || return $?
> +		if egrep "^$objsha1" packlist
>  		then
>  			found_duplicate_object=1
>  			echo "DUPLICATE OBJECT FOUND"

These egrep that try to match lines that begin with an object name
can be a simple grep instead (again, outside the scope of this
series).

> @@ -109,15 +112,18 @@ test_expect_success 'packed obs in alt ODB are repacked even when local repo is
>  	test_path_is_file "$myidx" &&
>  	for p in alt_objects/pack/*.idx
>  	do
> -		git verify-pack -v $p | sed -n -e "/^[0-9a-f]\{40\}/p"
> -	done | while read sha1 rest
> +		git verify-pack -v $p >packlist || return $?
> +		sed -n -e "/^[0-9a-f]\{40\}/p"
> +	done >packs &&

A misleading filename?  The lines in this file are not pack files;
rather the file has a list of objects in various packs.

> +	git verify-pack -v $myidx >mypacklist &&
> +	while read sha1 rest
>  	do
> -		if ! ( git verify-pack -v $myidx | grep "^$sha1" )
> +		if ! grep "^$sha1" mypacklist
>  		then
>  			echo "Missing object in local pack: $sha1"
>  			return 1
>  		fi
> -	done
> +	done <packs
>  '

Again outside the scope of this series, but this looks O(n^2)
to me.

If I were writing this today, I would prepare a sorted list of all
object names (and nothing else on each line) in alt_objects/pack/ in
one file (call it 'orig'), and prepare another file with a sorted
list of all object names described in $myidx (call it 'dest'), and
then run "comm -23 orig dest" and see if there is anything that is
unique in the 'orig' file (i.e. something in 'orig' is missing from
'dest').

> @@ -132,15 +138,18 @@ test_expect_success 'packed obs in alt ODB are repacked when local repo has pack
>  	test_path_is_file "$myidx" &&
>  	for p in alt_objects/pack/*.idx
>  	do
> -		git verify-pack -v $p | sed -n -e "/^[0-9a-f]\{40\}/p"
> -	done | while read sha1 rest
> +		git verify-pack -v $p >packlist || return $?
> +		sed -n -e "/^[0-9a-f]\{40\}/p" packlist
> +	done >packs &&
> +	git verify-pack -v $myidx >mypacklist &&
> +	while read sha1 rest
>  	do
> -		if ! ( git verify-pack -v $myidx | grep "^$sha1" )
> +		if ! grep "^$sha1" mypacklist
>  		then
>  			echo "Missing object in local pack: $sha1"
>  			return 1
>  		fi
> -	done
> +	done <packs
>  '

Likewise.

> @@ -160,15 +169,18 @@ test_expect_success 'packed obs in alternate ODB kept pack are repacked' '
>  	test_path_is_file "$myidx" &&
>  	for p in alt_objects/pack/*.idx
>  	do
> -		git verify-pack -v $p | sed -n -e "/^[0-9a-f]\{40\}/p"
> -	done | while read sha1 rest
> +		git verify-pack -v $p >packlist || return $?
> +		sed -n -e "/^[0-9a-f]\{40\}/p" packlist
> +	done >packs &&
> +	git verify-pack -v $myidx >mypacklist &&
> +	while read sha1 rest
>  	do
> -		if ! ( git verify-pack -v $myidx | grep "^$sha1" )
> +		if ! grep "^$sha1" mypacklist
>  		then
>  			echo "Missing object in local pack: $sha1"
>  			return 1
>  		fi
> -	done
> +	done <packs
>  '

Likewise.

