From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH] i18n: make the translation of -u advise in one go
Date: Fri, 12 Apr 2013 10:46:26 +0800
Message-ID: <4003e29bb04b122897cefe2a8057266e2428dce5.1365734618.git.worldhello.net@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.co>
X-From: git-owner@vger.kernel.org Fri Apr 12 04:46:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQU0o-0001QB-FN
	for gcvg-git-2@plane.gmane.org; Fri, 12 Apr 2013 04:46:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751504Ab3DLCqp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Apr 2013 22:46:45 -0400
Received: from mail-pd0-f177.google.com ([209.85.192.177]:46619 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750731Ab3DLCqo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Apr 2013 22:46:44 -0400
Received: by mail-pd0-f177.google.com with SMTP id u11so1171982pdi.36
        for <git@vger.kernel.org>; Thu, 11 Apr 2013 19:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=ue3PqAoVzTf1IGEa0fxb5sAJCj6LgYdJDs+FvWZmhzs=;
        b=rTglHHWbLKpikqAi2GuT+J3ip783XYb90EEh+6tCjbZniIxW6EJGXY3Qwg4elHxNjU
         NwHPuNaiwzr9l8EtT+tlY5G8DviiygcPOHJM1yWvtjb5Z3Z1PLt99QzCgZeCVHr1gYeN
         Ahi9Wr/h3jfuFlGAxG4Ixj/LAkcsxCktwHCjnmbaj5IaAO//7kjWMeWsy6MkXeo9U/cl
         1LCrpFfZMSWRpZdH/QEfO9K0VF25AJyUCiCsmC7/E9F0KKKNxgIxiKDFnfmUAzhwkt10
         yk9q5pURDaexLrF4qvzluU08XXtv95bVnmZVprXHlkljDZNviE+X1J5CAbZGeShJ9fGp
         9lLw==
X-Received: by 10.68.171.33 with SMTP id ar1mr12032641pbc.195.1365734804070;
        Thu, 11 Apr 2013 19:46:44 -0700 (PDT)
Received: from localhost.localdomain ([114.248.153.32])
        by mx.google.com with ESMTPS id z8sm6475045pbt.23.2013.04.11.19.46.41
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 11 Apr 2013 19:46:43 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.347.g1003b3a.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220945>

The advise (consider use of -u when read_directory takes too long) is
separated into 3 different status_printf_ln() calls, and which brings
trouble for translators.

Since status_vprintf() called by status_printf_ln() can handle eol in
buffer, we could simply join these lines into one paragraph.

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
---
 wt-status.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index 09416..f0d3 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1223,16 +1223,12 @@ void wt_status_print(struct wt_status *s)
 		if (s->show_ignored_files)
 			wt_status_print_other(s, &s->ignored, _("Ignored files"), "add -f");
 		if (advice_status_u_option && 2000 < s->untracked_in_ms) {
-			status_printf_ln(s, GIT_COLOR_NORMAL, "");
 			status_printf_ln(s, GIT_COLOR_NORMAL,
-				 _("It took %.2f seconds to enumerate untracked files."
-				   "  'status -uno'"),
-				 s->untracked_in_ms / 1000.0);
-			status_printf_ln(s, GIT_COLOR_NORMAL,
-				 _("may speed it up, but you have to be careful not"
-				   " to forget to add"));
-			status_printf_ln(s, GIT_COLOR_NORMAL,
-				 _("new files yourself (see 'git help status')."));
+					 _("\n"
+					   "It took %.2f seconds to enumerate untracked files. 'status -uno'\n"
+					   "may speed it up, but you have to be careful not to forget to add\n"
+					   "new files yourself (see 'git help status')."),
+					 s->untracked_in_ms / 1000.0);
 		}
 	} else if (s->commitable)
 		status_printf_ln(s, GIT_COLOR_NORMAL, _("Untracked files not listed%s"),
-- 
1.8.2.1.347.g1003b3a.dirty
