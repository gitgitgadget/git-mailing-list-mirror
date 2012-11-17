From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC/PATCH 3/5] completion: trivial test improvement
Date: Sat, 17 Nov 2012 02:38:16 +0100
Message-ID: <1353116298-11798-4-git-send-email-felipe.contreras@gmail.com>
References: <1353116298-11798-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	=?UTF-8?q?Bj=C3=B6rn=20Gustavsson?= <bgustavsson@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Robert Zeh <robert.a.zeh@gmail.com>,
	Peter van der Does <peter@avirtualhome.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 17 02:38:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZXN4-0004Op-1g
	for gcvg-git-2@plane.gmane.org; Sat, 17 Nov 2012 02:38:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753952Ab2KQBiq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Nov 2012 20:38:46 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:39206 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753814Ab2KQBip (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Nov 2012 20:38:45 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so1411525bkw.19
        for <git@vger.kernel.org>; Fri, 16 Nov 2012 17:38:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=HYB8LTWAyb2CV4EYacty6O8uMAqtD16BOlS/mj2QPUA=;
        b=B7PIgtAdim8qJvWks6nu5LzuIs/3fGND+2Pu4No7h1mqdU3uLghsSroUBD2VdWv2QD
         KuYrIxQKUSe8hTovBYGz9a1ci7limchL8NdpvE5jArOkjkVLARrXPqNVWaM4/+i2VZXE
         wLjPla+fJVRZj9c3h6tw22grs3OU9o72G0ZYHrB7pRAyNxM8A4ve8pmeeMSwLy0dfZy6
         2dtnf/Gf61kui4Fo4qZDOnTN9tmmW+iNXsrrUVKJ2VFx/gdN7+dQWynWr1fM75RF1nGo
         wsPtMikF68oAgvVIPAXlRAx/VjzizbWvOZLB9Q+tjaR5mI9Nkwn6TaqgSkBNB+dupelb
         ObOA==
Received: by 10.205.139.16 with SMTP id iu16mr2776773bkc.88.1353116324804;
        Fri, 16 Nov 2012 17:38:44 -0800 (PST)
Received: from localhost (ip-109-43-0-81.web.vodafone.de. [109.43.0.81])
        by mx.google.com with ESMTPS id v14sm2003986bkv.10.2012.11.16.17.38.42
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 16 Nov 2012 17:38:44 -0800 (PST)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1353116298-11798-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209924>

Instead of passing a dummy "", let's check if the last character is a
space, and then move the _cword accordingly.

Apparently we were passing "" all the way to compgen, which fortunately
expanded it to nothing.

Lets do the right thing though.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t9902-completion.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index cbd0fb6..0b5e1f5 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -51,6 +51,7 @@ run_completion ()
 	local _cword
 	_words=( $1 )
 	(( _cword = ${#_words[@]} - 1 ))
+	test "${1: -1}" == ' ' && (( _cword += 1 ))
 	__git_wrap__git_main && print_comp
 }
 
@@ -156,7 +157,7 @@ test_expect_success '__gitcomp - suffix' '
 '
 
 test_expect_success 'basic' '
-	run_completion "git \"\"" &&
+	run_completion "git " &&
 	# built-in
 	grep -q "^add \$" out &&
 	# script
-- 
1.8.0
