Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D739FC15
	for <git@vger.kernel.org>; Sun, 25 Feb 2024 11:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708861203; cv=none; b=GfFh1CfUMJFsKqntjBp0ajeJS3XZ/xlpCuNdeOmvQ2tevu81uhzYdprKH8uH08E4FZp2ywabYNWo8+hUQ/xLuyHcIDIfyQaBPj1noIff8YU91Kwo2lcmMsQevYEWpd3dx0YR5mUhAWcC65bf/+0QupfgblCsW6jVf67U44BuoLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708861203; c=relaxed/simple;
	bh=lE1aebN+y80OzsCthD6RZZTGQy3aU+AuXEmU0Vy757c=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q9hoefkJmU5g/XQH8WYn7V00ZA5pc3lysEm5HKKBjQgHFGVuavnzP4ue6gSInAem05XKSATfatfJSIu5peafdf4QOVUgM/pEcMFQJ9VFJG2DUhBcMSGClmk4EPagbDXMt7etgZaf223Nkzgi2WPAd294afk2iOFIems1fV5Rre8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=ep0TVJQO; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="ep0TVJQO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1708861198; x=1709465998; i=l.s.r@web.de;
	bh=lE1aebN+y80OzsCthD6RZZTGQy3aU+AuXEmU0Vy757c=;
	h=X-UI-Sender-Class:From:To:Subject:Date:In-Reply-To:References;
	b=ep0TVJQO6b9wX668eU0IUI7alHzWGh0CMYOXsd8k+wiH6FUJJbjqE5YBq5OTCPYZ
	 lRBgBJzdgjmhEA0qJ4lqoObKY1ewYyYgP5B2U1iBIOywJunwQtFBpKNSuUv/Fq02O
	 i0/OGwIGJ7Yyq+qoZYrnaSh6t8efZ6lVVPjTml7U19mTPhHbsQkM07Zi96u3BAeqp
	 jKu92qdUtkhJBkv3aooMT6qeukEnIUNPnI/RoF1NxsALHHTmLEqgStv+EkbvAMOme
	 PeLMRHccMD97R5m+EvVeKvkAF3wdtr9SUPJe+Vkg9NxHY8OtcnT6vwKwOYNVGLKh+
	 fGBaoZjGXMgxasf8YA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from Mini-von-Rene.fritz.box ([79.203.19.211]) by smtp.web.de
 (mrweb106 [213.165.67.124]) with ESMTPSA (Nemesis) id
 1MUCuv-1rUc6X2rRL-00R8i6 for <git@vger.kernel.org>; Sun, 25 Feb 2024 12:39:58
 +0100
From: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
To: git@vger.kernel.org
Subject: [PATCH 2/2] name-rev: use mem_pool_strfmt()
Date: Sun, 25 Feb 2024 12:39:45 +0100
Message-ID: <20240225113947.89357-3-l.s.r@web.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240225113947.89357-1-l.s.r@web.de>
References: <20240225113947.89357-1-l.s.r@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QlDeAdtzFSqd9K2q6LB4fILnJep712Ex9Liv5jqMWTog5zAf3cv
 UGDclTSBA75Kt1r1r4sqdHLmBTxrAu04O5HnQmpNtX5CFK6MXs8ravBTiU1RqkPWjuCi5kx
 TFOJshXuGr9YU6jXS3howqbaqJ2rEwMJzW4XXML80ughe6Z0R1tDK6rbQEPIChOC4P2QXqg
 RjO1YBjgbF0n1ULkWdrgg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:CCwA989U3Cg=;JA3X2O1bZg/R0a1EXbxBhnuXpWO
 VJcIpGu32AIrp5M/BzS6yCEiR9rdMVCBnd6o7T+T4SK/TkIADmix4mCcKlVG1ykhJhAV+AAfW
 OHa5Zd4IeDAuLec8X+t5+xBMB10CthC+TNId+20B/NuftnWwz7S3/6hlwtMsx/g2kpZTtUOlh
 VzCwMD8d5BxdU+moOBMEomWhrG0qBissEuYgYE98QLs51wljDnH0t5LTXHOBVwic7qIvDa7gv
 lZdfXX5XYqJ36AG3qk5noRaYgGjWhdFmCVITCTh+JDim1ohsH26p1LtTEEx7KpDoFyVMkR7H5
 DrqGo3rwnGu19OB4a5+YgWQz3lv9tEz2Gm8lYmG5VJ9mS6dKzZ3CX4X0PXUPCpKmpMePb1dVg
 f7iJocFsHJ3ciBJuluL5xreNdLE+nnR6abLP65G5x6y/Hg1DJNCm4R3Xh1uyGn2Ej4XK+xg5C
 IPIGntPtDFTO7yzFddtOkD9uFUklwlvuhZxSsuxQ4LtA9ptZD2iI5fegt0RuvCHblxOkIfzFi
 E2obHTNVWoo1uxDZWyv4ynNrtxTuofZucCvnwn/cN8bl6AVjVJKt5V2vQhagjkDRm2YdIrWSc
 gCY9YpoTc/3u9zuj1dOJGITw3obT5g2dt3AdO7uDmJGckUyBP74TeeoqbNSsczMSbqeSOgeTK
 oyrJ3RgYrOqrK4EL0L70AOSH0Fza4wdBjK4gvCEe1kfGczSseo0ic2YDLQdhQCDsCP1WgXH5U
 cqMOJTWx8beAGoWtp1AjLKdg0UqlVnviKw7Q5pzA/NspmFbussLoiJ2FEfcmTJRwuMjSnxGRd
 gkBxVDnY/OXHrUNINI5A8pb0V8cgrD8579KN/aY7MQwiM=

1c56fc2084 (name-rev: pre-size buffer in get_parent_name(), 2020-02-04)
got a big performance boost in an unusual repository by calculating the
name length in advance.  This is a bit awkward, as it references the
name components twice.

Use a memory pool to store the strings for the struct rev_name member
tip_name.  Using mem_pool_strfmt() allows efficient allocation without
explicit size calculation.  This simplifies the formatting part of the
code without giving up performance:

Benchmark 1: ./git_2.44.0 -C ../chromium/src name-rev --all
  Time (mean =C2=B1 =CF=83):      1.231 s =C2=B1  0.013 s    [User: 1.082 =
s, System: 0.136 s]
  Range (min =E2=80=A6 max):    1.214 s =E2=80=A6  1.252 s    10 runs

Benchmark 2: ./git -C ../chromium/src name-rev --all
  Time (mean =C2=B1 =CF=83):      1.220 s =C2=B1  0.020 s    [User: 1.083 =
s, System: 0.130 s]
  Range (min =E2=80=A6 max):    1.197 s =E2=80=A6  1.254 s    10 runs

Don't bother discarding the memory pool just before exiting.  The effort
for that would be very low, but actually measurable in the above
example, with no benefit to users.  At least UNLEAK it to calm down leak
checkers.  This addresses the leaks that 45a14f578e (Revert "name-rev:
release unused name strings", 2022-04-22) brought back.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
This doesn't make any test script leak-free, though.

 builtin/name-rev.c | 39 ++++++++++++++++++++-------------------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 2dd1807c4e..ad9930c831 100644
=2D-- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -15,6 +15,7 @@
 #include "commit-slab.h"
 #include "commit-graph.h"
 #include "wildmatch.h"
+#include "mem-pool.h"

 /*
  * One day.  See the 'name a rev shortly after epoch' test in t6120 when
@@ -155,30 +156,25 @@ static struct rev_name *create_or_update_name(struct=
 commit *commit,
 	return name;
 }

-static char *get_parent_name(const struct rev_name *name, int parent_numb=
er)
+static char *get_parent_name(const struct rev_name *name, int parent_numb=
er,
+			     struct mem_pool *string_pool)
 {
-	struct strbuf sb =3D STRBUF_INIT;
 	size_t len;

 	strip_suffix(name->tip_name, "^0", &len);
 	if (name->generation > 0) {
-		strbuf_grow(&sb, len +
-			    1 + decimal_width(name->generation) +
-			    1 + decimal_width(parent_number));
-		strbuf_addf(&sb, "%.*s~%d^%d", (int)len, name->tip_name,
-			    name->generation, parent_number);
+		return mem_pool_strfmt(string_pool, "%.*s~%d^%d",
+				       (int)len, name->tip_name,
+				       name->generation, parent_number);
 	} else {
-		strbuf_grow(&sb, len +
-			    1 + decimal_width(parent_number));
-		strbuf_addf(&sb, "%.*s^%d", (int)len, name->tip_name,
-			    parent_number);
+		return mem_pool_strfmt(string_pool, "%.*s^%d",
+				       (int)len, name->tip_name, parent_number);
 	}
-	return strbuf_detach(&sb, NULL);
 }

 static void name_rev(struct commit *start_commit,
 		const char *tip_name, timestamp_t taggerdate,
-		int from_tag, int deref)
+		int from_tag, int deref, struct mem_pool *string_pool)
 {
 	struct prio_queue queue;
 	struct commit *commit;
@@ -195,9 +191,10 @@ static void name_rev(struct commit *start_commit,
 	if (!start_name)
 		return;
 	if (deref)
-		start_name->tip_name =3D xstrfmt("%s^0", tip_name);
+		start_name->tip_name =3D mem_pool_strfmt(string_pool, "%s^0",
+						       tip_name);
 	else
-		start_name->tip_name =3D xstrdup(tip_name);
+		start_name->tip_name =3D mem_pool_strdup(string_pool, tip_name);

 	memset(&queue, 0, sizeof(queue)); /* Use the prio_queue as LIFO */
 	prio_queue_put(&queue, start_commit);
@@ -235,7 +232,8 @@ static void name_rev(struct commit *start_commit,
 				if (parent_number > 1)
 					parent_name->tip_name =3D
 						get_parent_name(name,
-								parent_number);
+								parent_number,
+								string_pool);
 				else
 					parent_name->tip_name =3D name->tip_name;
 				ALLOC_GROW(parents_to_queue,
@@ -415,7 +413,7 @@ static int name_ref(const char *path, const struct obj=
ect_id *oid,
 	return 0;
 }

-static void name_tips(void)
+static void name_tips(struct mem_pool *string_pool)
 {
 	int i;

@@ -428,7 +426,7 @@ static void name_tips(void)
 		struct tip_table_entry *e =3D &tip_table.table[i];
 		if (e->commit) {
 			name_rev(e->commit, e->refname, e->taggerdate,
-				 e->from_tag, e->deref);
+				 e->from_tag, e->deref, string_pool);
 		}
 	}
 }
@@ -561,6 +559,7 @@ static void name_rev_line(char *p, struct name_ref_dat=
a *data)

 int cmd_name_rev(int argc, const char **argv, const char *prefix)
 {
+	struct mem_pool string_pool;
 	struct object_array revs =3D OBJECT_ARRAY_INIT;
 	int all =3D 0, annotate_stdin =3D 0, transform_stdin =3D 0, allow_undefi=
ned =3D 1, always =3D 0, peel_tag =3D 0;
 	struct name_ref_data data =3D { 0, 0, STRING_LIST_INIT_NODUP, STRING_LIS=
T_INIT_NODUP };
@@ -587,6 +586,7 @@ int cmd_name_rev(int argc, const char **argv, const ch=
ar *prefix)
 		OPT_END(),
 	};

+	mem_pool_init(&string_pool, 0);
 	init_commit_rev_name(&rev_names);
 	git_config(git_default_config, NULL);
 	argc =3D parse_options(argc, argv, prefix, opts, name_rev_usage, 0);
@@ -648,7 +648,7 @@ int cmd_name_rev(int argc, const char **argv, const ch=
ar *prefix)
 	adjust_cutoff_timestamp_for_slop();

 	for_each_ref(name_ref, &data);
-	name_tips();
+	name_tips(&string_pool);

 	if (annotate_stdin) {
 		struct strbuf sb =3D STRBUF_INIT;
@@ -676,6 +676,7 @@ int cmd_name_rev(int argc, const char **argv, const ch=
ar *prefix)
 				  always, allow_undefined, data.name_only);
 	}

+	UNLEAK(string_pool);
 	UNLEAK(revs);
 	return 0;
 }
=2D-
2.44.0

