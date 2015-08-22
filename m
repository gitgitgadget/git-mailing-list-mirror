From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 5/5] clone: better error when --reference is a linked checkout
Date: Sat, 22 Aug 2015 07:40:02 +0700
Message-ID: <1440204002-7638-6-git-send-email-pclouds@gmail.com>
References: <20150715132552.GA28574@lanh>
 <1440204002-7638-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: bjornar@snoksrud.no,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 22 02:41:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZSwsR-0005ei-Cl
	for gcvg-git-2@plane.gmane.org; Sat, 22 Aug 2015 02:41:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752931AbbHVAlh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 21 Aug 2015 20:41:37 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:35618 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752819AbbHVAl1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2015 20:41:27 -0400
Received: by pacdd16 with SMTP id dd16so54400517pac.2
        for <git@vger.kernel.org>; Fri, 21 Aug 2015 17:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=LVhiewfNPHUcmNysMdKtwpmlaH/o7cB1hLcyQ/wz6tk=;
        b=UT9sZ9DexnPHlWrygPnuOPsJ2bD3X3hVkG6nprFGCcnMG3wWATF0z1MkE3YKhP0YG8
         liTTjc1Wz3TgtM38WQuwLoPSetHtgUNrQ2IfXQroC18m5A3k9rQ2+6BYvm0AxA9gcJIp
         XmJ9yNhibYgrl881Wm6MKwBfT5hPuXj5zz28wLwOWP/Qr5ctI5+l75EE9s6jQ3VIU2tc
         69iE4Q3NkGR41FFl4nTRoYH4TJexD8ghl0o7XnRH6ljA7++qc0hxGKqWvN4isUPHDtmL
         Bqly68LRYnGItTtYLA2rfv8/Sh6xylaLOz7mJFQpQYSBsuWBlal+Jbs2jpdNWEAYucN6
         RgtQ==
X-Received: by 10.66.252.131 with SMTP id zs3mr22042913pac.75.1440204086674;
        Fri, 21 Aug 2015 17:41:26 -0700 (PDT)
Received: from lanh ([171.232.84.126])
        by smtp.gmail.com with ESMTPSA id a2sm1636715pas.47.2015.08.21.17.41.23
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Aug 2015 17:41:26 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 22 Aug 2015 07:41:23 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1440204002-7638-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276351>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/clone.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 836fb64..7a010bb 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -294,9 +294,14 @@ static int add_one_reference(struct string_list_it=
em *item, void *cb_data)
 		char *ref_git_git =3D mkpathdup("%s/.git", ref_git);
 		free(ref_git);
 		ref_git =3D ref_git_git;
-	} else if (!is_directory(mkpath("%s/objects", ref_git)))
+	} else if (!is_directory(mkpath("%s/objects", ref_git))) {
+		struct strbuf sb =3D STRBUF_INIT;
+		if (get_common_dir(&sb, ref_git))
+			die(_("reference repository '%s' as a linked checkout is not suppor=
ted yet."),
+			    item->string);
 		die(_("reference repository '%s' is not a local repository."),
 		    item->string);
+	}
=20
 	if (!access(mkpath("%s/shallow", ref_git), F_OK))
 		die(_("reference repository '%s' is shallow"), item->string);
--=20
2.3.0.rc1.137.g477eb31
