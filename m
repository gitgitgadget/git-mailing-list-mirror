From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 11/12] test: add tests for aliases in bash completion
Date: Sun,  8 Apr 2012 06:07:58 +0300
Message-ID: <1333854479-23260-12-git-send-email-felipe.contreras@gmail.com>
References: <1333854479-23260-1-git-send-email-felipe.contreras@gmail.com>
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 08 05:09:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SGiV8-0007HT-Om
	for gcvg-git-2@plane.gmane.org; Sun, 08 Apr 2012 05:09:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754641Ab2DHDI6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Apr 2012 23:08:58 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:54731 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754341Ab2DHDIk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Apr 2012 23:08:40 -0400
Received: by mail-lb0-f174.google.com with SMTP id gg6so1342002lbb.19
        for <git@vger.kernel.org>; Sat, 07 Apr 2012 20:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=wXDu+ocXVN6Vjz+g8cRE2otxrtuvH8wFeaABV80YKeI=;
        b=KB6NlYy4iQU3gsP5Jnu8sAm5Oxr2rHV82t8gUZm2S8uHIuA41j8WWGRN2D+ddDuzNS
         YusBgUcrThg0F+TU2Ate+Qh1e8lLC9e4nSs4nR+tiCxycQH7QlPA8UT+7vVWRi/csKOd
         VPefT8tCAwhYjSTN/NWOY888MRycOeKrXX+UQLxgqF/LSls5ddYWri9umG+rjsD+6Omh
         t25yvGBVxV39e1enYLL8I+Z+o6R5eUTnoLeA9aXViMrioavH8rGImyVoFeQCg3HNCdZF
         xsmEBsknDIYlRaauPrueORWGyU22bn0IIvY87SDgB5r3Ij/YksfIC5J7h8c4vUGelpCj
         B5Lg==
Received: by 10.152.145.169 with SMTP id sv9mr4772596lab.12.1333854519945;
        Sat, 07 Apr 2012 20:08:39 -0700 (PDT)
Received: from localhost (84-231-195-184.elisa-mobile.fi. [84.231.195.184])
        by mx.google.com with ESMTPS id pj20sm11380316lab.13.2012.04.07.20.08.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 07 Apr 2012 20:08:39 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.3.g5a738d
In-Reply-To: <1333854479-23260-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194964>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t9902-completion.sh |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 7b87f4c..6c61e7a 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -54,11 +54,12 @@ _get_comp_words_by_ref ()
 test_completion ()
 {
 	local -a COMPREPLY _words
-	local _cword
+	local _cword wrap
 	_words=( $1 )
 	test $# -gt 1 && echo "$2" > expected
+	wrap="${3-_git_wrap}"
 	(( _cword = ${#_words[@]} - 1 ))
-	_git_wrap && print_comp &&
+	$wrap && print_comp &&
 	test_cmp expected out
 }
 
@@ -305,4 +306,9 @@ test_expect_success 'global options extra checks' '
 	test_completion "git --no-pager tag -d v" "v0.1 "
 '
 
+test_expect_success 'aliases' '
+	git_complete gf git_fetch &&
+	test_completion "gf o" "origin " "_git_fetch_wrap"
+'
+
 test_done
-- 
1.7.10.3.g5a738d
