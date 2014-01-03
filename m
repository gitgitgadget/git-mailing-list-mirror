From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v3 4/4] completion: fix remote.pushdefault
Date: Sat,  4 Jan 2014 01:27:02 +0530
Message-ID: <1388779022-14536-5-git-send-email-artagnon@gmail.com>
References: <1388779022-14536-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 03 20:57:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VzArz-0003Ia-Up
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jan 2014 20:57:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753679AbaACT5S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jan 2014 14:57:18 -0500
Received: from mail-pb0-f54.google.com ([209.85.160.54]:42314 "EHLO
	mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753660AbaACT5P (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jan 2014 14:57:15 -0500
Received: by mail-pb0-f54.google.com with SMTP id un15so16063781pbc.13
        for <git@vger.kernel.org>; Fri, 03 Jan 2014 11:57:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9VDdCo7ycywNhTZPU7BBqcEATLeOi+BcoNTb/IN6azQ=;
        b=T+1GMJumADrkL8ts5P4ZNt+Q5sXf2NKw5cHrZd/LiQLZlQM8D+tIe0tpmMgAObbK8j
         Vbnt/cW//uxOoduDfEQi6bdoNyZPTSB6FF+QciiFMWxlD+q4vMqGybLgBC8/RCK5/BeA
         u1BH6fWmoWRdtJXZTE2p9SfWY7Sbnc/RUKUh/elnYehNSRAjyHJEqyhoKlGteFUTfBS4
         zsd25/XkkGxbkepdqnFp+BB8RBq37xIeAFJlZaJUmj4Dx7bKGSQGTcLRQo2ZRZUkjMUh
         Hek+uRrFw2o49UkXk+Dd50yx3wsTHQgHaRK3icsJpcg0vCpd1lg2zUPsyz0wbkMFfVrP
         zUqw==
X-Received: by 10.66.25.100 with SMTP id b4mr96386805pag.24.1388779035188;
        Fri, 03 Jan 2014 11:57:15 -0800 (PST)
Received: from localhost.localdomain ([122.164.141.93])
        by mx.google.com with ESMTPSA id e6sm110782903pbg.4.2014.01.03.11.57.13
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 03 Jan 2014 11:57:14 -0800 (PST)
X-Mailer: git-send-email 1.8.5.2.227.g53f3478
In-Reply-To: <1388779022-14536-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239932>

When attempting to complete

  $ git config remote.push<TAB>

'pushdefault' doesn't come up. This is because "$cur" is matched with
"remote.*" and a list of remotes are completed. Add 'pushdefault' to the
list of remotes using __gitcomp_nl_append ().

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 contrib/completion/git-completion.bash | 1 +
 1 file changed, 1 insertion(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 75c7302..345ceff 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1883,6 +1883,7 @@ _git_config ()
 	remote.*)
 		local pfx="${cur%.*}." cur_="${cur#*.}"
 		__gitcomp_nl "$(__git_remotes)" "$pfx" "$cur_" "."
+		__gitcomp_nl_append "pushdefault" "$pfx" "$cur_"
 		return
 		;;
 	url.*.*)
-- 
1.8.5.2.227.g53f3478
