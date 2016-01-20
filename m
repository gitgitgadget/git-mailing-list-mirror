From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v6 08/11] dir: simplify untracked cache "ident" field
Date: Wed, 20 Jan 2016 10:59:41 +0100
Message-ID: <1453283984-8979-9-git-send-email-chriscool@tuxfamily.org>
References: <1453283984-8979-1-git-send-email-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Wed Jan 20 11:06:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLpex-0007wT-Ag
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jan 2016 11:06:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758513AbcATKGc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 Jan 2016 05:06:32 -0500
Received: from mail-wm0-f47.google.com ([74.125.82.47]:33003 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933445AbcATKGV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jan 2016 05:06:21 -0500
Received: by mail-wm0-f47.google.com with SMTP id 123so125785992wmz.0
        for <git@vger.kernel.org>; Wed, 20 Jan 2016 02:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=DYEuwjrvP2FI0TUo8WzjJ8gZRzRoOG6hSVqq6L/W31o=;
        b=ksz+P50KnIVTsbnGmZVCGNQNgb/zG4YLa7dNZBQoAuDJCpIZf4yFuWbnW4RB/6PQme
         P+5KqiKeyMsss89ZRnr3o86nn4R3qvZHkJsQRHpfsF0XEvOzbhy8nDYdzxsL5zdf55Ts
         COBNNBqSMpc4ylQknrq8lOj5eXcWowOOhOjwt8XL76xjZI8IIyCEYXZx0Nz7FetceaXh
         l0CjXmzQdHvYYSH5klr6NihFNtPWtkACR6/EGk8I+280aTEq3stxRDP9BGK9orTD5mXP
         KUJlQIQ/ok9depX4jbshIygoJY9MC+MXBfUV3vviUHpWj+ov77/utjIES+xEtnsT+qqy
         phqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=DYEuwjrvP2FI0TUo8WzjJ8gZRzRoOG6hSVqq6L/W31o=;
        b=JFWOgqddnoJFFLJV01zQdQHmramzQj1MEJF7sfc+VG/v3piFJ1si+n69xpZv9l+3Uv
         jawD+ydfB9gie9F2QyFfgaCKVxDqMjpmxW8Ru1M2dmsnsjZdLgybsik4DNjvQqlCAfLg
         RWcyLIh2WvSz4MW96Tofmv1aNCSEd7t5X9mi9pJ4z0D1+7NMalbZ8JNfJHfIafpwjABH
         Wr50rK1zRf7trDCvJLvrE1wOV64j/mshP2NjE/ez3Kgixx6gl5Y5JbAbhQ4u97q343FB
         ZSJM/QlaN3+RE9Yhe+ks1LUVdZXFc73Qf7L7Ek9nT/6JfEj0HpM+rpPJ4UA0uCYqvPT3
         2cRw==
X-Gm-Message-State: AG10YOS6x/A2+FAMvxhRmT80MbVd5Y8y+1J01HMv7URq3q/aQwHYQGnhiZUweut4klrKCA==
X-Received: by 10.28.229.20 with SMTP id c20mr2821899wmh.79.1453284380357;
        Wed, 20 Jan 2016 02:06:20 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id x6sm32305613wje.38.2016.01.20.02.06.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 20 Jan 2016 02:06:19 -0800 (PST)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.7.0.36.g6be5eef
In-Reply-To: <1453283984-8979-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284441>

It is not a good idea to compare kernel versions and disable
the untracked cache if it changes, as people may upgrade and
still want the untracked cache to work. So let's just
compare work tree locations and kernel name to decide if we
should disable it.

Also storing many locations in the ident field and comparing
to any of them can be dangerous if GIT_WORK_TREE is used with
different values. So let's just store one location, the
location of the current work tree.

The downside is that untracked cache can only be used by one
type of OS for now. Exporting a git repo to different clients
via a network to e.g. Linux and Windows means that only one
can use the untracked cache.

If the location changed in the ident field and we still want
an untracked cache, let's delete the cache and recreate it.

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
2.7.0.36.g6be5eef
