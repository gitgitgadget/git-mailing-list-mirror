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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67B36C433E2
	for <git@archiver.kernel.org>; Sat,  5 Sep 2020 14:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 143072078E
	for <git@archiver.kernel.org>; Sat,  5 Sep 2020 14:48:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="DxtojWCy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728663AbgIEOsA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Sep 2020 10:48:00 -0400
Received: from mout.web.de ([212.227.15.4]:54827 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728727AbgIEOr7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Sep 2020 10:47:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1599317272;
        bh=grZbJtl4Ka3z+v9d2SgX8Qim7YxE08XvueFbcFBl0dg=;
        h=X-UI-Sender-Class:From:Subject:To:Cc:Date;
        b=DxtojWCyqYo3dqRmQGXrYftyq2PrnjsAq1SabJcy7egSeXBcrC9//KWlLwU9SC4Jw
         p4doOz9xx2fNyEUMXruiSsmjnbVD0mx5wGbg7j6a9D+cE6WPbwISiVgVvabREjRaV4
         BGIa0FfAp9n95vTqkyLGvQTduGhh6URyLn4S3E1I=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([91.47.149.245]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LgYRZ-1kspmn2xFt-00nyrL; Sat, 05
 Sep 2020 16:47:52 +0200
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH 1/2] push: release strbufs used for refspec formatting
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
Message-ID: <e0c7b847-b8c7-6880-748e-1e5b32934ed5@web.de>
Date:   Sat, 5 Sep 2020 16:47:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Os/mdZA5JNmvIvWW91dnceTa6grC9uzi3eB0dNetAkd5+rlnr4B
 o5H01o/8xcbkD/fY8FloDij/6r58i8kokySynXz7arb/enkF5uA47uxlErXal13TXUHdNSH
 bEh3UOIGovukJhEDoVKtU7P6SB5k6pZIsoFraTQKeLaEEaoP9P8BEdTLdDcyYHCI2RU733q
 agUNYgjRxNQ1af7Ks19ow==
X-UI-Out-Filterresults: notjunk:1;V03:K0:C4472qY+iQc=:/sn+EAknt4REGRcq1ACUBZ
 xZU1lecYlRWftDAzAwe3M9i2Eb8zsCM7ZUk86cwt++ZGZPIwnYNK0iv1bbGT1j2NMk05ZN5KO
 bsTWrTq5uRvRTU2s1O7gVbsrvPCcKfEJ1Uyc6Ndp55CnfQosPr14NwaIDjKdiiWxRoXWJ9JMv
 +D8A7vuOw99uJZFwTIfYKEj0VCqcA4/FacmHSrF84CuQDeLr9u4yt3NHf5Q4+IhKa1Ae+/1Fo
 8HlDpAHcK1/SsubEyNCpy+QDo6mMiCUZD/wiA2+elhJwGqlsgVXkjWYUsG5V3Lvet/SeTjlnb
 Pppl5rPMpoK86JahEYqAhPqL8L7Raq/3iW2/s9YGLeDYqMLE2rAir9IeA/6Q8g13eEBHuYLIm
 ly2HZHdLxRWAwC4v4mZC/OBgP7Lh9541AsicdDhB1dECUD8kQjHNSFqO0XQvxuBAxivwsS6gd
 0H9JTqbfpXb5gFtyTrpMt54BOO8+t/EWjgoqf5PTY6CWwZxDu4GnRj25HDASI5gXmTnlMf/fa
 +X7au5FrAu9RqTo609kTM1AIEumJtGpTYD+Hf4OLIISV/AMi6Vl6WXc5fPp5YlpOZY9106YUQ
 aF22jSxBxB/J/XDZ0RPMbw4IvlVlSN3/AIYBCPzwnfy+CBdjUbwCjCvKUuoxc++GQwBzVy1gL
 lvm0Ljsw4SHdvKJq0pWCbS6qDykyy1FqJyLOdYlnrC2QLSebT8e9Z2QSEEbluZgUkOWRrbVVn
 uFztYeNfLn6RJk2KN7zscreZtR8Kn/FShiA9C4ud+i78SJJ3RXYGHUq2Kb6ID7qDqqPQRmCYc
 qXaRzvZunrtZKMwXMqryXKiNIpLYA9/BRPTBkWBeLxzeVFgJZLE9+i01SXQN7Z2oHINxttE+8
 OQDE7UKF8QhrHbJD0TTqSxX+n72/oKsbVjKgxsCfBi6lkRuZtPW9E4VHUt8ekBY6Yr8NxWtl0
 tRdosXtUxz/t6X4wferyTZp9isw2mb7GhALNLhn69Kog46FGT7s1w28XgJ0Ovo0RMldu3fDhq
 ToUrewWEsCJDVs1zMKFpy5seSP6sDR1VBeviWWBT8DPAxRY7XyJrOcAro0W0suN4rVJTow+6s
 xltr9EVZJrFx8FU+Yrdk4DEC5gJ7IMqhYjFGWPsXNjnYlupQ2aR36FgOkAlAhYNUBZrUhb0N7
 9r3/AcPyKbtSxdVtIM3UiRgQfNLMgm1ZTtRuGGiyGaX7tW2be7pPUEr/HCi4Pi+i1F3+Sfgbj
 qFYPsIFimQwHYi4MJ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

map_refspec() either returns the passed in ref string or a detached
strbuf.  This makes it hard for callers to release the possibly
allocated memory, and set_refspecs() consequently leaks it.

Let map_refspec() append any refspecs directly and release its own
strbufs after use.  Rename it to refspec_append_mapped() and don't
return anything to reflect its increased responsibility.

set_refspecs() also leaks its strbufs.  Do the same here and directly
call refspec_append() in each if branch instead of holding onto a
detached strbuf, then dispose of the allocated memory after use.  We
need to add an else branch for the final call because all the other
conditional branches already add their formatted refspec now.

setup_push_upstream() and setup_push_current() forgot to release their
strbufs as well; plug these leaks, too, while at it.

None of these leaks were likely to impact users, because the number
and sizes of refspecs are usually small and the allocations are only
done once per program run.  Clean them up nevertheless, as another
step on the long road towards zero memory leaks.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
Patch generated with --function-context for easier review.

 builtin/push.c | 34 ++++++++++++++++++++++------------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/builtin/push.c b/builtin/push.c
index bc94078e72..0f3c108c93 100644
=2D-- a/builtin/push.c
+++ b/builtin/push.c
@@ -61,76 +61,84 @@ static struct refspec rs =3D REFSPEC_INIT_PUSH;

 static struct string_list push_options_config =3D STRING_LIST_INIT_DUP;

-static const char *map_refspec(const char *ref,
-			       struct remote *remote, struct ref *local_refs)
+static void refspec_append_mapped(struct refspec *refspec, const char *re=
f,
+				  struct remote *remote, struct ref *local_refs)
 {
 	const char *branch_name;
 	struct ref *matched =3D NULL;

 	/* Does "ref" uniquely name our ref? */
-	if (count_refspec_match(ref, local_refs, &matched) !=3D 1)
-		return ref;
+	if (count_refspec_match(ref, local_refs, &matched) !=3D 1) {
+		refspec_append(refspec, ref);
+		return;
+	}

 	if (remote->push.nr) {
 		struct refspec_item query;
 		memset(&query, 0, sizeof(struct refspec_item));
 		query.src =3D matched->name;
 		if (!query_refspecs(&remote->push, &query) && query.dst) {
 			struct strbuf buf =3D STRBUF_INIT;
 			strbuf_addf(&buf, "%s%s:%s",
 				    query.force ? "+" : "",
 				    query.src, query.dst);
-			return strbuf_detach(&buf, NULL);
+			refspec_append(refspec, buf.buf);
+			strbuf_release(&buf);
+			return;
 		}
 	}

 	if (push_default =3D=3D PUSH_DEFAULT_UPSTREAM &&
 	    skip_prefix(matched->name, "refs/heads/", &branch_name)) {
 		struct branch *branch =3D branch_get(branch_name);
 		if (branch->merge_nr =3D=3D 1 && branch->merge[0]->src) {
 			struct strbuf buf =3D STRBUF_INIT;
 			strbuf_addf(&buf, "%s:%s",
 				    ref, branch->merge[0]->src);
-			return strbuf_detach(&buf, NULL);
+			refspec_append(refspec, buf.buf);
+			strbuf_release(&buf);
+			return;
 		}
 	}

-	return ref;
+	refspec_append(refspec, ref);
 }

 static void set_refspecs(const char **refs, int nr, const char *repo)
 {
 	struct remote *remote =3D NULL;
 	struct ref *local_refs =3D NULL;
 	int i;

 	for (i =3D 0; i < nr; i++) {
 		const char *ref =3D refs[i];
 		if (!strcmp("tag", ref)) {
 			struct strbuf tagref =3D STRBUF_INIT;
 			if (nr <=3D ++i)
 				die(_("tag shorthand without <tag>"));
 			ref =3D refs[i];
 			if (deleterefs)
 				strbuf_addf(&tagref, ":refs/tags/%s", ref);
 			else
 				strbuf_addf(&tagref, "refs/tags/%s", ref);
-			ref =3D strbuf_detach(&tagref, NULL);
+			refspec_append(&rs, tagref.buf);
+			strbuf_release(&tagref);
 		} else if (deleterefs) {
 			struct strbuf delref =3D STRBUF_INIT;
 			if (strchr(ref, ':'))
 				die(_("--delete only accepts plain target ref names"));
 			strbuf_addf(&delref, ":%s", ref);
-			ref =3D strbuf_detach(&delref, NULL);
+			refspec_append(&rs, delref.buf);
+			strbuf_release(&delref);
 		} else if (!strchr(ref, ':')) {
 			if (!remote) {
 				/* lazily grab remote and local_refs */
 				remote =3D remote_get(repo);
 				local_refs =3D get_local_heads();
 			}
-			ref =3D map_refspec(ref, remote, local_refs);
-		}
-		refspec_append(&rs, ref);
+			refspec_append_mapped(&rs, ref, remote, local_refs);
+		} else
+			refspec_append(&rs, ref);
 	}
 }

@@ -192,45 +200,47 @@ static const char message_detached_head_die[] =3D
 static void setup_push_upstream(struct remote *remote, struct branch *bra=
nch,
 				int triangular, int simple)
 {
 	struct strbuf refspec =3D STRBUF_INIT;

 	if (!branch)
 		die(_(message_detached_head_die), remote->name);
 	if (!branch->merge_nr || !branch->merge || !branch->remote_name)
 		die(_("The current branch %s has no upstream branch.\n"
 		    "To push the current branch and set the remote as upstream, use\n"
 		    "\n"
 		    "    git push --set-upstream %s %s\n"),
 		    branch->name,
 		    remote->name,
 		    branch->name);
 	if (branch->merge_nr !=3D 1)
 		die(_("The current branch %s has multiple upstream branches, "
 		    "refusing to push."), branch->name);
 	if (triangular)
 		die(_("You are pushing to remote '%s', which is not the upstream of\n"
 		      "your current branch '%s', without telling me what to push\n"
 		      "to update which remote branch."),
 		    remote->name, branch->name);

 	if (simple) {
 		/* Additional safety */
 		if (strcmp(branch->refname, branch->merge[0]->src))
 			die_push_simple(branch, remote);
 	}

 	strbuf_addf(&refspec, "%s:%s", branch->refname, branch->merge[0]->src);
 	refspec_append(&rs, refspec.buf);
+	strbuf_release(&refspec);
 }

 static void setup_push_current(struct remote *remote, struct branch *bran=
ch)
 {
 	struct strbuf refspec =3D STRBUF_INIT;

 	if (!branch)
 		die(_(message_detached_head_die), remote->name);
 	strbuf_addf(&refspec, "%s:%s", branch->refname, branch->refname);
 	refspec_append(&rs, refspec.buf);
+	strbuf_release(&refspec);
 }

 static int is_workflow_triangular(struct remote *remote)
=2D-
2.28.0
