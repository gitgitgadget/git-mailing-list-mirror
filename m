Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE9B9C433EF
	for <git@archiver.kernel.org>; Tue, 18 Jan 2022 12:46:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238582AbiARMqo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Jan 2022 07:46:44 -0500
Received: from mout.web.de ([212.227.15.3]:58165 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238498AbiARMqn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jan 2022 07:46:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1642509992;
        bh=6F6c5ukjterhmghzh/5R6TvZl+iw4yi2TyBF+b5uRZo=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=H+WU3UIUdUeTEHSEZ3+gzWvGG+PKqdZ6qf9K/pcNB/Lb6/XhVWXKH89s0N2JEWXcB
         AcQo7zUFOVXhASUZhp+1FYdhGMzhhWOnvQcyeNbRts69Ofn3t/nG60pUwql13rxxKv
         aKjAfm3OHpJDCBVG+KplUsb4xeg44yAcvtD1Aqxw=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.22.121]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N5UkQ-1mG8v43CKA-0172mH; Tue, 18
 Jan 2022 13:46:32 +0100
Message-ID: <20987dc6-e0c7-6ca2-19fd-2b323b3f6d9f@web.de>
Date:   Tue, 18 Jan 2022 13:46:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.0
Subject: [PATCH v2 4/4] bisect--helper: double-check run command on exit code
 126 and 127
Content-Language: en-US
To:     Git List <git@vger.kernel.org>
Cc:     Ramkumar Ramachandra <r@artagnon.com>,
        Christian Couder <christian.couder@gmail.com>,
        "Miriam R." <mirucam@gmail.com>, Junio C Hamano <gitster@pobox.com>
References: <1edfc6ff-4db8-447f-9eb7-85843258a286@www.fastmail.com>
 <xmqqilus3ctf.fsf@gitster.g>
 <fead25d6-6f5f-487a-ad4c-0657fe9785fd@www.fastmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <fead25d6-6f5f-487a-ad4c-0657fe9785fd@www.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:t3hx6lmvO6iMt7N992LwdzB8MImHGlH5Q+w+n8UPEFOqAPN3Ilq
 clBLrkD6oRc3W5lraBnjiT1bceMxC/DgUbHRsEw3qrKJQzo5qQ2Xs5o4xgLn6cY8bQM70ll
 Bo1OYOVJ4YuD24P5eT/qhl8BVh6WAQD34ElMOinA7dUoPwt4H75T5qmmZT3FLXrsmOP/VHF
 KJmsTnPrhpVGUsJzQgzFQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DdjvOl0g8gQ=:wLy9CBuIJnIxoa/BJI/PJf
 fIzlxfQ7H1ym/1EYM5zHWyp3bZcCw4Z4OzSkAqhIz9SeoHNHrN4K9vR2EP5UPvlu8Jj21R/xY
 Cgv5mU9AqKLAF9WLhMHzDcKlOVleC0EBo9wQ3ESlwRkcxRAtABj9bYoKlcMxADVDYnS9R/DtM
 gL8P4UgKIPyLkeA51+hMCyknMBJlqOZP4fCB+ohrZ4Mxxo7p0ql9+QtqwVJEh+6eYEqPiDqsu
 YHK+wzUMc5UnN7aAhAooZou3+cnz6/LVb3SuYmKJkv6TS3qMD1nPGUmOyO5KusqdvaL8PrTrP
 EYMjzKwn6W54jXn+A3DGUah5GRgAumKRTkai09GzlY+haaMZEtsp24pCOSh9JiyuUz47sfyw0
 Y6xa5QVswmwC+Bbc1LEaiACdo0GYZ5tXm9ji5PbDXdoyMB/i035WmqfNZF8h8jtuxET5xkIRY
 CebuiINR4JQ08HKusj8DNT23phZ4PVE/ANT/DlZl+IcGlVLZ1aOEpJ+zsB9r+48oGZsmu5pxQ
 WfNdCHgT7Qfj8+zX4/Tnh1dSUrShqt/oxya+7EH0pMlsTcCMGV3bgs+VQQd6TELC++2cA6Cf/
 566NPe6QMl3JTlKhDiHOAXys8q+xxNTHwMUzISRFO8BUu8Mh+AZy7SeZekQXswtIXSnUirMAa
 w6GauLZL8Aqfx5TK6LvNItG0PTVs+lmXyOaDv/+k+xq2A76KXMp2ATDuM6CFmJ87DxbGYWHln
 tpjM4kfuEWwBOd1ZBKpZHDoJ81JdScz6uLRGvSM+7MkM4yB6AoMFnLLONiS9P7++8n+q+I/pJ
 Nu6E5LMSLHLfAQ+taLIoqI4uGiXXm05SSN9shHHw0tEEdmNNG6pug0QaOeacr0H6Z2RfRmG3x
 RZtxGFVBCgY/g9oiufDARJ+JJRtPAbq+yhumrcXnPj7bYY7yXbk9W39l6bsvJbZoa2WsO7K0G
 Ci6TUGqY7p3lYPOzbGA0wa2QQbTGD6AB67CORRio2A8P4AwDGIgJ/PXVZBnqGbJKMItETFxlt
 KVvOVB9Ve5bZxbvQkSPss9Bc8Ci06F+X2f6RybkYip3p27zPqD+DHBBJfOKGhCl24w==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When a run command cannot be executed or found, shells return exit code
126 or 127, respectively.  Valid run commands are allowed to return
these codes as well to indicate bad revisions, though, for historical
reasons.  This means typos can cause bogus bisect runs that go over the
full distance and end up reporting invalid results.

The best solution would be to reserve exit codes 126 and 127, like
71b0251cdd (Bisect run: "skip" current commit if script exit code is
125., 2007-10-26) did for 125, and abort bisect run when we get them.
That might be inconvenient for those who relied on the documentation
stating that 126 and 127 can be used for bad revisions, though.

The workaround used by this patch is to run the command on a known-good
revision and abort if we still get the same error code.  This adds one
step to runs with scripts that use exit codes 126 and 127, but keeps
them supported, with one exception: It won't work with commands that
cannot recognize the (manually marked) known-good revision as such.

Run commands that use low exit codes are unaffected.  Typos are reported
after executing the missing command twice and three checkouts (the first
step, the known good revision and back to the revision of the first
step).

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 bisect.c                    |  3 +-
 bisect.h                    |  3 ++
 builtin/bisect--helper.c    | 63 +++++++++++++++++++++++++++++++++++++
 t/t6030-bisect-porcelain.sh |  4 +--
 4 files changed, 70 insertions(+), 3 deletions(-)

diff --git a/bisect.c b/bisect.c
index 888949fba6..9e6a2b7f20 100644
=2D-- a/bisect.c
+++ b/bisect.c
@@ -724,7 +724,8 @@ static int is_expected_rev(const struct object_id *oid=
)
 	return res;
 }

-static enum bisect_error bisect_checkout(const struct object_id *bisect_r=
ev, int no_checkout)
+enum bisect_error bisect_checkout(const struct object_id *bisect_rev,
+				  int no_checkout)
 {
 	char bisect_rev_hex[GIT_MAX_HEXSZ + 1];
 	struct commit *commit;
diff --git a/bisect.h b/bisect.h
index ec24ac2d7e..748adf0cff 100644
=2D-- a/bisect.h
+++ b/bisect.h
@@ -69,4 +69,7 @@ void read_bisect_terms(const char **bad, const char **go=
od);

 int bisect_clean_state(void);

+enum bisect_error bisect_checkout(const struct object_id *bisect_rev,
+				  int no_checkout);
+
 #endif
diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index e529665d9f..50783a586c 100644
=2D-- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -1089,6 +1089,44 @@ static int bisect_visualize(struct bisect_terms *te=
rms, const char **argv, int a
 	return res;
 }

+static int get_first_good(const char *refname, const struct object_id *oi=
d,
+			  int flag, void *cb_data)
+{
+	oidcpy(cb_data, oid);
+	return 1;
+}
+
+static int verify_good(const struct bisect_terms *terms,
+		       const char **quoted_argv)
+{
+	int rc;
+	enum bisect_error res;
+	struct object_id good_rev;
+	struct object_id current_rev;
+	char *good_glob =3D xstrfmt("%s-*", terms->term_good);
+	int no_checkout =3D ref_exists("BISECT_HEAD");
+
+	for_each_glob_ref_in(get_first_good, good_glob, "refs/bisect/",
+			     &good_rev);
+	free(good_glob);
+
+	if (read_ref(no_checkout ? "BISECT_HEAD" : "HEAD", &current_rev))
+		return -1;
+
+	res =3D bisect_checkout(&good_rev, no_checkout);
+	if (res !=3D BISECT_OK)
+		return -1;
+
+	printf(_("running %s\n"), quoted_argv[0]);
+	rc =3D run_command_v_opt(quoted_argv, RUN_USING_SHELL);
+
+	res =3D bisect_checkout(&current_rev, no_checkout);
+	if (res !=3D BISECT_OK)
+		return -1;
+
+	return rc;
+}
+
 static int bisect_run(struct bisect_terms *terms, const char **argv, int =
argc)
 {
 	int res =3D BISECT_OK;
@@ -1096,6 +1134,7 @@ static int bisect_run(struct bisect_terms *terms, co=
nst char **argv, int argc)
 	struct strvec run_args =3D STRVEC_INIT;
 	const char *new_state;
 	int temporary_stdout_fd, saved_stdout;
+	int is_first_run =3D 1;

 	if (bisect_next_check(terms, NULL))
 		return BISECT_FAILED;
@@ -1113,6 +1152,30 @@ static int bisect_run(struct bisect_terms *terms, c=
onst char **argv, int argc)
 		printf(_("running %s\n"), command.buf);
 		res =3D run_command_v_opt(run_args.v, RUN_USING_SHELL);

+		/*
+		 * Exit code 126 and 127 can either come from the shell
+		 * if it was unable to execute or even find the script,
+		 * or from the script itself.  Check with a known-good
+		 * revision to avoid trashing the bisect run due to a
+		 * missing or non-executable script.
+		 */
+		if (is_first_run && (res =3D=3D 126 || res =3D=3D 127)) {
+			int rc =3D verify_good(terms, run_args.v);
+			is_first_run =3D 0;
+			if (rc < 0) {
+				error(_("unable to verify '%s' on good"
+					" revision"), command.buf);
+				res =3D BISECT_FAILED;
+				break;
+			}
+			if (rc =3D=3D res) {
+				error(_("bogus exit code %d for good revision"),
+				      rc);
+				res =3D BISECT_FAILED;
+				break;
+			}
+		}
+
 		if (res < 0 || 128 <=3D res) {
 			error(_("bisect run failed: exit code %d from"
 				" '%s' is < 0 or >=3D 128"), res, command.buf);
diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index fc18796517..5382e5d216 100755
=2D-- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -290,7 +290,7 @@ test_expect_success 'bisect run accepts exit code 126 =
as bad' '
 	grep "$HASH3 is the first bad commit" my_bisect_log.txt
 '

-test_expect_failure POSIXPERM 'bisect run fails with non-executable test =
script' '
+test_expect_success POSIXPERM 'bisect run fails with non-executable test =
script' '
 	test_when_finished "git bisect reset" &&
 	>not-executable.sh &&
 	chmod -x not-executable.sh &&
@@ -313,7 +313,7 @@ test_expect_success 'bisect run accepts exit code 127 =
as bad' '
 	grep "$HASH3 is the first bad commit" my_bisect_log.txt
 '

-test_expect_failure 'bisect run fails with missing test script' '
+test_expect_success 'bisect run fails with missing test script' '
 	test_when_finished "git bisect reset" &&
 	rm -f does-not-exist.sh &&
 	git bisect start &&
=2D-
2.34.1
