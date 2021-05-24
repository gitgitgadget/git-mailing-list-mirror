Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCEAEC2B9F8
	for <git@archiver.kernel.org>; Mon, 24 May 2021 22:21:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6E6A613D8
	for <git@archiver.kernel.org>; Mon, 24 May 2021 22:21:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbhEXWXM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 May 2021 18:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbhEXWXF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 May 2021 18:23:05 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77BB2C061574
        for <git@vger.kernel.org>; Mon, 24 May 2021 15:21:35 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id gb17so26096452ejc.8
        for <git@vger.kernel.org>; Mon, 24 May 2021 15:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=hzHTUz6pl9ZyKI05mVfzUHyl4/auI/ysaL3OyRsfPzA=;
        b=gDeuqDlALcjA5i4xQ7kuA4I4bktP5iS6c1p8/BmA9bPsFZYGidEywYCATUItQm9Fv/
         icsGtLZulxuSW4G4WR9Bh3XKeM5ZLfA1c+v319yme4D7cgvJ+4FHAKE8NqoUFkLW2ACJ
         dK7wogASU/Py8TTTHYu1sLujcphc37iR6V7Jf3fpeo4Cg2VUcVot3e70yUyhlKzoIM69
         rzAqWUom/hwjP4noEnmjQckRKK5aUldQJa4o8o0/Ca5UGLlxC6QMB4MpOfNGzLalPblN
         d2S88OrQYmPpObdwoI0vSVPpJWBC1xZJH1lIOE7oqeCiurMWiICLdsKxk1sQjwpE7Xmv
         LUEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=hzHTUz6pl9ZyKI05mVfzUHyl4/auI/ysaL3OyRsfPzA=;
        b=dF1Ei2wEJhzUmHhJmQsC5QZRX5mT1+bi/GGVY0z+F8wIv8e3NLFRGboigwUmj8zW60
         1jbC4umMaiiqOGCVPC5yBBDSOHrASnwdhetE+yAj/Y1teBz8Yw6mWdDNWbbPiYpXynKV
         Ib/OWdLXLdMsmpO4OvaaCS2gEyjaUd0/M+oq83FkgN03RO61IZ0Qd/x8QQHwuKerPS8z
         rQC9r78KhhT3DGqytQf5BFBuX624aZXQ2od9JkTJ7IPiivvAgKFxwFs0a8EVI+u8ok6h
         7rmWv9ikTFIpe3xl1mxnHFcwVsSK3Bmav3bBS2KMY/GPW55EI6qJO5OME+ZL90OqnwXG
         WpdA==
X-Gm-Message-State: AOAM532e6qsZ6FAxd7lFvSabRx2ocTTDFHO/69dp2i7QGjPKoZxiQJcr
        bGwtuyM2TMS2nFlobWNzxQpRSlHVdZ/nSA==
X-Google-Smtp-Source: ABdhPJyta5AsJghiJH+G7vD1wbNP2e1E9M6S+Ofg7+mSSiYFnim1NotIQ48pniOCaVBx4lcNQ95bpQ==
X-Received: by 2002:a17:907:781a:: with SMTP id la26mr25287283ejc.435.1621894893878;
        Mon, 24 May 2021 15:21:33 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id gl20sm8315120ejb.5.2021.05.24.15.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 15:21:33 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] t9001-send-email.sh: fix expected absolute paths on
 Windows
Date:   Tue, 25 May 2021 00:15:44 +0200
References: <bb30fe2b-cd75-4782-24a6-08bb002a0367@kdbg.org>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <bb30fe2b-cd75-4782-24a6-08bb002a0367@kdbg.org>
Message-ID: <87im37ojrn.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, May 24 2021, Johannes Sixt wrote:

Also CC-ing Robert Foss <robert.foss@linaro.org>, I last touched this
code, but the fallout is ultimately from his c8243933c74
(git-send-email: Respect core.hooksPath setting, 2021-03-23).

> Git for Windows is a native Windows program that works with native
> absolute paths in the drive letter style C:\dir. The auxiliary
> infrastructure is based on MSYS2, which uses POSIX style /C/dir.
>
> When we test for output of absolute paths produced by git.exe, we
> usally have to expect C:\dir style paths. To produce such expected
> paths, we have to use $(pwd) in the test scripts; the alternative,
> $PWD, produces a POSIX style path. ($PWD is a shell variable, and the
> shell is bash, an MSYS2 program, and operates in the POSIX realm.)
>
> There are two recently added tests that were written to expect C:\dir
> paths. The output that is tested is produced by `git send-email`, but
> behind the scenes, this is a Perl script, which also works in the
> POSIX realm and produces /C/dir style output.
>
> In the first test case that is changed here, replace $(pwd) by $PWD
> so that the expected path is constructed using /C/dir style.
>
> The second test case sets core.hooksPath to an absolute path. Since
> the test script talks to native git.exe, it is supposed to place a
> C:/dir style path into the configuration; therefore, keep $(pwd).
> When this configuration value is consumed by the Perl script, it is
> transformed to /C/dir style by the MSYS2 layer and echoed back in
> this form in the error message. Hence, do use $PWD for the expected
> value.
>
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---
>  When I say "the configuration is transformed to /C/dir style", I am
>  actually hand-waving: I can observe that a transformation must
>  happen somewhere, but I actually do not know where the conversion
>  really happens. "The MSYS2 layer" is my best qualified guess.
>
>  t/t9001-send-email.sh | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
> index 65b3035371..68bebc505b 100755
> --- a/t/t9001-send-email.sh
> +++ b/t/t9001-send-email.sh
> @@ -539,15 +539,14 @@ test_expect_success $PREREQ "--validate respects relative core.hooksPath path" '
>  	test_path_is_file my-hooks.ran &&
>  	cat >expect <<-EOF &&
>  	fatal: longline.patch: rejected by sendemail-validate hook
> -	fatal: command '"'"'$(pwd)/my-hooks/sendemail-validate'"'"' died with exit code 1
> +	fatal: command '"'"'$PWD/my-hooks/sendemail-validate'"'"' died with exit code 1
>  	warning: no patches were sent
>  	EOF
>  	test_cmp expect actual
>  '
>  
>  test_expect_success $PREREQ "--validate respects absolute core.hooksPath path" '
> -	hooks_path="$(pwd)/my-hooks" &&
> -	test_config core.hooksPath "$hooks_path" &&
> +	test_config core.hooksPath "$(pwd)/my-hooks" &&
>  	test_when_finished "rm my-hooks.ran" &&
>  	test_must_fail git send-email \
>  		--from="Example <nobody@example.com>" \
> @@ -558,7 +557,7 @@ test_expect_success $PREREQ "--validate respects absolute core.hooksPath path" '
>  	test_path_is_file my-hooks.ran &&
>  	cat >expect <<-EOF &&
>  	fatal: longline.patch: rejected by sendemail-validate hook
> -	fatal: command '"'"'$hooks_path/sendemail-validate'"'"' died with exit code 1
> +	fatal: command '"'"'$PWD/my-hooks/sendemail-validate'"'"' died with exit code 1
>  	warning: no patches were sent
>  	EOF
>  	test_cmp expect actual

Does this alternate patch[1] also fix the issue? I don't have a Windows
system on which to test this, but it seems to me like it should.

I.e. the issue seems to me to me that we have an absolute path from
--git-path, and one of Cwd.pm's or File::Spec.pm's ideas of what that
absolute path should look like differs from ours.

We have a sprinkle of File::Spec->file_name_is_absolute($dir) in Git.pm
for some other stuff to deal with the same scenario, but I don't see why
we need the abs_path() here at all.

Either we have a relative path from "rev-parse --git-dir hooks", or an
absolute one, in either case we feed it to Perl's
system("some-relative-or-absolute-path").

I have a parallel series where I did some send-email changes by just
extracting the relevant code from Git.pm, since there were objections to
changing the "public API". But in this case there's been no release with
this, so presumably it's fine to just change it.

1.

diff --git a/perl/Git.pm b/perl/Git.pm
index 73ebbf80cc6..df6280ebab5 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -629,8 +629,7 @@ sub hooks_path {
 	my ($self) = @_;
 
 	my $dir = $self->command_oneline('rev-parse', '--git-path', 'hooks');
-	my $abs = abs_path($dir);
-	return $abs;
+	return $dir;
 }
 
 =item wc_path ()
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 65b30353719..9c518462c3e 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -539,7 +539,7 @@ test_expect_success $PREREQ "--validate respects relative core.hooksPath path" '
 	test_path_is_file my-hooks.ran &&
 	cat >expect <<-EOF &&
 	fatal: longline.patch: rejected by sendemail-validate hook
-	fatal: command '"'"'$(pwd)/my-hooks/sendemail-validate'"'"' died with exit code 1
+	fatal: command '"'"'my-hooks/sendemail-validate'"'"' died with exit code 1
 	warning: no patches were sent
 	EOF
 	test_cmp expect actual
