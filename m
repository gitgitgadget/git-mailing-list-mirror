Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BD01C636D7
	for <git@archiver.kernel.org>; Sat, 18 Feb 2023 08:36:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbjBRIgn (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Feb 2023 03:36:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjBRIgl (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Feb 2023 03:36:41 -0500
Received: from mout.web.de (mout.web.de [212.227.15.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ECCE11E8B
        for <git@vger.kernel.org>; Sat, 18 Feb 2023 00:36:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1676709384; i=l.s.r@web.de;
        bh=EkRgcNI5hPJFetKN7c7493/SwahnXB8kib2XRZyiUPo=;
        h=X-UI-Sender-Class:Date:Subject:To:References:Cc:From:In-Reply-To;
        b=R0lpsT5SpRS44D6e5iLqBQXrCsXJommPf2BW5bc8tBy97B7pAaKUtk8qobedMDEea
         gVGP7a0kMvasJOxrI9pGs/FmGC6k8cjWuiCS2hdlcJHVvuG/9bgebltQm4tERRu56Z
         xFBI5zAYgYKtFrxICbu/caU8Dw/gpas1+9o+Qr0V5Rz1s8efM8ca8/YOQ1DB4ZgKdh
         IkcRoaB05FEvGB6CXe+lsS3dwzJ+j2EM27C7sfmJANlFY6xvXhUU7W81HUmlDYGPMT
         4Zm5qjX6JRKrYu95W5Aco40P/jebxvkaWwac5dKzpdAkRhJNQH2kpE8QcklpztZ+YU
         moCVE12pIKjqg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.21.51]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MIc7N-1pHWc12odB-00Ee1l; Sat, 18
 Feb 2023 09:36:24 +0100
Message-ID: <91a73f5d-ca3e-6cb0-4ba3-38d703074ee6@web.de>
Date:   Sat, 18 Feb 2023 09:36:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
Subject: [PATCH] archive: add --mtime
To:     Raul E Rangel <rrangel@chromium.org>, git@vger.kernel.org
References: <Y+6G9n6cWRT9EKyl@google.com>
Content-Language: en-US
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        demerphq <demerphq@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <Y+6G9n6cWRT9EKyl@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ommirsfGKJH/G6xv5xkcp7OJRyC7bVczuDATCEaEPMvjAvHAcwg
 aas/nPSqk0U1AKEvs4T8LP5MAAHXwlTfrNeK4geuIXPEIvh00pT0kbakzRPs6gpD5CTfWWH
 3MkcZh3UBCJt3cjbMoGV4Sv3NlXba2RkHbmvIyB9ua4MtwHlSqYFQzr7hMEBVw2Uv5sgmdH
 RgAVE0zjCvVUHRJUvbgFw==
UI-OutboundReport: notjunk:1;M01:P0:8vIA1ZYP3BY=;IMa/ucLfRex0Qw5SlCw0CGyVU/l
 Uy41O2yrejiAyuAbmAlf6et5/hWHCaPO8vnZeaoG0D4SGnHmOHX38P89kUZ5iN1CCOAAKeaXb
 TAtmXuGVgv6JBJ65GRh4ce79qyil5vLmXPK7AxEXBoHSiu5sH6OYWD+JlPk3eQyzMJRQmlhLR
 lbrJJzKtZ/5AJ0ZtQ+Kjm5R2ewp/6bMkAxfpB/muNJXdO6CAaP5nE1wACp3qeE62IxpdqPyEP
 32X/H0QOnQu4TCBncPl33qet+BXth/njkBXqyR4Uyjdreb91JQLdZzgTmQRpasQnomp1G7oWX
 n9yBbyDr5l1VZCUPQZ24mtzoUHSjzgOEgE/Q30PSXx2hXf0sTc5WKZgyb7hVL2QmDV+5Nqnn3
 24l1qOber5hkilv/e/5wx22V6fG1qS5E6OKGqrTi+vn7hzNfoM6x4l070LixFrO6nfkun6dCy
 frbKUSMcM9pnPiNutYEq0SLWa0qBPme6Zq/IMjjUP8rMOYDvHl96BwL5iA6BUFIkhToAFZ0Se
 7YAGfuA9mV4I5SbDM1TxW6HwvcisQvj6UxKtdePukB+LwzOFz2AeEbtBkHnuLMd9XTMAXgGGC
 rx0QChuuPtmhMIDnaX9YV9mHPA3fQYctxL6LiC7W0YtKK4qO/wVcByso1DOclWmzUj9MglcmI
 mo63kJ+OYHv5fV3iEyqidr3Wt9Bpw7ecxZ/HGCXzxeKHBjJQmF1K85KEqUWCTW1oA5n7HeLrk
 6C2OmLgnbF8dauIgDcX8yWJ53JTtyozLtM747Y3NQfQ3APOaWjXFWGQf/tgg3tq5ufPv3Zbas
 8bSejfPWkULL+gPPlfVK6eimGgyJ4YGQaz5TAb/asN6F9gL7vqlprs8uZWcDG8q5T8UZqgR+s
 aiHDo20p5aCCBXV5bqQo1Q4Ssig8iuf6I2Lz4Wmh+/yfXCcDuMCQOUOtZ9c/FjSCkGuQGeWRk
 nDY6wA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Allow users to specify the modification time of archive entries.  The
new option --mtime uses approxidate() to parse a time specification and
overrides the default of using the current time for trees and the commit
time for tags and commits.  It can be used to create a reproducible
archive for a tree, or to use a specific mtime without creating a commit
with GIT_COMMITTER_DATE set.

This implementation doesn't support the negated form of the new option,
i.e. --no-mtime is not accepted.  It is not possible to have no mtime at
all.  We could use the Unix epoch or revert to the default behavior, but
since negation is not necessary for the intended use it's left undecided
for now.

Requested-by: Raul E Rangel <rrangel@chromium.org>
Suggested-by: demerphq <demerphq@gmail.com>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 Documentation/git-archive.txt |  5 +++++
 archive.c                     |  7 +++++++
 archive.h                     |  1 +
 t/t5000-tar-tree.sh           | 19 +++++++++++++++++++
 4 files changed, 32 insertions(+)

diff --git a/Documentation/git-archive.txt b/Documentation/git-archive.txt
index 60c040988b..6bab201d37 100644
=2D-- a/Documentation/git-archive.txt
+++ b/Documentation/git-archive.txt
@@ -86,6 +86,11 @@ cases, write an untracked file and use `--add-file` ins=
tead.
 	Look for attributes in .gitattributes files in the working tree
 	as well (see <<ATTRIBUTES>>).

+--mtime=3D<time>::
+	Set modification time of archive entries.  Without this option
+	the committer time is used if `<tree-ish>` is a commit or tag,
+	and the current time if it is a tree.
+
 <extra>::
 	This can be any options that the archiver backend understands.
 	See next section.
diff --git a/archive.c b/archive.c
index 81ff76fce9..122860b39d 100644
=2D-- a/archive.c
+++ b/archive.c
@@ -472,6 +472,8 @@ static void parse_treeish_arg(const char **argv,
 		commit_oid =3D NULL;
 		archive_time =3D time(NULL);
 	}
+	if (ar_args->mtime_option)
+		archive_time =3D approxidate(ar_args->mtime_option);

 	tree =3D parse_tree_indirect(&oid);
 	if (!tree)
@@ -586,6 +588,7 @@ static int parse_archive_args(int argc, const char **a=
rgv,
 	const char *remote =3D NULL;
 	const char *exec =3D NULL;
 	const char *output =3D NULL;
+	const char *mtime_option =3D NULL;
 	int compression_level =3D -1;
 	int verbose =3D 0;
 	int i;
@@ -607,6 +610,9 @@ static int parse_archive_args(int argc, const char **a=
rgv,
 		OPT_BOOL(0, "worktree-attributes", &worktree_attributes,
 			N_("read .gitattributes in working directory")),
 		OPT__VERBOSE(&verbose, N_("report archived files on stderr")),
+		{ OPTION_STRING, 0, "mtime", &mtime_option, N_("time"),
+		  N_("set modification time of archive entries"),
+		  PARSE_OPT_NONEG },
 		OPT_NUMBER_CALLBACK(&compression_level,
 			N_("set compression level"), number_callback),
 		OPT_GROUP(""),
@@ -668,6 +674,7 @@ static int parse_archive_args(int argc, const char **a=
rgv,
 	args->base =3D base;
 	args->baselen =3D strlen(base);
 	args->worktree_attributes =3D worktree_attributes;
+	args->mtime_option =3D mtime_option;

 	return argc;
 }
diff --git a/archive.h b/archive.h
index 08bed3ed3a..7178e2a9a2 100644
=2D-- a/archive.h
+++ b/archive.h
@@ -16,6 +16,7 @@ struct archiver_args {
 	struct tree *tree;
 	const struct object_id *commit_oid;
 	const struct commit *commit;
+	const char *mtime_option;
 	timestamp_t time;
 	struct pathspec pathspec;
 	unsigned int verbose : 1;
diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index eb3214bc17..918a2fc7c6 100755
=2D-- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -105,6 +105,18 @@ check_added() {
 	'
 }

+check_mtime() {
+	dir=3D$1
+	path_in_archive=3D$2
+	mtime=3D$3
+
+	test_expect_success " validate mtime of $path_in_archive" '
+		test-tool chmtime --get $dir/$path_in_archive >actual.mtime &&
+		echo $mtime >expect.mtime &&
+		test_cmp expect.mtime actual.mtime
+	'
+}
+
 test_expect_success 'setup' '
 	test_oid_cache <<-EOF
 	obj sha1:19f9c8273ec45a8938e6999cb59b3ff66739902a
@@ -174,6 +186,13 @@ test_expect_success 'git archive' '

 check_tar b

+test_expect_success 'git archive --mtime' '
+	git archive --mtime=3D2002-02-02T02:02:02-0200 HEAD >with_mtime.tar
+'
+
+check_tar with_mtime
+check_mtime with_mtime a/a 1012622522
+
 test_expect_success 'git archive --prefix=3Dprefix/' '
 	git archive --prefix=3Dprefix/ HEAD >with_prefix.tar
 '
=2D-
2.39.2
