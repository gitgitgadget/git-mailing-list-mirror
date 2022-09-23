Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 022EAC6FA82
	for <git@archiver.kernel.org>; Fri, 23 Sep 2022 08:53:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231124AbiIWIxo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Sep 2022 04:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231371AbiIWIxb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Sep 2022 04:53:31 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68DB91284B2
        for <git@vger.kernel.org>; Fri, 23 Sep 2022 01:53:28 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id x21so10002062edd.11
        for <git@vger.kernel.org>; Fri, 23 Sep 2022 01:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date;
        bh=0LOaEylyBLhhSR+i1T1tsY4tWM8IhIfDFF0Cp7IFySI=;
        b=kvzJp4Hig1pC908dtAJiGWDF24IeYSjWG54Gug4bMZnz+Xgdfy4kUfwOTnGdc4kN99
         OisJ4WmLExI/fNRarpYmjiuv0zT909yyiAjyjojnlESdH9KKkigx751ZHX+h43P/cbge
         Xb/stkWCB0vEYrUKIooJCJKNZMGsZfTPTn6Fpd9ERBCGOr191VxRUt8lcEYzrsEi80R8
         l+9k8jb5cFUHm+xooeCZ/N5Q2Bq6Hh0QZRUbI15pTU0RQTogPNP6BUXeqoTuJNBT272U
         iAiKmsCcl1KdWtmtA+EySeb0n16BmiKxF/z7Ulx0ZML9nhn4l3JQbHyoLG7r/nGBDd0m
         2ODA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date;
        bh=0LOaEylyBLhhSR+i1T1tsY4tWM8IhIfDFF0Cp7IFySI=;
        b=GlC0I+Yjl9DzBhjq0KQ2svfIr85UaqJQQKtaalmKHxJ/nDeRasfUBAhSzIQvs2zfnY
         CEyCuQ1xEE0UAfMNEVH3VjDyd/pPssglQmdkm45B5mPWzI41Y1Na8XFjWNE8KUCSk2Xn
         tsqwlVVCYUOXsau77mUNnvajq0ZCtVi+J2DRiedpltpifTerfhw28gw6MMBAyko+rNcF
         uXRM6pe6kwpcEXj1uFYfizKieJoBZrTjZXqM4HCo5zuHg6cdteMEbF2FepWhb+RlUrJ4
         6v253QaL2Otnd6XXeczmdJ1RoV2TqeZp549orlYcA2j9vfMSfxjhHf+ajvEDhmfF3buI
         zoCw==
X-Gm-Message-State: ACrzQf1E0n355N4oxacl4lAYoyw+DGwLMV0Eu8+BPgO4ymb0Q4eO2+HH
        pQZYJiY0g7l68RfcXhynuj3Uoun3OOE=
X-Google-Smtp-Source: AMsMyM58e2kK4ia7RGijZ5EYku3HaYAmBMb2GFBKPjSQHgU/z0dGKzCNtz0y1FDfEDf8nLV8seRyHQ==
X-Received: by 2002:a05:6402:d0b:b0:443:df38:9df with SMTP id eb11-20020a0564020d0b00b00443df3809dfmr7194107edb.9.1663923206528;
        Fri, 23 Sep 2022 01:53:26 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id p14-20020a17090653ce00b007828150a2f1sm1116265ejo.36.2022.09.23.01.53.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 01:53:26 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1obeR3-003HPC-0s;
        Fri, 23 Sep 2022 10:53:25 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org, Victoria Dye <vdye@github.com>
Subject: Re: [PATCH v2] cmd-list.perl: fix identifying man sections
Date:   Fri, 23 Sep 2022 10:37:33 +0200
References: <220923.86wn9u4joo.gmgdl@evledraar.gmail.com>
 <20220923080733.1995862-1-martin.agren@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <20220923080733.1995862-1-martin.agren@gmail.com>
Message-ID: <220923.86fsgi4gl6.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Sep 23 2022, Martin =C3=85gren wrote:

> We attribute each documentation text file to a man section by finding a
> line in the file that looks like "gitfoo(<digit>)". Commit cc75e556a9
> ("scalar: add to 'git help -a' command list", 2022-09-02) updated this
> logic to look not only for "gitfoo" but also "scalarfoo". In doing so,
> it forgot to account for the fact that after the updated regex has found
> a match, the man section is no longer to be found in `$1` but now lives
> in `$2`.
>
> This makes our git(1) manpage look as follows:
>
>   Main porcelain commands
>        git-add(git)
>            Add file contents to the index.
>
>   [...]
>
>        gitk(git)
>            The Git repository browser.
>
>        scalar(scalar)
>            A tool for managing large Git repositories.
>
> Restore the man sections by not capturing the (git|scalar) part of the
> match into `$1`.
>
> As noted by =C3=86var [1], we could even match any "foo" rather than just
> "gitfoo" and "scalarfoo", but that's a larger change. For now, just fix
> the regression in cc75e556a9.

Thanks for the quick turn-around, this looks good to me in this form.

> [1] https://lore.kernel.org/git/220923.86wn9u4joo.gmgdl@evledraar.gmail.c=
om/#t
>
> Helped-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> Signed-off-by: Martin =C3=85gren <martin.agren@gmail.com>
> ---
>  Thanks =C3=86var for having a look at v1.
>
>  Documentation/cmd-list.perl | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/cmd-list.perl b/Documentation/cmd-list.perl
> index 9515a499a3..755a110bc4 100755
> --- a/Documentation/cmd-list.perl
> +++ b/Documentation/cmd-list.perl
> @@ -10,7 +10,7 @@ sub format_one {
>  	$state =3D 0;
>  	open I, '<', "$name.txt" or die "No such file $name.txt";
>  	while (<I>) {
> -		if (/^(git|scalar)[a-z0-9-]*\(([0-9])\)$/) {
> +		if (/^(?:git|scalar)[a-z0-9-]*\(([0-9])\)$/) {
>  			$mansection =3D $1;
>  			next;
>  		}

Just for anyone doing future archaeology / digging into the "larger
change": The reason I felt safe in removing the "git" matching entirely
is because the larger context here is that we're parsing only the very
start of the *.txt. I.e. we would not want this:
=09
	git(1)
	=3D=3D=3D=3D=3D=3D
=09
	NAME
	----
	git - the stupid content tracker
=09

        foo(2)

To report Documentation/git.txt as being a "foo" in man section 2, but
that will not happen because as soon as we see a "NAME" line followed by
a "----" line we'll extract that one line of description, so even if our
regex would have eagerly matched that "foo(2)" we won't see it.

Now, having written and looked at this with fresh eyes this would be an
even better & more logical thing to do:
=09
	diff --git a/Documentation/cmd-list.perl b/Documentation/cmd-list.perl
	index 755a110bc48..0bc4c803a10 100755
	--- a/Documentation/cmd-list.perl
	+++ b/Documentation/cmd-list.perl
	@@ -1,38 +1,38 @@
	 #!/usr/bin/perl -w
=09=20
	 use File::Compare qw(compare);
=09=20
	 sub format_one {
	 	my ($out, $nameattr) =3D @_;
	 	my ($name, $attr) =3D @$nameattr;
	 	my ($state, $description);
	 	my $mansection;
	 	$state =3D 0;
	 	open I, '<', "$name.txt" or die "No such file $name.txt";
	 	while (<I>) {
	-		if (/^(?:git|scalar)[a-z0-9-]*\(([0-9])\)$/) {
	+		if (/^\Q$name\E\(([0-9])\)$/) {
	 			$mansection =3D $1;
	 			next;
	 		}
	 		if (/^NAME$/) {
	 			$state =3D 1;
	 			next;
	 		}
	 		if ($state =3D=3D 1 && /^----$/) {
	 			$state =3D 2;
	 			next;
	 		}
	 		next if ($state !=3D 2);
	 		chomp;
	 		$description =3D $_;
	 		last;
	 	}
	 	close I;
	 	if (!defined $description) {
	 		die "No description found in $name.txt";
	 	}
	 	if (my ($verify_name, $text) =3D ($description =3D~ /^($name) - (.*)/)) {
	 		print $out "linkgit:$name\[$mansection\]::\n\t";
	 		if ($attr =3D~ / deprecated /) {
	 			print $out "(deprecated) ";
	 		}

It yields the exact same result as Martin's patch above according to the
doc-diff, but as the -U25 context shows we already have a hard
dependency on the "scalar -" part of the description line matching the
name of the file ("scalar.txt") is something we should be doing.

Anyway, this is more than good enough for now, thanks! There's also much
bigger issues with the script, and we can leave that all aside from now
(e.g. if it dies the Makefile doesn't report an error, ouch!).
