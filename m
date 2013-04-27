From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 1/2] complete: zsh: trivial simplification
Date: Sat, 27 Apr 2013 15:34:05 -0500
Message-ID: <1367094846-9830-2-git-send-email-felipe.contreras@gmail.com>
References: <1367094846-9830-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 27 22:35:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWBqV-0006Cb-JZ
	for gcvg-git-2@plane.gmane.org; Sat, 27 Apr 2013 22:35:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755346Ab3D0Ufi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Apr 2013 16:35:38 -0400
Received: from mail-ob0-f179.google.com ([209.85.214.179]:54907 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755056Ab3D0Uf1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Apr 2013 16:35:27 -0400
Received: by mail-ob0-f179.google.com with SMTP id oi10so4363925obb.24
        for <git@vger.kernel.org>; Sat, 27 Apr 2013 13:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=EmZ6sFA61XGwMFHSnvIgHJJ0Mzoxy+rVZeDNGFZCegA=;
        b=PZ6GdiroX0AI5WEgXhEb2BZo6D87kZ+E6ozm4iJAkl7k3e4Yhri632MiRh9PlooQ4y
         fB6UW1CsaRi41V3K1A/XBszEQYZbPp1ckS3hlZQgX4zSbN+TCNlsLWfnGV6Wl+dUk7iL
         9g5gcQb0PxSyccRWkyAuf194HmIzWSH4a3TYE5NQRpwUKN+fuXKB0ANeKWSst+3CnGNT
         noV91hqy7qEt9mu1vs4tYs1ZYvEYn6bvRySb3tkmkMz/ZWJ9t2aOXCNNZH48JAXK+qp8
         vfUTAPpgtxQK/QbbnyRfwMZNNO6cK5nXfpsQRKG6MBwz87//2HDEeFXN2rMkbMLa27yP
         MqYQ==
X-Received: by 10.60.63.238 with SMTP id j14mr949705oes.77.1367094927286;
        Sat, 27 Apr 2013 13:35:27 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id wq8sm13245057obb.7.2013.04.27.13.35.25
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 27 Apr 2013 13:35:26 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.1031.g2ee5873
In-Reply-To: <1367094846-9830-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222696>

There should be no functional changes.

The only reason I wrapped this code around a sub-function is because zsh
did the same in it's bashcompinit script in order to declare the special
variable 'words' as hidden, but only in this context.

There's no need for that any more since we access __git_main directly,
so 'words' is not modified, so there's no need for the sub-function.

In zsh mode the array indexes are different though.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.zsh | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index cf8116d..93d8f42 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -72,14 +72,14 @@ __gitcomp_file ()
 _git ()
 {
 	local _ret=1
-	() {
-		emulate -L ksh
-		local cur cword prev
-		cur=${words[CURRENT-1]}
-		prev=${words[CURRENT-2]}
-		let cword=CURRENT-1
-		__${service}_main
-	}
+	local cur cword prev
+
+	cur=${words[CURRENT]}
+	prev=${words[CURRENT-1]}
+	let cword=CURRENT-1
+
+	emulate ksh -c __${service}_main
+
 	let _ret && _default -S '' && _ret=0
 	return _ret
 }
-- 
1.8.2.1.1031.g2ee5873
