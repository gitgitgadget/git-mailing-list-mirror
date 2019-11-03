Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 921471F454
	for <e@80x24.org>; Sun,  3 Nov 2019 18:07:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727922AbfKCSH0 (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Nov 2019 13:07:26 -0500
Received: from mail-eopbgr10099.outbound.protection.outlook.com ([40.107.1.99]:62084
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726719AbfKCSH0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Nov 2019 13:07:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nBNfBDOHBPkpbQU1BMXGf+d+6g4oPD9IyQdpkS2YPehyo4Z7RCJrLMp/xp0a1CtLLEmfKE8Eb5Tu19ZKj5JBZE1LPNZ/XW3NyPEs3qjeEzsQvrX5Zd+aKl4V6CqDsisrAbjtFh+WnQ+j5CP464WzCPcrOiBCVRrwSeOqrA0j2WpvyEgqNv6ZQOOPsFRSyjQsYaL5f41bAFYcD0P/9xY2q2RqO34TT9IKmMkB5wvN+N4WHXUpJF7guIzPx6F9wxQY8a0XrXsT0UlgLHzPjLpSyAkjQ3UQ3w4ux6smybuKOOeGmxkMTX4P+Lngf5cVtZr3xVbMGvbH0gJbHCFeRMvEIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8LVVnD3p3je87gG6J7M73v6FH3Ao9yA6ehhraGfzu7E=;
 b=gS/3q5Tv7iJ9QdkSF7/bwv6VIqvh1Mm3+MulkzXhzoITLomJBRJmoxuhX4GSih60NByDwlK9J5F+uJjZTTHDcYmq+m3wcPfMswMLb6UUE4DCLqaLSH3hTty6jz98aiVCX1kS9DOqmsUcJZ/EbjRK0LptU7ojOJkFfBUcbWIlT9jCyTJ96O7aPjBlHsLqTrBu5uP9ezcLM0eX1jhl/xCgnN5qTiv9xA50lhp7AP73m/prMI3Eya3nY+++ml6+zQcAbFi7GWqPn558OTlNS0/zykkBKZUr1B/dAUIJn1nMToL/k99FWqQSC97VrBX4kztudRU1s5syLmWRiTkndI2+Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=unibo.it; dmarc=pass action=none header.from=unibo.it;
 dkim=pass header.d=unibo.it; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=liveunibo.onmicrosoft.com; s=selector2-liveunibo-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8LVVnD3p3je87gG6J7M73v6FH3Ao9yA6ehhraGfzu7E=;
 b=QEkbXKuUMkljVnfJhNaC5uKq6fD4ssKcsK43Mx9MM5aIARtcpHSDTnVenf222p/9y0aQVrV/ZDhrYwwwdoqOVm2/gluQAFeoGD12/yr1VpeF3ZeAgmwy3/FBAtrIM1aDDreK7OIjRwmI9Qjckzo5vmkQyDGP2Y5ozXkhrMkTNqo=
Received: from DB6PR01MB3864.eurprd01.prod.exchangelabs.com (10.168.24.33) by
 DB6PR01MB3734.eurprd01.prod.exchangelabs.com (10.168.21.156) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Sun, 3 Nov 2019 18:07:19 +0000
Received: from DB6PR01MB3864.eurprd01.prod.exchangelabs.com
 ([fe80::dfd:cdf6:74ba:bdb8]) by DB6PR01MB3864.eurprd01.prod.exchangelabs.com
 ([fe80::dfd:cdf6:74ba:bdb8%7]) with mapi id 15.20.2408.024; Sun, 3 Nov 2019
 18:07:19 +0000
From:   Davide Berardi <davide.berardi6@unibo.it>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: [PATCH v2] clone: Don't segfault on -b specifing a non-commit
Thread-Topic: [PATCH v2] clone: Don't segfault on -b specifing a non-commit
Thread-Index: AQHVknGHkjA6WTGovEC1tzjjJjwaWA==
Date:   Sun, 3 Nov 2019 18:07:18 +0000
Message-ID: <20191103180716.GA72007@carpenter.lan>
References: <20191101002432.GA49846@carpenter.lan>
In-Reply-To: <20191101002432.GA49846@carpenter.lan>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: PR1PR01CA0032.eurprd01.prod.exchangelabs.com
 (2603:10a6:102::45) To DB6PR01MB3864.eurprd01.prod.exchangelabs.com
 (2603:10a6:6:52::33)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=davide.berardi6@unibo.it; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [212.171.200.96]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 03c20f8f-9bb0-4c36-f5c0-08d76088aa57
x-ms-traffictypediagnostic: DB6PR01MB3734:
x-microsoft-antispam-prvs: <DB6PR01MB373445DD2C97353CFADD16FCDE7C0@DB6PR01MB3734.eurprd01.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 0210479ED8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(376002)(136003)(39860400002)(366004)(346002)(199004)(189003)(6486002)(5640700003)(66446008)(26005)(6436002)(11346002)(476003)(486006)(1730700003)(8676002)(6506007)(386003)(76176011)(52116002)(81156014)(81166006)(102836004)(2351001)(8936002)(66946007)(186003)(66556008)(66476007)(64756008)(66066001)(2501003)(786003)(86362001)(316002)(36756003)(6116002)(3846002)(305945005)(2906002)(6916009)(99286004)(446003)(14454004)(25786009)(256004)(14444005)(33656002)(5660300002)(71200400001)(71190400001)(6512007)(9686003)(478600001)(7736002)(1076003);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR01MB3734;H:DB6PR01MB3864.eurprd01.prod.exchangelabs.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: unibo.it does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UJBw9aki7a3jihJdMcVfokhHExqzugLTf2HJDSCYrZUlm2a92GDQBWPmvV61pkVCpGxw0dGgGlUJ7U5/xbVN1jiIDPzGBepgG9mwm+rImbu3hQ8DPkmyMAoCmjukuPPL4ulqfFvG6/TMf0s59zx+s3JPPr+klSBPOE75fqY+MA4M43/MJhG31Zs53NNUvYoZQfI+En5krdTTi3JQ5shvp/jJP17ahG73ASFSh8/Cn8SeYH3MgRxnoK0E1KQXPvONKn5Ed5g6IWlRM33Fzqt5s7/oHEkbHxm9gYCodUJz/nCwql00vqRAoImZf2XXiwTjhSTHBkqU2PLlTyIAYuahk+w6ay0OQovAompLa7T+GXPaFzP8j0kVCFXGms+qorGbVxmVVLXYpUDmg9+RUnZZRy4CZzC1cAKB0hcwbz3ONXVawQcvDMQZU894Pwx/2gUi
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <20842D48459FA046B7629DED243EBA48@eurprd01.prod.exchangelabs.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: unibo.it
X-MS-Exchange-CrossTenant-Network-Message-Id: 03c20f8f-9bb0-4c36-f5c0-08d76088aa57
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2019 18:07:18.8932
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e99647dc-1b08-454a-bf8c-699181b389ab
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dtg+MnThZAo6asdOvbq3d0g56ZCT9JX2j5LklOlKlAVPUa/nLTWnM1V883vTAAI8zko+0BOdFJ8D04JLZHKwqNEf/j1lkaJnk7C9ktZgyHk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR01MB3734
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The code in "git clone -b B" to decide what branch to check out
assumed that B points at a commit object without checking,
leading to dereferencing a NULL pointer and causing a segmentation
fault.

Just aborting the operation when it happens is not a very
attractive option because we would be left with a directory
without .git/HEAD that cannot be used as a valid repository the
user can attempt to recover from the situation by checking out
something.

Fall back to use the 'master' branch, which is what we use when
the command without the "-b" option cannot figure out what
branch the remote side points with its HEAD.

Signed-off-by: Davide Berardi <berardi.dav@gmail.com>
---
 builtin/clone.c         | 49 ++++++++++++++++++++++++++++++++++++-----
 commit.c                | 16 +++++++++++---
 commit.h                |  4 ++++
 t/t5609-clone-branch.sh | 16 +++++++++++++-
 4 files changed, 75 insertions(+), 10 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index f665b28ccc..f185b7f193 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -704,10 +704,46 @@ static void update_remote_refs(const struct ref *refs=
,
 	}
 }
=20
-static void update_head(const struct ref *our, const struct ref *remote,
+static struct commit *lookup_commit_helper(const struct ref *our,
+					   const struct ref *remote,
+					   const char *msg, int *err)
+{
+	const struct object_id *tip =3D NULL;
+	struct commit *tip_commit =3D NULL;
+
+	if (our)
+		tip =3D &our->old_oid;
+	else if (remote)
+		tip =3D &remote->old_oid;
+
+	if (!tip)
+		return NULL;
+
+	tip_commit =3D lookup_commit_reference_gently_err(the_repository, tip, 1,=
 err);
+	if (!tip_commit) {
+		/*
+		 * The given non-commit cannot be checked out,
+		 * so have a 'master' branch and leave it unborn.
+		 */
+		warning(_("non-commit cannot be checked out"));
+		create_symref("HEAD", "refs/heads/master", msg);
+		return NULL;
+	}
+
+	return tip_commit;
+}
+
+static int update_head(const struct ref *our, const struct ref *remote,
 			const char *msg)
 {
+	int err =3D 0;
 	const char *head;
+	struct commit *c =3D NULL;
+
+	c =3D lookup_commit_helper(our, remote, msg, &err);
+	if (err)
+		return -1;
+
 	if (our && skip_prefix(our->name, "refs/heads/", &head)) {
 		/* Local default branch link */
 		if (create_symref("HEAD", our->name, NULL) < 0)
@@ -718,8 +754,6 @@ static void update_head(const struct ref *our, const st=
ruct ref *remote,
 			install_branch_config(0, head, option_origin, our->name);
 		}
 	} else if (our) {
-		struct commit *c =3D lookup_commit_reference(the_repository,
-							   &our->old_oid);
 		/* --branch specifies a non-branch (i.e. tags), detach HEAD */
 		update_ref(msg, "HEAD", &c->object.oid, NULL, REF_NO_DEREF,
 			   UPDATE_REFS_DIE_ON_ERR);
@@ -732,6 +766,7 @@ static void update_head(const struct ref *our, const st=
ruct ref *remote,
 		update_ref(msg, "HEAD", &remote->old_oid, NULL, REF_NO_DEREF,
 			   UPDATE_REFS_DIE_ON_ERR);
 	}
+	return err;
 }
=20
 static int checkout(int submodule_progress)
@@ -1249,7 +1284,7 @@ int cmd_clone(int argc, const char **argv, const char=
 *prefix)
 			   branch_top.buf, reflog_msg.buf, transport,
 			   !is_local, filter_options.choice);
=20
-	update_head(our_head_points_at, remote_head, reflog_msg.buf);
+	err =3D update_head(our_head_points_at, remote_head, reflog_msg.buf) < 0;
=20
 	/*
 	 * We want to show progress for recursive submodule clones iff
@@ -1268,8 +1303,10 @@ int cmd_clone(int argc, const char **argv, const cha=
r *prefix)
 	}
=20
 	junk_mode =3D JUNK_LEAVE_REPO;
-	fetch_if_missing =3D 1;
-	err =3D checkout(submodule_progress);
+	if (!err) {
+		fetch_if_missing =3D 1;
+		err =3D checkout(submodule_progress);
+	}
=20
 	strbuf_release(&reflog_msg);
 	strbuf_release(&branch_top);
diff --git a/commit.c b/commit.c
index a98de16e3d..ffb5230f0f 100644
--- a/commit.c
+++ b/commit.c
@@ -26,16 +26,26 @@ int save_commit_buffer =3D 1;
=20
 const char *commit_type =3D "commit";
=20
-struct commit *lookup_commit_reference_gently(struct repository *r,
-		const struct object_id *oid, int quiet)
+struct commit *lookup_commit_reference_gently_err(struct repository *r,
+		const struct object_id *oid, int quiet, int *err)
 {
+	struct commit *retval;
 	struct object *obj =3D deref_tag(r,
 				       parse_object(r, oid),
 				       NULL, 0);
=20
 	if (!obj)
 		return NULL;
-	return object_as_type(r, obj, OBJ_COMMIT, quiet);
+	retval =3D object_as_type(r, obj, OBJ_COMMIT, quiet);
+	if (!retval && err)
+		*err =3D 1;
+	return retval;
+}
+
+struct commit *lookup_commit_reference_gently(struct repository *r,
+		const struct object_id *oid, int quiet)
+{
+	return lookup_commit_reference_gently_err(r, oid, quiet, NULL);
 }
=20
 struct commit *lookup_commit_reference(struct repository *r, const struct =
object_id *oid)
diff --git a/commit.h b/commit.h
index f5295ca7f3..157c5dc526 100644
--- a/commit.h
+++ b/commit.h
@@ -70,6 +70,10 @@ struct commit *lookup_commit_reference(struct repository=
 *r,
 struct commit *lookup_commit_reference_gently(struct repository *r,
 					      const struct object_id *oid,
 					      int quiet);
+struct commit *lookup_commit_reference_gently_err(struct repository *r,
+						  const struct object_id *oid,
+						  int quiet,
+						  int *err);
 struct commit *lookup_commit_reference_by_name(const char *name);
=20
 /*
diff --git a/t/t5609-clone-branch.sh b/t/t5609-clone-branch.sh
index 6e7a7be052..d57f750eeb 100755
--- a/t/t5609-clone-branch.sh
+++ b/t/t5609-clone-branch.sh
@@ -20,7 +20,10 @@ test_expect_success 'setup' '
 	 echo one >file && git add file && git commit -m one &&
 	 git checkout -b two &&
 	 echo two >file && git add file && git commit -m two &&
-	 git checkout master) &&
+	 git checkout master &&
+	 blob=3D$(git rev-parse HEAD:file)  &&
+	 echo $blob > .git/refs/heads/broken-tag &&
+	 echo $blob > .git/refs/heads/broken-head) &&
 	mkdir empty &&
 	(cd empty && git init)
 '
@@ -67,4 +70,15 @@ test_expect_success 'clone -b not allowed with empty rep=
os' '
 	test_must_fail git clone -b branch empty clone-branch-empty
 '
=20
+test_expect_success 'clone -b with a non-commit tag must fallback' '
+	test_must_fail git clone -b broken-tag parent clone-broken-tag &&
+	(cd clone-broken-tag &&
+	 check_HEAD master)
+'
+test_expect_success 'clone -b with a non-commit head must fallback' '
+	test_must_fail git clone -b broken-head parent clone-broken-head &&
+	(cd clone-broken-head &&
+	 check_HEAD master)
+'
+
 test_done
--=20
2.22.0

