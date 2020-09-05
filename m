Return-Path: <SRS0=od8b=CO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60927C433E2
	for <git@archiver.kernel.org>; Sat,  5 Sep 2020 14:50:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0ACD1206B8
	for <git@archiver.kernel.org>; Sat,  5 Sep 2020 14:50:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="FKd2EgOu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728649AbgIEOuF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Sep 2020 10:50:05 -0400
Received: from mout.web.de ([212.227.15.4]:50721 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728659AbgIEOtm (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Sep 2020 10:49:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1599317370;
        bh=HZUVjSqKSCvWwxhzpeBgaDHpQv8Qr+lhpKY/07kwEmo=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=FKd2EgOuJG8AEsstZyJ77GaGo/OZSiAeGGQC+X+VqpeN6mB1kV792X9/Oxby3w4W2
         mdQ2titR4KYSGoxw5GDYxjalFG2htQSK6umwYZY++q+sMm1UYspQZKuEvsKwA6mXa3
         uRjWCjqTbzRCkLf63HnBhi+99ufJKzy37DQjDMMg=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([91.47.149.245]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MKJAE-1kF7TI2rHa-001fES; Sat, 05
 Sep 2020 16:49:30 +0200
Subject: [PATCH 2/2] refspec: add and use refspec_appendf()
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
References: <e0c7b847-b8c7-6880-748e-1e5b32934ed5@web.de>
Message-ID: <e49140b8-25d6-0e5b-b1da-468a40c4a687@web.de>
Date:   Sat, 5 Sep 2020 16:49:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <e0c7b847-b8c7-6880-748e-1e5b32934ed5@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rq1CylbHsjPyjZxMwAvE9M0aerWI7g5IrUyaCXYgJCdyhHuhxFZ
 Aj3nx6ui5TN9itPnKCI7P6rk/feqQAi+JdiZ6RyzoUUsEUzSGpsMafLUFLsBpVBUAdwt6Vk
 8+PSYKk1ju149Sait+y0cYNzDnRsxinElaxeOtcMTFQcgIfzuXQvbJQDDwkpYgTAXvPdeou
 kXjLgokobvn+E9r6FgpKg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:LnP3QbX5Kng=:L+daEQRGV9UbgJWL2LIfhM
 odpzZf6478hC7LuExy/8YNJE/Wt33Be3XM8hKjcyLdNOUx5+WMEzqSGaXJjdUUXflPCyV1lin
 oFaSFG2D36NSV+7PF89mRGrWRs7jr0v9nmcaoRoz6KFmoKVqq/zOLaUJlwOIpHWMiCKsNVSDy
 PzHI3tCGk9jVNdl8A8tDAu2qx1GtnWMC/QD90EBJ1OhQZLI/9/WQ1c/XyddXmc76ULG6ghfNt
 eU46xrU3v5Jc2QnclRKZqFPhM+lNizpz7YgDTUeYLacFYZkvOHU/b3QhyXxoPLLAgMZZl2L6v
 DCP27aa47EqpoJQ1ld7GNUzMLjZZgyxtVQekB8L7yhaxItctrGvdb9cwVlVJel56nnuae8hfG
 JPkHvmT8O9x/3M9NaOqlxb+emrlx3OC3nl7IcTiuqETmSqJA5qv5aWrrzAZOXRxydHusAfNtK
 dmaPVniC9TKtpApe4TdRy3eIF0OPlWsOcnIdBlT+q1v0eScB1LkZct1EyddlBtJzUQp5Rh9+w
 Z5HU7jtpo2DIJiGFudHihT9DdNTV3M8tIZ2X5HnGAF3ttYBtCfVOwhwKKvaGEMUtylRVvf+rn
 s9+VlZVSoZVXaSx6gH35Q6/UzCs9bi35wYvljFiJbfgjmEvyZJ9vOek/rE05CxJK2NyKg9Dau
 KiFbmAHpjWnVpvOSGlOha4wflDD5WVxGV/rrPsh8zbLQG/oNhz46t1zLdvj+BZxYijQA2gVeF
 IDhgkcVsBOSk2r6vXSlyngWzuJZOwtN+lvY25R6gHZmsVB+6Ku3zkwvf15vmVQxsDVmYRWZHa
 yDtFAAoao9HVJdizKGDuMFKMppiJ4Udn0yKpXjNVAY2TO28lm2HesAEMckazWvli7Cfwh/zK/
 6kMURzHfNY4hc3e4zvvLyBdiDolOUFLMNlGuUIcI5Rdh35+BuREdrELwFK7TPeeoEhGMQlwz/
 oxFLQrkNxmKD/y2KDmB4rPUDaGY+oNtHrlQiII5qrsHuPBlVPYNgZ+/myfp5koVtx+MhtSoaO
 RsShJYKCydbc+J4zyVy03wjD9z+p9vMqFSsUB0XhDamEzuzvc4tpyQd8u8pkpCicbRrNZNVJE
 yQlj+i7p1gLEp/hSpVQOO5QfqwDcx/oXkg2c1V0jqUv1rdTKJjuJUhpXFvZlk19wHKlABT5ed
 fWzy8tgtkojgIKnF9BiCLHIDNQ6Vy/qiVeb899xCPeeXpAx55OAVk/Cmx4HfmyW4f8/FmlpWg
 dhzT7rO2S9v8SxZxW
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a function for building a refspec using printf-style formatting.  It
frees callers from managing their own buffer.  Use it throughout the
tree to shorten and simplify its callers.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 builtin/clone.c |  7 ++-----
 builtin/fetch.c |  7 ++-----
 builtin/push.c  | 40 ++++++++++------------------------------
 refspec.c       | 18 ++++++++++++++++--
 refspec.h       |  2 ++
 remote.c        | 10 +++-------
 6 files changed, 35 insertions(+), 49 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index b087ee40c2..fbfd6568cd 100644
=2D-- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -953,7 +953,6 @@ int cmd_clone(int argc, const char **argv, const char =
*prefix)
 	struct ref *mapped_refs;
 	const struct ref *ref;
 	struct strbuf key =3D STRBUF_INIT;
-	struct strbuf default_refspec =3D STRBUF_INIT;
 	struct strbuf branch_top =3D STRBUF_INIT, reflog_msg =3D STRBUF_INIT;
 	struct transport *transport =3D NULL;
 	const char *src_ref_prefix =3D "refs/heads/";
@@ -1157,9 +1156,8 @@ int cmd_clone(int argc, const char **argv, const cha=
r *prefix)

 	remote =3D remote_get(option_origin);

-	strbuf_addf(&default_refspec, "+%s*:%s*", src_ref_prefix,
-		    branch_top.buf);
-	refspec_append(&remote->fetch, default_refspec.buf);
+	refspec_appendf(&remote->fetch, "+%s*:%s*", src_ref_prefix,
+			branch_top.buf);

 	transport =3D transport_get(remote, remote->url[0]);
 	transport_set_verbosity(transport, option_verbosity, option_progress);
@@ -1332,7 +1330,6 @@ int cmd_clone(int argc, const char **argv, const cha=
r *prefix)
 	strbuf_release(&reflog_msg);
 	strbuf_release(&branch_top);
 	strbuf_release(&key);
-	strbuf_release(&default_refspec);
 	junk_mode =3D JUNK_LEAVE_ALL;

 	strvec_clear(&ref_prefixes);
diff --git a/builtin/fetch.c b/builtin/fetch.c
index a6d3268661..c555836937 100644
=2D-- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1738,15 +1738,12 @@ static int fetch_one(struct remote *remote, int ar=
gc, const char **argv,

 	for (i =3D 0; i < argc; i++) {
 		if (!strcmp(argv[i], "tag")) {
-			char *tag;
 			i++;
 			if (i >=3D argc)
 				die(_("You need to specify a tag name."));

-			tag =3D xstrfmt("refs/tags/%s:refs/tags/%s",
-				      argv[i], argv[i]);
-			refspec_append(&rs, tag);
-			free(tag);
+			refspec_appendf(&rs, "refs/tags/%s:refs/tags/%s",
+					argv[i], argv[i]);
 		} else {
 			refspec_append(&rs, argv[i]);
 		}
diff --git a/builtin/push.c b/builtin/push.c
index 0f3c108c93..0eeb2c8dd5 100644
=2D-- a/builtin/push.c
+++ b/builtin/push.c
@@ -78,12 +78,9 @@ static void refspec_append_mapped(struct refspec *refsp=
ec, const char *ref,
 		memset(&query, 0, sizeof(struct refspec_item));
 		query.src =3D matched->name;
 		if (!query_refspecs(&remote->push, &query) && query.dst) {
-			struct strbuf buf =3D STRBUF_INIT;
-			strbuf_addf(&buf, "%s%s:%s",
-				    query.force ? "+" : "",
-				    query.src, query.dst);
-			refspec_append(refspec, buf.buf);
-			strbuf_release(&buf);
+			refspec_appendf(refspec, "%s%s:%s",
+					query.force ? "+" : "",
+					query.src, query.dst);
 			return;
 		}
 	}
@@ -92,11 +89,8 @@ static void refspec_append_mapped(struct refspec *refsp=
ec, const char *ref,
 	    skip_prefix(matched->name, "refs/heads/", &branch_name)) {
 		struct branch *branch =3D branch_get(branch_name);
 		if (branch->merge_nr =3D=3D 1 && branch->merge[0]->src) {
-			struct strbuf buf =3D STRBUF_INIT;
-			strbuf_addf(&buf, "%s:%s",
-				    ref, branch->merge[0]->src);
-			refspec_append(refspec, buf.buf);
-			strbuf_release(&buf);
+			refspec_appendf(refspec, "%s:%s",
+					ref, branch->merge[0]->src);
 			return;
 		}
 	}
@@ -113,23 +107,17 @@ static void set_refspecs(const char **refs, int nr, =
const char *repo)
 	for (i =3D 0; i < nr; i++) {
 		const char *ref =3D refs[i];
 		if (!strcmp("tag", ref)) {
-			struct strbuf tagref =3D STRBUF_INIT;
 			if (nr <=3D ++i)
 				die(_("tag shorthand without <tag>"));
 			ref =3D refs[i];
 			if (deleterefs)
-				strbuf_addf(&tagref, ":refs/tags/%s", ref);
+				refspec_appendf(&rs, ":refs/tags/%s", ref);
 			else
-				strbuf_addf(&tagref, "refs/tags/%s", ref);
-			refspec_append(&rs, tagref.buf);
-			strbuf_release(&tagref);
+				refspec_appendf(&rs, "refs/tags/%s", ref);
 		} else if (deleterefs) {
-			struct strbuf delref =3D STRBUF_INIT;
 			if (strchr(ref, ':'))
 				die(_("--delete only accepts plain target ref names"));
-			strbuf_addf(&delref, ":%s", ref);
-			refspec_append(&rs, delref.buf);
-			strbuf_release(&delref);
+			refspec_appendf(&rs, ":%s", ref);
 		} else if (!strchr(ref, ':')) {
 			if (!remote) {
 				/* lazily grab remote and local_refs */
@@ -200,8 +188,6 @@ static const char message_detached_head_die[] =3D
 static void setup_push_upstream(struct remote *remote, struct branch *bra=
nch,
 				int triangular, int simple)
 {
-	struct strbuf refspec =3D STRBUF_INIT;
-
 	if (!branch)
 		die(_(message_detached_head_die), remote->name);
 	if (!branch->merge_nr || !branch->merge || !branch->remote_name)
@@ -227,20 +213,14 @@ static void setup_push_upstream(struct remote *remot=
e, struct branch *branch,
 			die_push_simple(branch, remote);
 	}

-	strbuf_addf(&refspec, "%s:%s", branch->refname, branch->merge[0]->src);
-	refspec_append(&rs, refspec.buf);
-	strbuf_release(&refspec);
+	refspec_appendf(&rs, "%s:%s", branch->refname, branch->merge[0]->src);
 }

 static void setup_push_current(struct remote *remote, struct branch *bran=
ch)
 {
-	struct strbuf refspec =3D STRBUF_INIT;
-
 	if (!branch)
 		die(_(message_detached_head_die), remote->name);
-	strbuf_addf(&refspec, "%s:%s", branch->refname, branch->refname);
-	refspec_append(&rs, refspec.buf);
-	strbuf_release(&refspec);
+	refspec_appendf(&rs, "%s:%s", branch->refname, branch->refname);
 }

 static int is_workflow_triangular(struct remote *remote)
diff --git a/refspec.c b/refspec.c
index f10ef284ce..8d0affc34a 100644
=2D-- a/refspec.c
+++ b/refspec.c
@@ -153,7 +153,7 @@ void refspec_init(struct refspec *rs, int fetch)
 	rs->fetch =3D fetch;
 }

-void refspec_append(struct refspec *rs, const char *refspec)
+static void refspec_append_nodup(struct refspec *rs, char *refspec)
 {
 	struct refspec_item item;

@@ -163,7 +163,21 @@ void refspec_append(struct refspec *rs, const char *r=
efspec)
 	rs->items[rs->nr++] =3D item;

 	ALLOC_GROW(rs->raw, rs->raw_nr + 1, rs->raw_alloc);
-	rs->raw[rs->raw_nr++] =3D xstrdup(refspec);
+	rs->raw[rs->raw_nr++] =3D refspec;
+}
+
+void refspec_append(struct refspec *rs, const char *refspec)
+{
+	refspec_append_nodup(rs, xstrdup(refspec));
+}
+
+void refspec_appendf(struct refspec *rs, const char *fmt, ...)
+{
+	va_list ap;
+
+	va_start(ap, fmt);
+	refspec_append_nodup(rs, xstrvfmt(fmt, ap));
+	va_end(ap);
 }

 void refspec_appendn(struct refspec *rs, const char **refspecs, int nr)
diff --git a/refspec.h b/refspec.h
index 8d654e3a3a..7569248d11 100644
=2D-- a/refspec.h
+++ b/refspec.h
@@ -56,6 +56,8 @@ void refspec_item_init_or_die(struct refspec_item *item,=
 const char *refspec,
 void refspec_item_clear(struct refspec_item *item);
 void refspec_init(struct refspec *rs, int fetch);
 void refspec_append(struct refspec *rs, const char *refspec);
+__attribute__((format (printf,2,3)))
+void refspec_appendf(struct refspec *rs, const char *fmt, ...);
 void refspec_appendn(struct refspec *rs, const char **refspecs, int nr);
 void refspec_clear(struct refspec *rs);

diff --git a/remote.c b/remote.c
index c5ed74f91c..5c04275342 100644
=2D-- a/remote.c
+++ b/remote.c
@@ -287,19 +287,15 @@ static void read_branches_file(struct remote *remote=
)
 		frag =3D (char *)git_default_branch_name();

 	add_url_alias(remote, strbuf_detach(&buf, NULL));
-	strbuf_addf(&buf, "refs/heads/%s:refs/heads/%s",
-		    frag, remote->name);
-	refspec_append(&remote->fetch, buf.buf);
+	refspec_appendf(&remote->fetch, "refs/heads/%s:refs/heads/%s",
+			frag, remote->name);

 	/*
 	 * Cogito compatible push: push current HEAD to remote #branch
 	 * (master if missing)
 	 */
-	strbuf_reset(&buf);
-	strbuf_addf(&buf, "HEAD:refs/heads/%s", frag);
-	refspec_append(&remote->push, buf.buf);
+	refspec_appendf(&remote->push, "HEAD:refs/heads/%s", frag);
 	remote->fetch_tags =3D 1; /* always auto-follow */
-	strbuf_release(&buf);
 }

 static int handle_config(const char *key, const char *value, void *cb)
=2D-
2.28.0
