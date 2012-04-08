From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 02/12] completion: simplify __gitcomp
Date: Sun,  8 Apr 2012 06:07:49 +0300
Message-ID: <1333854479-23260-3-git-send-email-felipe.contreras@gmail.com>
References: <1333854479-23260-1-git-send-email-felipe.contreras@gmail.com>
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 08 05:09:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SGiVP-0007R6-Bw
	for gcvg-git-2@plane.gmane.org; Sun, 08 Apr 2012 05:09:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753374Ab2DHDIu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Apr 2012 23:08:50 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:54731 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753139Ab2DHDIV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Apr 2012 23:08:21 -0400
Received: by mail-lb0-f174.google.com with SMTP id gg6so1342002lbb.19
        for <git@vger.kernel.org>; Sat, 07 Apr 2012 20:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=5emw5LFwqvR6+h0tTRqovRqR4zyVnv72//i5srGj1ZY=;
        b=YMwnKcCQnrDaxB7hTRnVo1TiRx+2m1JqtxzmZSilCjfK16AU5VrEPIll2JbwdaFSyB
         XQxvdtDau42Yfz5JsCqiUJtMqf8qkxcT9NVK31tszcq3bal1XrHJ/06SNUofVV4SRUdf
         cdt4mwwjL13tILRFcGXDeQwuGtH2Kpx/M+XucNdsnJiy7mzfxL9R8R2Mi5qzI2uD2uNY
         zN38kcIPVeg81wxXQYwm8IkEbtxgZ7JqBEFa1Xv9L7jEFiJLBJzXVSMik4Hz1mV5syeU
         WSMx6qF2m14YPU8lPoN2C3xRjvqNuIokYef2C0Z7fEYVpmwslolE5iXiGvPqLKY58l4o
         OaJw==
Received: by 10.152.106.9 with SMTP id gq9mr4755234lab.14.1333854500470;
        Sat, 07 Apr 2012 20:08:20 -0700 (PDT)
Received: from localhost (84-231-195-184.elisa-mobile.fi. [84.231.195.184])
        by mx.google.com with ESMTPS id p2sm15523074lbj.0.2012.04.07.20.08.19
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 07 Apr 2012 20:08:20 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.3.g5a738d
In-Reply-To: <1333854479-23260-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194965>

The suffix is never used.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash |   12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 31f714d..39f5435 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -304,15 +304,14 @@ __git_ps1 ()
 	fi
 }
 
-# __gitcomp_1 requires 2 arguments
 __gitcomp_1 ()
 {
 	local c IFS=' '$'\t'$'\n'
 	for c in $1; do
-		case "$c$2" in
-		--*=*) printf %s$'\n' "$c$2" ;;
-		*.)    printf %s$'\n' "$c$2" ;;
-		*)     printf %s$'\n' "$c$2 " ;;
+		case "$c" in
+		--*=*) printf %s$'\n' "$c" ;;
+		*.)    printf %s$'\n' "$c" ;;
+		*)     printf %s$'\n' "$c " ;;
 		esac
 	done
 }
@@ -479,7 +478,6 @@ fi
 # 1: List of possible completion words.
 # 2: A prefix to be added to each possible completion word (optional).
 # 3: Generate possible completion matches for this word (optional).
-# 4: A suffix to be appended to each possible completion word (optional).
 __gitcomp ()
 {
 	local cur_="${3-$cur}"
@@ -491,7 +489,7 @@ __gitcomp ()
 	*)
 		local IFS=$'\n'
 		COMPREPLY=($(compgen -P "${2-}" \
-			-W "$(__gitcomp_1 "${1-}" "${4-}")" \
+			-W "$(__gitcomp_1 "${1-}")" \
 			-- "$cur_"))
 		;;
 	esac
-- 
1.7.10.3.g5a738d
