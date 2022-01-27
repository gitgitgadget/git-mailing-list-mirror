Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A901C433EF
	for <git@archiver.kernel.org>; Thu, 27 Jan 2022 03:41:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbiA0Dls (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jan 2022 22:41:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbiA0Dlp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jan 2022 22:41:45 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1980C06161C
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 19:41:44 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id u18so1820899edt.6
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 19:41:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=vMGmpUxRLbquf/RVzrkbXHZZ/frMj3Za/WYgWIdo9/g=;
        b=FoQtP9dmfYplxTBhGaQF36B9L/efiKpyKC+AbmeaLat0AvLGUENssHq5Li7rnjukMh
         JrzSNEW1TACLnYs12vNSA3kW3yyT18htEJYzXfwL5y+UPbb+h0Aazv61cSnf3OHPFEXs
         IghAejJ0pxpsdpGxUVbf3qV77sTK9q4EIRrfNWJ4V/3tMGjjgCAvLBv0Byq9hSLAu8ed
         k73iBFTtjYU7UB9zjTa+FPf9G/033K3nnIm6GcPBHRM2qmZ/xIOOKlk2T92SoQqqbLVG
         ffiv3lq+VlXQUzGQDFxPQRF4ooIC9I7F5pdqSzKaiLxpNcRNZ+SsX01c5F9MXQtz8H/E
         zU0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=vMGmpUxRLbquf/RVzrkbXHZZ/frMj3Za/WYgWIdo9/g=;
        b=TAuUigKZjgfqdTW9E3gxQ7W0/zT0fpc5AJJGrYY95Oy1FU27JM6ESRh6voXPcdV9qP
         ZxJFM1/POKGZRDX8eu9gWj75WMrkYTSsD4dPxTezI/tEUlIh0CPuvONgqZSmSh7GxRla
         PJJlmc6FEDVuCTgw3lEZsBUq8aMjXsYU4rhOZpVSJWPG9efvwDPE6RwqVwWnc7gauqbg
         fWBAeuHoXEX3CP4WJFd95qwK5pJJ4wMwSBD9a6oiA4DxHAdd9rQW5sh9XRqjZq8BKDzO
         KdeIL1RSs0yryaqR3PvgejLF8WRFavcXJT/f+kYAt/SkXwYxNbjN1KntFONZV0bCBIAX
         WtIg==
X-Gm-Message-State: AOAM531nLpjXUWOB5dBslbN8lV2AwyQAmyoG0Q4znQyBL8aNjw8SzqOQ
        9k+K9N/raeeIIyU++wujY+c=
X-Google-Smtp-Source: ABdhPJyVUvHOYFiWIquenjso1VEyxbPLkEqOpiaTG+R2xWs/1qtEjUlfqWZi4zTBb3jm/Xhm0mghWQ==
X-Received: by 2002:a05:6402:2807:: with SMTP id h7mr1915900ede.402.1643254902980;
        Wed, 26 Jan 2022 19:41:42 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id h3sm10657006edq.83.2022.01.26.19.41.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 19:41:42 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nCvfJ-003HIe-9q;
        Thu, 27 Jan 2022 04:41:41 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        jeffhost@microsoft.com
Subject: Re: [PATCH v2] test-lib: unset trace2 parent envvars
Date:   Thu, 27 Jan 2022 04:23:10 +0100
References: <82e51a52e20fbe13a5a898a0a2f6dbe1188e3fa3.1642116539.git.steadmon@google.com>
 <2b5e573c22f226cbdb07d931d470a37bca7ffe2b.1643234866.git.steadmon@google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <2b5e573c22f226cbdb07d931d470a37bca7ffe2b.1643234866.git.steadmon@google.com>
Message-ID: <220127.86r18tdeve.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jan 26 2022, Josh Steadmon wrote:

> The trace2 subsystem can inherit certain information from parent
> processes via environment variables; e.g., the parent command name and
> session ID. This allows trace2 to note when a command is the child
> process of another Git process, and to adjust various pieces of output
> accordingly.
>
> This behavior breaks certain tests that examine trace2 output when the
> tests run as a child of another git process, such as in `git rebase -x
> "make test"`.
>
> While we could fix this by unsetting the relevant variables in the
> affected tests (currently t0210, t0211, t0212, and t6421), this would
> leave other tests vulnerable to similar breakage if new test cases are
> added which inspect trace2 output.
>
> In t/test-lib.sh, we keep a pattern of permitted GIT_* environment
> variables. Variables matching /^GIT_TRACE.*/ are currently allowed via
> this pattern. We want to preserve this behavior, because it can be
> useful to collect trace output over the entire test suite. Instead of
> modifying the allow-pattern, we instead fix this issue by unsetting only
> the GIT_TRACE2_PARENT_NAME and GIT_TRACE2_PARENT_SID in t/test-lib.sh.
>
> Reported-by: Emily Shaffer <emilyshaffer@google.com>
> Signed-off-by: Josh Steadmon <steadmon@google.com>
> ---
> Updated commit message and added code comments to explain why we keep
> "TRACE" in the allow pattern.
>
>  t/test-lib.sh | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 0f7a137c7d..faf25ba1b2 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -432,7 +432,7 @@ EDITOR=:
>  unset VISUAL EMAIL LANGUAGE $("$PERL_PATH" -e '
>  	my @env = keys %ENV;
>  	my $ok = join("|", qw(
> -		TRACE
> +		TRACE	# Allow tracing in general, but see unsets below.

I think it would be good to turn that -e into a -we, which would tell
you why this doesn't work the way you think:

    Possible attempt to put comments in qw() list at -e line 14.
    Possible attempt to separate words with commas at -e line 14.

I.e. you added one string "#" to the array, and a string "Allow" etc.

I think replacing it with this would be clearer, and means that...

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 0f7a137c7d8..9a7611f412f 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -432,7 +432,7 @@ EDITOR=:
 unset VISUAL EMAIL LANGUAGE $("$PERL_PATH" -e '
 	my @env = keys %ENV;
 	my $ok = join("|", qw(
-		TRACE
+		TRACE(?!2_(?:PARENT_NAME|PARENT_SID)$)
 		DEBUG
 		TEST
 		.*_TEST


>  		DEBUG
>  		TEST
>  		.*_TEST
> @@ -449,6 +449,10 @@ unset VISUAL EMAIL LANGUAGE $("$PERL_PATH" -e '
>  unset XDG_CACHE_HOME
>  unset XDG_CONFIG_HOME
>  unset GITPERLLIB
> +# Unset trace environment variables that can interfere with trace output used in
> +# certain tests.
> +unset GIT_TRACE2_PARENT_NAME
> +unset GIT_TRACE2_PARENT_SID
>  TEST_AUTHOR_LOCALNAME=author
>  TEST_AUTHOR_DOMAIN=example.com
>  GIT_AUTHOR_EMAIL=${TEST_AUTHOR_LOCALNAME}@${TEST_AUTHOR_DOMAIN}
>
> base-commit: dcc0cd074f0c639a0df20461a301af6d45bd582e

...you won't need this hunk, since it'll be obvious that we're
specifically excluding those variables.

But more generally I think it's best to replace this with the below,
i.e. to also fold the nearby "unset" into this command which'll find
everything we need to unset for us, since it was doing most of the work
anyway.

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 0f7a137c7d8..ff4d4a553be 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -426,13 +426,12 @@ export LANG LC_ALL PAGER TZ COLUMNS
 EDITOR=:
 
 # A call to "unset" with no arguments causes at least Solaris 10
-# /usr/xpg4/bin/sh and /bin/ksh to bail out.  So keep the unsets
-# deriving from the command substitution clustered with the other
-# ones.
-unset VISUAL EMAIL LANGUAGE $("$PERL_PATH" -e '
+# /usr/xpg4/bin/sh and /bin/ksh to bail out.  So we'll need at least
+# one unconditional variable here, which might as well be VISUAL.
+unset VISUAL $("$PERL_PATH" -we '
 	my @env = keys %ENV;
 	my $ok = join("|", qw(
-		TRACE
+		TRACE(?!2_(?:PARENT_NAME|PARENT_SID)$)
 		DEBUG
 		TEST
 		.*_TEST
@@ -444,11 +443,20 @@ unset VISUAL EMAIL LANGUAGE $("$PERL_PATH" -e '
 		TRACE_CURL
 	));
 	my @vars = grep(/^GIT_/ && !/^GIT_($ok)/o, @env);
+	my @nongit = qw(
+		CDPATH
+		EMAIL
+		GITPERLLIB
+		GREP_OPTIONS
+		LANGUAGE
+		UNZIP
+		XDG_CACHE_HOME
+		XDG_CONFIG_HOME
+	);
+	push @vars => grep { exists $ENV{$_} } @nongit;
 	print join("\n", @vars);
 ')
-unset XDG_CACHE_HOME
-unset XDG_CONFIG_HOME
-unset GITPERLLIB
+
 TEST_AUTHOR_LOCALNAME=author
 TEST_AUTHOR_DOMAIN=example.com
 GIT_AUTHOR_EMAIL=${TEST_AUTHOR_LOCALNAME}@${TEST_AUTHOR_DOMAIN}
@@ -524,13 +532,6 @@ else
 	}
 fi
 
-# Protect ourselves from common misconfiguration to export
-# CDPATH into the environment
-unset CDPATH
-
-unset GREP_OPTIONS
-unset UNZIP
-
 case $(echo $GIT_TRACE |tr "[A-Z]" "[a-z]") in
 1|2|true)
 	GIT_TRACE=4
