Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81B441F404
	for <e@80x24.org>; Mon, 13 Aug 2018 08:48:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728724AbeHML3d (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 07:29:33 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:37212 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728411AbeHML3d (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 07:29:33 -0400
Received: by mail-io0-f194.google.com with SMTP id z19-v6so14016904ioh.4
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 01:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PvpdRiH5mAr3qyctDCuFTUJU0RpzM33W1S1NOJT8XYA=;
        b=mWBs0ASc/UvksmwwB8GK8/rXcCHSlg4JB8kuM6R2stFGGxcgtb1HSUwdkIMW8B5Y7z
         SHWa7ObYj0AMEinFA08BVYeZt549v1tX/Rkw/RYM6aABLN360ybcwMJWhCXzS33bseMA
         mMntewNj3hshkuzf/AXVYppGJRQIQ0qZ/KpJKASAPjjGvaX611SQq1qHWYTXHisAjs78
         18cf1xSIVTunejM7bk2e4kxE1oRSwflVE7XNYY7iqBLhwq9KfrQEn4a9bxhf5kRWnRqL
         cxzLcU1p/Td0fbMM01d0mpLsE4/fQ+VmNumz1YiArYUqB6scAc/RdhVPBZ1tHkewhHwS
         IFzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=PvpdRiH5mAr3qyctDCuFTUJU0RpzM33W1S1NOJT8XYA=;
        b=gj39TdA0SGttMHBvotiNcfGqaCrS0QPjJvJCVjbgGNAl8+JNsyRXuiPIsLN/oOOYLc
         fuJ/jTObbWD9OQTeEfhscksRHUNNYqNX9Xte64uiM4RWkDOStUQC13r7BX1Z89yjN8KI
         T0LWdlSR7xeO8QtuEpzAchTss8nqyfLYVqOQuRPRsvU/QBir/cdOYk6vZRbdhsXRZyOY
         /kZPaWMiDELjoFJd0FkOxCKKG14lu8FH2el5v0RtvYeo5qlwvew3artGnfRJ/o7Vl2KN
         0VN0naiWqmOMZiqUIMFFVhr7WYb8DhxqwsE4kF/43sjHXPvmprtVowHMdSKPufZrfoOB
         YGIw==
X-Gm-Message-State: AOUpUlFSNdJW8/+EJUVxLLnc2V2rSY6FSAY8Q9Ibcg36ur3m6YFpJPiD
        S+Vp1ZbfcGGJhpfHz3bGZ5zZRWwq
X-Google-Smtp-Source: AA+uWPxw2N0DnI9xs9QI2oPKu1nCjGVoqVQ+kLoNLFZtacf671W6i+3IgOVca/IoWX1Z7kR8VA34Jw==
X-Received: by 2002:a6b:8c41:: with SMTP id o62-v6mr13827712iod.84.1534150097059;
        Mon, 13 Aug 2018 01:48:17 -0700 (PDT)
Received: from localhost.localdomain (user-12l2dpj.cable.mindspring.com. [69.81.55.51])
        by smtp.gmail.com with ESMTPSA id g23-v6sm5609405iob.88.2018.08.13.01.48.16
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 13 Aug 2018 01:48:16 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 3/6] chainlint: recognize multi-line $(...) when command cuddled with "$("
Date:   Mon, 13 Aug 2018 04:47:36 -0400
Message-Id: <20180813084739.16134-4-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.18.0.758.g1932418f46
In-Reply-To: <20180813084739.16134-1-sunshine@sunshineco.com>
References: <20180807082135.60913-1-sunshine@sunshineco.com>
 <20180813084739.16134-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For multi-line $(...) expressions nested within subshells, chainlint.sed
only recognizes:

    x=$(
        echo foo &&
        ...

but it is not unlikely that test authors may also cuddle the command
with the opening "$(", so support that style, as well:

    x=$(echo foo &&
        ...

The closing ")" is already correctly recognized when cuddled or not.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/chainlint.sed                                       |  2 +-
 .../multi-line-nested-command-substitution.expect     | 11 ++++++++++-
 .../multi-line-nested-command-substitution.test       | 11 ++++++++++-
 3 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/t/chainlint.sed b/t/chainlint.sed
index 2901494e8a..afb2443a9c 100644
--- a/t/chainlint.sed
+++ b/t/chainlint.sed
@@ -216,7 +216,7 @@ s/.*\n//
 # "$(...)" -- command substitution; not closing ")"
 /\$([^)][^)]*)[^)]*$/bcheckchain
 # multi-line "$(...\n...)" -- command substitution; treat as nested subshell
-/\$([ 	]*$/bnest
+/\$([^)]*$/bnest
 # "=(...)" -- Bash array assignment; not closing ")"
 /=(/bcheckchain
 # closing "...) &&"
diff --git a/t/chainlint/multi-line-nested-command-substitution.expect b/t/chainlint/multi-line-nested-command-substitution.expect
index 19c023b1c8..59b6c8b850 100644
--- a/t/chainlint/multi-line-nested-command-substitution.expect
+++ b/t/chainlint/multi-line-nested-command-substitution.expect
@@ -6,4 +6,13 @@
 >>	) &&
 	echo ok
 >) |
-sort
+sort &&
+(
+	bar &&
+	x=$(echo bar |
+		cat
+>>	) &&
+	y=$(echo baz |
+>>		fip) &&
+	echo fail
+>)
diff --git a/t/chainlint/multi-line-nested-command-substitution.test b/t/chainlint/multi-line-nested-command-substitution.test
index ca0620ab6b..300058341b 100644
--- a/t/chainlint/multi-line-nested-command-substitution.test
+++ b/t/chainlint/multi-line-nested-command-substitution.test
@@ -6,4 +6,13 @@
 	) &&
 	echo ok
 ) |
-sort
+sort &&
+(
+	bar &&
+	x=$(echo bar |
+		cat
+	) &&
+	y=$(echo baz |
+		fip) &&
+	echo fail
+)
-- 
2.18.0.267.gbc8be36ecb

