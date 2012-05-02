From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 01/10] streaming: void pointer instead of char pointer
Date: Wed,  2 May 2012 20:25:13 +0700
Message-ID: <1335965122-17458-2-git-send-email-pclouds@gmail.com>
References: <1335965122-17458-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 02 15:29:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPZcK-0000ZM-E8
	for gcvg-git-2@plane.gmane.org; Wed, 02 May 2012 15:29:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753890Ab2EBN3G convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 May 2012 09:29:06 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:64496 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753763Ab2EBN3E (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 May 2012 09:29:04 -0400
Received: by mail-pb0-f46.google.com with SMTP id rp8so1097342pbb.19
        for <git@vger.kernel.org>; Wed, 02 May 2012 06:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=dVReaPKD/Pi2UinMolWCYpZHyP8z895TAS1TkwqAy2Q=;
        b=jJsuamMElpqQtDiySeD52aComg0nBw+2+CYLUgnK44QNGVFgsvxAog6N+Hgs+0uEPN
         GM49EUMpodYcvsalu4hadlL9iLaavnl0VJe8gSHG/bvFGDpVkUTmAGeW++64lUqQq0Uy
         NX4MqaR+yDbLZpIo4SEWh1tVqfsROL8kFo6Uun0T3bdiEAfn0gtGjucFOZMjPZ43vegg
         jYt+LWVRaWs17hTvpH1d/ZFX8+aS342TotK2yyHqDsbnx0Rx75pSHVIgUQlFeyqFFYhX
         o5owS0wN0h9qeuC5HWcaasxHHY7tq+9ReIxGFbtVzWqUf3R/Szmq02yuIbQTjxTwAXsn
         AmLQ==
Received: by 10.68.194.72 with SMTP id hu8mr40224057pbc.26.1335965344080;
        Wed, 02 May 2012 06:29:04 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.34.118])
        by mx.google.com with ESMTPS id qa9sm1993376pbb.26.2012.05.02.06.28.59
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 02 May 2012 06:29:03 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 02 May 2012 20:25:33 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <1335965122-17458-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196804>

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
1.7.8.36.g69ee2
