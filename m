Return-Path: <SRS0=90au=Z7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B498CC04E30
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 16:10:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88BB2207FF
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 16:10:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S+JNHi2P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbfLIQKP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Dec 2019 11:10:15 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53543 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbfLIQKN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Dec 2019 11:10:13 -0500
Received: by mail-wm1-f65.google.com with SMTP id n9so15592099wmd.3
        for <git@vger.kernel.org>; Mon, 09 Dec 2019 08:10:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Aw86E2JesYnBke1UD3Cn25oDyN4i0P0DvTe/Iw1CwQU=;
        b=S+JNHi2PyX6IU5/Jf2Zo/p/EiYPKqIYmbWUJ4MAJdJP4OaMxvEgdDd25zEwFgrYWu2
         2jaM++fKj4r2GyEXwt2RX5RcnOJvFkLW9XqUwaKK++aL+rIq30LfV4EXlpRr4yAC1m1z
         7buJKH8efyGuXZuVGvfkJRwGM5qu9e59b6kzNE4IIAHq0owh45AdFKzdCF8rk+KXslBc
         MVUTu6KKp9eYNSCY9mq4U5OpEQOVTG9Ju/1Snvr+R+/Ak2QBpV/8QMYvUXcvdSOWzEr1
         5JLfRog5iXkKKhRmagCzKrBj3SVpF/L3VjttrNyykWD0sNBs20U0r8kBuwKIy+Y4FIzV
         4dxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Aw86E2JesYnBke1UD3Cn25oDyN4i0P0DvTe/Iw1CwQU=;
        b=M83IxbT7rVxzntEDRYW3A7Tjva/unLZW5EVAhxS3kbiRg5HQPUojLVp5g8Tccv9p9E
         l8AB/YlRewRbMWSu36im8UYriXSntJ4Wp28w+hjw8loMEhaQpNyG0pMh2eLuGEKDZ6dB
         ZHCf7ajcAjlDlVNeayGndbrnUNTj1zgCf8d5GeMQDdS9kfxytRqDxoQmoSwRuRcHzNbp
         6e0adD/tAj+mhsDizykq1IvSeNgCYs2Li3UwUGnFk7IIVXp3UBoxlglPrV4a6Bnl0Zkm
         zwN5PEQQjCePPo0q6FIZN4FyMyYxCbEi1f6HGOR602pKwSzLGTjokQY2hkLONRnv1Xt/
         0RKA==
X-Gm-Message-State: APjAAAW0V8fT9rJuve11QdagOXK96KQD9mHBO8YqAsNpXkNR288vxiZd
        k2/NGXtZX3BDBBRmixlEWNAotlcU
X-Google-Smtp-Source: APXvYqzPF4R1ZMZksTEgJl/rSpqaQVK634tLh6fauUZhf7cJ+1P+tuTqUdghShR0lT+K91w2p2FE5Q==
X-Received: by 2002:a1c:8086:: with SMTP id b128mr25735248wmd.80.1575907811306;
        Mon, 09 Dec 2019 08:10:11 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z11sm27843002wrt.82.2019.12.09.08.10.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Dec 2019 08:10:10 -0800 (PST)
Message-Id: <215ec8688e60c594d50628caa03258010e4d6606.1575907804.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.466.v2.git.1575907804.gitgitgadget@gmail.com>
References: <pull.466.git.1574374826.gitgitgadget@gmail.com>
        <pull.466.v2.git.1575907804.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 09 Dec 2019 16:10:03 +0000
Subject: [PATCH v2 7/8] t7519: disable external GIT_TEST_FSMONITOR variable
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     szeder.dev@gmail.com, ukshah2@illinois.edu,
        Kevin.Willford@microsoft.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The GIT_TEST_FSMONITOR variable was created specifically so the
t7519-status-fsmonitor.sh test script could tweak the expected
behavior depending on its value. However, if we set it externally
to use the Watchman integration, then it breaks the initial tests
that demonstrate behavior _without_ the fsmonitor feature.

Disable this variable at the start of the script.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t7519-status-fsmonitor.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/t/t7519-status-fsmonitor.sh b/t/t7519-status-fsmonitor.sh
index 81a375fa0f..443d2e653b 100755
--- a/t/t7519-status-fsmonitor.sh
+++ b/t/t7519-status-fsmonitor.sh
@@ -8,6 +8,9 @@ test_description='git status with file system watcher'
 # "git update-index --fsmonitor" can be used to get the extension written
 # before testing the results.
 
+# Disable an external value, as we will set it directly as needed.
+GIT_TEST_FSMONITOR=""
+
 clean_repo () {
 	git reset --hard HEAD &&
 	git clean -fd
-- 
gitgitgadget

