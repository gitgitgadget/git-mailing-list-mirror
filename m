Return-Path: <SRS0=6EDX=DO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FAF3C41604
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 15:36:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2A4B2168B
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 15:36:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="TEbPKfpJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbgJGPgh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Oct 2020 11:36:37 -0400
Received: from mout.gmx.net ([212.227.15.18]:52045 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726504AbgJGPgh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Oct 2020 11:36:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1602084990;
        bh=Ih8DT+s0kJWd9GXc8sDQLAWGo+x/T/dnke1m/JbWwOk=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=TEbPKfpJZ2184d4/yMf+7ko2GgxMQXqLbu+wF+ovsBzy7FiF9wHS/SFXHKOcVEb5X
         2nkqKeKEXWPvOW5J3InNbelBudhX8/e8zVmz7VZDFH31S4JtT4YVvP9pll6nj+4089
         LO8Is2ldi4/HeWIlAip6/QUoTI42coar4YaY1uc8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.20.73.169] ([213.196.213.184]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mf0BM-1ktDuO2OgU-00gUSN; Wed, 07
 Oct 2020 17:36:30 +0200
Date:   Wed, 7 Oct 2020 17:36:28 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Tom Clarkson via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Avery Pennarun <apenwarr@gmail.com>,
        Ed Maste <emaste@freebsd.org>,
        Tom Clarkson <tom@tqclarkson.com>,
        Tom Clarkson <tom@tqclarkson.com>
Subject: Re: [PATCH v2 2/7] subtree: exclude commits predating add from
 recursive processing
In-Reply-To: <79b5f4a65197cea26ddc080c19dd2c5c7d424fc1.1602021913.git.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2010071211180.50@tvgsbejvaqbjf.bet>
References: <pull.493.git.1589176201.gitgitgadget@gmail.com> <pull.493.v2.git.1602021913.gitgitgadget@gmail.com> <79b5f4a65197cea26ddc080c19dd2c5c7d424fc1.1602021913.git.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Yec66xSDfpiGWHpiyMGNFzcEN1xpkvy54HJMMVH9shqipb5n63A
 GlUmQNK753Bx9+/hSzZk7IE4yRJYjTfH8Kzm3RfCGD2e2c/3D5OLqvmblACbz0cTKD9nR4Y
 af8xvm7dmkwYuKtk5uJSa5B8txmDd6yutA1HuDs7knYKjVLt+rxtdPrfIHWqXXqeAmoIXaC
 J+xfKg0Rv60uxIJ3uyiYQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:430tejICR0U=:e8ZM9Y6uo/BzGtYX0cndAM
 PYg12f8qlgI94ZFaFJxvVFFKaOeVmx2JcCdU1EftBFlEjKACfg1bhJ7nkKjq+UD4VcS/tKmZR
 pwEg0bbrIpIwXfctJt2oCdUFhXZdKTwPzC/+6k9/+vk7Ym7J7Djb5f+zfYsXY9+s2jHlYU1r/
 4cPHASJLCMB1/dnZXhX2J5UTzDFNvm9ZlDS6PHhp+HdTjktMnJrlCn43k+2ixgBhqp4CZ2X9K
 mCT0dBBCpKu+c/hCflvkeoMQXawTZ9A+gtQ1kP4UkMC/n+Dd8QJoenqQcJZ2gy0T1moOsI8i+
 7KA/WoGZNz0VR+StjDoMMz5xzJHRiOclFERLbsDac0vriaOaAQq4U3SIJRAg79aTYgxS+mEYA
 d2mNMhOh18ymK6eaLq5v798tLP9XuaggZlH2OfYJL8Ramt80OVW57aRSDQ0C72/8FaKQeqXFI
 T3Z+NrSIHTHiCB2AX2jgReYwDlqkBTuSV2k4pMNxoG2VYy1p95aq9VXy6vLzx0Gd07VcQjz3g
 e/B9VdRYbJXVZ8HNQNhy2pHardcrRoPwN0v+J8xVE2Fbjxoamy2JtB4mfS382NP+LQY54Inqn
 c8zhW9BNiB57rPzxAmzGGprMukWXbMV4/OJtzOfqhdEnjp/ky1P1tLBz96UwB0j9w/YY4hSag
 JiRImAQSLdbG7mZtS1W1kP1w0XOyC4YuQdlBE9SwiF4BuXAYshhgV9AJMikZfCdQj1deMfgir
 86tcTwKH5KL2HREaq9+fdVCJ3atpeHJ5bLpmGP6qEntFiyN98R2dYHfVw8N+rAhXQVodJRuEy
 bLKKhpICdvnFLv0maT1jSNU2b5Izkjnsx3ElTiYtgXYcEDRsGvcm9FdgRGTGertD6XbYKTGnL
 lpuEMNJPZOm3RkexIBzvN578yKWrJ5Z4N/774nsoIYP8MsRHiCNj64TSYGKiqXbIaj45EDj1u
 ChFq+QLkgTPQbl8yMJLjKLEWdlE3VgQYMLIZxNCHWPWg4GCRqrnWKmAAXv/JE3oVocD3C0Am2
 O/JCtQ9ZTOOnVQoLdqyirsCmh15Um4rQuhl54Ug3kBFv4eWB/eo4yxi7DgwKbErRGdYJU6eU+
 JvbRp2OVZy9FEBjKvrw0D/LvtoF+rIGIccIAnAJLgHCdMtgbIEO386qT04qtbkqy3AWCPQdrm
 Acn+VF9H6pC6yWaVDWkLbySqdpV8NlrQJDuhsBuWlOVWqwPPMb8WiG5koRrErUL9ly40VeZYC
 bwfic/rBnmCsh9ybBmiJ+KTi0g1Xp7hupbObSeQ==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Tom,

On Tue, 6 Oct 2020, Tom Clarkson via GitGitGadget wrote:

> From: Tom Clarkson <tom@tqclarkson.com>
>
> Include recursion depth in debug logs so we can see when the recursion i=
s
> getting out of hand.
>
> Making the cache handle null mappings correctly and adding older commits
> to the cache allows the recursive algorithm to terminate at any point on
> mainline rather than needing to reach either the add point or the initia=
l
> commit.

Makes sense.

> diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtre=
e.sh
> index 9867718503..160bad95c1 100755
> --- a/contrib/subtree/git-subtree.sh
> +++ b/contrib/subtree/git-subtree.sh
> @@ -244,7 +244,7 @@ check_parents () {
>  	do
>  		if ! test -r "$cachedir/notree/$miss"
>  		then
> -			debug "  incorrect order: $miss"
> +			debug "  unprocessed parent commit: $miss ($indent)"

Without any context, it is hard to understand what the `$indent` variable
is supposed to mean, so it is unclear why we need to print it here.

I _guess_ it is the degree removed from the first-parent lineage?

In any case, it does not hurt here, so I trust that it is good to include
it in the debug output.

>  			process_split_commit "$miss" "" "$indent"
>  		fi
>  	done
> @@ -392,6 +392,24 @@ find_existing_splits () {
>  	done
>  }
>
> +find_mainline_ref () {
> +	debug "Looking for first split..."
> +	dir=3D"$1"
> +	revs=3D"$2"

The `git-subtree` script seems to rely on the `local` construct, using it
in plenty of other circumstances. How about using it here, too?

> +
> +	git log --reverse --grep=3D"^git-subtree-dir: $dir/*\$" \
> +		--no-show-signature --pretty=3Dformat:'START %H%n%s%n%n%b%nEND%n' $re=
vs |

Since all you are interested in is the `git-subtree-mainline:` trailer,
wouldn't a format like `%(trailers:key=3Dgit-subtree-mainline)` instead of
`START %H%n%s%n%n%b%nEND%n`?

See
https://git-scm.com/docs/git-log#Documentation/git-log.txt-emtrailersoptio=
nsem
for more information about pretty formats.

BTW I am super unfamiliar with `git subtree`'s inner workings, and
therefore it would help me incredibly if the commit message talked a bit
about the commit message layout (with a particular eye on
`git-subtree-dir` and `git-subtree-mainline` which I guess are trailers
added by `git subtree`?)...

> +	while read a b junk
> +	do
> +		case "$a" in
> +		git-subtree-mainline:)
> +			echo "$b"
> +			return
> +			;;
> +		esac
> +	done
> +}
> +
>  copy_commit () {
>  	# We're going to set some environment vars here, so
>  	# do it in a subshell to get rid of them safely later
> @@ -646,9 +664,9 @@ process_split_commit () {
>
>  	progress "$revcount/$revmax ($createcount) [$extracount]"
>
> -	debug "Processing commit: $rev"
> +	debug "Processing commit: $rev ($indent)"
>  	exists=3D$(cache_get "$rev")
> -	if test -n "$exists"
> +	if test -z "$(cache_miss "$rev")"
>  	then
>  		debug "  prior: $exists"

I do not see the `exists` variable being used other than for the debug
statement. Maybe better something like this?

	debug "  prior found for $rev"

>  		return
> @@ -773,6 +791,17 @@ cmd_split () {
>
>  	unrevs=3D"$(find_existing_splits "$dir" "$revs")"
>
> +	mainline=3D"$(find_mainline_ref "$dir" "$revs")"
> +	if test -n "$mainline"
> +	then
> +		debug "Mainline $mainline predates subtree add"
> +		git rev-list --topo-order --skip=3D1 $mainline |
> +		while read rev
> +		do
> +			cache_set "$rev" ""

Ah, so they are not really "null mappings", but mapped to an empty string.
Makes sense. Maybe adjust the commit message?

> +		done || exit $?
> +	fi
> +
>  	# We can't restrict rev-list to only $dir here, because some of our
>  	# parents have the $dir contents the root, and those won't match.
>  	# (and rev-list --follow doesn't seem to solve this)
> --
> gitgitgadget
>
>
