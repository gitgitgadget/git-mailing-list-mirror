From: Vietor Liu <vietor@vxwo.org>
Subject: [PATCH v3] imap-send.c: fix compiler warnings for OpenSSL 1.0
Date: Wed, 28 Oct 2009 16:28:03 +0800
Message-ID: <1256718483-4275-1-git-send-email-vietor@vxwo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 28 09:25:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N33q9-0004k0-KS
	for gcvg-git-2@lo.gmane.org; Wed, 28 Oct 2009 09:25:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932686AbZJ1IY6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Oct 2009 04:24:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932675AbZJ1IY6
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Oct 2009 04:24:58 -0400
Received: from mail-yx0-f187.google.com ([209.85.210.187]:35100 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932684AbZJ1IY5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2009 04:24:57 -0400
Received: by yxe17 with SMTP id 17so447192yxe.33
        for <git@vger.kernel.org>; Wed, 28 Oct 2009 01:25:01 -0700 (PDT)
Received: by 10.151.92.9 with SMTP id u9mr14895071ybl.158.1256718301690;
        Wed, 28 Oct 2009 01:25:01 -0700 (PDT)
Received: from localhost.localdomain ([123.113.74.202])
        by mx.google.com with ESMTPS id 8sm313822ywg.19.2009.10.28.01.24.57
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 28 Oct 2009 01:25:01 -0700 (PDT)
X-Mailer: git-send-email 1.6.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131435>

=46ixes some compiler warnings:
imap-send.c: In function =E2=80=98ssl_socket_connect=E2=80=99:
warning: assignment discards qualifiers from pointer target type

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
OpenSSL Changes between 0.9.8 and 1.0:

*) Let the TLSv1_method() etc. functions return a 'const' SSL_METHOD
     pointer and make the SSL_METHOD parameter in SSL_CTX_new,
     SSL_CTX_set_ssl_version and SSL_set_ssl_method 'const'.

Signed-off-by: Vietor Liu <vietor@vxwo.org>
---
 imap-send.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index 3847fd1..298aa80 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -281,9 +281,9 @@ static int ssl_socket_connect(struct imap_socket *s=
ock, int use_tls_only, int ve
 	SSL_load_error_strings();
=20
 	if (use_tls_only)
-		meth =3D TLSv1_method();
+		meth =3D (SSL_METHOD *)TLSv1_method();
 	else
-		meth =3D SSLv23_method();
+		meth =3D (SSL_METHOD *)SSLv23_method();
=20
 	if (!meth) {
 		ssl_socket_perror("SSLv23_method");
--=20
1.6.5.2
