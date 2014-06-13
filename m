From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 09/32] update-index: be specific what part of the index has changed
Date: Fri, 13 Jun 2014 19:19:28 +0700
Message-ID: <1402661991-14977-10-git-send-email-pclouds@gmail.com>
References: <1402661991-14977-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 13 14:21:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvQTl-00037n-EM
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jun 2014 14:21:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752200AbaFMMVE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Jun 2014 08:21:04 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:35529 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751740AbaFMMVD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2014 08:21:03 -0400
Received: by mail-pa0-f54.google.com with SMTP id et14so2084472pad.41
        for <git@vger.kernel.org>; Fri, 13 Jun 2014 05:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=+zMkb9klnYYgaDDQgJ08ArGgPvIHhFOgM6A11Ie93uE=;
        b=SokwfTPAlQMwVsIX6gZvnZ6BLn3qI//G9bnhnZ4fAhqgTIUoky5x5YywAnOE8aHapQ
         xZ1zbAOCzbhFRoP6I0xtBJpk8VNUZYgsUbI5tV0BbUzmSor0X4L4pQ1zmtY1mYsGjNt8
         SPczZvbcLtJhsEth2/FSzP3iGSRYNwdWqEeS+skYOS0Iw+TrJMnnW3BZ660lck7ljqhq
         e045+DtICXXNw0voAKkFFwSG0K/rLapw8DXCBO+KizvCzCu9/xwq/GWtxtvJfeLSeXz/
         qGSFuRX3v+dQq4vdxxvP84hFryITk9CXhpc1XAncbtYur3Gg0QwMPpjzl5lgdU/MEpk0
         d9ZQ==
X-Received: by 10.68.254.5 with SMTP id ae5mr2812345pbd.83.1402662062532;
        Fri, 13 Jun 2014 05:21:02 -0700 (PDT)
Received: from lanh ([115.73.228.145])
        by mx.google.com with ESMTPSA id vc5sm20752526pac.19.2014.06.13.05.20.59
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jun 2014 05:21:01 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Fri, 13 Jun 2014 19:21:00 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <1402661991-14977-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251565>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/update-index.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index d2654d6..e0e881b 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -56,7 +56,7 @@ static int mark_ce_flags(const char *path, int flag, =
int mark)
 		else
 			active_cache[pos]->ce_flags &=3D ~flag;
 		cache_tree_invalidate_path(active_cache_tree, path);
-		active_cache_changed =3D SOMETHING_CHANGED;
+		active_cache_changed |=3D CE_ENTRY_CHANGED;
 		return 0;
 	}
 	return -1;
@@ -268,7 +268,7 @@ static void chmod_path(int flip, const char *path)
 		goto fail;
 	}
 	cache_tree_invalidate_path(active_cache_tree, path);
-	active_cache_changed =3D SOMETHING_CHANGED;
+	active_cache_changed |=3D CE_ENTRY_CHANGED;
 	report("chmod %cx '%s'", flip, path);
 	return;
  fail:
@@ -889,7 +889,7 @@ int cmd_update_index(int argc, const char **argv, c=
onst char *prefix)
 			    INDEX_FORMAT_LB, INDEX_FORMAT_UB);
=20
 		if (the_index.version !=3D preferred_index_format)
-			active_cache_changed =3D SOMETHING_CHANGED;
+			active_cache_changed |=3D SOMETHING_CHANGED;
 		the_index.version =3D preferred_index_format;
 	}
=20
--=20
1.9.1.346.ga2b5940
