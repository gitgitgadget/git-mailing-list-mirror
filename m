From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 1/7] completion: trivial test improvement
Date: Wed, 10 Apr 2013 01:57:51 -0500
Message-ID: <1365577077-12648-2-git-send-email-felipe.contreras@gmail.com>
References: <1365577077-12648-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 10 08:59:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPozw-0007M5-0t
	for gcvg-git-2@plane.gmane.org; Wed, 10 Apr 2013 08:59:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752108Ab3DJG7F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Apr 2013 02:59:05 -0400
Received: from mail-qe0-f52.google.com ([209.85.128.52]:63449 "EHLO
	mail-qe0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751723Ab3DJG7E (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Apr 2013 02:59:04 -0400
Received: by mail-qe0-f52.google.com with SMTP id jy17so68498qeb.25
        for <git@vger.kernel.org>; Tue, 09 Apr 2013 23:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=Dif2o1JW0LTB+AOjFRAI3x9gkZGpySjC3QqEYbauNY8=;
        b=sm0cHTZYmLBxVTz2Tb6XXLoChZQ7IHIQmsooWW/s/27gwJ2/03vTBv9rkvBKhYMqQg
         EJPqpE3WAGahUmhP6zwi2Oir0bQTTuYIY4kesfaXhdxFlxIpkNnRyaQh1e6hsHAPrZfX
         3u3qstpXQIqifjqSPGJKQZdnh4JghSo2Y1LMKmQM80E2lZKAnfiyoAkszTpRPT6ynvd3
         8mCwsqD8vDizWLgOCHDR3n4LU5zvchXi4SGkyUWb1KATac15uREmaaXHD2CNK3MbQutV
         r6mjaUkbY4WLvIerc+iAyHc7aab5157/BhgsN0OU3cC6qETCSGnBkX9sewm+MZRRyXRW
         gAZA==
X-Received: by 10.229.118.11 with SMTP id t11mr281673qcq.152.1365577143214;
        Tue, 09 Apr 2013 23:59:03 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id dl6sm22581206qab.12.2013.04.09.23.59.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 09 Apr 2013 23:59:02 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1
In-Reply-To: <1365577077-12648-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220664>

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
index adc1372..99d5c01 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -69,6 +69,7 @@ run_completion ()
 	local -a COMPREPLY _words
 	local _cword
 	_words=( $1 )
+	test "${1: -1}" == ' ' && _words+=('')
 	(( _cword = ${#_words[@]} - 1 ))
 	__git_wrap__git_main && print_comp
 }
@@ -148,7 +149,7 @@ test_expect_success '__gitcomp - suffix' '
 '
 
 test_expect_success 'basic' '
-	run_completion "git \"\"" &&
+	run_completion "git " &&
 	# built-in
 	grep -q "^add \$" out &&
 	# script
-- 
1.8.2.1
