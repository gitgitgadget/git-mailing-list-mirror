From: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] get_local_heads(): do not return random pointer if there is no head
Date: Fri, 17 Apr 2009 08:16:23 +1000
Message-ID: <1239920183-29512-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 17 00:18:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LuZuM-0001zZ-Vd
	for gcvg-git-2@gmane.org; Fri, 17 Apr 2009 00:18:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754508AbZDPWQg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 16 Apr 2009 18:16:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754410AbZDPWQf
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Apr 2009 18:16:35 -0400
Received: from ti-out-0910.google.com ([209.85.142.187]:42586 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751751AbZDPWQf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Apr 2009 18:16:35 -0400
Received: by ti-out-0910.google.com with SMTP id 11so367719tim.23
        for <git@vger.kernel.org>; Thu, 16 Apr 2009 15:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=ck/N/dMAL8aJjeQXKbMMFG94nk6qK6oYdIMwBU4DzO8=;
        b=lPnQfQlAAYWSTH9bfCOay8r/RBIKFv0C6/XniKhRM+pT+wuASiDpxXQi04HxPcTA+G
         i7DWLTwm8uz1+Jnw7ukZry7exd2lQO8dC7lF9+DAxpFFZ92N43jaOaI5DTX7Czwglx7h
         Skc9RLlNBaQXjIjQ7ats/tGuOAFH0hOFDem6o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=nE8GfhbT1QA9BpXGQcFxvMy1VM+ldrDjo4EPEJT+w4sOSW2sCxgb37rVkWwz8djiig
         51nSbPTolUU+/Pt8H9soVJhuFenTv7eAvOjdtxr3OMvJfpgipw8NOTOkponmlLZ8l0SS
         cGpv2CiwB0tQ/r4NOwjPWR5g+FjnwrU6FvscY=
Received: by 10.110.73.3 with SMTP id v3mr2018397tia.38.1239920192950;
        Thu, 16 Apr 2009 15:16:32 -0700 (PDT)
Received: from dektop (dektec.lnk.telstra.net [203.45.32.221])
        by mx.google.com with ESMTPS id b4sm219255tic.37.2009.04.16.15.16.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 16 Apr 2009 15:16:31 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Fri, 17 Apr 2009 08:16:25 +1000
X-Mailer: git-send-email 1.6.2.2.693.g5a1be
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116718>

it's silly to do this:

mkdir foo && cd foo && git init && git push somewhere.git

but segfault should not happen even in that case.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 remote.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/remote.c b/remote.c
index d12140e..63f749c 100644
--- a/remote.c
+++ b/remote.c
@@ -1493,7 +1493,7 @@ static int one_local_ref(const char *refname, con=
st unsigned char *sha1, int fla
=20
 struct ref *get_local_heads(void)
 {
-	struct ref *local_refs, **local_tail =3D &local_refs;
+	struct ref *local_refs =3D NULL, **local_tail =3D &local_refs;
 	for_each_ref(one_local_ref, &local_tail);
 	return local_refs;
 }
--=20
1.6.2.2.693.g5a1be
