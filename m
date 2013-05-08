From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 1/2] completion: cleanup zsh wrapper
Date: Wed,  8 May 2013 02:37:00 -0500
Message-ID: <1367998621-12582-2-git-send-email-felipe.contreras@gmail.com>
References: <1367998621-12582-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Manlio Perillo <manlio.perillo@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 08 09:38:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZyxV-0004fw-Gs
	for gcvg-git-2@plane.gmane.org; Wed, 08 May 2013 09:38:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751344Ab3EHHia (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 May 2013 03:38:30 -0400
Received: from mail-ye0-f175.google.com ([209.85.213.175]:59056 "EHLO
	mail-ye0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751109Ab3EHHi3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 May 2013 03:38:29 -0400
Received: by mail-ye0-f175.google.com with SMTP id q4so341123yen.6
        for <git@vger.kernel.org>; Wed, 08 May 2013 00:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=JBTMwgOn6cmAia5EWLEzfLKhMjYGmHtEpkPmmN3546w=;
        b=x7MXiI19bv0p+et3e3Cekkf/u+1SY62p0SXKGnP7YMPNM1jvyjRCHj9tYjRP7R4PrZ
         Y+Rpo+FWlaFvXUavi3Oa8MGxqBAiBehUuHGol3RZ3x0uT1wxQbYU743b56mqBUTF/E2I
         SUpTgxYmRz4CxArvj6VolkT7GqMXu+GxCbOeMrcwWc2wgRK+3iWMalpfUVBObpcsfzFh
         EwpiVKs3LglQfpCSgRoy4wQN+qGnfyLAMdqM3gqRuhaTXwAltaz0mg57rhodudyxnWs0
         GiRQVsyBdtAk2DSdubDEwBlArkGCF1UxGZaE1P4vyPGYb2AtPiIKXZpToLixD5rlKPTY
         TP5A==
X-Received: by 10.236.192.231 with SMTP id i67mr5359400yhn.23.1367998709047;
        Wed, 08 May 2013 00:38:29 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id a24sm61894152yhj.23.2013.05.08.00.38.27
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 08 May 2013 00:38:28 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.553.gac13664
In-Reply-To: <1367998621-12582-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223647>

There's no need for a separate function; we can call
'emulate -k ksh func'.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index b97162f..84dbf19 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2689,21 +2689,13 @@ if [[ -n ${ZSH_VERSION-} ]]; then
 		compadd -Q -p "${2-}" -f -- ${=1} && _ret=0
 	}
 
-	__git_zsh_helper ()
-	{
-		emulate -L ksh
-		local cur cword prev
-		cur=${words[CURRENT-1]}
-		prev=${words[CURRENT-2]}
-		let cword=CURRENT-1
-		__${service}_main
-	}
-
 	_git ()
 	{
-		emulate -L zsh
-		local _ret=1
-		__git_zsh_helper
+		local _ret=1 cur cword prev
+		cur=${words[CURRENT]}
+		prev=${words[CURRENT-1]}
+		let cword=CURRENT-1
+		emulate ksh -c __${service}_main
 		let _ret && _default -S '' && _ret=0
 		return _ret
 	}
-- 
1.8.3.rc1.553.gac13664
