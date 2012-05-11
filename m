From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 2/4] notes: "add -c" refuses to open an editor with non-blobs
Date: Fri, 11 May 2012 08:25:04 +0700
Message-ID: <1336699506-28388-3-git-send-email-pclouds@gmail.com>
References: <1336658701-9004-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Johannes Sixt <j.sixt@viscovery.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 11 03:26:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSecq-0001y0-DA
	for gcvg-git-2@plane.gmane.org; Fri, 11 May 2012 03:26:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757836Ab2EKB01 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 May 2012 21:26:27 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:65022 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755777Ab2EKB00 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2012 21:26:26 -0400
Received: by mail-pz0-f46.google.com with SMTP id y13so2400997dad.19
        for <git@vger.kernel.org>; Thu, 10 May 2012 18:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=wJMZcSXt//kj4E/6BDeuRqYyu5p/35IXYS4vF5EwOpA=;
        b=ajy/4MYJWe1NfAqgeggRMkGMp5ESPTLTOf5Fc9YXHfqqXvsLdMrjfxHZa04rBuK1Au
         teHDx4Qw4Vv25cVFDkTNaIRRP7DsZAkF1T6+Lm+o2h3m7IdgL24dtoJbOt5COTaSpD8A
         7zXI9XCEK6uBf0MBXd0iqBqUjDmBK/aS4VkZA+kYjt0e55HyMOAhf9zPM2Ro0e1zQaQb
         lk6Rk4fhDOZBhrrxJfqpHp4xOn4wfgOz9J1R4myGV5bqJY1R35ASOUYa1qjZLXVVSctq
         bl9ce3H/+Tbf98QtzrAK6svVvcHDeZJmhf2EpykmGYUheF8pyYrqnGHQrXFnVyHKIzUR
         b8rQ==
Received: by 10.68.217.67 with SMTP id ow3mr26329419pbc.16.1336699586595;
        Thu, 10 May 2012 18:26:26 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id q5sm11121506pbp.28.2012.05.10.18.26.21
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 10 May 2012 18:26:25 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 11 May 2012 08:25:25 +0700
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
In-Reply-To: <1336658701-9004-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197651>

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
index d3fd341..dd8675f 100755
--- a/t/t3301-notes.sh
+++ b/t/t3301-notes.sh
@@ -1222,6 +1222,10 @@ test_expect_success 'git notes get-ref (--ref)' =
'
 	test "$(GIT_NOTES_REF=3Drefs/notes/bar git notes --ref=3Dbaz get-ref)=
" =3D "refs/notes/baz"
 '
=20
+test_expect_success 'non-blobs cannot be edited using editor' '
+	test_must_fail git notes add -f -c HEAD^{tree}
+'
+
 test_expect_success 'add -C happily takes object of any kind' '
 	git notes add -f -C HEAD^{tree}
 '
--=20
1.7.3.1.256.g2539c.dirty
