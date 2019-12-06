Return-Path: <SRS0=yMBz=Z4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B978C2BBE2
	for <git@archiver.kernel.org>; Fri,  6 Dec 2019 13:08:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC3052075C
	for <git@archiver.kernel.org>; Fri,  6 Dec 2019 13:08:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qSfkr6UQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbfLFNId (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Dec 2019 08:08:33 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46545 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbfLFNIb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Dec 2019 08:08:31 -0500
Received: by mail-wr1-f67.google.com with SMTP id z7so7617433wrl.13
        for <git@vger.kernel.org>; Fri, 06 Dec 2019 05:08:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=FbYx9s5BzVDyeboThLHY4f9FslCWDrhTHE6FCY7J7qQ=;
        b=qSfkr6UQPbMcdoXANwgnxjui4K2v8vbx6DF/buFLBKqk/GLzP78ZrUywL5acjB4Su0
         fRK5cl5myHhrsGmNs6TBjNgELlGYe/NK0y9uto0+uuWiPlr+b8IJtaLNkf74v+3irjUq
         VHYfBuVjr0KTm7epVbaDA4bMXTXvF7sbEz3gIabDneVULhTaFqqc/xHyj3jETrSu4u+l
         /ZG4PAGJhLWWkMrovDCuRWcuxDvIzNPC9J8lGaoURJmSuOqjOV984kSr+MeGmp/cLA4L
         lTrpFxSMPNKDYVBv+9uuw+swKpqgR+vQCHwG82/NlaMhWS8XNy9xQADGiwiyRBGEPqL3
         vLTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=FbYx9s5BzVDyeboThLHY4f9FslCWDrhTHE6FCY7J7qQ=;
        b=CWQhvDzYd/3z9hRJ7fMgDWmOZwGEsGcxbX4zmOaX1T8VsZ4VPX/Gu4RBqVNbkoEC/9
         fwgjHhRRes4TpJCJuM2Cud2T1x9LOE1HJSpKqt34rq3IVztVVO7TNxIn5oNuhZspylm9
         qr9aWsaXF0QrxCW1Qu6eEeELwWs4h3xktkzgn4zTch0FmlH/+6LhX3740pwIwPzE+qjC
         VCNyoFe93ByyPknJHKuKidj2hkui97h9iZaKOhUKx3L7twWqs3cHWt6Kykxt0S/qk7yp
         Jj4PhUaaJlpj2NIOcbUsDOLudA9Ll6zeOGSG1gnc/883ZgXJXkwv6v1eXysZqQ2YXrlC
         XJCQ==
X-Gm-Message-State: APjAAAXEZ4t5m7d/JEJg5iM6WWnE1zWYvfetk7Iy4SP3aZ+3sa2BJ1ws
        c0mc4Pwippl9lER7pkpTl/Gvw5+a
X-Google-Smtp-Source: APXvYqzZIaPFJEF7PalObgJkqt0yD+fnL1F6e91NmO6I7/TH7ueJ4NHNbcqAYGI5OVeS6zw+46PkAQ==
X-Received: by 2002:a5d:65c5:: with SMTP id e5mr15688426wrw.311.1575637709133;
        Fri, 06 Dec 2019 05:08:29 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z12sm3390565wmd.16.2019.12.06.05.08.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Dec 2019 05:08:28 -0800 (PST)
Message-Id: <a8bd214c905ff76d3651eec05766ad5b774847e8.1575637705.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.172.git.1575637705.gitgitgadget@gmail.com>
References: <pull.172.git.1575637705.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 06 Dec 2019 13:08:21 +0000
Subject: [PATCH 3/7] t3701: add a test for the different `add -p` prompts
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The `git add -p` command offers different prompts for regular diff hunks
vs mode change pseudo hunks vs diffs deleting files.

Let's cover this in the regresion test suite, in preparation for
re-implementing `git add -p` in C.

For the mode change prompt, we use a trick that lets this test case pass
even on systems without executable bit, i.e. where `core.filemode =
false` (such as Windows): we first add the file to the index with `git
add --chmod=+x`, and then call `git add -p` with `core.filemode` forced
to `true`. The file on disk has no executable bit set, therefore we will
see a mode change.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t3701-add-interactive.sh | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 793ce28297..c90aaa25b0 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -105,7 +105,6 @@ test_expect_success 'revert works (commit)' '
 	grep "unchanged *+3/-0 file" output
 '
 
-
 test_expect_success 'setup expected' '
 	cat >expected <<-\EOF
 	EOF
@@ -274,6 +273,24 @@ test_expect_success FILEMODE 'stage mode and hunk' '
 
 # end of tests disabled when filemode is not usable
 
+test_expect_success 'different prompts for mode change/deleted' '
+	git reset --hard &&
+	>file &&
+	>deleted &&
+	git add --chmod=+x file deleted &&
+	echo changed >file &&
+	rm deleted &&
+	test_write_lines n n n |
+	git -c core.filemode=true add -p >actual &&
+	sed -n "s/^\(([0-9/]*) Stage .*?\).*/\1/p" actual >actual.filtered &&
+	cat >expect <<-\EOF &&
+	(1/1) Stage deletion [y,n,q,a,d,?]?
+	(1/2) Stage mode change [y,n,q,a,d,j,J,g,/,?]?
+	(2/2) Stage this hunk [y,n,q,a,d,K,g,/,e,?]?
+	EOF
+	test_cmp expect actual.filtered
+'
+
 test_expect_success 'setup again' '
 	git reset --hard &&
 	test_chmod +x file &&
-- 
gitgitgadget

