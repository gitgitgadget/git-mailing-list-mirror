From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] strbuf: allocate enough space when strbuf_setlen() is called first time
Date: Tue, 26 Apr 2011 19:24:20 +0700
Message-ID: <1303820660-744-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 26 14:24:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QEhJh-0004Iu-UO
	for gcvg-git-2@lo.gmane.org; Tue, 26 Apr 2011 14:24:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751706Ab1DZMY3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Apr 2011 08:24:29 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:64666 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751129Ab1DZMY2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2011 08:24:28 -0400
Received: by pwi15 with SMTP id 15so400540pwi.19
        for <git@vger.kernel.org>; Tue, 26 Apr 2011 05:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        bh=NNs9wBAn49bqVoNtWTlAUe13ROV9d81xaUtt6ExfJz0=;
        b=moSLm9t27AOx/mfQZymCyHXavp8Z3zGjNqCvYhArTzknCouo/h3HCo8ZGa9UgrKN0A
         XQQLMzjWuyE+SQhbrOdnBVGWtv0/0oUfI6ap/OZTwk5WTLSQXnN07FARzfa9M+JayRqO
         +sAOfasOlk3oL6t4pm/gwJ1J9YWc8HH/wQCPw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=RiHG0fH8dHTdXZmm4JJdfJwN+lLtG2l9OvsmI+EnqWN5YIH5tKgVTB1KLGxV2QVgqi
         1azAu4OeAR3McQHw1aanPdlX5zGzmAjbOnF5uH5C1lxV4XCfMwsKHpLaOyqDIaXV32+0
         mNFRe6I+tyy8qmsuDvzmDXFbr2kPOK28Q9IKM=
Received: by 10.142.215.19 with SMTP id n19mr344042wfg.143.1303820668338;
        Tue, 26 Apr 2011 05:24:28 -0700 (PDT)
Received: from tre ([115.73.248.91])
        by mx.google.com with ESMTPS id f4sm535701pbd.13.2011.04.26.05.24.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 26 Apr 2011 05:24:27 -0700 (PDT)
Received: by tre (sSMTP sendmail emulation); Tue, 26 Apr 2011 19:24:21 +0700
X-Mailer: git-send-email 1.7.4.74.g639db
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172090>

strbuf_grow(sb, 0) may allocate less than requested len and violate the
next assertion.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 strbuf.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/strbuf.h b/strbuf.h
index 07060ce..ab213da 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -34,7 +34,7 @@ extern void strbuf_grow(struct strbuf *, size_t);
=20
 static inline void strbuf_setlen(struct strbuf *sb, size_t len) {
 	if (!sb->alloc)
-		strbuf_grow(sb, 0);
+		strbuf_grow(sb, len);
 	assert(len < sb->alloc);
 	sb->len =3D len;
 	sb->buf[len] =3D '\0';
--=20
1.7.4.74.g639db
