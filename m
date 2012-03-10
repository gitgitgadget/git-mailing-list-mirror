From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 1/2] Git::I18N: compatibility with perl <5.8.3
Date: Sat, 10 Mar 2012 12:29:34 +0000
Message-ID: <1331382575-16936-2-git-send-email-avarab@gmail.com>
References: <CACBZZX5wHEigiYjn6ahmnXN3wd9sEyDnRV2EZiP+JSUCc182TQ@mail.gmail.com>
 <1331382575-16936-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Tom G. Christensen" <tgc@statsbiblioteket.dk>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 10 13:30:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S6LRb-0006Ta-4C
	for gcvg-git-2@plane.gmane.org; Sat, 10 Mar 2012 13:30:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753208Ab2CJMaj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 10 Mar 2012 07:30:39 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:63704 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753146Ab2CJMaE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Mar 2012 07:30:04 -0500
Received: by mail-we0-f174.google.com with SMTP id x9so1827137wej.19
        for <git@vger.kernel.org>; Sat, 10 Mar 2012 04:30:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=I/Q1y5W/S3OQm/23YvrJ5X6dnuaktw5nDfIB/W+kbNs=;
        b=a5Obq472ZQuZEeoEU9tsea+agM8t65eY2I2MDp8qipriatVmVHOp34Am+BG7bNVg4A
         m31xrZp0hfA2ledHWfAjGDfQNX22oo/7XB/Igby1zwLJ9HjEU5ttvrq6fPPDvyd1YCNU
         tf874KRRZtLvbwehjv1IGKlhnVnB7TQZAAcTIxudoCSCU8fS3kTgTwhekVyRVdRc/oZ8
         t6e8qKx2Ep13q85303wztFJ9vZBXojgZ/oGAWOYJt6PMQzy8GxHtI5lF1n3ZpqpXsm5o
         g0lLxhl8VYHCqsW0jsEgHfc3f94yq6Me4r6ypuSHh91NyecBxBKDwFRXCz7NZgpU3/j0
         YMRA==
Received: by 10.180.80.40 with SMTP id o8mr12679472wix.10.1331382603924;
        Sat, 10 Mar 2012 04:30:03 -0800 (PST)
Received: from w.nix.is (w.nix.is. [188.40.98.140])
        by mx.google.com with ESMTPS id e6sm10892551wix.8.2012.03.10.04.29.56
        (version=SSLv3 cipher=OTHER);
        Sat, 10 Mar 2012 04:30:03 -0800 (PST)
X-Mailer: git-send-email 1.7.9
In-Reply-To: <1331382575-16936-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192778>

Change the Exporter invocation in Git::I18N to be compatible with
5.8.0 to 5.8.2 inclusive. Before Exporter 5.57 (released with 5.8.3)
Exporter didn't export the 'import' subroutine.

Reported-by: Tom G. Christensen <tgc@statsbiblioteket.dk>
Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 perl/Git/I18N.pm |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/perl/Git/I18N.pm b/perl/Git/I18N.pm
index 07597dc..40dd897 100644
--- a/perl/Git/I18N.pm
+++ b/perl/Git/I18N.pm
@@ -2,7 +2,16 @@ package Git::I18N;
 use 5.008;
 use strict;
 use warnings;
-use Exporter 'import';
+BEGIN {
+	require Exporter;
+	if ($] < 5.008003) {
+		*import =3D \&Exporter::import;
+	} else {
+		# Exporter 5.57 which supports this invocation was
+		# released with perl 5.8.3
+		Exporter->import('import');
+	}
+}
=20
 our @EXPORT =3D qw(__);
 our @EXPORT_OK =3D @EXPORT;
--=20
1.7.9
