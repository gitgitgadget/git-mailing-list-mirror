From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv2] branch -d: test if we can delete broken refs
Date: Tue, 25 Nov 2014 16:59:25 -0800
Message-ID: <1416963565-32318-1-git-send-email-sbeller@google.com>
References: <CAGZ79kao0CpeidBzVL4O-4jfNd7nGbOJwtvsJCEgOjb370z8uw@mail.gmail.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	Stefan Beller <sbeller@google.com>
To: jrnieder@gmail.com, mhagger@alum.mit.edu, gitster@pobox.com,
	ronniesahlberg@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 26 01:59:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XtQxB-0002Yl-Ie
	for gcvg-git-2@plane.gmane.org; Wed, 26 Nov 2014 01:59:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751289AbaKZA73 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Nov 2014 19:59:29 -0500
Received: from mail-ie0-f169.google.com ([209.85.223.169]:65418 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750975AbaKZA73 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Nov 2014 19:59:29 -0500
Received: by mail-ie0-f169.google.com with SMTP id y20so1734617ier.14
        for <git@vger.kernel.org>; Tue, 25 Nov 2014 16:59:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9c3Ce08TWBE7xgUly2Pv4JPJUtvqV4ZgF9l5VAnJa8A=;
        b=Lz/8N5v+OSZSw0ZOND7KUtWwkbe59bdk5x5PQW8oXjKMcear7JL5TQ9sRAXuKLFkAA
         GxNBFqxQShSl2ip1eHzJzrXLoMOTq6FXjIid4gJL8sdGbS+8OzoymFm9De9lmVZ7kghX
         e0Pp7+4BzvmnzJ/ZZX1Gi+9gliKmqwS+EciIO/sD+0HV7C5ftP8HvTuvePNLuD1dEZ/g
         VdwKWlJ8YQuOynurrrqvTXCF97XzR4yNRWNyoYFP5ubhczRpaVLbvq7jggLoL/JrsDFC
         CJP+rF/g5+EekUvgUhkDfVjHuS4RbP/b0MbnzpcOVpxZ53r93figUyiTCIbi7vDSrvfL
         skXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9c3Ce08TWBE7xgUly2Pv4JPJUtvqV4ZgF9l5VAnJa8A=;
        b=iHK6zuyJCJbU5ncgUfPFY9hkDW/UWle2ihDEjWMsRjfqL126xBmc2DNtW6yeoRS3cC
         Y6F5GAssb9hCTvD5+WdWMzCutkUSYMFnh2HKoloTOT71b5JhUFN0sRlP0gJqpJXlU+l4
         K6OANT1gJfKmUvYSfQ1ZKWjSVutPUsriKytxjrGE/AxYLQwBf/Jar67Payk4L1iB3iL2
         3mIZQJv9fgseMkyQmUHdZsqgXJ97XgZhtHMfZiFTRpcX8BR0rXTS/b7T/+xkYCSlNfAg
         mAkSCEk4r8Zg6Ljc9oSI6RuIkUihFcmX1qQg7m+RAO/y2Z66q7EtXtBmBy0h9QdJtHA/
         GhTg==
X-Gm-Message-State: ALoCoQkeEFDQVrnUUhMvIwqQR0w4hBmVC2T2Y21HoiTOdrbUiIi0OnQBQMqy2D6H62GyS2heSef3
X-Received: by 10.107.171.129 with SMTP id u123mr27565164ioe.40.1416963568412;
        Tue, 25 Nov 2014 16:59:28 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:79de:6365:bed8:92ea])
        by mx.google.com with ESMTPSA id o4sm6880633ige.7.2014.11.25.16.59.27
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 25 Nov 2014 16:59:27 -0800 (PST)
X-Mailer: git-send-email 2.2.0.rc3
In-Reply-To: <CAGZ79kao0CpeidBzVL4O-4jfNd7nGbOJwtvsJCEgOjb370z8uw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260257>

From: Ronnie Sahlberg <sahlberg@google.com>

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
Changes v1->v2
 * relocated the test from t1402 to t3200
 * reword the commit message title to fit in with similar commits touching 
   t/t3200-branch.sh 

 t/t3200-branch.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 432921b..fa7d7bd 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -163,6 +163,14 @@ test_expect_success 'git branch --list -d t should fail' '
 	test_path_is_missing .git/refs/heads/t
 '
 
+test_expect_failure 'git branch -d can delete ref with broken sha1' '
+	echo "pointing nowhere" > .git/refs/heads/brokensha1 &&
+	test_when_finished "rm -f .git/refs/heads/brokensha1" &&
+	git branch -d brokensha1 &&
+	git branch >output &&
+	! grep -e "brokensha1" output
+'
+
 test_expect_success 'git branch --column' '
 	COLUMNS=81 git branch --column=column >actual &&
 	cat >expected <<\EOF &&
-- 
2.2.0.rc3
