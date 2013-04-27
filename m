From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 06/11] completion: refactor __git_complete_index_file()
Date: Sat, 27 Apr 2013 05:19:49 -0500
Message-ID: <1367057994-19887-7-git-send-email-felipe.contreras@gmail.com>
References: <1367057994-19887-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Manlio Perillo <manlio.perillo@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 27 12:21:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UW2GD-0003IE-Jc
	for gcvg-git-2@plane.gmane.org; Sat, 27 Apr 2013 12:21:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755685Ab3D0KV3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Apr 2013 06:21:29 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:54509 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754816Ab3D0KV2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Apr 2013 06:21:28 -0400
Received: by mail-oa0-f46.google.com with SMTP id k3so4733901oag.19
        for <git@vger.kernel.org>; Sat, 27 Apr 2013 03:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=h+mwHl0zgFozXNjC+IaJejlNpQ4LlenonvX77jnVqr0=;
        b=aHXYs/PrerR/2ouDiHfk/b3Kf5Qp/Xqy9ZQfh56IN/nN3cwDvPeThDjxQkW9gFrg52
         QGR96V7qs1WxmbEHsD50VB+D9fp+Mb/gAj7W+oXXzDATYQu0lhjMKYOe+WmkdaNQr+mM
         YFtORprttedsHcKNDpE2dMjH+DMhgNEYr4pr1wZ9XaNoDthosmhKVnyAmXyZ9w1buibf
         B0bUHrvlC1lkr9uNHaO3qg3IrtAnqmlpgmtWZANT0jnVnXax9wTY5Dt2P990pJvj9eud
         U8nWZ0mZWv8iMWAZJKZGJmYeXI54qWMaKaxLYdqaw6B4cH02Xe037fJmSjxWEBagU1vC
         qSwQ==
X-Received: by 10.182.106.102 with SMTP id gt6mr19503641obb.37.1367058087680;
        Sat, 27 Apr 2013 03:21:27 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id a3sm12077476oee.8.2013.04.27.03.21.26
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 27 Apr 2013 03:21:26 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.1031.g2ee5873
In-Reply-To: <1367057994-19887-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222631>

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
