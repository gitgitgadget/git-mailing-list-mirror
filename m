From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 6/9] completion: refactor __git_complete_index_file()
Date: Sat, 27 Apr 2013 15:10:04 -0500
Message-ID: <1367093407-8898-7-git-send-email-felipe.contreras@gmail.com>
References: <1367093407-8898-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Manlio Perillo <manlio.perillo@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 27 22:11:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWBTI-0000Il-Ks
	for gcvg-git-2@plane.gmane.org; Sat, 27 Apr 2013 22:11:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756296Ab3D0ULp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Apr 2013 16:11:45 -0400
Received: from mail-ob0-f171.google.com ([209.85.214.171]:43013 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756319Ab3D0ULo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Apr 2013 16:11:44 -0400
Received: by mail-ob0-f171.google.com with SMTP id er7so4468709obc.16
        for <git@vger.kernel.org>; Sat, 27 Apr 2013 13:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=h+mwHl0zgFozXNjC+IaJejlNpQ4LlenonvX77jnVqr0=;
        b=l9qdA5qROIvjyMW0CtK+EfZkD9F8spU5lXatUgsGHA/EEZO+If8qR3tudmtIpzquQT
         9O0Xhd5APUWHUnMlUpiR/rtwqS10Uqu282JtrATlJ5BLMpY9LP5afmX1WKtcB+JgyugQ
         f9ZyBNx1lCB+p6LJ9u67X6ZgkkSHe4A5JEa+eJt/H6wg7f5GKdMwcH53XxHyRKXXkbNK
         l/TjFS/CzQ1/TnmYbSQz6NeC9PsO31SbBXlxupXNNtaSmT3NPqttdvZibnAdudKuKPUY
         CIMKpT6dBmDXkccG+lWjGfDbcc7P3ItgXFyuzWIbRtpvapYzPFuj5KA2hMxiTaD6mRi4
         W5xw==
X-Received: by 10.182.126.162 with SMTP id mz2mr24797125obb.30.1367093503370;
        Sat, 27 Apr 2013 13:11:43 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id fl7sm13347497obb.0.2013.04.27.13.11.41
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 27 Apr 2013 13:11:42 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.1031.g2ee5873
In-Reply-To: <1367093407-8898-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222688>

The calls to __gitcomp_file() are essentially the same, but with
different prefix.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 2561265..9cea170 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -535,20 +535,17 @@ __git_complete_revlist_file ()
 # The exception is --committable, which finds the files appropriate commit.
 __git_complete_index_file ()
 {
-	local pfx cur_="$cur"
+	local pfx="" cur_="$cur"
 
 	case "$cur_" in
 	?*/*)
 		pfx="${cur_%/*}"
 		cur_="${cur_##*/}"
 		pfx="${pfx}/"
-
-		__gitcomp_file "$(__git_index_files "$1" "$pfx")" "$pfx" "$cur_"
-		;;
-	*)
-		__gitcomp_file "$(__git_index_files "$1")" "" "$cur_"
 		;;
 	esac
+
+	__gitcomp_file "$(__git_index_files "$1" "$pfx")" "$pfx" "$cur_"
 }
 
 __git_complete_file ()
-- 
1.8.2.1.1031.g2ee5873
