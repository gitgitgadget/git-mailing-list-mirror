Return-Path: <SRS0=IlH6=24=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 757A6C3F68F
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 04:53:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B9CD207E0
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 04:53:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qqIP5+3+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727581AbgAGExc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jan 2020 23:53:32 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:33755 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727558AbgAGExa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jan 2020 23:53:30 -0500
Received: by mail-qk1-f193.google.com with SMTP id d71so33768446qkc.0
        for <git@vger.kernel.org>; Mon, 06 Jan 2020 20:53:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1aXnx/J08W6X6FOk0xhH/K3eXu/5ICJHXtqwWyZqQ9o=;
        b=qqIP5+3+clzKe3UcQp1QhZEEZ7NmtK8xMf3VyPRnbOxacVRsIllCN+i1hbPPtfEv7H
         A/28IjrNxwBNmTngoDtJM1Zy9/D46Y7poSFrSi1gDRslTEB80cLAOE+92XGReZnYaUXK
         3ZwcM5AjNCLuQ6I8FZPcptK3DikyxOov0qwiPj4IRhCYmqHF7BlZveAcFkrXUngVpird
         n0cW/0fpG+OxTI/eTvB073uq5HMnvTfcOBsXzLQNZDx+gFk/QeMUXndpSTZ8o0YId+9S
         1J/sC7hUukd5RT8CrtQ6XcyBJrwQDG1akQanGkOocATwpvyWlIKIYMsgDyCTIA46OlZv
         mCVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1aXnx/J08W6X6FOk0xhH/K3eXu/5ICJHXtqwWyZqQ9o=;
        b=Mzly3JQ6AaHJUY4EgkKo/cbWv07S2ffgFVFljMNgo5SOxKOIcuqU9f5Db43wqkfKQd
         p0LjNwZUxhAjRh7LsGfsxvGyFVfjY/gie11aRjUI1rRCreBdst/WQjmnVs8R9myN8a6/
         b/a2ytFocmr171wgUNErRxLlBVjDbzmWqIk+bbmXAKchcKfDpooCVon3xhYEnQ8zf1JM
         u/oG36l5/8T7MyAw1h5i76DzhrbzlPXZUch2PgxzrnwYrGTGC0ZZWG1dnH6Acf/jWgf0
         NQj/lyUsYvonUs9+1030bA10knVHEqfJwEf4eThdYsvWHqmNYjnVAUhTqahH/2JSUXuh
         qYqQ==
X-Gm-Message-State: APjAAAUZKlRiiOtcbW24gaoBKsPPJIp+GxDxs/VhqU9nh6LrfAYQMVBx
        K95g6Bkeh26bUVuiW2G0xSBLe++3
X-Google-Smtp-Source: APXvYqyos6KrVRq9NBeAiR4N7CKAjUsrgHJ7HEqvnWkTm2m9WTmPWextoi/ZwGyj0DtuTS18gMoV/A==
X-Received: by 2002:a37:a642:: with SMTP id p63mr79270444qke.85.1578372809426;
        Mon, 06 Jan 2020 20:53:29 -0800 (PST)
Received: from archbookpro.lan ([199.249.110.29])
        by smtp.gmail.com with ESMTPSA id t2sm21663893qkc.31.2020.01.06.20.53.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 20:53:29 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 03/16] t2018: improve style of if-statement
Date:   Mon,  6 Jan 2020 23:53:00 -0500
Message-Id: <501eb147c3442b781b6b50be0691f326dc82f91a.1578372682.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.25.0.rc1.180.g49a268d3eb
In-Reply-To: <cover.1578372682.git.liu.denton@gmail.com>
References: <cover.1577454401.git.liu.denton@gmail.com> <cover.1578372682.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert `[]` to `test` and break if-then into separate lines, both of
which bring the style in line with Git's coding guidelines.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t2018-checkout-branch.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t2018-checkout-branch.sh b/t/t2018-checkout-branch.sh
index 79b16e4677..61206a90fb 100755
--- a/t/t2018-checkout-branch.sh
+++ b/t/t2018-checkout-branch.sh
@@ -20,7 +20,8 @@ do_checkout () {
 	exp_sha=${2:-$(git rev-parse --verify HEAD)} &&
 
 	# default options for git checkout: -b
-	if [ -z "$3" ]; then
+	if test -z "$3"
+	then
 		opts="-b"
 	else
 		opts="$3"
-- 
2.25.0.rc1.180.g49a268d3eb

