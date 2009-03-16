From: pclouds@gmail.com
Subject: [PATCH] grep: prefer builtin over external one when coloring results
Date: Mon, 16 Mar 2009 13:20:04 +1100
Message-ID: <1237170004-27768-1-git-send-email-pclouds@gmail.com>
References: <49B6979B.8080900@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, rene.scharfe@lsrfire.ath.cx,
	gitster@pobox.com, thiago.salves@gmail.com
X-From: git-owner@vger.kernel.org Mon Mar 16 03:21:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lj2Sb-0006GR-Jc
	for gcvg-git-2@gmane.org; Mon, 16 Mar 2009 03:21:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751539AbZCPCUP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 Mar 2009 22:20:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751511AbZCPCUO
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Mar 2009 22:20:14 -0400
Received: from rv-out-0506.google.com ([209.85.198.227]:55813 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751375AbZCPCUM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Mar 2009 22:20:12 -0400
Received: by rv-out-0506.google.com with SMTP id g37so1348381rvb.1
        for <git@vger.kernel.org>; Sun, 15 Mar 2009 19:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=6SBytpOYx9DoT2UD3CSOkZ15oGjMMV5+isxubq3fY2A=;
        b=wVk6IJrJqRFkEd4j8Sz7TUgEqP4sn76OvUxiJCL/m8XH4Cv9EgD0GhprqrwrF0xz34
         UQZyxZpm78Ta9aX3VsTGHgIDgBPjY2He555NaiY0iBbErRNrLHeZCJ5BbiRlJpbe6liI
         Uya3ANEuJrsm+RPcu7nlc17PTsDdzdCq3aLj8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=IOYvJ10yKERISqGu8M8R5mnHv2AJA9sxz1bM4hWdREjGLHXuyXj+zLdabbE7rMrfbQ
         kV0BadJPMP1TC3YcAAAdpjmEGWZMYY0m7BKBbheVecwQEzsVLuUNLdPLFXfrVxDAHdQ7
         WnublH8OVBYIoe65uAQ70gusvNThtQx3p5qdQ=
Received: by 10.142.110.10 with SMTP id i10mr1883114wfc.300.1237170010701;
        Sun, 15 Mar 2009 19:20:10 -0700 (PDT)
Received: from dektop (dektec.lnk.telstra.net [203.45.32.221])
        by mx.google.com with ESMTPS id 29sm10698901wfg.13.2009.03.15.19.20.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 15 Mar 2009 19:20:10 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Mon, 16 Mar 2009 13:20:04 +1100
X-Mailer: git-send-email 1.6.1.446.gc7851
In-Reply-To: <49B6979B.8080900@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113306>

As far as I know, not all grep programs support coloring, so we should
rely on builtin grep. If you want external grep, set
color.grep.external to empty string.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 How about this?

 builtin-grep.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/builtin-grep.c b/builtin-grep.c
index 9e7e766..89489dd 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -825,6 +825,8 @@ int cmd_grep(int argc, const char **argv, const cha=
r *prefix)
 		}
 	}
=20
+	if (opt.color && !opt.color_external)
+		builtin_grep =3D 1;
 	if (!opt.pattern_list)
 		die("no pattern given.");
 	if ((opt.regflags !=3D REG_NEWLINE) && opt.fixed)
--=20
1.6.1.446.gc7851
