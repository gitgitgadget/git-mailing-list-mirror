From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/4] notes: "add -c" refuses to open an editor with non-blobs
Date: Thu, 10 May 2012 21:04:59 +0700
Message-ID: <1336658701-9004-3-git-send-email-pclouds@gmail.com>
References: <1336482692-30729-1-git-send-email-pclouds@gmail.com>
 <1336658701-9004-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 10 16:09:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSU3b-0000AG-5Q
	for gcvg-git-2@plane.gmane.org; Thu, 10 May 2012 16:09:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759681Ab2EJOJH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 May 2012 10:09:07 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:58252 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759655Ab2EJOJD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2012 10:09:03 -0400
Received: by pbbrp8 with SMTP id rp8so1953088pbb.19
        for <git@vger.kernel.org>; Thu, 10 May 2012 07:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=/vuGMajU8BFF6cFHjkevJFDMX183aY2cPnODKxGjX7Y=;
        b=JbyskQZIK1RqYk5yEAfNrgI2wwyBOC97mXdlgX4I2gmmDmOPhcDQAb0Tu5fLyOh90g
         GhvgsQYvt8um0IhTz/3sQXHxh8gihRqNL/m5239USNSsCSLWAqQgvvjB3qpZwpj5wht7
         WvXE+fSD6kvs14tLhxqgcoatd3IC9gjTjMR3g+qzHp1KCy47MEXMEnt33JeNvabL98Pr
         g0SimrP7hbtrhW8w7FYrW4+SwS08SAWf7GSvfBXRgkM3PTU9osHQGqV8bj24eAGjLw5L
         vg8zoRE3I6La9x7hSq9sbeK8gvdplHoMNGG3ZFdWFz5oyaTdGBJsM+Wacy/wjWSSF1pG
         PbMw==
Received: by 10.68.131.71 with SMTP id ok7mr3214861pbb.139.1336658942557;
        Thu, 10 May 2012 07:09:02 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.38.158])
        by mx.google.com with ESMTPS id d2sm9629805pbw.39.2012.05.10.07.08.58
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 10 May 2012 07:09:01 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 10 May 2012 21:05:20 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <1336658701-9004-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197569>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/notes.c  |    2 ++
 t/t3301-notes.sh |    4 ++++
 2 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/builtin/notes.c b/builtin/notes.c
index 9840269..2960535 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -275,6 +275,8 @@ static int parse_reuse_arg(const struct option *opt=
, const char *arg, int unset)
 		free(buf);
 		die(_("Failed to read object '%s'."), arg);;
 	}
+	if (msg->use_editor && type !=3D OBJ_BLOB)
+		die(_("%s is not a blob, cannot be edited manually"), sha1_to_hex(ob=
ject));
 	strbuf_add(&(msg->buf), buf, len);
 	free(buf);
=20
diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
index d3fd341..add13bc 100755
--- a/t/t3301-notes.sh
+++ b/t/t3301-notes.sh
@@ -1222,6 +1222,10 @@ test_expect_success 'git notes get-ref (--ref)' =
'
 	test "$(GIT_NOTES_REF=3Drefs/notes/bar git notes --ref=3Dbaz get-ref)=
" =3D "refs/notes/baz"
 '
=20
+test_expect_success 'non-blobs cannot be edited using editor' '
+	EDITOR=3Dcat test_must_fail git notes add -f -c HEAD^{tree}
+'
+
 test_expect_success 'add -C happily takes object of any kind' '
 	git notes add -f -C HEAD^{tree}
 '
--=20
1.7.8.36.g69ee2
