Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98558C433DB
	for <git@archiver.kernel.org>; Sun, 24 Jan 2021 17:08:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71ABD22511
	for <git@archiver.kernel.org>; Sun, 24 Jan 2021 17:08:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726305AbhAXRIM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Jan 2021 12:08:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbhAXRHs (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Jan 2021 12:07:48 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E40B5C06174A
        for <git@vger.kernel.org>; Sun, 24 Jan 2021 09:07:07 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id n25so7355801pgb.0
        for <git@vger.kernel.org>; Sun, 24 Jan 2021 09:07:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ViXmFBzQ+/qpchAFb5bLM28xzO1lcwQ8ijh1Mo/eRpI=;
        b=hlhDjloJ6b1YvErtLOh8Uih1JG1e0opn49G2xRoccdv9j0z+43TfCZhHegbpNTdGG6
         675MVZhLVoG7iBCWrKvforxfz/30BAp0aEn8A3nd6GSadPcnXCwGEnl2cA1jmsPgd584
         f8pU2UG49ElimlTL8bbY3d6YxVKQbkIarGtkNP2ISRECDwzsXXw+eLpiUjBBTm7aFRpr
         k56TndNE8fh9jsTz+4NkvlnKx1G5nz6DIUnfibKPb2RV4nknbLtobdQDn24B/Lv0RqFr
         vQravZnhmQEvMh9H490Hu9u407cxtqIA1JoIdQ9jQjv6NVTeatFk/fPabrbBhcUx8HXV
         cVuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ViXmFBzQ+/qpchAFb5bLM28xzO1lcwQ8ijh1Mo/eRpI=;
        b=dDH14n00lXjbTWf/ih8ZHxgNk7leCT558liWeFV7plKe4vHpTDJGepTDc6xbTQG20I
         JA92gLLQMFEo23OeIcYwvwgsDDq14xQkzefOvZDy7oxFz5slDk8r2AAJmNRxB4jwAq65
         5uCuJck7vf0Ks2/L1OzRMryInHIKfsPOw4c+HOjvH8Z9Ekm0teTB2AvT6/8OUc37n8u+
         uVtZISfgpt/ChMnSBV+sWyu0nd5DonheGvtLSWpGFYFezR/jPizQ1VMQvv/3+wpmwahB
         muVzyUt9+YzYjV6TzQ0/fIMVmOWY1OGqY9a7PRjM1IlywBW79DxNFhF5J7BIBv9Iy8kf
         lXVw==
X-Gm-Message-State: AOAM530l+M4G3Rqdh3TPOWmKOezdqry6MoZm2el74+VklBak0XDJC64w
        eS/UYriRErZHmRtOZzmw7y6VM36iYnJS+g==
X-Google-Smtp-Source: ABdhPJxueNFq61ScMa/j2jtgB913xkTvBVBrGM7JRqv+/cXHy/3xIBGIgGsbcmup5RZvdXzExfVOOQ==
X-Received: by 2002:a63:5526:: with SMTP id j38mr14473093pgb.177.1611508027299;
        Sun, 24 Jan 2021 09:07:07 -0800 (PST)
Received: from localhost.localdomain ([2409:4050:2d0e:58a:f516:739c:ea0e:a6ba])
        by smtp.googlemail.com with ESMTPSA id r30sm16283308pjg.43.2021.01.24.09.07.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Jan 2021 09:07:06 -0800 (PST)
From:   Charvi Mendiratta <charvi077@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, christian.couder@gmail.com,
        marcnarc@xiplink.com, phillip.wood123@gmail.com,
        Charvi Mendiratta <charvi077@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v3 9/9] doc/git-rebase: add documentation for fixup [-C|-c] options
Date:   Sun, 24 Jan 2021 22:34:07 +0530
Message-Id: <20210124170405.30583-10-charvi077@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1
In-Reply-To: <20210124170405.30583-1-charvi077@gmail.com>
References: <20210119074102.21598-1-charvi077@gmail.com>
 <20210124170405.30583-1-charvi077@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Reviewed-by: Marc Branchaud <marcnarc@xiplink.com>
Signed-off-by: Charvi Mendiratta <charvi077@gmail.com>
---
 Documentation/git-rebase.txt | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index a0487b5cc5..a6903419c4 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -887,9 +887,17 @@ If you want to fold two or more commits into one, replace the command
 "pick" for the second and subsequent commits with "squash" or "fixup".
 If the commits had different authors, the folded commit will be
 attributed to the author of the first commit.  The suggested commit
-message for the folded commit is the concatenation of the commit
-messages of the first commit and of those with the "squash" command,
-but omits the commit messages of commits with the "fixup" command.
+message for the folded commit is the concatenation of the first
+commit's message with those identified by "squash" commands, omitting the
+messages of commits identified by "fixup" commands, unless "fixup -c"
+is used.  In that case the suggested commit message is only the message
+of the "fixup -c" commit, and an editor is opened allowing you to edit
+the message.  The contents (patch) of the "fixup -c" commit are still
+incorporated into the folded commit. If there is more than one "fixup -c"
+commit, the message from the last last one is used.  You can also use
+"fixup -C" to get the same behavior as "fixup -c" except without opening
+an editor.
+
 
 'git rebase' will stop when "pick" has been replaced with "edit" or
 when a command fails due to merge errors. When you are done editing
-- 
2.29.0.rc1

