Return-Path: <SRS0=90au=Z7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C394C04E30
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 14:16:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F16A20726
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 14:16:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M2UeWZjQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbfLIOQ4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Dec 2019 09:16:56 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42870 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727572AbfLIOQy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Dec 2019 09:16:54 -0500
Received: by mail-wr1-f67.google.com with SMTP id a15so16345052wrf.9
        for <git@vger.kernel.org>; Mon, 09 Dec 2019 06:16:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=2OWtz1ywBrk5hySH2j3HtFlNv2/6yPxzpHRoB9xHYA8=;
        b=M2UeWZjQWqJKM7jj8lFmHmFymrLvMV5tVEL+VoaC23DoIv+6seiFBDLrOtqEt8UyLg
         WPNhAUlXGDKX6a8QHzG0z+rHmDPMUHjFRqtpqaIDv5/QkRV9qtqc0Zm3I1caCADLcJQL
         XCPbM+NZuesOvInJ9uBp9Hbl66yp6yxYpewJ6pxPbDGubHUUlbegrUmVRJR7tRbDCUIk
         K+A+wi69pGTgBQ5G3fMruJ0dimRS+MbzvSFtTT9zi7QML7ZrhWo78a6BHFElm4oX5wfT
         XfxmpA0+X2yk8K2osV72+KyoZcZ0onzSmyJdJZsNd9ZTUioF9DjCoZxZbsqEExdG4plw
         Np2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=2OWtz1ywBrk5hySH2j3HtFlNv2/6yPxzpHRoB9xHYA8=;
        b=YPAqFt+yEcUHp1IY4LRfaVtMP0AWaW7C23NgieFLXGPukVZ9u54pA5ltj6GR5mozSU
         nWHrpx0+eXJkYPGWqgWUJVC6/mrySyFADErDttbDDkQVZ+cJj1mNO/2fKZS7Ik2Ymotn
         7sSXBh7lTs/CecksiiJ6xq/jI8cTXmPMyPKhYC2iCJpB4vC5ml/szKu5P7S7snED2VKT
         RgaJVLib2aA87jIOwLEQUoWUTGtBc6/ktRKLeRgHVwuRabBzD2ogR8BVgainlDK897nh
         nuA3e0LOHpHp7KZw0IIiRidLudUTlgFbljg8LgLvSwcd0myeeDQj2vwROOlFaLH4AGe+
         3riA==
X-Gm-Message-State: APjAAAV9aSEBrEe/yp76R5IXpjn/5zOIlakZXCi7Eq20K6UMQ8z8D2cv
        LahKiw3rGfB/I164Omq7MZ62UH0i
X-Google-Smtp-Source: APXvYqyG8s1QvyyU83IqnnzjWEjJfWefELEIEtojcfohD7GUa17NJNHSZHZeBdFM0edKiVLGiw6AHA==
X-Received: by 2002:a05:6000:11c3:: with SMTP id i3mr2406994wrx.244.1575901012629;
        Mon, 09 Dec 2019 06:16:52 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o15sm28954513wra.83.2019.12.09.06.16.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Dec 2019 06:16:52 -0800 (PST)
Message-Id: <d608f529a0e01e99c97e895ab483000da068a7ac.1575901009.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.675.git.git.1575901009.gitgitgadget@gmail.com>
References: <pull.675.git.git.1575901009.gitgitgadget@gmail.com>
From:   "Ben Keene via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 09 Dec 2019 14:16:48 +0000
Subject: [PATCH 2/3] git-p4: [usability] RCS Keyword failure should suggest
 help
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Ben Keene <seraphire@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Ben Keene <seraphire@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ben Keene <seraphire@gmail.com>

When applying a commit fails because of RCS keywords, Git
will fail the P4 submit. It would help the user if Git suggested that
the user set git-p4.attemptRCSCleanup to true.

Change the applyCommit() method that when applying a commit fails
becasue of the P4 RCS Keywords, the user should consider setting
git-p4.attemptRCSCleanup to true.

Signed-off-by: Ben Keene <seraphire@gmail.com>
---
 git-p4.py | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 0fa562fac9..856fe82079 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -1950,8 +1950,23 @@ def applyCommit(self, id):
                     # disable the read-only bit on windows.
                     if self.isWindows and file not in editedFiles:
                         os.chmod(file, stat.S_IWRITE)
-                    self.patchRCSKeywords(file, kwfiles[file])
-                    fixed_rcs_keywords = True
+                    
+                    try:
+                        self.patchRCSKeywords(file, kwfiles[file])
+                        fixed_rcs_keywords = True
+                    except:
+                        # We are throwing an exception, undo all open edits
+                        for f in editedFiles:
+                            p4_revert(f)
+                        raise
+            else:
+                # They do not have attemptRCSCleanup set, this might be the fail point
+                # Check to see if the file has RCS keywords and suggest setting the property.
+                for file in editedFiles | filesToDelete:
+                    if p4_keywords_regexp_for_file(file) != None:
+                        print("At least one file in this commit has RCS Keywords that may be causing problems. ")
+                        print("Consider:\ngit config git-p4.attemptRCSCleanup true")
+                        break
 
             if fixed_rcs_keywords:
                 print("Retrying the patch with RCS keywords cleaned up")
-- 
gitgitgadget

