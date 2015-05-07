From: Luke Diamand <luke@diamand.org>
Subject: [PATCH 1/2] git-p4: add failing test for P4EDITOR handling
Date: Thu,  7 May 2015 18:25:00 +0100
Message-ID: <1431019501-30807-2-git-send-email-luke@diamand.org>
References: <1431019501-30807-1-git-send-email-luke@diamand.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Chris Lasell <chrisl@pixar.com>,
	Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 07 19:25:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YqPYQ-0007fy-JT
	for gcvg-git-2@plane.gmane.org; Thu, 07 May 2015 19:25:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751390AbbEGRZo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2015 13:25:44 -0400
Received: from mail-wg0-f49.google.com ([74.125.82.49]:33434 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751333AbbEGRZm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2015 13:25:42 -0400
Received: by wgin8 with SMTP id n8so50508562wgi.0
        for <git@vger.kernel.org>; Thu, 07 May 2015 10:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Z3kBlT9kOmtU/cdWUaJUqAv4NkX3nHadiAuhk/5Lcrw=;
        b=TgBMF/060DJbZNdMUZyaJaGk81WSipGST9CBwD4Gje6CJfpzVhmqWxKy41hD2lcfUV
         PEHuu+HSjH9w9SKyNrsrGc/yxAKlrA6sEVUNVf3gO/N+mnw8AZ1KRUUH1KYDXpJOV13N
         cG1Z6nwKWXzGuWPq88hyeX/upDucVjosxmXjA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Z3kBlT9kOmtU/cdWUaJUqAv4NkX3nHadiAuhk/5Lcrw=;
        b=Y5rkjGWe2VHtIjRvoV7mInZzF2oGG8s9xcun7ppJLKIvzGqaW9GZZ1tA9SphIy92D5
         8mM32w7sqCaWLODHeH2c6aMBU7YtFhklKnRHYfjYoNU22rTT3gfgXUJ0gUDe1LUFrhkE
         mvJoP312ao9/LuQcMLfWe5jES1R6YOy/rOjWKU07X026uFaynMeCeNxfigKrvE5herVL
         gpVpkRWybrosZx77spHqBhYj/bTeXIqxqsDo0dcFnisBj4VCaN4RsMt4B/U5yta2D3++
         7rcoDp9XARZDuGR3xzoHU1xxD4g67oCG3v9dyrertP7rD/nyuYkiJ/O/BxGrO+5Niwwo
         MKKA==
X-Gm-Message-State: ALoCoQmggN8aTY5EvVdLqbbneuWLJML5xiOmlD2uF5Pcsajvxd7bPqkp+dWqWjkgoeZug6733NKX
X-Received: by 10.194.186.145 with SMTP id fk17mr9690911wjc.156.1431019540672;
        Thu, 07 May 2015 10:25:40 -0700 (PDT)
Received: from ethel.cable.virginmedia.net (cpc7-cmbg17-2-0-cust139.5-4.cable.virginm.net. [86.1.43.140])
        by mx.google.com with ESMTPSA id b5sm8416807wiw.8.2015.05.07.10.25.39
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 07 May 2015 10:25:39 -0700 (PDT)
X-Mailer: git-send-email 2.4.0.rc3.380.g8e2ddc7
In-Reply-To: <1431019501-30807-1-git-send-email-luke@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268558>

Add test case that git-p4 handles a setting of P4EDITOR
that takes arguments, e.g. "gvim -f"

Signed-off-by: Luke Diamand <luke@diamand.org>
---
 t/t9820-git-p4-editor-handling.sh | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100755 t/t9820-git-p4-editor-handling.sh

diff --git a/t/t9820-git-p4-editor-handling.sh b/t/t9820-git-p4-editor-handling.sh
new file mode 100755
index 0000000..e0a3c52
--- /dev/null
+++ b/t/t9820-git-p4-editor-handling.sh
@@ -0,0 +1,38 @@
+#!/bin/sh
+
+test_description='git p4 handling of EDITOR'
+
+. ./lib-git-p4.sh
+
+test_expect_success 'start p4d' '
+	start_p4d
+'
+
+test_expect_success 'init depot' '
+	(
+		cd "$cli" &&
+		echo file1 >file1 &&
+		p4 add file1 &&
+		p4 submit -d "file1"
+	)
+'
+
+test_expect_failure 'EDITOR has options' '
+# Check that the P4EDITOR argument can be given command-line
+# options, which git-p4 will then pass through to the shell.
+	git p4 clone --dest="$git" //depot &&
+	test_when_finished cleanup_git &&
+	(
+		cd "$git" &&
+		echo change >file1 &&
+		git commit -m "change" file1 &&
+		P4EDITOR="touch \"$git/touched\"" git p4 submit &&
+		test_path_is_file "$git/touched"
+	)
+'
+
+test_expect_success 'kill p4d' '
+	kill_p4d
+'
+
+test_done
-- 
2.4.0.rc3.380.g8e2ddc7
