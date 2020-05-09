Return-Path: <SRS0=Fs4s=6X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_STARTS_WITH_NUMS,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0150C28CBC
	for <git@archiver.kernel.org>; Sat,  9 May 2020 19:15:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7143A20722
	for <git@archiver.kernel.org>; Sat,  9 May 2020 19:15:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aG/sN8QU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728144AbgEITPx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 May 2020 15:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727938AbgEITPx (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 9 May 2020 15:15:53 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B81D8C061A0C
        for <git@vger.kernel.org>; Sat,  9 May 2020 12:15:51 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id 72so4332269otu.1
        for <git@vger.kernel.org>; Sat, 09 May 2020 12:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=Ntq/pxa5H5NhrD+C9cf+4c62xPqP/oDRoZpfTIUS8NI=;
        b=aG/sN8QU9mfID6W1Kuz5RVBpCfgSxcJiViKo+JK6Gh43IoFlkmlkzqoS0k2WWFvAzg
         i6Wzy0DgNvHZc1cSvk+P3w2cC+wU+et3Ui9Rf5RsN3FEsdlY5wr1KljJSUxlKzK2Q9Dh
         S1erSVnOrzHJSQc1XJ8dbYH+EswpIm4Ybuvxf6EAmBNuZ4wEp0rKKBo4CcgK6gofsh03
         bXR/3r63+GDfnx97MIURGcrxMYmNHkyx8VFwilT2JcrZzwbM3L7LwAPeO6715lD9V8C2
         HccVF2WCgRvIXhXIuS2cmkmaSYWUcPDIcCTur+fLgPOlaAnekXpglAWSqCnKL50w/UuJ
         /5yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=Ntq/pxa5H5NhrD+C9cf+4c62xPqP/oDRoZpfTIUS8NI=;
        b=JHvjroyRxw01Qt8Va58564MOSuPOiUDFl81FMpHl8HUKQiAqwqeT2u49MtuOkieXWJ
         leZKDb17D/keRM9Nlyti2pqFQ0SRDfEk8MJRauDfFI41J78qBDa+6rMfjCEVKDOAiNcj
         c3AIOwo4qNaSkg+PzVgSi7IsmLC2ZeU+Cc7BExTRSCOQSdokOxRrRY6J4JetGUgZi0E7
         5L+P/c7HvvfBQ6q3A8F5JgM4WY6KumOvzwITxEWCnhLwuZBEiZJH8yxSUGebS8s209qk
         PodnKbDXRu15gMCogD9BEVvClH/EUNKuzq1aBKA2H0qmjVM8rpNBSFXV1PopWfLRQjQm
         6Pew==
X-Gm-Message-State: AGi0PuZnMN3CJNRlrLhWhzwXyv8fkzXjncsb8Ksa4N16naOK74ZCTn5e
        lknHLR6ceB5oWZ4zdLPeu9o/U96VHjWeWB/Of8rx3jRh
X-Google-Smtp-Source: APiQypK70Wh0z/HsWiDxrpjUioBE770FuXtOnVY2EG+5uuYye8urgw0wZ1T3KV0ngYP4dtfEV+VdGQNQkDwkxPGlvRs=
X-Received: by 2002:a9d:1eaa:: with SMTP id n39mr7198870otn.238.1589051750891;
 Sat, 09 May 2020 12:15:50 -0700 (PDT)
MIME-Version: 1.0
From:   George Brown <321.george@gmail.com>
Date:   Sat, 9 May 2020 20:15:40 +0100
Message-ID: <CAFKec1W0-OOQYypP-3VC=dJnuNDrykdQ2xibc=u4D=Zo6if-+Q@mail.gmail.com>
Subject: [PATCH] contrib/git-jump: cat output when not a terminal
To:     git@vger.kernel.org
Cc:     peff@peff.net
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

contrib/git-jump: cat output when not a terminal

The current usage to populate Vim's quickfix list cannot be used from
within the editor as it invokes another instance.

Check if stdout is to a terminal or not. If not simply cat the output.

Signed-off-by: George Brown <321.george@gmail.com>
---
 contrib/git-jump/git-jump | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/contrib/git-jump/git-jump b/contrib/git-jump/git-jump
index 931b0fe3a9..253341c64e 100755
--- a/contrib/git-jump/git-jump
+++ b/contrib/git-jump/git-jump
@@ -19,8 +19,12 @@ EOF
 }

 open_editor() {
-    editor=`git var GIT_EDITOR`
-    eval "$editor -q \$1"
+    if test -t 1; then
+        editor=`git var GIT_EDITOR`
+        eval "$editor -q \$1"
+    else
+        cat "$1"
+    fi
 }

 mode_diff() {
