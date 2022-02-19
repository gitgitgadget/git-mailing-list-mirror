Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BB9BC433F5
	for <git@archiver.kernel.org>; Sat, 19 Feb 2022 03:29:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240302AbiBSD3g (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Feb 2022 22:29:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbiBSD3g (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Feb 2022 22:29:36 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B6E35F257
        for <git@vger.kernel.org>; Fri, 18 Feb 2022 19:29:17 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id a8so19222268ejc.8
        for <git@vger.kernel.org>; Fri, 18 Feb 2022 19:29:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=7poQqOzV7c02up9g5dd310iSGnnMA2poovJ15gq3Vxs=;
        b=YAWd2CrTul/0xWIRYpyUGmiOVWo9Wo4HTZYUajmBK7euguBhQpbx3AUek4D0Tc6+Dj
         nshI/gO22hErS7sMrji8fED9LBSxDGsTDFsMNj7uGdxx2PuUa+gAqFbGdEdMkXuk3Nhj
         QNHLZqCVbnFRilxXLuYdUiv54W8dRGIyu9BHPlElk5/zoQUY/slUcHKrTP6BESaW7HOa
         2RaL2n5UkVXc/h1WoCbJ66RSTM9NsRH1n7DEh5aY7xUL5SNrC9iWoC7GjwED/Gckg2An
         STrJMfjMD8T/1RXK9+uBbLF9pZhb6HQgJL4IEsdL0USdzE7gK4p1VqNKwz1QpN+aSBZe
         S0pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=7poQqOzV7c02up9g5dd310iSGnnMA2poovJ15gq3Vxs=;
        b=vIIBegC5gNK4qeXFuAG2AKOMregO1oGaMrth6h790WdVLNAF/uhBcQXwckembuXnBo
         68AjXmj6fHoyFa8+teyKI79ew0WXC9vmCSmkfU5ALBmUNErxYowDZNeahD3IdorRQqvx
         tgzjykIBBNE2YiXUusv+q+IMDV5d8cHn2fgF2Xf53ED94iZyXbzzuxofE3t+G4q3gbXV
         lBQrVEVBrLa+fh/GiE9D0zs/GPF1FgR4JbNyP5WQSYU+X72SE8GPKb4MvUdLN8B6lYLt
         aek5WUdaFxTzTNYGfxUOo1vcEk0DgrjKdPM5OV05RHvngsPS9hDDr2ZJApDraVg6LFuJ
         h3jw==
X-Gm-Message-State: AOAM531sMw7PYuRZVXbaGVBKx3fFk5HRCUZl4fUWU9Dx6pLdGS1BB2tk
        tQ/2ir+BfZ2rqz6YJfeX6DipH9L7cBNArQ==
X-Google-Smtp-Source: ABdhPJwk1EtxnBCctXX38oQHRAtMI7TxwhvQWwgE4LdUCnqHWeMBCp13IHTZGg4OCBLtu+r1Ir8grA==
X-Received: by 2002:a17:906:6d09:b0:6b9:2e0e:5bdd with SMTP id m9-20020a1709066d0900b006b92e0e5bddmr8264811ejr.246.1645241355878;
        Fri, 18 Feb 2022 19:29:15 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id h21sm5219729edt.26.2022.02.18.19.29.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 19:29:15 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nLGQs-004hI1-UW;
        Sat, 19 Feb 2022 04:29:14 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] ls-files: support --recurse-submodules --stage
Date:   Sat, 19 Feb 2022 04:11:30 +0100
References: <20220218223212.1139366-1-jonathantanmy@google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <20220218223212.1139366-1-jonathantanmy@google.com>
Message-ID: <220219.868ru7fsad.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Feb 18 2022, Jonathan Tan wrote:

> e77aa336f1 ("ls-files: optionally recurse into submodules", 2016-10-10)
> taught ls-files the --recurse-submodules argument, but only in a limited
> set of circumstances. In particular, --stage was unsupported, perhaps
> because there was no repo_find_unique_abbrev(), which was only
> introduced in 8bb95572b0 ("sha1-name.c: add
> repo_find_unique_abbrev_r()", 2019-04-16). This function is needed for
> using --recurse-submodules with --stage.
>
> Now that we have repo_find_unique_abbrev(), teach support for this
> combination of arguments.
>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
> I got the similar-hashing object contents from =C3=86var's work in [1].

Hah! FWIW that was made by this script I hacked up at the time:
=09
	#!/usr/bin/env perl
	use v5.32.0;
	use strict;
	use warnings;
	use Digest::SHA qw(sha1_hex sha256_hex);
=09
	# Usage:
	## prefix=3D type=3Dbad git find-colliding-hashes | tee garbage-coll-bad.t=
xt
	## prefix=3D type=3Dbad want=3Dbad git find-colliding-hashes | tee garbage=
-coll-bad.txt
=09
	$| =3D 1;
	my $s =3D $ENV{s} // "s";
	my %seen;
	my $type =3D $ENV{type} // "blob";
	my $prefix =3D $ENV{prefix} // "";
	my $want =3D $ENV{want} // "";
	while ($s++) {
		my $str =3D $prefix . $s;
		my $l =3D length($str) + 1;
		my $p =3D "$type $l\0$str\n";
		my $o =3D sha1_hex($p);
		next if length $want && index($o, $want) !=3D 0;
		my $n =3D sha256_hex($p);
		my $os =3D substr($o, 0, 4);
		my $ns =3D substr($n, 0, 4);
		if ($os eq $ns) {
			say "hash($str) =3D [$os, $ns]" . ($seen{$os} ? " SEEN" : "");
			$seen{$os} =3D 1;
		}
	}

https://gist.github.com/avar/9e4c2bde7fbdc888b031713065a9eaf6 has some
more colliding blob prefixes, which I generated until I got bored with
it...

> +test_expect_success '--stage' '
> +	# In order to test hash abbreviation, write two objects that have the
> +	# same first 4 hexadecimal characters in their (SHA-1) hashes.
> +	echo brocdnra >submodule/c &&
> +	git -C submodule commit -am "update c" &&
> +	echo brigddsv >submodule/c &&
> +	git -C submodule commit -am "update c again" &&
> +
> +	cat >expect <<-\EOF &&
> +	100644 6da7 0	.gitmodules
> +	100644 7898 0	a
> +	100644 6178 0	b/b
> +	100644 dead9 0	submodule/c
> +	EOF

This test though will break, as you can see with:

    GIT_TEST_DEFAULT_HASH=3Dsha256 ./t3007-ls-files-recurse-submodules.sh

So you'll need at least something like:

diff --git a/t/t3007-ls-files-recurse-submodules.sh b/t/t3007-ls-files-recu=
rse-submodules.sh
index 3d2da360d17..0fe69da8dcf 100755
--- a/t/t3007-ls-files-recurse-submodules.sh
+++ b/t/t3007-ls-files-recurse-submodules.sh
@@ -42,10 +42,10 @@ test_expect_success '--stage' '
 	echo brigddsv >submodule/c &&
 	git -C submodule commit -am "update c again" &&
=20
-	cat >expect <<-\EOF &&
-	100644 6da7 0	.gitmodules
-	100644 7898 0	a
-	100644 6178 0	b/b
+	cat >expect <<-EOF &&
+	100644 $(git rev-parse --short=3D4 HEAD:.gitmodules) 0	.gitmodules
+	100644 $(git rev-parse --short=3D4 HEAD:a) 0	a
+	100644 $(git rev-parse --short=3D4 HEAD:b/b) 0	b/b
 	100644 dead9 0	submodule/c
 	EOF
=20
But then the problem is that one is dead9 and the other dead6, I was
just trying to find 4-char prefixes.

But having indulged in all that, I'm now entirely confused about why any
of this needs to be tested here.

You're adding --stage, which will give us --stage-y output, and it was
previously incompatible with --recurse-submodules. Having the two
combine is good!

But why do we need to test the OID abbreviation at all, isn't that a bit
too much paranoia? Isn't it sufficient just do:

    opts=3D"--stage --abbrev=3D4" &&
    git -C submodule ls-files $opts >expect &&
    git ls-files --recurse-submodules $opts --stage >raw &&
    grep submodule raw >actual &&
    test_cmp expect actual

Or well, then the path won't be the same, but I think you get the
idea.

I.e. don't we just want to test that the submodule is indeed included
here, not that some particular feature works in combination with it.

Supposing that repo_find_unique_abbrev() won't work might be a bit too
much paranoia, and I'm more test-happy than most :)

I'd think that if we should test anything it would be more meaningful to
e.g. test the sort order of the returned entries.

Your test case won't disambiguate between index entries being returned
in sort order v.s. just "submodules at the end". Since "s" sorts after
0, a and b.

Presumably it does the former, but I'd think distinguishing those would
be one meaningful test of actual --recurse-submodules --stage
functionality.
