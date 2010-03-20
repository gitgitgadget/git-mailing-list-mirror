From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v2] Makefile: Fix CDPATH problem
Date: Fri, 19 Mar 2010 19:06:15 -0500
Message-ID: <20100320000615.GA17761@progeny.tock>
References: <d557014b1003191436r4d141825p6c5b8e1b3bee4fc8@mail.gmail.com>
 <7veijgc6md.fsf@alter.siamese.dyndns.org>
 <d557014b1003191525m490d1bfam4e8ce40681ff2214@mail.gmail.com>
 <20100319234033.GA18035@progeny.tock>
 <7vd3yz513z.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael Cox <mhcox@bluezoosoftware.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 20 01:05:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsmC6-0007FH-2X
	for gcvg-git-2@lo.gmane.org; Sat, 20 Mar 2010 01:05:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752348Ab0CTAF3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Mar 2010 20:05:29 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:35684 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752209Ab0CTAF2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Mar 2010 20:05:28 -0400
Received: by gwaa18 with SMTP id a18so61653gwa.19
        for <git@vger.kernel.org>; Fri, 19 Mar 2010 17:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=2ultOsOQPk2LcgT80oCJbL35tAFCS5D8RclH/Iej2xU=;
        b=CgvBqr0aBaS2kNlmd6Ex4n4Z8N0ISxbt6YIJGK7tvz5+Rrf8eSiGpy6LTHPmH+UhJB
         8qHfEtgJZHgbucYuPLoxLqq+y8v5zm4m0B4NMgaafLpe46iLId5XOaPJLq7s7NjJpy/8
         FnS+lUV/JK8U8/xfQJB+7Ox/LeBMxVJPiavU0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=kvRX9wMbMwzpSyzzruFB2q+zWbR1pUMTiuq6D5sQIuAnWvehaX6ralqKZhmrEZGIu2
         qi0yLd/9AgAVOFhshuLD/Qdh0L5t6Buh4CxByieXunaLzf0FGN7NUmEcMILhXF2DSvir
         NNA1JfJI8FZKF97ndkBSugV13664Xe2gEVzXw=
Received: by 10.150.32.1 with SMTP id f1mr2229385ybf.222.1269043527888;
        Fri, 19 Mar 2010 17:05:27 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 23sm1402196iwn.10.2010.03.19.17.05.27
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 19 Mar 2010 17:05:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vd3yz513z.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142664>

If CDPATH is set, "cd" prints its destination to stdout, causing
the common (cd a && tar cf - .) | (cd b && tar xf -) idiom to fail.
=46or example:

 make -C templates DESTDIR=3D'' install
 make[1]: Entering directory `/users/e477610/exptool/src/git-1.7.0.2/te=
mplates'
 install -d -m 755 '/home/e477610/exptool/share/git-core/templates'
 (cd blt && gtar cf - .) | \
	(cd '/home/e477610/exptool/share/git-core/templates' && umask 022 && g=
tar xof -)
 gtar: This does not look like a tar archive

Most git scripts already protect against use of CDPATH through
git-sh-setup, but the Makefile doesn=E2=80=99t.

Reported-by: Michael Cox <mhcox@bluezoosoftware.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
> Eh, the rationale and the in-code comment need to be fixed.  The issu=
e is
> not "taking us to random places", but "reporting the name of the rand=
om
> place in its standard output".

That makes more sense.  Thanks.

> But other than that, this is something we have seen on the list a few
> times, and I think it is about time to do this.

Here=E2=80=99s an updated patch.

 Makefile |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index 4387d42..98372eb 100644
--- a/Makefile
+++ b/Makefile
@@ -317,6 +317,12 @@ SCRIPT_PYTHON =3D
 SCRIPT_SH =3D
 TEST_PROGRAMS =3D
=20
+# Having this variable in your environment would break pipelines becau=
se
+# you cause "cd" to echo its destination to stdout.  It can also take
+# scripts to unexpected places.  If you like CDPATH, define it for you=
r
+# interactive shell sessions without exporting it.
+unexport CDPATH
+
 SCRIPT_SH +=3D git-am.sh
 SCRIPT_SH +=3D git-bisect.sh
 SCRIPT_SH +=3D git-difftool--helper.sh
--=20
1.7.0
