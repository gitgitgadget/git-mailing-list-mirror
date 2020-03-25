Return-Path: <SRS0=ys1m=5K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BBE5C54FD0
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 15:06:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22D4820789
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 15:06:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EpTgxZ6O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727901AbgCYPG5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Mar 2020 11:06:57 -0400
Received: from mail-pl1-f182.google.com ([209.85.214.182]:46719 "EHLO
        mail-pl1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727501AbgCYPG4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Mar 2020 11:06:56 -0400
Received: by mail-pl1-f182.google.com with SMTP id s23so883022plq.13
        for <git@vger.kernel.org>; Wed, 25 Mar 2020 08:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=59G8EJqdPdCXQu1bW2RtjXEIWnfC37lI1/5lFVAm+c0=;
        b=EpTgxZ6ORjJ4ZFJeVGr0NX+eUAi9cyArBZROF4A17bjqUBZFRxyj4DmeMLkTedHL6O
         4+W4J+Ya0GdfSVNKr+mkRlCGndz5Q8S5uZzMIgg+enfS9fBJmEoLFPj2oZ73rb4EjCVT
         Nfqo+dXO1lDMf6NdXf3uMA8qcQAjqSsz/jNhzj3tbYX5jjZMud79Ipw+D364SoW05oBo
         sGjD1rJ2108Ly2QMrQDCSKtzr73/GlJgc+5XsePd5mPBcE3YrWytwme7cwORNAeBUQI5
         HxQP2ZNnlHmrkt8/Cqd9L9xTxugTyj+a8oSkLBs8IsxZKvHNbdolbUftitq5tqJUowZv
         10fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=59G8EJqdPdCXQu1bW2RtjXEIWnfC37lI1/5lFVAm+c0=;
        b=fcR86sFeHlBJlrJs+k5K3nHtOIbPxFUo4N8JzAPe1eeBV0lleAVU/kypRcA/i52UVr
         Rnm71/llkxu6kq3uwi6ZlHMQu5oEMp73u99xRJEd7/feHhDfSEwef7CkESW8DH7Uc0m9
         V1CQGG7PCBh7piRnjubrTolXFo09AdCILFVgY5X/sfqZ19O9/UehitJnsZkmNNw7HPma
         dTHYj5lFW5s9lec3ONkM71aI40luc6ZAFfXeNS0wJoIJZJz0PDTSrwb84EGYfA2rqQgn
         KlI/nr3sRT+r3guVP9D2fYhSQ2uiU+qQg0L+MyXWTd8fBEEpfkr9597s/x3CX3ANLj4J
         B3YA==
X-Gm-Message-State: ANhLgQ17F/19Ze36j0qwdq49Letoj2TNaY5oksX+sY+Odp/MV5jmn8o6
        jxTXJ0YgV8t1cMc3XYtq9d3z2bUp
X-Google-Smtp-Source: ADFU+vtWQ5KhIWsBEazAo3Q/PssuifxxTrAWDnnYx9tR5IGRqz8bJ3u57aC3UyqHwd2q5IrmOVEg/w==
X-Received: by 2002:a17:902:76c9:: with SMTP id j9mr3841134plt.166.1585148815111;
        Wed, 25 Mar 2020 08:06:55 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6374:c347:544a:f0cc:8a21:fee3])
        by smtp.gmail.com with ESMTPSA id f127sm18232538pfa.112.2020.03.25.08.06.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Mar 2020 08:06:54 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH v3 1/8] t4061: use POSIX compliant regex(7)
Date:   Wed, 25 Mar 2020 22:06:14 +0700
Message-Id: <088905ab6fb5acffbf9a8158cf9b1ee28d0bb7b0.1585148327.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.26.0.rc2.357.g1e1ba0441d
In-Reply-To: <cover.1585148327.git.congdanhqx@gmail.com>
References: <cover.1585148327.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

BRE interprets `+` literally, and
`\+` is undefined for POSIX BRE, from:
https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap09.html#tag_09_03_02

> The interpretation of an ordinary character preceded
> by an unescaped <backslash> ( '\\' ) is undefined, except for:
> - The characters ')', '(', '{', and '}'
> - The digits 1 to 9 inclusive
> - A character inside a bracket expression

This test is failing with busybox sed, the default sed of Alpine Linux

We have 2 options here:

- Using literal `+` because BRE will interpret it as-is, or
- Using character class `[+]` to defend against a sed that expects ERE

ERE-expected sed is theoretical at this point,
but we haven't found it, yet.
And, we may run into other problems with that sed.
Let's go with first option and fix it later if that sed could be found.

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 t/t4061-diff-indent.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t4061-diff-indent.sh b/t/t4061-diff-indent.sh
index 2affd7a100..0f7a6d97a8 100755
--- a/t/t4061-diff-indent.sh
+++ b/t/t4061-diff-indent.sh
@@ -17,7 +17,7 @@ compare_diff () {
 # Compare blame output using the expectation for a diff as reference.
 # Only look for the lines coming from non-boundary commits.
 compare_blame () {
-	sed -n -e "1,4d" -e "s/^\+//p" <"$1" >.tmp-1
+	sed -n -e "1,4d" -e "s/^+//p" <"$1" >.tmp-1
 	sed -ne "s/^[^^][^)]*) *//p" <"$2" >.tmp-2
 	test_cmp .tmp-1 .tmp-2 && rm -f .tmp-1 .tmp-2
 }
-- 
2.26.0.rc2.357.g1e1ba0441d

