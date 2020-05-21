Return-Path: <SRS0=Ny9l=7D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB0BAC433E0
	for <git@archiver.kernel.org>; Thu, 21 May 2020 18:36:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7514A20826
	for <git@archiver.kernel.org>; Thu, 21 May 2020 18:36:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kY/VGbz/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729593AbgEUSgF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 May 2020 14:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728240AbgEUSgF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 May 2020 14:36:05 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAD47C061A0E
        for <git@vger.kernel.org>; Thu, 21 May 2020 11:36:03 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id z6so9486748ljm.13
        for <git@vger.kernel.org>; Thu, 21 May 2020 11:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qeZfaBn94SUE4yZ6HewoyMJZmnEnux+7kkcF4+IcMZI=;
        b=kY/VGbz/+5LBMZ3UBFj+CJf+yQ8O/OUJ/xpUKRzJgqzd7WN+21nT3wpC535xnKgz3+
         AHAxQ9XFsoyN3e2y7fDU8QHC9DJD20mkFdTYHG0zy1FGK6d1zQKJR5sCpzuWLUFVTTV0
         ZSDK048ZHPP56NHqnohCwFb1qIxIskFIWTS5G7FhnrnSlCQPf02BCQaaTG5nZ4DY9dh/
         IEky66Ko2kIAYXuPIw0uVbtHvDV3Wxg5r3a/xfp7XFUXOGxnq1Cf8MXG4BQZhHZjBlrx
         IL9IqoN5clGJJ0UW+JoO+4iHK1wdaxyX+/LDFtgaX80AjOs1AxAbt3MzxzWWhRMR92KI
         TDag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=qeZfaBn94SUE4yZ6HewoyMJZmnEnux+7kkcF4+IcMZI=;
        b=pofv5jLrLLCRtx69oduvEFyeFeP6cNyJZCrs1cDY+rFF9iOFySfbv3W8s5uSzATHxL
         0Vb7LrdAhN0O8rQNeHaKpscFcnLv22q4hNzCzG+j7eoC/Z5l4ZEVNYRNAek0UcmR6TTV
         a8kDNINipppli9TmgXaFcIXcuTBjNQszjtCldcXwj+017HB/XKkTG7notIrDx+Wl7+1X
         VG3Qhi3RBgdREhRafOABd+qS2vpgJoidm3X1n6zMOAvhF/HVDEIYpzJ7bobdanBeLv2g
         22UexRyT9bVZToc7GN/1gxwdzMqhhZ9jsXAPiWIyPQI9vFtzLi4D6S9f1pX5oZ+yLRLF
         Ovbw==
X-Gm-Message-State: AOAM5326U38MRsxc20CunwPO+dh5U9fCpDXcYSPVOzNGIyfvAotWUaNY
        6Be78YFWgXbEJjkJ5W64vj0oKs+y
X-Google-Smtp-Source: ABdhPJypxSWdVZXbdbZaaxL7hsUZLH7hzpWu8MK8+8mrSNOzDaFU3CYiDuEeLxBLBpVyLWuFEPMxlA==
X-Received: by 2002:a2e:994b:: with SMTP id r11mr3066000ljj.331.1590086161976;
        Thu, 21 May 2020 11:36:01 -0700 (PDT)
Received: from uncleman.localhost.localhost (dygyyw1rfqhphgdtwzl6t-4.rev.dnainternet.fi. [2001:14bb:140:955:c469:9862:8e12:a275])
        by smtp.gmail.com with ESMTPSA id p23sm1158533ljh.117.2020.05.21.11.36.01
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 11:36:01 -0700 (PDT)
From:   =?UTF-8?q?Ville=20Skytt=C3=A4?= <ville.skytta@iki.fi>
To:     git@vger.kernel.org
Subject: [PATCH] completion: don't override given stash subcommand with -p
Date:   Thu, 21 May 2020 21:35:59 +0300
Message-Id: <20200521183559.14744-1-ville.skytta@iki.fi>
X-Mailer: git-send-email 2.27.0.rc1.dirty
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

df70b190 (completion: make stash -p and alias for stash push -p,
2018-04-20) wanted to make sure "git stash -p <TAB>" offers the same
completion as "git stash push -p <TAB>", but it did so by forcing the
$subcommand to be "push" whenever then "-p" option is found on the
command line.

This harms any subcommand that can take the "-p" option---even when the
subcommand is explicitly given, e.g. "git stash show -p", the code added
by the change would overwrite the $subcommand the user gave us.

Fix it by making sure that the defaulting to "push" happens only when
there is no $subcommand given yet.

Signed-off-by: Ville Skyttä <ville.skytta@iki.fi>
---
 contrib/completion/git-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 70ad04e1b2..8dc4ad0e0d 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2782,7 +2782,7 @@ _git_stash ()
 	local save_opts='--all --keep-index --no-keep-index --quiet --patch --include-untracked'
 	local subcommands='push list show apply clear drop pop create branch'
 	local subcommand="$(__git_find_on_cmdline "$subcommands save")"
-	if [ -n "$(__git_find_on_cmdline "-p")" ]; then
+	if [ -z "$subcommand" -a -n "$(__git_find_on_cmdline "-p")" ]; then
 		subcommand="push"
 	fi
 	if [ -z "$subcommand" ]; then
-- 
2.27.0.rc1.dirty

