From: Michael Wookey <michaelwookey@gmail.com>
Subject: [PATCH] fast-import.c: Silence build warning
Date: Mon, 31 Aug 2009 21:21:34 +1000
Message-ID: <d2e97e800908310421u7de8ae58o361bd64a026384bf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 31 13:22:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mi4xY-0003Tr-0c
	for gcvg-git-2@lo.gmane.org; Mon, 31 Aug 2009 13:22:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751884AbZHaLVy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 31 Aug 2009 07:21:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751845AbZHaLVx
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Aug 2009 07:21:53 -0400
Received: from mail-yw0-f188.google.com ([209.85.211.188]:43721 "EHLO
	mail-yw0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751837AbZHaLVx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 31 Aug 2009 07:21:53 -0400
Received: by ywh26 with SMTP id 26so5907194ywh.5
        for <git@vger.kernel.org>; Mon, 31 Aug 2009 04:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:from:date:message-id
         :subject:to:content-type:content-transfer-encoding;
        bh=XH2rXIdCtzYZr0Uq46g0EqHnHjhwXkBvUnPP7WaTatE=;
        b=DfRmC8X29bpRC/Qo6QAT4mS5cPfMvFxUHK2JoTQe4HOR3c63HWRe1xZ9dTmkwJoTBX
         1MYwuJatPi6wS55d8v76Tjm2FzeXRfuf2wRtoebgt949u2JmgcvWHaniyQ8cp/Q+N1mk
         O5mpcbzpgZZtcPyioonoGxJW7ixsf5PvfqbHk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        b=u3Q+RB4kP/gB1SPHaj0IjWGdbknwNNeJfk5qfT1K1i2QYeNSNw+vZW6HJQBvrUZzkT
         E2gcqcWhoM19uGKZdpcNeXjGq0rJMJM/EgoYv56ntFp+DH81zdlP2GhFHdnLey0Csq6W
         l6Ba6NC3k5bzQmpW39Ci/PkOhFfaIOkncHlSQ=
Received: by 10.101.87.4 with SMTP id p4mr5547113anl.68.1251717714087; Mon, 31 
	Aug 2009 04:21:54 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127477>

gcc 4.3.3 (Ubuntu 9.04) warns that the return value of strtoul() was no=
t
checked by issuing the following notice:

  warning: ignoring return value of =E2=80=98strtoul=E2=80=99, declared=
 with attribute
warn_unused_result

Provide a dummy variable to keep the compiler happy.

Signed-off-by: Michael Wookey <michaelwookey@gmail.com>
---
 fast-import.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 7ef9865..1386e75 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1744,10 +1744,11 @@ static int validate_raw_date(const char *src,
char *result, int maxlen)
 {
 	const char *orig_src =3D src;
 	char *endp;
+	unsigned long int unused;

 	errno =3D 0;

-	strtoul(src, &endp, 10);
+	unused =3D strtoul(src, &endp, 10);
 	if (errno || endp =3D=3D src || *endp !=3D ' ')
 		return -1;

@@ -1755,7 +1756,7 @@ static int validate_raw_date(const char *src,
char *result, int maxlen)
 	if (*src !=3D '-' && *src !=3D '+')
 		return -1;

-	strtoul(src + 1, &endp, 10);
+	unused =3D strtoul(src + 1, &endp, 10);
 	if (errno || endp =3D=3D src || *endp || (endp - orig_src) >=3D maxle=
n)
 		return -1;

--=20
1.6.4.2.236.gf324c
