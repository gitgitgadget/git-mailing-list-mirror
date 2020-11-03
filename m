Return-Path: <SRS0=XO6Y=EJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D840FC2D0A3
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 15:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D0D920786
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 15:55:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N5U0BC50"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728048AbgKCPzg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Nov 2020 10:55:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726581AbgKCPzf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Nov 2020 10:55:35 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 175C2C0613D1
        for <git@vger.kernel.org>; Tue,  3 Nov 2020 07:55:34 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id w14so19057486wrs.9
        for <git@vger.kernel.org>; Tue, 03 Nov 2020 07:55:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=2fm9E7TQZF5AhRKf0uwkMPtUvSGUuzDxN/Spzxq5m6Y=;
        b=N5U0BC509lpQSsg1r8q6i1ZnS5fumM4qA2TQD5PPVWY6Ne/COIuiThjlVdexH3LrvP
         Vexq+rrtI1agGSJLh89bl/CEMjgsuL7OwMABOT1EdCYk37WpOK2NwXjnjEp9iWmeLVrh
         XAXjuhTDJZpQ9rGVnPc2KOxR2hWQGsjYocDc8r8EDz31yl+j1xsyYvan1vlnnTaSoAgf
         B0XvaXQEnGMyjzRgOT2QYbHGQGVRUG9blKUtEqs11umV2qwW/b/Z7uCSz3wc9E/B8pR8
         hVCJVzUB/VnwyGynbgN1gJdNvdFn/04MqoAfqg4Ymrvpr0gPSYTsepflmqOQpocWdASE
         YCPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=2fm9E7TQZF5AhRKf0uwkMPtUvSGUuzDxN/Spzxq5m6Y=;
        b=GDTqW7i0vlDHPODonCdPQ+aZU6B7R8teBEftViFqS9Qhzh9k0n65ROvfnYJZTZ9/u/
         taZ3gV6+uJBk3RAbMksRAzjJNhFUS3HoRO+FpD2Ln+qqTohOEiCWzvY8EZ3OUtodXLnw
         uw8Zalfg2JE64aCWWIHzzuTt30k8vva4pLefw0tmmSdneDXNwKuUrriN+JNjG7FOlnky
         NjRqTGRjlOYqb1Nm/afD8Zq72BrmL5mKoWP4FuiQeiwPAVoJ2KoQzPQpySE6Jxv3EUDQ
         NbXJ5Q2tY2UpRdDx1mZz0ARu9+qKER+9erdIyr4XLES3fP7kICFsfTnnEcG68g4gXCHM
         S4Tw==
X-Gm-Message-State: AOAM530ONYK3SHREArq7mbikCOVLS7Vfp/Ig5Mjx3ZUp7sCjDnSIeTgF
        v86b4/AqIFNB1XMfFOq0Hmd6RLWtNbo=
X-Google-Smtp-Source: ABdhPJysxHRH1tYaagrO5amk3T2Y5BqWGehGCRo10KMTSbCw2vZHZGIllR5bM94PGYhWZ474Zlem2A==
X-Received: by 2002:a5d:4d0d:: with SMTP id z13mr25819900wrt.23.1604418932671;
        Tue, 03 Nov 2020 07:55:32 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 71sm26748976wrm.20.2020.11.03.07.55.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 07:55:31 -0800 (PST)
Message-Id: <pull.778.git.1604418931303.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 03 Nov 2020 15:55:31 +0000
Subject: [PATCH] ci: make the whitespace checker more robust
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     "Chris. Webster" <chris@webstech.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In 32c83afc2c69 (ci: github action - add check for whitespace errors,
2020-09-22), we introduced a GitHub workflow that automatically checks
Pull Requests for whitespace problems.

However, when affected lines contain one or more double quote
characters, this workflow failed to attach the informative comment
because the Javascript snippet incorrectly interpreted these quotes
instead of using the `git log` output as-is.

Let's fix that.

While at it, let's `await` the result of the `createComment()` function.

Finally, we enclose the log in the comment with ```...``` to avoid
having the diff marker be misinterpreted as an enumeration bullet.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    ci: make the whitespace checker more robust
    
    I noticed that the checker failed to add a comment
    [https://github.com/gitgitgadget/git/runs/1344883313?check_suite_focus=true] 
    in one of my PRs. Turns out that the double-quote characters in the log
    output made it fail.
    
    One thing we discussed earlier whether the log should be pasted as
    pre-formatted text or not, and we fell on the side of not pre-formatting
    it. However, in my tests, this does not look right
    [https://github.com/dscho/git/pull/18#issuecomment-721160985], and it 
    looks much better pre-formatted
    [https://github.com/dscho/git/pull/18#issuecomment-721167209] (even if
    we unfortunately lose the direct link to the commit
    [https://github.com/dscho/git/commit/68317764849af81b17c4b31906da20bdf2c52082]
    ).

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-778%2Fdscho%2Ffix-whitespace-github-workflow-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-778/dscho/fix-whitespace-github-workflow-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/778

 .github/workflows/check-whitespace.yml | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/.github/workflows/check-whitespace.yml b/.github/workflows/check-whitespace.yml
index 9d070b9cdf..80a961716b 100644
--- a/.github/workflows/check-whitespace.yml
+++ b/.github/workflows/check-whitespace.yml
@@ -58,12 +58,14 @@ jobs:
     - name: Add Check Output as Comment
       uses: actions/github-script@v3
       id: add-comment
+      env:
+        log: ${{ steps.check_out.outputs.checkout }}
       with:
         script: |
-            github.issues.createComment({
+            await github.issues.createComment({
               issue_number: context.issue.number,
               owner: context.repo.owner,
               repo: context.repo.repo,
-              body: "Whitespace errors found in workflow ${{ github.workflow }}:\n\n${{ steps.check_out.outputs.checkout }}"
+              body: `Whitespace errors found in workflow ${{ github.workflow }}:\n\n\`\`\`\n${process.env.log.replace(/\\n/g, "\n")}\n\`\`\``
             })
       if: ${{ failure() }}

base-commit: 32c83afc2c69aa51b82aa223f2099389f1f0be0a
-- 
gitgitgadget
