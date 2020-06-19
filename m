Return-Path: <SRS0=lJm1=AA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62952C433E0
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 16:03:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3659421532
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 16:03:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uPjXQMfH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405453AbgFSQDS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Jun 2020 12:03:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403850AbgFSQDR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jun 2020 12:03:17 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16743C06174E
        for <git@vger.kernel.org>; Fri, 19 Jun 2020 09:03:16 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id v3so2709369wrc.1
        for <git@vger.kernel.org>; Fri, 19 Jun 2020 09:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=kosJ5mfqFB1nRiWqET/+bGT86dk6zSEW9ulSMEAb0pY=;
        b=uPjXQMfHzZo2XPQd4NUJjMtVnizhQywzrSSIAgl+mS/H38eyA/WCze8gnomiiPDAFS
         pl5pFxZSQSVrbspOH3Hr8iTVMYcX3FHKmTKtyoQwm61m6lLP141C7uiunuSeDt0GlAMn
         LjhJJq7P4DLx5fYLNqKBqgHspuPQzxBKBc3S4jHriWcH+nHAbcnSuK75mAQOMGqNfEh9
         y5CjU/v8rtCYkei0176v3ghygI5VO21uM2NlEG214axQf1yj7mlvgUgny7xNReSJMjL2
         bgaAUFIBrrrPmR0G96L3EaaajHxK11BMeixtISMyCBvtMTNN07+wpxxRTxBuSzweDtJw
         nv/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=kosJ5mfqFB1nRiWqET/+bGT86dk6zSEW9ulSMEAb0pY=;
        b=sM2P91TzIRBAGXrFnFydwHRG0B/jbuPDu6Y1iSUrJD+yniFtYKdyl42aVrOKDZ0FYo
         N4MChbjTwgGQcBmYVsMeet+XweU9JzxPaA9lcV1rmFIO198ZoPGUcTmjl5irNdrzRmUU
         +WPmKjJaeXipt+R0uBWrNUhJB3UK4MmKR0lptE+HqdsJrwZxmAHp2LYqNOfrMV33P8Wo
         jLAzS6FzPGwh/3JWvcZ0O/ZgBGfih3qTU/qCAoeFMQIoLjkbSLaLs9iM3xNs6KiJDFkg
         ISuReicGWKgogyOsEbl9ulFPDafLicDJfTqV4K5n40S+oe9olb5mhBzNEEf/pFZi1H8I
         3gnw==
X-Gm-Message-State: AOAM530yBIwekfixlgjaCysUx6TSmmS58RYWO4HrUame2jDSoNBKV9QF
        D+S1gHVjoYiZzZz8bIaJvVxrLqUi
X-Google-Smtp-Source: ABdhPJw0NbOQSpgW6apw3mZhVWDZPQ/4XjmJR7Yac3nK+jGEGo6hypPA0PUIDQL/tlJ4Fw/fHaohig==
X-Received: by 2002:a5d:4d92:: with SMTP id b18mr5087595wru.296.1592582595564;
        Fri, 19 Jun 2020 09:03:15 -0700 (PDT)
Received: from szeder.dev (62-165-236-97.pool.digikabel.hu. [62.165.236.97])
        by smtp.gmail.com with ESMTPSA id b8sm7554998wrm.35.2020.06.19.09.03.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Jun 2020 09:03:14 -0700 (PDT)
Date:   Fri, 19 Jun 2020 18:03:12 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH v17 16/17] Add reftable testing infrastructure
Message-ID: <20200619160312.GH2898@szeder.dev>
References: <pull.539.v16.git.1591380199.gitgitgadget@gmail.com>
 <pull.539.v17.git.1592335242.gitgitgadget@gmail.com>
 <4f24b5f73ded722b5a06b44cb3a43a9f497598bf.1592335243.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4f24b5f73ded722b5a06b44cb3a43a9f497598bf.1592335243.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 16, 2020 at 07:20:41PM +0000, Han-Wen Nienhuys via GitGitGadget wrote:
> * Add GIT_TEST_REFTABLE environment var to control default ref storage
> 
> * Add test_prerequisite REFTABLE.
> 
> * Skip some tests that are incompatible:

>   * t9903-bash-prompt - The bash mode reads .git/HEAD directly

The patch below fixes this incompatibility, relying on the fact that
the reftable specs clearly specify what must be written to the
placeholder '.git/HEAD'.  You can queue this as a preparatory patch to
this series.

Note, however, that, as poined out in my other email, the current
reftable code doesn't follow the specs WRT what must be written to
'.git/HEAD'.  The patch below follows the code, not the specs, so it
will have to be updated as well.

  ---  >8  ---

Subject: [PATCH] git-prompt: prepare for reftable refs backend

In our git-prompt script we strive to use Bash builtins wherever
possible, because fork()-ing subshells for command substitutions and
fork()+exec()-ing Git commands are expensive on some platforms.  We
even read and parse '.git/HEAD' using Bash builtins to get the name of
the current branch [1].  However, the upcoming reftable refs backend
won't use '.git/HEAD' at all, but will write an invalid refname as
placeholder for backwards compatibility instead, which will break our
git-prompt script.

Update the git-prompt script to recognize the placeholder '.git/HEAD'
written by the reftable backend (its content is specified in the
reftable specs), and then fall back to use 'git symbolic-ref' to get
the name of the current branch.

[1] 3a43c4b5bd (bash prompt: use bash builtins to find out current
    branch, 2011-03-31)

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 contrib/completion/git-prompt.sh | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index 014cd7c3cf..708d0b4b95 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -460,10 +460,15 @@ __git_ps1 ()
 			if ! __git_eread "$g/HEAD" head; then
 				return $exit
 			fi
-			# is it a symbolic ref?
 			b="${head#ref: }"
 			if [ "$head" = "$b" ]; then
 				detached=yes
+			elif [ "$b" = "refs/.invalid" ]; then
+				# Reftable
+				b="$(git symbolic-ref HEAD 2>/dev/null)" ||
+				detached=yes
+			fi
+			if [ "$detached" = yes ]; then
 				b="$(
 				case "${GIT_PS1_DESCRIBE_STYLE-}" in
 				(contains)
-- 
2.27.0.365.g477ada09ef

