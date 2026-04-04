Received: from cyborg.thican.net (cyborg.thican.net [94.23.45.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF8222538F
	for <git@vger.kernel.org>; Sat,  4 Apr 2026 14:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.23.45.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775313387; cv=none; b=FHHQzP2wYHGTT72xwlNgnOG101YdVXzAULWOHk+LwIqOzmXHB13AxQLM0/4K62RakxpbpGb27bRnCRnSrnb/xOrhZ5SO6XUaeVyLOdN43T+Q1kf9r2RsMTv36eBO/trt4WmDUULufLSASbGb/rNFA5WFF/PP1UNQjFlPay1FImU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775313387; c=relaxed/simple;
	bh=IQ0ZebvQOj8s0htrJDRslfcRngyzyFM0W1HAi3Bpxq0=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ogs0aEQUlEVbOiCqf0Q4WiZIUjtWFa8S8jNqbvZ3Gr2Eic86jBr8iJ1NWAxUUzhs74/RhNluKHt/55OIJesv8f4i7yiLOG3+s1ardNO+4OBoAlu1zLLDD2HkNT/mgKq42apJIWf1pxhISbtAs2qzyxd7GhWYa7+hyDxsWGeWehs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=thican.net; spf=pass smtp.mailfrom=thican.net; dkim=pass (2048-bit key) header.d=thican.net header.i=@thican.net header.b=hKfF7C1y; arc=none smtp.client-ip=94.23.45.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=thican.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thican.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thican.net header.i=@thican.net header.b="hKfF7C1y"
Received: by cyborg.thican.net (Postfix, from userid 1000)
	id B6763818076; Sat, 04 Apr 2026 16:28:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=thican.net; s=cyborg;
	t=1775312937; bh=IQ0ZebvQOj8s0htrJDRslfcRngyzyFM0W1HAi3Bpxq0=;
	h=Date:From:To:Subject;
	b=hKfF7C1yxYQf4taGCyCO6d7far5CnnK4a/G5KRKeknHu8TR0i2N8eJ9G359qVW6dW
	 2wTQ17sblNU/mQKlBK0yniBKxXCD2FwFmyOrY3VKxrCf8S6qu6xkmCn1hL8uoNw/Lt
	 qo828eTE36Huesiura/MadId2ojRVI17O+bVkDlwRTq4IHQ4KaFqW8NwXiLZyyJ4uq
	 IuwQQAmgrMFaZmP+tiYjVyBmBSxwndhLtwLR1Sal50FKdDuGxxXv7dR3cv9S6ZpFDo
	 vds8tR4jyEXq/Esf9tKA2MSpys2gm6q8qIhnAMZ04S4xHkdZJIVDCDMw17v6ShdD8s
	 WjKDo8YYooFYw==
Date: Sat, 4 Apr 2026 16:28:57 +0200
From: Thibaud CANALE <thican@thican.net>
To: git@vger.kernel.org
Subject: [RFC PATCH] switch: provide configurable detach
Message-ID: <njuf62lav6akkmdyqutwk7pim5yutw5cuicjidwpe5eh6qnkqr@4ir6q4uhhvht>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rzokuhjjf7jwezna"
Content-Disposition: inline


--rzokuhjjf7jwezna
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: [RFC PATCH] switch: provide configurable detach
MIME-Version: 1.0

Its purpose is to provide for git-switch(1) same detach behavior on
commit it than git-checkout(1) through configuration option
`checkout.switchDetach`.

Signed-off-by: Thibaud CANALE <thican@thican.net>
---
 Documentation/config/checkout.adoc |  4 ++++
 builtin/checkout.c                 | 18 +++++++++++++++---
 t/t2060-switch.sh                  | 27 +++++++++++++++++++++++++++
 3 files changed, 46 insertions(+), 3 deletions(-)

diff --git a/Documentation/config/checkout.adoc b/Documentation/config/chec=
kout.adoc
index e35d2129..3a6c1049 100644
--- a/Documentation/config/checkout.adoc
+++ b/Documentation/config/checkout.adoc
@@ -22,6 +22,10 @@ commands or functionality in the future.
 	option in `git checkout` and `git switch`. See
 	linkgit:git-switch[1] and linkgit:git-checkout[1].
=20
+`checkout.switchDetach`::
+	Provides for linkgit:git-switch[1] the same detach behavior on commit id
+	than linkgit:git-checkout[1] without the explicit --detach option.
+
 `checkout.workers`::
 	The number of parallel workers to use when updating the working tree.
 	The default is one, i.e. sequential execution. If set to a value less
diff --git a/builtin/checkout.c b/builtin/checkout.c
index e031e618..1da1062e 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -53,6 +53,7 @@ struct checkout_opts {
 	int force;
 	int force_detach;
 	int implicit_detach;
+	int switch_detach;  // For checkout.switchDetach configuration
 	int writeout_stage;
 	int overwrite_ignore;
 	int ignore_skipworktree;
@@ -1005,7 +1006,10 @@ static void update_refs_for_switch(const struct chec=
kout_opts *opts,
 	else
 		strbuf_insertstr(&msg, 0, reflog_msg);
=20
-	if (!strcmp(new_branch_info->name, "HEAD") && !new_branch_info->path && !=
opts->force_detach) {
+	if (!strcmp(new_branch_info->name, "HEAD") &&
+	    !new_branch_info->path &&
+	    !opts->force_detach &&
+	    !opts->switch_detach) {
 		/* Nothing to do. */
 	} else if (opts->force_detach || !new_branch_info->path) {	/* No longer o=
n any branch. */
 		refs_update_ref(get_main_ref_store(the_repository), msg.buf,
@@ -1014,7 +1018,9 @@ static void update_refs_for_switch(const struct check=
out_opts *opts,
 				REF_NO_DEREF, UPDATE_REFS_DIE_ON_ERR);
 		if (!opts->quiet) {
 			if (old_branch_info->path &&
-			    advice_enabled(ADVICE_DETACHED_HEAD) && !opts->force_detach)
+			    advice_enabled(ADVICE_DETACHED_HEAD) &&
+			    !opts->force_detach &&
+			    !opts->switch_detach)
 				detach_advice(new_branch_info->name);
 			describe_detached_head(_("HEAD is now at"), new_branch_info->commit);
 		}
@@ -1541,8 +1547,11 @@ static void die_expecting_a_branch(const struct bran=
ch_info *branch_info)
 		 */
 		code =3D die_message(_("a branch is expected, got '%s'"), branch_info->n=
ame);
=20
-	if (advice_enabled(ADVICE_SUGGEST_DETACHING_HEAD))
+	if (advice_enabled(ADVICE_SUGGEST_DETACHING_HEAD)) {
 		advise(_("If you want to detach HEAD at the commit, try again with the -=
-detach option."));
+		advise(_("Also you can detach by default by setting the config variable "
+		         "checkout.switchDetach to true."));
+	}
=20
 	exit(code);
 }
@@ -1660,6 +1669,7 @@ static int checkout_branch(struct checkout_opts *opts,
=20
 	if (!opts->implicit_detach &&
 	    !opts->force_detach &&
+	    !opts->switch_detach &&
 	    !opts->new_branch &&
 	    !opts->new_branch_force &&
 	    new_branch_info->name &&
@@ -2119,6 +2129,8 @@ int cmd_switch(int argc,
 	options =3D add_common_options(&opts, options);
 	options =3D add_common_switch_branch_options(&opts, options);
=20
+	repo_config_get_bool(the_repository, "checkout.switchDetach", &opts.switc=
h_detach);
+
 	cb_option =3D 'c';
=20
 	return checkout_main(argc, argv, prefix, &opts, options,
diff --git a/t/t2060-switch.sh b/t/t2060-switch.sh
index c91c4db9..3435ae98 100755
--- a/t/t2060-switch.sh
+++ b/t/t2060-switch.sh
@@ -177,4 +177,31 @@ test_expect_success 'switch back when temporarily deta=
ched and checked out elsew
 	git -C wt2 switch --ignore-other-worktrees shared
 '
=20
+test_expect_success 'switch with configured detach behavior from configura=
tion ' '
+	test_when_finished "
+		test_config checkout.switchDetach false;
+		git switch main
+	" &&
+	test_config checkout.switchDetach true &&
+	git switch main &&
+	git symbolic-ref HEAD &&
+	git switch main~ &&
+	test_must_fail git symbolic-ref HEAD &&
+	git switch - &&
+	git symbolic-ref HEAD &&
+	git switch - &&
+	test_must_fail git symbolic-ref HEAD
+'
+
+test_expect_success 'switch without configured detach behavior from config=
uration ' '
+	test_when_finished "
+		test_config checkout.switchDetach false;
+		git switch main
+	" &&
+	test_config checkout.switchDetach false &&
+	git switch main &&
+	git symbolic-ref HEAD &&
+	test_must_fail git switch main~
+'
+
 test_done

base-commit: 2855562ca6a9c6b0e7bc780b050c1e83c9fcfbd0
--=20
Thibaud CANALE
thican [at] thican [dot] net
https://thican.net/
GPG: rsa4096 2013-10-14 485EF628CB85CDD4CB7CFF0D52F5127650733A18

--rzokuhjjf7jwezna
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJPBAABCAA5FiEESF72KMuFzdTLfP8NUvUSdlBzOhgFAmnRICUbFIAAAAAABAAO
bWFudTIsMi41KzEuMTEsMiwyAAoJEFL1EnZQczoY5MEQAIB/Yt3eRsSiQPamDlG2
uJkGNiNcV2IJXowTmFXw/Bg509TeqPtJQ7IerJLzwjob97cFtkDy3xlINN6ZY37D
OB4c37miFEHCb5gWSmKPFMvkcn3esHuMx/xsF+GUOXYTnAMbwMMwjY/Lg6UXnYHC
D5sz3mmqx5m0v5EmrMBjKr9GuoGsVlYDPUCpCzlbWVblHE6l/DRnz3S9/FQlbtZj
1nJhSC7kpr4N3kckW1RwfPuslgBZvv7GngnMJGwRZVrJqCrfyAll/JoXXY4Yqb1F
vImMHSctWKC+f3JlqxTOZlGmpPyQQkdOCcp4sOwqV7VRf3ghhDxGK2f6UhapgTAQ
tqcIwKDaUoQdQKOrNclF8flo5Klykc79aYRD7yN1brrMuAcD4n9w5RgySBWtr4hi
PWubjA5acpJ2D808E2RXI1WOFPgcEUUi6PxCwnJvvdwYGGNLic2QE4qSPk352uHT
wT5GJC0VPbwoH9QUE1DABkMglFcpnDXHQh0L8MplRuIDnygq+6pK37dsmTzDc7iz
t7J7iaOmZ3vHJFIqGX630oKwhD1ywHzmbcJ8EW4MyefFhfIWmD+OQf/O0fqYe4nh
Le5o5cgCxqPIIjCDzOMQsRY1Rf/4YQK3vtIuF1/7V5h63WwbhqU0mi121xpZjA6X
VonOgDWzPbfUFa13q19/Pr/c
=YBoR
-----END PGP SIGNATURE-----

--rzokuhjjf7jwezna--
