From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC/PATCH v2 8/8] completion: small optimization
Date: Sun, 18 Nov 2012 11:56:53 +0100
Message-ID: <1353236213-13471-9-git-send-email-felipe.contreras@gmail.com>
References: <1353236213-13471-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	=?UTF-8?q?Bj=C3=B6rn=20Gustavsson?= <bgustavsson@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Robert Zeh <robert.a.zeh@gmail.com>,
	Peter van der Does <peter@avirtualhome.com>,
	Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 18 11:58:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ta2Zb-00087z-9q
	for gcvg-git-2@plane.gmane.org; Sun, 18 Nov 2012 11:57:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751786Ab2KRK5p convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 18 Nov 2012 05:57:45 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:38308 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751459Ab2KRK5o (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Nov 2012 05:57:44 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so1599953bkw.19
        for <git@vger.kernel.org>; Sun, 18 Nov 2012 02:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=1KuOvHo4Klsmfcmor0EaqV/Q7mWfrY90wHohK7Lr/Zw=;
        b=BICXO7VI8zLiZFpWcjLoNqcfCD0OZ103PqsftSeiLlEh+mJaKXKGhCNFwNVOCbOP8T
         NwiQ18UPaJT2sLGV/irWHwYNWtaQY13XI60byeUnerjR9Wr6oL6x890VDtuQ6yNnEml8
         hcqCqldLvS5iTZVVdg+7K6/VOruetLqHe8fySfqYwAn61zWfs9hocuJLcmwYuMoey146
         sW8YN0hQLTLBmtR2/0E2haOwOP/pRiPhrk8d57oK1FT9JNF96Vhz5FEp26SeR9zVsNUU
         31yA6TUS43HOmSzX1Rk+zR02Z80F4Un5ay6mh1E/Ot2kpew9WLoLyTJgNXzrx8IGK3B6
         GzLw==
Received: by 10.204.3.214 with SMTP id 22mr3732439bko.108.1353236263864;
        Sun, 18 Nov 2012 02:57:43 -0800 (PST)
Received: from localhost (ip-109-43-0-81.web.vodafone.de. [109.43.0.81])
        by mx.google.com with ESMTPS id f24sm207534bkv.7.2012.11.18.02.57.41
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 18 Nov 2012 02:57:43 -0800 (PST)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1353236213-13471-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210020>

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
index 82ea7b1..e5f862c 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -240,11 +240,11 @@ __gitcomp ()
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
1.8.0
