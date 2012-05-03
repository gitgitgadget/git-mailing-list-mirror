From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 1/9] streaming: void pointer instead of char pointer
Date: Thu,  3 May 2012 08:51:00 +0700
Message-ID: <1336009868-7411-2-git-send-email-pclouds@gmail.com>
References: <1336009868-7411-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 03 03:53:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPlEu-0007lZ-B5
	for gcvg-git-2@plane.gmane.org; Thu, 03 May 2012 03:53:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755380Ab2ECBww convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 May 2012 21:52:52 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:55696 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754563Ab2ECBwY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 May 2012 21:52:24 -0400
Received: by mail-pb0-f46.google.com with SMTP id rp8so1813971pbb.19
        for <git@vger.kernel.org>; Wed, 02 May 2012 18:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=9+h0w3WbZ5nlU+KXsRLHUaMmcYgg9k7EvK6KJvklfKE=;
        b=aKNm6mNbFyrmLACwkWgi4v70LgZdGw+cRsbn34gvrFSSOMtWrzw6zExtVs3xSWq57s
         qNfu1dq3m+oaEzHqdSR86yM/P80zerdSeqvM5FOFRLP0I2WlS1ygd7/pLD92Nggp+NYC
         AtjqX/ei1aLxM+dW0SvlLw7Gd5l/I4dsQw/QIdhy9ODhWnzZ830oAPuiEgrojv1TbbMd
         ijOrbO5fjUF4l0Zy2llax73cZKDkbAe3n7r7+X9ATGorVM9Jnqi4YIHvyTHqeqPK8c7V
         4aWCTuxCLgZ1XoNxUvJ/NPeHOiOMQwk8HAPN7wUc5nm3gkdMNBxcw1PQYsWeWWb7RWGD
         4G5w==
Received: by 10.68.227.227 with SMTP id sd3mr2527164pbc.64.1336009944718;
        Wed, 02 May 2012 18:52:24 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id mr6sm3622221pbb.29.2012.05.02.18.52.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 02 May 2012 18:52:23 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 03 May 2012 08:51:28 +0700
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
In-Reply-To: <1336009868-7411-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196882>

=46rom: Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx>

Allow any kind of buffer to be fed to read_istream() without an explici=
t
cast by making it's buf argument a void pointer.  It's about arbitrary
data, not only characters.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 streaming.c |    2 +-
 streaming.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/streaming.c b/streaming.c
index 7e7ee2b..3a3cd12 100644
--- a/streaming.c
+++ b/streaming.c
@@ -99,7 +99,7 @@ int close_istream(struct git_istream *st)
 	return r;
 }
=20
-ssize_t read_istream(struct git_istream *st, char *buf, size_t sz)
+ssize_t read_istream(struct git_istream *st, void *buf, size_t sz)
 {
 	return st->vtbl->read(st, buf, sz);
 }
diff --git a/streaming.h b/streaming.h
index 3e82770..1d05c2a 100644
--- a/streaming.h
+++ b/streaming.h
@@ -10,7 +10,7 @@ struct git_istream;
=20
 extern struct git_istream *open_istream(const unsigned char *, enum ob=
ject_type *, unsigned long *, struct stream_filter *);
 extern int close_istream(struct git_istream *);
-extern ssize_t read_istream(struct git_istream *, char *, size_t);
+extern ssize_t read_istream(struct git_istream *, void *, size_t);
=20
 extern int stream_blob_to_fd(int fd, const unsigned char *, struct str=
eam_filter *, int can_seek);
=20
--=20
1.7.3.1.256.g2539c.dirty
