From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [RFC PATCH v3 4/8] excluded_1(): support exclude "directories" in index
Date: Tue, 11 Aug 2009 22:44:02 +0700
Message-ID: <1250005446-12047-5-git-send-email-pclouds@gmail.com>
References: <1250005446-12047-1-git-send-email-pclouds@gmail.com>
 <1250005446-12047-2-git-send-email-pclouds@gmail.com>
 <1250005446-12047-3-git-send-email-pclouds@gmail.com>
 <1250005446-12047-4-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 11 17:44:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MatWs-0006wH-Di
	for gcvg-git-2@gmane.org; Tue, 11 Aug 2009 17:44:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753538AbZHKPoh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 Aug 2009 11:44:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753529AbZHKPoh
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Aug 2009 11:44:37 -0400
Received: from rv-out-0506.google.com ([209.85.198.235]:29186 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753527AbZHKPog (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2009 11:44:36 -0400
Received: by rv-out-0506.google.com with SMTP id f6so1344620rvb.1
        for <git@vger.kernel.org>; Tue, 11 Aug 2009 08:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=xp37p8rZWCPVWyNmb/Vs4yku+ET9RJcF14mPWZ4S+Ag=;
        b=JCLzyg3R2kArVd70qsLsbt2/d9i22gB0g4/mcZEhz9LNOQ+TTsxfiqghOk3f5FJEvF
         ggkboCX2DZFMpuq9uqY3RxHb7WYwroZJoOvQ4Q+9tbQROD1DhEzqiUYKcdcS4NABd3oq
         ep2vWE8CgMA73qGzx80zV7CKArKVM5mr9oDmw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=MSQht3TvdMkEk+E1SZXuFda6GGVAYWBacNaIBrGqJ5fTTTX33CVDoXluU71lTDr9cx
         ALwwyjHD/S5IaCwGA6/px4UstsQKaCcaFpEOKO/8XKpz5mh5DB1oHnD0UOSy4Hr7phWP
         f142pL4nRLfrZaT4uY/U/U/IZrlmYdzMrhXwU=
Received: by 10.140.134.9 with SMTP id h9mr2313669rvd.43.1250005477916;
        Tue, 11 Aug 2009 08:44:37 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.239.0])
        by mx.google.com with ESMTPS id g14sm32711192rvb.0.2009.08.11.08.44.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 11 Aug 2009 08:44:37 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Tue, 11 Aug 2009 22:44:32 +0700
X-Mailer: git-send-email 1.6.3.GIT
In-Reply-To: <1250005446-12047-4-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125578>

Index does not really have "directories", attempts to match "foo/"
against index will fail unless someone tries to reconstruct directories
from a list of file.

Observing that dtype in this function can never be NULL (otherwise
it would segfault), dtype NULL will be used to say "hey.. you are
matching against index" and behave properly.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
  Having dtype to segfault when dtype is NULL is nice, but I found
  no way else to sneak the new code in. Defining DT_INDEX may clash
  existing system definitions..


 dir.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/dir.c b/dir.c
index 66b485c..c990938 100644
--- a/dir.c
+++ b/dir.c
@@ -350,6 +350,12 @@ static int excluded_1(const char *pathname,
 			int to_exclude =3D x->to_exclude;
=20
 			if (x->flags & EXC_FLAG_MUSTBEDIR) {
+				if (!dtype) {
+					if (!prefixcmp(pathname, exclude))
+						return to_exclude;
+					else
+						continue;
+				}
 				if (*dtype =3D=3D DT_UNKNOWN)
 					*dtype =3D get_dtype(NULL, pathname, pathlen);
 				if (*dtype !=3D DT_DIR)
--=20
1.6.3.GIT
