Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 679B61F453
	for <e@80x24.org>; Thu,  7 Feb 2019 23:45:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbfBGXpu (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Feb 2019 18:45:50 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44402 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbfBGXpu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Feb 2019 18:45:50 -0500
Received: by mail-wr1-f67.google.com with SMTP id v16so1680595wrn.11
        for <git@vger.kernel.org>; Thu, 07 Feb 2019 15:45:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=zY7iGdI/BcTwJP9Q41OdyT75LBQQxPhKHWCGyVc/GWk=;
        b=ZcJod/cOCvuAlPm23aoLGmK4KVd1/+MPzyzhy15vxUkLHQKRrltbmzdmv4Vjtq0oxB
         iBAFxs+GrpqkKazBs3IwOvDEqe8lQAYjRGG9HK3FWtXCdlf9e8R18fVnjLsSF/2NKWBA
         k+i3YA0op+M2pXU2jGxuLM3oXgPJLfiuU7yHBnEEy/bW2I5a3HXSAxQhKkKp/LhHPC1w
         EFmFsYwDJiaCAM/bosh0xmuVMYhrs7BQ1BIbYUx2s7MeneL5hx82qzA7hd/iR1rcZMIk
         8OTR1HNxgxQZHfe/a9P62qaezXIsW6tZSNVjM+6Z9L4EKbGRP8P64jHB5g0v0T0ZD9qB
         GH9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=zY7iGdI/BcTwJP9Q41OdyT75LBQQxPhKHWCGyVc/GWk=;
        b=CAtO3eBuxIHTWyVb6n1nh7ntG0PDz1smMczRSm6lHNCVvCaa4v9BA9Pyd8NewxE/Yd
         iYLiRxe+ObHObxVbibqNWNLRyMtte+QDpRzdbytZxj/x5dq66gPXjAaLbD0EEp7P0LRc
         RnCaIO5JNXJSIKkUhvFY9CseXtuaGIaAHD2EjdzQsR16UMKd0MWnMUMKrqWxZW6gg1/F
         3xohMXf77wxV4XJ559PlSpMBSav+qgCysiy2jOeOS7avtomZB5MI0zWjAxOJ/+um37Ia
         ZDRaAR/hPBTz+iWb3A/oE1QL5yT3ZgAk0qIBxbEtOdM1TkQvncWwPtL+R5EXp474izgD
         CRFg==
X-Gm-Message-State: AHQUAuYB3vbyenx9/X0+LDSvFeQxE/1cA2pL8NSuEcM4SHb2QvqD1nHw
        gwbQLbxIyUftN3iifDJKhM6X/ydx
X-Google-Smtp-Source: AHgI3IZ8VRC01vNAtHHbV82IqctWwmFORGspJ1cL17LVpYj23nnj4c1Hhg09G8+0m6FJo2Uh55Wwyw==
X-Received: by 2002:a5d:4ecd:: with SMTP id s13mr6084665wrv.110.1549583147789;
        Thu, 07 Feb 2019 15:45:47 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id e27sm734507wra.67.2019.02.07.15.45.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Feb 2019 15:45:47 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] ci: clear and mark MAKEFLAGS exported just once
References: <20190207183736.9299-1-szeder.dev@gmail.com>
        <xmqqbm3npgox.fsf@gitster-ct.c.googlers.com>
        <xmqq1s4jpgh6.fsf@gitster-ct.c.googlers.com>
        <xmqqsgwzo0ib.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1902072331060.41@tvgsbejvaqbjf.bet>
        <xmqqh8dfmawn.fsf@gitster-ct.c.googlers.com>
Date:   Thu, 07 Feb 2019 15:45:46 -0800
In-Reply-To: <xmqqh8dfmawn.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Thu, 07 Feb 2019 15:33:28 -0800")
Message-ID: <xmqqd0o3mac5.fsf_-_@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Clearing it once upfront, and turning all the assignment into
appending, would future-proof the code even more, to prevent
mistakes the previous one fixed from happening again.

Also, mark the variable exported just once at the beginning.  There
is no point in marking it exported repeatedly.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
    >> So I'd rather clear `MAKEFLAGS` at the beginning (i.e. where you `export
    >> MAKEFLAGS`, I'd simply append a `=`).

    This time in proper patch form.

 ci/lib.sh | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/ci/lib.sh b/ci/lib.sh
index cee51a4cc4..288a5b3884 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -74,6 +74,9 @@ check_unignored_build_artifacts ()
 	}
 }
 
+# Clear MAKEFLAGS that may come from the outside world.
+export MAKEFLAGS=
+
 # Set 'exit on error' for all CI scripts to let the caller know that
 # something went wrong.
 # Set tracing executed commands, primarily setting environment variables
@@ -101,7 +104,7 @@ then
 	BREW_INSTALL_PACKAGES="git-lfs gettext"
 	export GIT_PROVE_OPTS="--timer --jobs 3 --state=failed,slow,save"
 	export GIT_TEST_OPTS="--verbose-log -x --immediate"
-	export MAKEFLAGS="--jobs=2"
+	MAKEFLAGS="$MAKEFLAGS --jobs=2"
 elif test -n "$SYSTEM_COLLECTIONURI" || test -n "$SYSTEM_TASKDEFINITIONSURI"
 then
 	CI_TYPE=azure-pipelines
@@ -126,7 +129,7 @@ then
 	BREW_INSTALL_PACKAGES=gcc@8
 	export GIT_PROVE_OPTS="--timer --jobs 10 --state=failed,slow,save"
 	export GIT_TEST_OPTS="--verbose-log -x --write-junit-xml"
-	export MAKEFLAGS="--jobs=10"
+	MAKEFLAGS="$MAKEFLAGS --jobs=10"
 	test windows_nt != "$CI_OS_NAME" ||
 	GIT_TEST_OPTS="--no-chain-lint --no-bin-wrappers $GIT_TEST_OPTS"
 else
@@ -185,4 +188,4 @@ GIT_TEST_GETTEXT_POISON)
 	;;
 esac
 
-export MAKEFLAGS="$MAKEFLAGS CC=${CC:-cc}"
+MAKEFLAGS="$MAKEFLAGS CC=${CC:-cc}"
-- 
2.21.0-rc0

