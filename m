Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35E7920189
	for <e@80x24.org>; Wed, 22 Jun 2016 16:53:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752375AbcFVQxc (ORCPT <rfc822;e@80x24.org>);
	Wed, 22 Jun 2016 12:53:32 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35409 "EHLO
	mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750970AbcFVQxb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jun 2016 12:53:31 -0400
Received: by mail-pf0-f196.google.com with SMTP id t190so4494445pfb.2
        for <git@vger.kernel.org>; Wed, 22 Jun 2016 09:53:31 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tfxVHpsm2PhazaQZ8Su5zK3dchMPhlrW3DJqYEWUpHo=;
        b=K7dvWUVf9317Pjt+i3rUNGrIAKbN0bhO97vMb38iS7ydSukfSm4IIDJdARkASJrD28
         wKdNNOjh1N8lRaZxTVl/N9pkrNL6zHPgvfeuSvCo1WtCn8a/pPYxtdi4LKaWHxhE7I+G
         OIZ5no4ANagyu0s0G4CXdVNQjGNn9DdtxE1WxZidTPrRKhCfRT4CumOMdFTtWo8bVkrU
         FC5OOZMQP7gAj0tBJF+7AVLrNBptqTwrTY/7vE0F/iWTATscXfcAKWy30XJBD9JMSBCU
         Otw9NfEGT5nYCkRTQ0bIJKQdOqu9N0FgiwIfca6B9OzzZDRivf8QBmRpusyeZrYMaiy/
         Bc2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tfxVHpsm2PhazaQZ8Su5zK3dchMPhlrW3DJqYEWUpHo=;
        b=Rxh7yYAaY3ejelVNLssgkSJyBDLx1rNS3MQjtaZEosuif7fKMDial6FjXB/drdqV5O
         I0yK8mYZboUKNiJHS31z/Xyvn/FYAOP3C4Tb9wv++yBfF09yjGOqvtP2B0w7VPtPxrfY
         Kc/b93wixlHdEhwdiU0MoaS06yq3rig7k9k+i9OHxe6Ps03xqAFMqYtDgNN9wF3WRSXg
         0gaXVNMWgvojedy5WlPLVKcotG+vRIDWVO7oWi+BmKNLCp8AG5IguiYUz0xqLoQwCXBn
         xc5nvAfax8VuyI1nTD5FHTuCz6PH64z4pD/xQwCvdfl2ejRkzdCvDDUlAzsCcvmF7qk8
         Yc1g==
X-Gm-Message-State: ALyK8tLMEXC2RDU1X2Zu7DJ+lf/LA7Yb7QQBAhxSW6RhqZP+VxWVga4Wa6Xywplhh5Ek5g==
X-Received: by 10.98.134.196 with SMTP id x187mr35640362pfd.21.1466614411044;
        Wed, 22 Jun 2016 09:53:31 -0700 (PDT)
Received: from localhost.localdomain ([106.218.86.37])
        by smtp.gmail.com with ESMTPSA id sz7sm1132865pab.23.2016.06.22.09.53.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 22 Jun 2016 09:53:30 -0700 (PDT)
From:	Mehul Jain <mehul.jain2029@gmail.com>
To:	git@vger.kernel.org
Cc:	Eric Sunshine <sunshine@sunshineco.com>,
	Mehul Jain <mehul.jain2029@gmail.com>
Subject: [PATCH v3 1/3] t4202: refactor test
Date:	Wed, 22 Jun 2016 22:21:24 +0530
Message-Id: <20160622165126.12786-2-mehul.jain2029@gmail.com>
X-Mailer: git-send-email 2.9.0.rc0.dirty
In-Reply-To: <20160622165126.12786-1-mehul.jain2029@gmail.com>
References: <20160622165126.12786-1-mehul.jain2029@gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Separate the creation of 'signed' branch so that other tests can take
advantage of this branch.

Signed-off-by: Mehul Jain <mehul.jain2029@gmail.com>
---
 t/t4202-log.sh | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 128ba93..ab66ee0 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -860,12 +860,15 @@ test_expect_success 'dotdot is a parent directory' '
 	test_cmp expect actual
 '
 
-test_expect_success GPG 'log --graph --show-signature' '
+test_expect_success 'setup signed branch' '
 	test_when_finished "git reset --hard && git checkout master" &&
 	git checkout -b signed master &&
 	echo foo >foo &&
 	git add foo &&
-	git commit -S -m signed_commit &&
+	git commit -S -m signed_commit
+'
+
+test_expect_success GPG 'log --graph --show-signature' '
 	git log --graph --show-signature -n1 signed >actual &&
 	grep "^| gpg: Signature made" actual &&
 	grep "^| gpg: Good signature" actual
-- 
2.9.0.rc0.dirty

