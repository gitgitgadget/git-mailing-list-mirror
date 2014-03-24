From: David Cowden <dcow90@gmail.com>
Subject: [PATCH v3] Clarify pre-push hook documentation
Date: Mon, 24 Mar 2014 16:51:28 -0700
Message-ID: <1395705088-82216-1-git-send-email-dcow90@gmail.com>
References: <1395704609-81957-1-git-send-email-dcow90@gmail.com>
Cc: David Cowden <dcow90@gmail.com>, philipoakley@iee.org,
	sunshine@sunshineco.com, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 25 00:56:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSEj4-00065U-DM
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 00:56:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751131AbaCXXz7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2014 19:55:59 -0400
Received: from mail-pd0-f171.google.com ([209.85.192.171]:39529 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751367AbaCXXz6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Mar 2014 19:55:58 -0400
Received: by mail-pd0-f171.google.com with SMTP id r10so6004947pdi.2
        for <git@vger.kernel.org>; Mon, 24 Mar 2014 16:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3ienz7LNmU1rJbEowLZENhGDRq1Atw+/2dNd8qyIQ/4=;
        b=0wozZZc/Zj6VWySCoTf4D9U9y88sFzk+CtC8wBkfCNVv/eCtz1fVA2lBIVPb9LyAZU
         qVoraWiM6SLuPBMcanR5kmgZGawXmZbdZF02QXEYpwmDgnR2qj5zopjP8OsZtZ5LDg9S
         0e2qxIiB1iWeaV3lVhJMhxCQj0q9ZCcgnNQiPkKn/QRgLI2ORIacghkYh6828piu/r5X
         1NM0RHRxhOfT4L3pU6xw98eD5QcYicTTXxkoaBCzPTdQaYjYtfNKqXIgkMvNuvVkLTKR
         5JEgYXrwNfLHLFOmbzYqXiTgRpJEbvf/TP3EZXoDigMF5dFycDcNTPx1raAaUv4d/W8s
         dGyg==
X-Received: by 10.66.193.161 with SMTP id hp1mr66431101pac.20.1395705357697;
        Mon, 24 Mar 2014 16:55:57 -0700 (PDT)
Received: from Davids-MacBook-Pro-2.local.com ([69.170.160.74])
        by mx.google.com with ESMTPSA id iu7sm36508728pbc.60.2014.03.24.16.55.56
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 24 Mar 2014 16:55:56 -0700 (PDT)
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1395704609-81957-1-git-send-email-dcow90@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244899>

The documentation as-is does not mention that the pre-push hook is
executed even when there is nothing to push.  This can lead a new
reader to believe there will always be lines fed to the script's
standard input and cause minor confusion as to what is happening
when there are no lines provided to the pre-push script.

Signed-off-by: David Cowden <dcow90@gmail.com>
---

Notes:
    I'm not sure if I've covered every case here.  If there are more cases to
    consider, please let me know and I can update to include them.
    
    c.f. http://stackoverflow.com/questions/22585091/git-hooks-pre-push-script-does-not-receive-input-via-stdin

 Documentation/githooks.txt | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index d954bf6..1fd6da9 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -203,6 +203,15 @@ SHA-1>` will be 40 `0`.  If the local commit was specified by something other
 than a name which could be expanded (such as `HEAD~`, or a SHA-1) it will be
 supplied as it was originally given.
 
+The hook is executed regardless of whether changes will actually be pushed or
+not.  This may happen when 'git push' is called and:
+
+ - the remote ref is already up to date, or
+ - pushing to the remote ref cannot be handled by a simple fast-forward
+
+In other words, the script is called for every push.  In the event that nothing
+is to be pushed, no data will be provided on the script's standard input.
+
 If this hook exits with a non-zero status, 'git push' will abort without
 pushing anything.  Information about why the push is rejected may be sent
 to the user by writing to standard error.
-- 
1.9.1
