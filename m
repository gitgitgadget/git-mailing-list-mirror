From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC/PATCH v2 1/8] completion: trivial test improvement
Date: Sun, 18 Nov 2012 11:56:46 +0100
Message-ID: <1353236213-13471-2-git-send-email-felipe.contreras@gmail.com>
References: <1353236213-13471-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	=?UTF-8?q?Bj=C3=B6rn=20Gustavsson?= <bgustavsson@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Robert Zeh <robert.a.zeh@gmail.com>,
	Peter van der Does <peter@avirtualhome.com>,
	Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 18 11:57:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ta2Z6-0007lt-Df
	for gcvg-git-2@plane.gmane.org; Sun, 18 Nov 2012 11:57:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751466Ab2KRK5O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Nov 2012 05:57:14 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:38308 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751239Ab2KRK5N (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Nov 2012 05:57:13 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so1599953bkw.19
        for <git@vger.kernel.org>; Sun, 18 Nov 2012 02:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=z1aWQy9pUi1gbK2JsWIfb/1ynJsbgVBT/czGKg/qr3E=;
        b=OxFrHzWwQ6wSIP7YBDupaJjcRmo/iVTwMHTv4UWAfFzfwRkT52skDmv9o4X779niB2
         MRd/4mbdDIHb4f5aj5PardWXiBEKQKbJjeEKNJfshyy7WzpdC/lDKj4Az9PGvQjry2wS
         vTLH53GdBks3kAQY92Co7R+d6stvhAyPAK0VUg0Hoxquuig/drQ50P4spSVEhAHz8MO6
         w/njzRbYqRsrzM6V85hU16JIF3yPoII5X6YgGM+v+R2qNYUT6xMeLfVGGvF1aFNtrXkV
         Late/C4m+MWPxEEsdrBXEDWDkvsMHhsd9C3vDJa9Gwo7aJbKm67euIL5YkZPSWXqLd7V
         G8LA==
Received: by 10.204.147.135 with SMTP id l7mr3862029bkv.119.1353236233280;
        Sun, 18 Nov 2012 02:57:13 -0800 (PST)
Received: from localhost (ip-109-43-0-81.web.vodafone.de. [109.43.0.81])
        by mx.google.com with ESMTPS id u3sm2896393bkw.9.2012.11.18.02.57.10
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 18 Nov 2012 02:57:12 -0800 (PST)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1353236213-13471-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210012>

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
index 8fa025f..79a2453 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -50,6 +50,7 @@ run_completion ()
 	local -a COMPREPLY _words
 	local _cword
 	_words=( $1 )
+	test "${1: -1}" == ' ' && _words+=('')
 	(( _cword = ${#_words[@]} - 1 ))
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
