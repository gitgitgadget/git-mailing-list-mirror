From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 20/25] list-files: preload index
Date: Mon,  6 Apr 2015 20:52:29 +0700
Message-ID: <1428328354-14897-21-git-send-email-pclouds@gmail.com>
References: <1428328354-14897-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: 1425896314-10941-1-git-send-email-pclouds@gmail.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 06 15:54:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yf7UH-00065N-9p
	for gcvg-git-2@plane.gmane.org; Mon, 06 Apr 2015 15:54:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753439AbbDFNyp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Apr 2015 09:54:45 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:34105 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753428AbbDFNyo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2015 09:54:44 -0400
Received: by pacyx8 with SMTP id yx8so44832726pac.1
        for <git@vger.kernel.org>; Mon, 06 Apr 2015 06:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Xc/XszPMfqVVqPg7efuran/7wepsKMAXGp1TeJuftL4=;
        b=YkBVIkqpNlW0AW/8Sos4OytFKZBXdFUDsvlrqF7rauorXPp3u0WvE6MpiV5Ix8Y9gZ
         ROoeFMvc/IWA7jyon4fQdp9VpkiUTP9bSmy2zDY+Xt/5cUgu/fdI9iiieSbQq96leK0b
         jbglbJxi3piL6QeNCYsOaxc4BOwFj5dADy3IDZIffrq9Oc4RQfL6TRvJY1BpuIsee3B7
         QRWQn7+hwn6bB7hKf0NI9KzXhvCiyG7aAAdpXN7OiSqXLrAYK4FjMutk1bUhvLma2dUE
         +EfhSEwnbRHNMo1lbjjklAttXKcDi4UOyXHK4yoi1eXapwRdQtPKtv6x70VZr7pQVYG4
         ZWxQ==
X-Received: by 10.70.96.233 with SMTP id dv9mr27881309pdb.44.1428328484181;
        Mon, 06 Apr 2015 06:54:44 -0700 (PDT)
Received: from lanh ([115.73.245.217])
        by mx.google.com with ESMTPSA id qp13sm4802263pdb.31.2015.04.06.06.54.41
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Apr 2015 06:54:43 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Mon, 06 Apr 2015 20:54:55 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1428328354-14897-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266864>

Try to reduce refresh time. Note that we still need another
read_cache() at top top, before parse_pathspec() because this
*_SLASH_CHEAP needs the index loaded.

One day read_index() should be improved to notice that the on-disk
version is the same as the one in memory and skip I/O entirely..

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/list-files.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/list-files.c b/builtin/list-files.c
index 31c2336..948b8e6 100644
--- a/builtin/list-files.c
+++ b/builtin/list-files.c
@@ -529,6 +529,7 @@ int cmd_list_files(int argc, const char **argv, con=
st char *cmd_prefix)
 	recursive_pathspec.max_depth =3D -1;
 	finalize_colopts(&colopts, -1);
=20
+	read_cache_preload(&recursive_pathspec);
 	refresh_index(&the_index, REFRESH_QUIET | REFRESH_UNMERGED,
 		      &recursive_pathspec, NULL, NULL);
=20
--=20
2.3.0.rc1.137.g477eb31
