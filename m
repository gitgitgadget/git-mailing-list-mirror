Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1DC403129
	for <git@vger.kernel.org>; Fri, 14 Aug 2026 07:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786692271; cv=none; b=igzuDn4yB/HWhWzIOb42VroDTQW9HWlKnV3hFusmhDZf62O6ghG9YbUEHxPx8JbNcpZrvqxrrwauFvN7lja5cZdh53BYOPbvxtCZmZ8ibCVzzLbA1NRitFce1e04PGVzE4GnsJ35RFCUHMQMtrN6b1Id26SNg5c+/nxA78GOBxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786692271; c=relaxed/simple;
	bh=G4mir5ZE6goSaBkSsSu4BEHrr/+1vuOCEFYAYFpiwPA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H6/sSJL6w+dIR9mqoXxSOqrobzFZJq1f/mVWeXHpkK+DkeQfCK0Q0imo7B9YMtuhrVzL1gg+gRf98O2CtBgqNKka8XoYoEt87R98qsTAPM9fILRQsa+ld/wGYzy/6L22F6e2iPMGQm8YkNgAXwkW26/x75fx2Sr+ot2DVG9IlcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=bV71Q/Ji; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=NJSgPg+u; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="bV71Q/Ji";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="NJSgPg+u"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=bV71Q/Jiiskmq+i3+l3R1M7ovZYHynW1VhAUQKaeRW/37wtyegHE+GKV6JfW1UbrSE+Hc0nKpTz/FHCKSn/wkFy9HX8LjhNa+A8VHQ3nn6W6WYfCpCU2XulaaF4Z3/+YzC4unjHfckKoSeSVjUPte6u6RviUrVH+bgCJjs9xI9GbjcOzOOZcbfV38zYlDRNquLTxLPBBgzghxA8tCPgSU7l3UqcpEX4wXKgjG0Ixd7ulHCxkWznxZw/SQdBoWSgdB4x1jFxACn7NzbP490W8DNFM+miYctD1WWZ/P1MVCiBXbTB+JYpjqQfNwad2YzEix+g+8mEtVmsrWzYL8mEbvA==; s=purelymail3; d=malon.dev; v=1; bh=G4mir5ZE6goSaBkSsSu4BEHrr/+1vuOCEFYAYFpiwPA=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=NJSgPg+uV7siyep7iz5EaEiBllcqirIWH4EZZHQwm3pvvoSTl4mNcmrnFtRXhX+XnHhEqnbq+mqG+WIezhLOelkLiee1A2AeKKx33XbyvnErTq8VBqqdq+Qd9+5IU3vKc2Qrj7oF3XL/SM0iFf04SDUJeLaOmWjDftfOiVlToLrL/GVwqMEiz8VUJpVMchzQgUHiSd2q/Lrfv83BJRT7My0LDENi5vFvhl6itZz+zUl91U57EFG+XfQt64l+SSD+DoIWa5rckxFFflo6i5xI1wp04asLi78QMJheTti8RSeIDEf0erG0zY3Z/4WZTbXoqXwlQBtcEre1napG1Jr2ew==; s=purelymail3; d=purelymail.com; v=1; bh=G4mir5ZE6goSaBkSsSu4BEHrr/+1vuOCEFYAYFpiwPA=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -946158751;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Fri, 14 Aug 2026 07:24:27 +0000 (UTC)
From: Tian Yuchen <cat@malon.dev>
To: git@vger.kernel.org
Cc: Tian Yuchen <cat@malon.dev>,
	Christian Couder <christian.couder@gmail.com>,
	Ayush Chandekar <ayu.chandekar@gmail.com>,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [PATCH v5 1/2] pack-objects: give fetch_if_missing call sites access to 'repo'
Date: Fri, 14 Aug 2026 15:24:18 +0800
Message-ID: <20260814072419.1666358-2-cat@malon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260814072419.1666358-1-cat@malon.dev>
References: <20260813061125.1089553-1-cat@malon.dev>
 <20260814072419.1666358-1-cat@malon.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8

In order to move the global 'fetch_if_missing' variable into 'struct
repository' in a follow-up commit, first make sure every call site in
builtin/pack-objects.c has a 'struct repository *'.

'cmd_pack_objects()' already receives a 'repo' parameter. Drop the
UNUSED mark.

'option_parse_missing_action()' is registered as an OPT_CALLBACK, so
its signature is fixed and cannot easily gain a 'repo' parameter of
its own. Let it only record 'arg_missing_action'. Instead, apply the
side effect right after 'parse_options()' returns in
'cmd_pack_objects()', where 'repo' is available.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Ayush Chandekar <ayu.chandekar@gmail.com>
Mentored-by: Olamide Caleb Bello <belkid98@gmail.com>
Signed-off-by: Tian Yuchen <cat@malon.dev>
---
 builtin/pack-objects.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 1ec5b6f206..2b14dd2f31 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -4087,7 +4087,8 @@ static void stdin_packs_read_input(struct rev_info *r=
evs,
=20
 static void add_unreachable_loose_objects(struct rev_info *revs);
=20
-static void read_stdin_packs(enum stdin_packs_mode mode, int rev_list_unpa=
cked)
+static void read_stdin_packs(struct repository *repo,
+=09=09=09     enum stdin_packs_mode mode, int rev_list_unpacked)
 {
 =09int prev_fetch_if_missing =3D fetch_if_missing;
 =09struct rev_info revs;
@@ -4099,7 +4100,7 @@ static void read_stdin_packs(enum stdin_packs_mode mo=
de, int rev_list_unpacked)
 =09 */
 =09fetch_if_missing =3D 0;
=20
-=09repo_init_revisions(the_repository, &revs, NULL);
+=09repo_init_revisions(repo, &revs, NULL);
 =09/*
 =09 * Use a revision walk to fill in the namehash of objects in the includ=
e
 =09 * packs. To save time, we'll avoid traversing through objects that are
@@ -4469,14 +4470,12 @@ static int option_parse_missing_action(const struct=
 option *opt UNUSED,
=20
 =09if (!strcmp(arg, "allow-any")) {
 =09=09arg_missing_action =3D MA_ALLOW_ANY;
-=09=09fetch_if_missing =3D 0;
 =09=09fn_show_object =3D show_object__ma_allow_any;
 =09=09return 0;
 =09}
=20
 =09if (!strcmp(arg, "allow-promisor")) {
 =09=09arg_missing_action =3D MA_ALLOW_PROMISOR;
-=09=09fetch_if_missing =3D 0;
 =09=09fn_show_object =3D show_object__ma_allow_promisor;
 =09=09return 0;
 =09}
@@ -5118,7 +5117,7 @@ static int parse_stdin_packs_mode(const struct option=
 *opt, const char *arg,
 int cmd_pack_objects(int argc,
 =09=09     const char **argv,
 =09=09     const char *prefix,
-=09=09     struct repository *repo UNUSED)
+=09=09     struct repository *repo)
 {
 =09int use_internal_rev_list =3D 0;
 =09int all_progress_implied =3D 0;
@@ -5267,6 +5266,10 @@ int cmd_pack_objects(int argc,
 =09argc =3D parse_options(argc, argv, prefix, pack_objects_options,
 =09=09=09     pack_usage, 0);
=20
+=09if (arg_missing_action =3D=3D MA_ALLOW_ANY ||
+=09    arg_missing_action =3D=3D MA_ALLOW_PROMISOR)
+=09=09fetch_if_missing =3D 0;
+
 =09if (argc) {
 =09=09base_name =3D argv[0];
 =09=09argc--;
@@ -5471,7 +5474,7 @@ int cmd_pack_objects(int argc,
 =09=09progress_state =3D start_progress(the_repository,
 =09=09=09=09=09=09_("Enumerating objects"), 0);
 =09if (stdin_packs) {
-=09=09read_stdin_packs(stdin_packs, rev_list_unpacked);
+=09=09read_stdin_packs(repo, stdin_packs, rev_list_unpacked);
 =09} else if (cruft) {
 =09=09read_cruft_objects();
 =09} else if (!use_internal_rev_list) {
--=20
2.43.0

