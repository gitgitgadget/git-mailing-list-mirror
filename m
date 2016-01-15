From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v5 08/11] dir: simplify untracked cache "ident" field
Date: Fri, 15 Jan 2016 07:59:49 +0100
Message-ID: <1452841192-620-9-git-send-email-chriscool@tuxfamily.org>
References: <1452841192-620-1-git-send-email-chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 15 08:00:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJyNT-000558-PA
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jan 2016 08:00:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755319AbcAOHAt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Jan 2016 02:00:49 -0500
Received: from mail-wm0-f50.google.com ([74.125.82.50]:34441 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754336AbcAOHAp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2016 02:00:45 -0500
Received: by mail-wm0-f50.google.com with SMTP id u188so11040300wmu.1
        for <git@vger.kernel.org>; Thu, 14 Jan 2016 23:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=QO0mt0v0u6F6a1HLG8AA6g5FeYv14+dESuDc6XDVlNM=;
        b=VyWwoYNwY8RcspcCwJ5wyhFbNEtZA+QxDPg/7lCMJosIwydVa4/XZfoTf74ortCf5V
         slNrxaFPY5Vzl+vIjkDG68fHwCS5oh2f7+QvayllGctnewMOd+NpaRsyW+6H59PkhePv
         hOl+B4lyycI0mUoRmgZoSswE7oR63E11ElyQO5lcYjMxI75XcM6/TruEpGP0lDfSbFQ6
         9wtQWIZm9T4A7QONO5niY7ydBCDBiipTgZjsF9MqlzfuPsOjgyihgEtchKf2Y/mcoAGW
         NrXMBfr450TrJT6Mcs43YMqfFMI46VSk+bdJCde3hcOuw/pdKW2FZ2AYa0E4ni1R3AdG
         bMSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=QO0mt0v0u6F6a1HLG8AA6g5FeYv14+dESuDc6XDVlNM=;
        b=e4KUSC8/kFdTkg5AOijaqVMk4fpHZi6RqIZ0eWh+hdfCDexIVMJY4X2j59hTZguon9
         96hMPK+qMOdOmGFlkdkMh7Q30Bp+3n17jlTYy3l3VODc+mrSY6pUEdVR8m8le2gk072L
         hAEVUO/YE35w+PMYiUvgSpB3hSd2ZWd0rpPH0lO4T7K3sbEZzmZQnwVJygsmLE/KOUlH
         qW0b1ViQSv5TBnf1qB64eeTZxiBYtEMaBcIaDh/ChqdlskQKPXst8zO/nCih58debEG8
         ccAC1ygEpJE/21VKmok3RtzBC6a7VcazKylEXb1MP85GIb2pbHai0VZRSfPuv7J5K7CS
         L4OQ==
X-Gm-Message-State: AG10YOSwJWekR9LIXvnFHzA3opQkrPKUDtgVKmbiQvbj3/jVJ669yNrFeOi4BYXpn8jWSg==
X-Received: by 10.28.47.213 with SMTP id v204mr1419413wmv.69.1452841243909;
        Thu, 14 Jan 2016 23:00:43 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id f205sm1169733wme.4.2016.01.14.23.00.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 14 Jan 2016 23:00:42 -0800 (PST)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.7.0.36.g20612a7
In-Reply-To: <1452841192-620-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284146>

It is not a good idea to compare kernel versions and disable
the untracked cache if it changes as people may upgrade and
still want the untracked cache to work. So let's just
compare work tree locations and kernel name to decide if we
should disable it.

Also it's not useful to store many locations in the ident
field and compare to any of them. It can even be dangerous
if GIT_WORK_TREE is used with different values. So let's
just store one location, the location of the current work
tree.

If this location changed and we still want an untracked
cache, let's delete the cache and recreate it.

Note that if an untracked cache has been created by a
previous Git version, then the kernel version is stored in
the ident field. As we now compare with just the kernel
name the comparison will fail and the untracked cache will
be disabled until it's recreated.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
Helped-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
 dir.c | 39 ++++++++++++++++++++++++---------------
 dir.h |  1 -
 2 files changed, 24 insertions(+), 16 deletions(-)

diff --git a/dir.c b/dir.c
index 0d069c9..42d3b6b 100644
--- a/dir.c
+++ b/dir.c
@@ -1913,28 +1913,31 @@ static const char *get_ident_string(void)
 		return sb.buf;
 	if (uname(&uts) < 0)
 		die_errno(_("failed to get kernel name and information"));
-	strbuf_addf(&sb, "Location %s, system %s %s %s", get_git_work_tree(),
-		    uts.sysname, uts.release, uts.version);
+	strbuf_addf(&sb, "Location %s, system %s", get_git_work_tree(),
+		    uts.sysname);
 	return sb.buf;
 }
=20
 static int ident_in_untracked(const struct untracked_cache *uc)
 {
-	const char *end =3D uc->ident.buf + uc->ident.len;
-	const char *p   =3D uc->ident.buf;
+	/*
+	 * Previous git versions may have saved many NUL separated
+	 * strings in the "ident" field, but it is insane to manage
+	 * many locations, so just take care of the first one.
+	 */
=20
-	for (p =3D uc->ident.buf; p < end; p +=3D strlen(p) + 1)
-		if (!strcmp(p, get_ident_string()))
-			return 1;
-	return 0;
+	return !strcmp(uc->ident.buf, get_ident_string());
 }
=20
-void add_untracked_ident(struct untracked_cache *uc)
+static void set_untracked_ident(struct untracked_cache *uc)
 {
-	if (ident_in_untracked(uc))
-		return;
+	strbuf_reset(&uc->ident);
 	strbuf_addstr(&uc->ident, get_ident_string());
-	/* this strbuf contains a list of strings, save NUL too */
+
+	/*
+	 * This strbuf used to contain a list of NUL separated
+	 * strings, so save NUL too for backward compatibility.
+	 */
 	strbuf_addch(&uc->ident, 0);
 }
=20
@@ -1945,15 +1948,21 @@ static void new_untracked_cache(struct index_st=
ate *istate)
 	uc->exclude_per_dir =3D ".gitignore";
 	/* should be the same flags used by git-status */
 	uc->dir_flags =3D DIR_SHOW_OTHER_DIRECTORIES | DIR_HIDE_EMPTY_DIRECTO=
RIES;
+	set_untracked_ident(uc);
 	istate->untracked =3D uc;
+	istate->cache_changed |=3D UNTRACKED_CHANGED;
 }
=20
 void add_untracked_cache(struct index_state *istate)
 {
 	if (!istate->untracked) {
 		new_untracked_cache(istate);
-	add_untracked_ident(istate->untracked);
-	istate->cache_changed |=3D UNTRACKED_CHANGED;
+	} else {
+		if (!ident_in_untracked(istate->untracked)) {
+			free_untracked_cache(istate->untracked);
+			new_untracked_cache(istate);
+		}
+	}
 }
=20
 void remove_untracked_cache(struct index_state *istate)
@@ -2022,7 +2031,7 @@ static struct untracked_cache_dir *validate_untra=
cked_cache(struct dir_struct *d
 		return NULL;
=20
 	if (!ident_in_untracked(dir->untracked)) {
-		warning(_("Untracked cache is disabled on this system."));
+		warning(_("Untracked cache is disabled on this system or location.")=
);
 		return NULL;
 	}
=20
diff --git a/dir.h b/dir.h
index a3dacdb..cd46f30 100644
--- a/dir.h
+++ b/dir.h
@@ -307,7 +307,6 @@ void untracked_cache_add_to_index(struct index_stat=
e *, const char *);
 void free_untracked_cache(struct untracked_cache *);
 struct untracked_cache *read_untracked_extension(const void *data, uns=
igned long sz);
 void write_untracked_extension(struct strbuf *out, struct untracked_ca=
che *untracked);
-void add_untracked_ident(struct untracked_cache *);
 void add_untracked_cache(struct index_state *istate);
 void remove_untracked_cache(struct index_state *istate);
 #endif
--=20
2.7.0.36.g20612a7
