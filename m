From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 20/19] count-objects: consider .bitmap without .pack/.idx pair garbage
Date: Sat, 26 Oct 2013 17:19:56 +0700
Message-ID: <1382782796-5495-1-git-send-email-pclouds@gmail.com>
References: <20131025060442.GQ23098@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, vicent@github.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 26 12:16:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Va0ub-00065l-Ap
	for gcvg-git-2@plane.gmane.org; Sat, 26 Oct 2013 12:16:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751552Ab3JZKQA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 26 Oct 2013 06:16:00 -0400
Received: from mail-pb0-f51.google.com ([209.85.160.51]:57292 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751389Ab3JZKP7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Oct 2013 06:15:59 -0400
Received: by mail-pb0-f51.google.com with SMTP id wz7so4474590pbc.38
        for <git@vger.kernel.org>; Sat, 26 Oct 2013 03:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=FX1LiYVdhoibSgdmHR7UxajIhHAFNWoYwp4l09EcsOA=;
        b=ebn/SwRHSJy9s6vXkfeZfTD0xr6hiSCNzCpULQX4MPjwHFW8aTsW8yGjWvIZ0rswdL
         0fFKdfLydgcTn1FesQaWhgLfwaV1BgFZ/Ib+vP+IcOtPV2XdBsI74Jeqmc4DwcjW9fiu
         GVsCugLoDSDe+2OivWmf1Sbmu1TSH7Avl8KLZKlfEyt5Q79M1tXJnRLf+lLORLj9JFX2
         80KTGUvXIQPGRWq2QQcZa2QO7o4Is75FwKVhqW0CsFXJfJXG1HLx70d7zciCq5nzxG2I
         ixogfptlCAs5Mnr0RmTqaiFJ6sbaSGJ5e2TmOZKmVU7zc+HXGhMxoTXa6+sT0g2mN1Iu
         zuyQ==
X-Received: by 10.68.209.133 with SMTP id mm5mr606636pbc.157.1382782559099;
        Sat, 26 Oct 2013 03:15:59 -0700 (PDT)
Received: from lanh ([115.73.224.222])
        by mx.google.com with ESMTPSA id ry4sm19774468pab.4.2013.10.26.03.15.55
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 26 Oct 2013 03:15:58 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 26 Oct 2013 17:20:01 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <20131025060442.GQ23098@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236749>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Maybe squash this in some place, or leave it separate. I'm fine either=
 way.

 sha1_file.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sha1_file.c b/sha1_file.c
index 4714bd8..1294962 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1194,6 +1194,7 @@ static void prepare_packed_git_one(char *objdir, =
int local)
=20
 		if (has_extension(de->d_name, ".idx") ||
 		    has_extension(de->d_name, ".pack") ||
+		    has_extension(de->d_name, ".bitmap") ||
 		    has_extension(de->d_name, ".keep"))
 			string_list_append(&garbage, path);
 		else
--=20
1.8.2.83.gc99314b
