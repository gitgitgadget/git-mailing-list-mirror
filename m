Return-Path: <SRS0=6EDX=DO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0C71C4727E
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 19:42:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54A14207EA
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 19:42:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Ti3Q6s+w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728430AbgJGTmy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Oct 2020 15:42:54 -0400
Received: from mout.gmx.net ([212.227.15.19]:57075 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728336AbgJGTmy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Oct 2020 15:42:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1602099766;
        bh=Ubawc7EPVehzuvV2pdNNB8h8Ct8y/Msz+ILIlODcmUY=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Ti3Q6s+wQWkIPew4uw74Ec1QQR5h2cGzuqa/oWu6fHgxudlAf4fS6/hcy1Fw41TFa
         X5WkqJq3VxTZZGHHEthYsQyz6pV13l7c2hOV0YAKqWaOyHfM8jumc4qFTU/S6IzC0d
         LEZgslryYrfanZDkAQz+VdqLnnexmyOuYfTBlXWk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.20.73.169] ([213.196.213.184]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MdvmO-1kxvzU2V4Y-00b1AO; Wed, 07
 Oct 2020 21:42:46 +0200
Date:   Wed, 7 Oct 2020 21:42:44 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Tom Clarkson via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Avery Pennarun <apenwarr@gmail.com>,
        Ed Maste <emaste@freebsd.org>,
        Tom Clarkson <tom@tqclarkson.com>,
        Tom Clarkson <tom@tqclarkson.com>
Subject: Re: [PATCH v2 6/7] subtree: more robustly distinguish subtree and
 mainline commits
In-Reply-To: <a7aaedfed3785c6ca693f60f05e76156f68a5d39.1602021913.git.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2010072128130.50@tvgsbejvaqbjf.bet>
References: <pull.493.git.1589176201.gitgitgadget@gmail.com> <pull.493.v2.git.1602021913.gitgitgadget@gmail.com> <a7aaedfed3785c6ca693f60f05e76156f68a5d39.1602021913.git.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:rUV/o68XOyrB3JpXBxdQpRPBCCvnGk7HJvdzkuIe0MTCDuIrPez
 kWrEedtCbLhG7Td8QiJIXagwcOiWEPdgMPm8/7WEqbyQ3uTgHRSEqtd4Vsr9v2S2lbvjLIY
 8OnsOtnn9CZ1vNf/nlSpSBxfa+KfJzq5kmm5q/9XsV+NA8YcaaJCwY9KxbBVF/W3Z310J8G
 n/btUytwbO5mIAmOqTf9A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:SYlV2MKfEFI=:GFrSr3qs6tVO0T4tFO53N5
 qnqkSpAia8+rfsrKzjCM8z736bYPqIAW8UmgFeOKCW/wkpLb+wlFT4zlvK8E7igFGkAdlLAzw
 iUBvEQKQ+KHidPFiK7yCmIeCNr0NzbXZoGh1BxvoDO83TLXWbjGIp8PRZ8OBIQTk15e9weKtW
 6iOBb9vukuK+vvB8dQmwo/Y3qM7bRWQarSp4438BW2sEiZnk4e7JQuT5Q931eiw7sJqAlvMga
 RQW+6ARx3p1uZXJkJQW7GljHPM9IcoQgYzClgGYE/UwQbXd+DpaY/yE+VE/srIZIYBpGsc6y+
 YUvrhUtDDWuFq4BG7e4oAt0atZkVeg4bzL/reKwrWQMpCLeqJUrdjMQVPrn0m1bQhek8KdB9v
 Da5xFKLEEU9V3zljravfALl0Lobjk49rLUjECOy+aUgdhOUGPn0Mtra75pmOC4/06XyooW796
 1NieQg7/q0qbQTxVjUoWlgx9E5HLY5gFxbXKLFEDOh2/w6jkdwfIN2MF25bpD4RCSWCRLfunb
 9WitQ82DqkhBZfLduiDbxUqyGS1EU5eHxbfSFSZcFvFyT8seb2Wrgvb/keatZVNFoGrIxJagc
 t/GcpGF49sGup5xRHGivrPXf5QlC5VWIEjNt5g66MDJwUrTvKrS7LxVsVF9v2d1VMRY0/l7Dq
 HOXz5yUGJkJoyU9RTg/HDb7r5uouJdoVuFIUM3DLHffcsboaAJZX/BkxQ/28HgulmY01bHWnr
 A4G7Cgbv7Fcj+Y7taYCRexyWtIEBmYx5oDx8Bc5JcZuvG7LXoms6qnFHr/O7CUzvgQ/wbqZW9
 l9nuOEaKKsUMTzYT4tgx45ctIdef0P8YtXjhCD0Fb3nv6/CHoOZ7sXzAzEZmECfLmhUOpCCsg
 +4t3ewTehs21fotnVWKZl2WYDG3tdSBG/6DPwqSlkq9yr+oKk/GsffTBncDyL7WT35yA0mAtD
 27gfvUneDoS5ib72YJUeOOx/lcU4TIkRD/MOIXJ6zGMbOKaR4rrOYFPwmfrOY5SYP/5T7zT1s
 72JwdI56Aq1jdDaZZGsU9XfqLkfWEqmMmaX5qa7YNm691ytyxg1sdUsU32nKriz6Eg9m2GyHD
 kFYdaTnckGbvIq2LVBsN1ldtIwFYlHoqLRuUcOV2YQlKiFFRRpLjuSWNAQwGfz8Zj6ZXnPaN6
 a6+kVu1JnhF/JCL9GVZ3Emhm0jWi3UfTPXUWIA7DnAmdfEbIPvbP8UfkQhZUd/o7x/yHAAQev
 fOSruDgVI4Piaed2yQAelkm3jgIKeyfXVwGhfrw==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Tue, 6 Oct 2020, Tom Clarkson via GitGitGadget wrote:

> From: Tom Clarkson <tom@tqclarkson.com>
>
> Prevent a mainline commit without $dir being treated as a subtree
> commit and pulling in the entire mainline history. Any valid subtree
> commit will have only valid subtree commits as parents, which will be
> unchanged by check_parents.

I feel like this is only half the picture because I have a hard time
stitching these two sentences together.

After studying the code and your patch a bit, it appears to me that
`process_split_commit()` calls `check_parents()` first, which will call
`process_split_commit()` for all as yet unmapped parents. So basically, it
recurses until it found a commit all of whose parents are already mapped,
then permeates that information all the way back.

Doesn't this cause serious issues with stack overflows and all for long
commit histories?

> Signed-off-by: Tom Clarkson <tom@tqclarkson.com>
> ---
>  contrib/subtree/git-subtree.sh | 24 +++++++++++-------------
>  1 file changed, 11 insertions(+), 13 deletions(-)
>
> diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtre=
e.sh
> index e56621a986..fa6293b372 100755
> --- a/contrib/subtree/git-subtree.sh
> +++ b/contrib/subtree/git-subtree.sh
> @@ -224,8 +224,6 @@ cache_setup () {
>  	fi
>  	mkdir -p "$cachedir" ||
>  		die "Can't create new cachedir: $cachedir"
> -	mkdir -p "$cachedir/notree" ||
> -		die "Can't create new cachedir: $cachedir/notree"

It might make sense to talk about this a bit in the commit message.
Essentially, you are replacing the `notree/<rev>` files by mapping `<rev>`
to the empty string.

This makes me wonder, again, whether the file system layout of the cache
can hold up to the demands. If a main project were to merge a subtree
with, say, 10 million commits, wouldn't that mean that `git subtree` would
now fill one directory with 10 million files? I cannot imagine that this
performs well, still.

>  	debug "Using cachedir: $cachedir" >&2
>  }
>
> @@ -255,18 +253,11 @@ check_parents () {
>  	local indent=3D$(($2 + 1))
>  	for miss in $missed
>  	do
> -		if ! test -r "$cachedir/notree/$miss"
> -		then
> -			debug "  unprocessed parent commit: $miss ($indent)"
> -			process_split_commit "$miss" "" "$indent"
> -		fi
> +		debug "  unprocessed parent commit: $miss ($indent)"
> +		process_split_commit "$miss" "" "$indent"

That makes sense to me, as the `missed` variable only contains as yet
unmapped commits, therefore we do not have to have an equivalent `test -r`
check.

Ciao,
Dscho

>  	done
>  }
>
> -set_notree () {
> -	echo "1" > "$cachedir/notree/$1"
> -}
> -
>  cache_set () {
>  	oldrev=3D"$1"
>  	newrev=3D"$2"
> @@ -719,11 +710,18 @@ process_split_commit () {
>  	# vs. a mainline commit?  Does it matter?
>  	if test -z "$tree"
>  	then
> -		set_notree "$rev"
>  		if test -n "$newparents"
>  		then
> -			cache_set "$rev" "$rev"
> +			if test "$newparents" =3D "$parents"
> +			then
> +				# if all parents were subtrees, this can be a subtree commit
> +				cache_set "$rev" "$rev"
> +			else
> +				# a mainline commit with tree missing is equivalent to the initial =
commit
> +				cache_set "$rev" ""
> +			fi
>  		else
> +			# no parents with valid subtree mappings means a commit prior to sub=
tree add
>  			cache_set "$rev" ""
>  		fi
>  		return
> --
> gitgitgadget
>
>
