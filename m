From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>
Subject: [PATCH] mailmap: xcalloc mailmap_info
Date: Thu, 17 Nov 2011 02:25:06 +0100
Message-ID: <1321493106-6533-1-git-send-email-marcandre.lureau@gmail.com>
References: <7v8vnfpn9v.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 17 02:25:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQqjA-0006v6-Ue
	for gcvg-git-2@lo.gmane.org; Thu, 17 Nov 2011 02:25:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754954Ab1KQBZO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Nov 2011 20:25:14 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:36112 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754825Ab1KQBZN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Nov 2011 20:25:13 -0500
Received: by wwe5 with SMTP id 5so1857496wwe.1
        for <git@vger.kernel.org>; Wed, 16 Nov 2011 17:25:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=68M7cdLKS+WefEwnBhHe+CB2rkzoVDVKB1fzocSSqMY=;
        b=vaco8HZBXgQzRT7yz0CAYWaAZExSNVrNLb2zCeHgR6hWGpBuzSMUVwa1abQ/lWgGP4
         hiP/HPCsCmSmfre4GbWt9Z+8Kq8WVKt2SQohz0BKIvWqk/YZoet6xvdeYp2f9ikYzBS8
         80XisIDI7RUPRcB72AtN41Xwx5qcClf3KDLf0=
Received: by 10.180.72.146 with SMTP id d18mr39253347wiv.12.1321493111978;
        Wed, 16 Nov 2011 17:25:11 -0800 (PST)
Received: from localhost ([80.31.222.109])
        by mx.google.com with ESMTPS id k5sm17438810wiz.9.2011.11.16.17.25.10
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 16 Nov 2011 17:25:11 -0800 (PST)
X-Mailer: git-send-email 1.7.7
In-Reply-To: <7v8vnfpn9v.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185568>

This is to avoid reaching free of uninitialized members.

With an invalid .mailmap (and perhaps in other cases), it can reach
free(mi->name) with garbage for example.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com>
---
 mailmap.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/mailmap.c b/mailmap.c
index 02fcfde..8c3196c 100644
--- a/mailmap.c
+++ b/mailmap.c
@@ -70,8 +70,7 @@ static void add_mapping(struct string_list *map,
 	} else {
 		/* create mailmap entry */
 		struct string_list_item *item =3D string_list_insert_at_index(map, i=
ndex, old_email);
-		item->util =3D xmalloc(sizeof(struct mailmap_entry));
-		memset(item->util, 0, sizeof(struct mailmap_entry));
+		item->util =3D xcalloc(1, sizeof(struct mailmap_entry));
 		((struct mailmap_entry *)item->util)->namemap.strdup_strings =3D 1;
 	}
 	me =3D (struct mailmap_entry *)map->items[index].util;
@@ -88,7 +87,7 @@ static void add_mapping(struct string_list *map,
 			me->email =3D xstrdup(new_email);
 		}
 	} else {
-		struct mailmap_info *mi =3D xmalloc(sizeof(struct mailmap_info));
+		struct mailmap_info *mi =3D xcalloc(1, sizeof(struct mailmap_info));
 		debug_mm("mailmap: adding (complex) entry for %s at index %d\n", old=
_email, index);
 		if (new_name)
 			mi->name =3D xstrdup(new_name);
--=20
1.7.7
