From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 7/7] completion: small optimization
Date: Wed, 10 Apr 2013 01:57:57 -0500
Message-ID: <1365577077-12648-8-git-send-email-felipe.contreras@gmail.com>
References: <1365577077-12648-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 10 08:59:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPp0H-0007zV-GN
	for gcvg-git-2@plane.gmane.org; Wed, 10 Apr 2013 08:59:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755531Ab3DJG7Z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Apr 2013 02:59:25 -0400
Received: from mail-qa0-f50.google.com ([209.85.216.50]:34618 "EHLO
	mail-qa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752532Ab3DJG7Y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Apr 2013 02:59:24 -0400
Received: by mail-qa0-f50.google.com with SMTP id bv4so111130qab.9
        for <git@vger.kernel.org>; Tue, 09 Apr 2013 23:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=wmHssTyXJcgLtDKhOPwEiVvKjvvsPYjcC35nA8IvT9M=;
        b=oUGFWGawgwdS+aKwYjRZLnGW5CeOijqqB67EdEh8AiWMcwk5qv9Br7+RQFhLYP2mzJ
         8ou+oB1m2Mkj1LPMyU8Jr4cNztFeSrwA9ymlR+tJMsvHq2A6BQeAFG5NOUIKiVwRltjE
         dU42yLY5lQGpLEH3gxM5t38Ql+15uL+epuRGF68gwp+etfJdwIcpEaDC6WqIsrP1hhkx
         N4QRafN4zmQRhs6OKgCRdQPOapZWTy/Y5pNJsY8hLOaqo6hb+gs9xqcLkKPkbcBWJUlm
         8y27n4c/pG5f2umugho6h0+DgxoI8W7erDKV22Gbmr4SmmRzCK9w8/TJNtlTqOc1aJf6
         a8BA==
X-Received: by 10.224.219.145 with SMTP id hu17mr1141243qab.38.1365577163718;
        Tue, 09 Apr 2013 23:59:23 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id e3sm29450388qeo.0.2013.04.09.23.59.21
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 09 Apr 2013 23:59:22 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1
In-Reply-To: <1365577077-12648-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220670>

No need to calculate a new $c with a space if we are not going to do
anything it with it.

There should be no functional changes, except that a word "foo " with n=
o
suffixes can't be matched. But $cur cannot have a space at the end
anyway. So it's safe.

Based on the code from SZEDER G=C3=A1bor.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 301de15..1666213 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -210,11 +210,11 @@ __gitcomp ()
 		local c i=3D0 IFS=3D$' \t\n'
 		for c in $1; do
 			c=3D"$c${4-}"
-			case $c in
-			--*=3D*|*.) ;;
-			*) c=3D"$c " ;;
-			esac
 			if [[ $c =3D=3D "$cur_"* ]]; then
+				case $c in
+				--*=3D*|*.) ;;
+				*) c=3D"$c " ;;
+				esac
 				COMPREPLY[i++]=3D"${2-}$c"
 			fi
 		done
--=20
1.8.2.1
