From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2] index-format.txt: be more liberal on what can represent invalid cache tree
Date: Thu, 13 Dec 2012 08:14:47 +0700
Message-ID: <1355361287-10875-1-git-send-email-pclouds@gmail.com>
References: <7v4njr5eac.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 13 02:14:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TixNh-0005e7-5R
	for gcvg-git-2@plane.gmane.org; Thu, 13 Dec 2012 02:14:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755225Ab2LMBOQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 12 Dec 2012 20:14:16 -0500
Received: from mail-da0-f46.google.com ([209.85.210.46]:65096 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755130Ab2LMBOP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2012 20:14:15 -0500
Received: by mail-da0-f46.google.com with SMTP id p5so488919dak.19
        for <git@vger.kernel.org>; Wed, 12 Dec 2012 17:14:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=CASUEAfnxfQ/J2ZLoIHZQxyrDfLH0S41vh4gGrRZMwc=;
        b=wDyuE4vuqkhnfW9CepXty+42h5ko5zYF0/hUCnG7iXzhC6Op/nSilx9/CyMjb5n94s
         lhnVHScjqiRqxMoYhy4HrkZ4NpLRj5Qdx5cPMVQ7HXudgZWlQg46r5mtWqEJVB6+DHPe
         mFviAkkAxO4pQbAoGGhnl5b7ixt/NeFU0Pm6lOm44lVyZp9RULbsEsWNyYg144tCU1sb
         c9s/KfDNhpGIziFY2O/D/SrJHPY8vkHEI/olz3lJMzlZnyDVxEp2x+VxmA0VS8Iqw5jU
         4WcRtp2SF+k6NnBtcAZ5JKBUhOr5scfZemhYcI15dNGgJmXVQBK9mdaspdkVTzcs8DQT
         c5wA==
Received: by 10.68.241.136 with SMTP id wi8mr201132pbc.95.1355361255395;
        Wed, 12 Dec 2012 17:14:15 -0800 (PST)
Received: from lanh ([115.74.41.198])
        by mx.google.com with ESMTPS id is3sm16541634pbc.6.2012.12.12.17.14.12
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 12 Dec 2012 17:14:14 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Thu, 13 Dec 2012 08:14:49 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
In-Reply-To: <7v4njr5eac.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211428>

We have been writing -1 as "invalid" since day 1. On that same day we
accept all negative entry counts as "invalid". So in theory all C Git
versions out there would be happy to accept any negative numbers. JGit
seems to do exactly the same.

Correct the document to reflect the fact that -1 is not the only magic
number. At least one implementation, libgit2, is found to treat -1
this way.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 On Thu, Dec 13, 2012 at 1:14 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:
 > Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> write=
s:
 >
 >> We have been writing -1 as "invalid" since day 1. On that same day =
we
 >> accept all negative entry counts as "invalid". So in theory all C G=
it
 >> versions out there would be happy to accept any negative numbers. J=
Git
 >> seems to do exactly the same.
 >
 > I am of two minds here.
 >
 > The existing code is being more lenient than specified when they
 > read stuff others wrote, but it still adheres to -1 when writing.
 > Allowing random implementations to write random negative values will
 > close the door for us to later update the specification to encode
 > more informatin about these invalid entries by using negative value
 > other than -1 here.

 How would that work with existing versions? If you write -2 in
 cache-tree, the next time 1.8.0 updates cache tree it writes -1 back.
 That loses whatever information you attach to -2. A new cache-tree
 extension is probably better.

 > I am OK with a reword to say "negative means invalid, and writers
 > should write -1 for invalid entries", but without the latter half,
 > this change is not justified.

 Done.

 Documentation/technical/index-format.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/technical/index-format.txt b/Documentation/t=
echnical/index-format.txt
index 9d25b30..ce28a7a 100644
--- a/Documentation/technical/index-format.txt
+++ b/Documentation/technical/index-format.txt
@@ -161,8 +161,9 @@ GIT index format
     this span of index as a tree.
=20
   An entry can be in an invalidated state and is represented by having
-  -1 in the entry_count field. In this case, there is no object name
-  and the next entry starts immediately after the newline.
+  a negative number in the entry_count field. In this case, there is n=
o
+  object name and the next entry starts immediately after the newline.
+  When writing an invalid entry, -1 should always be used as entry_cou=
nt.
=20
   The entries are written out in the top-down, depth-first order.  The
   first entry represents the root level of the repository, followed by=
 the
--=20
1.8.0.rc2.23.g1fb49df
