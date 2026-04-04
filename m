Received: from cyborg.thican.net (cyborg.thican.net [94.23.45.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AFBB1531E8
	for <git@vger.kernel.org>; Sat,  4 Apr 2026 21:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.23.45.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775337273; cv=none; b=UIl0bKbSEacNgI5KGlSXVxI6z92870e3MhF5t+QmHJTKh0S9FLqYtnOlxP6WTIeuPTNhwelgHAu0i/aWkeIxAoXlh8VVUY0Uc8efFCiplA76Slr5v/BL/XcffToUelXBMHAkka3vsRill2nS/3wmWcabqFQD0rBPaJfhSP2PZCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775337273; c=relaxed/simple;
	bh=CkVm75/MRNzzr3GAU0TFYYpgbfxInCJ/KyBN8n0HNNc=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oq+967AaRzFx8q6bOidnt53nsCZH5Qa1KNCAQBAxUkGfoo6mY8SkhS4BbY71l9YrFDShFwZWfEnvbt+YipSSrCFyGEoX2vxzyk863jXmM79fT30rcZmEnS/87MooZr12SdX/63+UL2r/zDeHjGhWB3KS63HWLX4RH92nqodUqC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=thican.net; spf=pass smtp.mailfrom=thican.net; dkim=pass (2048-bit key) header.d=thican.net header.i=@thican.net header.b=Ofwdjz5j; arc=none smtp.client-ip=94.23.45.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=thican.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thican.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thican.net header.i=@thican.net header.b="Ofwdjz5j"
Received: by cyborg.thican.net (Postfix, from userid 1000)
	id BCD0A818076; Sat, 04 Apr 2026 23:14:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=thican.net; s=cyborg;
	t=1775337270; bh=CkVm75/MRNzzr3GAU0TFYYpgbfxInCJ/KyBN8n0HNNc=;
	h=Date:From:To:Subject:References:In-Reply-To;
	b=Ofwdjz5jEt1SZiPmNx6Qm7g6w8RTxKxvLT5seTYYFCwPhF4WBKBDBdUPNfXpLsAs6
	 fO3kFYNRZ83Tuy4jA6cAEUIq4eFk8/GVQlfbUht2MA86h2VlAnJx3oBcE3Ca0jSwWX
	 wY4mMfbqoR5qwzq3ZJzAyrzadQFyg/+NfBLtxeGdZtKgeMiJNdMQT3UDtp2LiPOVt5
	 ADBboiBA1YYZqy2jpIKCGThk+Nhyj+QybNzump9NPUjUeC9mr8CjwPhstQRvThrStW
	 lVOvTb1vgVds6Nn3MPggZQwmU8aRliB9yGvYLUINDlUhq6x79c3CFj2ohX4MHHhLPS
	 +b3OJKlP5HExw==
Date: Sat, 4 Apr 2026 23:14:30 +0200
From: Thibaud CANALE <thican@thican.net>
To: git@vger.kernel.org
Subject: [RFC PATCH v2] switch: provide configurable detach
Message-ID: <3cfgodmlybyme4ggnybudz77tkdshnsi5rn263gv4ta6ru6cq4@o7j7ohf5jlmq>
References: <njuf62lav6akkmdyqutwk7pim5yutw5cuicjidwpe5eh6qnkqr@4ir6q4uhhvht>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gpdvj3w2wnbudjkl"
Content-Disposition: inline
In-Reply-To: <njuf62lav6akkmdyqutwk7pim5yutw5cuicjidwpe5eh6qnkqr@4ir6q4uhhvht>


--gpdvj3w2wnbudjkl
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: [RFC PATCH v2] switch: provide configurable detach
MIME-Version: 1.0

Some users won=E2=80=99t change to switch/restore commands and keep relying=
 on
checkout command because of this =E2=80=9Cmissing=E2=80=9D feature:

For git-switch(1), configurable through option `checkout.switchDetach`,
match git-checkout(1)=E2=80=99s detach behavior on non-branch references, s=
uch
as commit id and "tilde" reference (i.e "${my_branch}~2").
No need to use explicit --detach option, automatically detach on
non-branch reference, then reattach when going back on a branch, even
implicitly through `git switch -` command.
=E2=80=A6 like git-checkout(1) uses to do.

No impact on current behavior when option is unset or set to false.

Signed-off-by: Thibaud CANALE <thican@thican.net>
---
 Documentation/config/checkout.adoc | 14 ++++++++++++++
 builtin/checkout.c                 | 19 ++++++++++++++++---
 t/t2060-switch.sh                  | 27 +++++++++++++++++++++++++++
 3 files changed, 57 insertions(+), 3 deletions(-)

diff --git a/Documentation/config/checkout.adoc b/Documentation/config/chec=
kout.adoc
index e35d2129..5309bed7 100644
--- a/Documentation/config/checkout.adoc
+++ b/Documentation/config/checkout.adoc
@@ -22,6 +22,20 @@ commands or functionality in the future.
 	option in `git checkout` and `git switch`. See
 	linkgit:git-switch[1] and linkgit:git-checkout[1].
=20
+`checkout.switchDetach`::
+	For linkgit:git-switch[1], matches linkgit:git-checkout[1]=E2=80=99s deta=
ch behavior
+	on non-branch references, such as commit id and "tilde" reference (i.e
+	"${my_branch}~2").
++
+No need to use explicit --detach option, automatically detach on
+non-branch reference, then reattach when going back on a branch, even
+implicitly through `git switch -` command.
++
+=E2=80=A6 like linkgit:git-checkout[1] uses to do.
++
+No impact when option is unset or set to false, won't continue when trying=
 to
+detach HEAD without explicit --detach option.
+
 `checkout.workers`::
 	The number of parallel workers to use when updating the working tree.
 	The default is one, i.e. sequential execution. If set to a value less
diff --git a/builtin/checkout.c b/builtin/checkout.c
index e031e618..cd7b0a60 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -53,6 +53,7 @@ struct checkout_opts {
 	int force;
 	int force_detach;
 	int implicit_detach;
+	int switch_detach;
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
+		advise(_("You can also detach by default by setting the config "
+		         "variable checkout.switchDetach to true."));
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
@@ -2119,6 +2129,9 @@ int cmd_switch(int argc,
 	options =3D add_common_options(&opts, options);
 	options =3D add_common_switch_branch_options(&opts, options);
=20
+	repo_config_get_bool(the_repository, "checkout.switchDetach",
+	                     &opts.switch_detach);
+
 	cb_option =3D 'c';
=20
 	return checkout_main(argc, argv, prefix, &opts, options,
diff --git a/t/t2060-switch.sh b/t/t2060-switch.sh
index c91c4db9..3732a826 100755
--- a/t/t2060-switch.sh
+++ b/t/t2060-switch.sh
@@ -177,4 +177,31 @@ test_expect_success 'switch back when temporarily deta=
ched and checked out elsew
 	git -C wt2 switch --ignore-other-worktrees shared
 '
=20
+test_expect_success 'switch with configured detach behavior from configura=
tion' '
+	test_when_finished "
+		git config --unset checkout.switchDetach;
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
uration' '
+	test_when_finished "
+		git config --unset checkout.switchDetach;
+		git switch main
+	" &&
+	test_config checkout.switchDetach false &&
+	git switch main &&
+	git symbolic-ref HEAD &&
+	test_must_fail git switch main~
+'
+
 test_done

Range-diff against v1:
1:  d9a7ca4c ! 1:  ea7ea74c switch: provide configurable detach
    @@ Metadata
      ## Commit message ##
         switch: provide configurable detach
    =20
    -    Its purpose is to provide for git-switch(1) same detach behavior on
    -    commit it than git-checkout(1) through configuration option
    -    `checkout.switchDetach`.
    +    Some users won=E2=80=99t change to switch/restore commands and kee=
p relying on
    +    checkout command because of this =E2=80=9Cmissing=E2=80=9D feature:
    +
    +    For git-switch(1), configurable through option `checkout.switchDet=
ach`,
    +    match git-checkout(1)=E2=80=99s detach behavior on non-branch refe=
rences, such
    +    as commit id and "tilde" reference (i.e "${my_branch}~2").
    +    No need to use explicit --detach option, automatically detach on
    +    non-branch reference, then reattach when going back on a branch, e=
ven
    +    implicitly through `git switch -` command.
    +    =E2=80=A6 like git-checkout(1) uses to do.
    +
    +    No impact on current behavior when option is unset or set to false.
    =20
         Signed-off-by: Thibaud CANALE <thican@thican.net>
    =20
    @@ Documentation/config/checkout.adoc: commands or functionality in the=
 future.
      	linkgit:git-switch[1] and linkgit:git-checkout[1].
     =20
     +`checkout.switchDetach`::
    -+	Provides for linkgit:git-switch[1] the same detach behavior on commi=
t id
    -+	than linkgit:git-checkout[1] without the explicit --detach option.
    ++	For linkgit:git-switch[1], matches linkgit:git-checkout[1]=E2=80=99s=
 detach behavior
    ++	on non-branch references, such as commit id and "tilde" reference (i=
=2Ee
    ++	"${my_branch}~2").
    +++
    ++No need to use explicit --detach option, automatically detach on
    ++non-branch reference, then reattach when going back on a branch, even
    ++implicitly through `git switch -` command.
    +++
    ++=E2=80=A6 like linkgit:git-checkout[1] uses to do.
    +++
    ++No impact when option is unset or set to false, won't continue when t=
rying to
    ++detach HEAD without explicit --detach option.
     +
      `checkout.workers`::
      	The number of parallel workers to use when updating the working tree.
    @@ builtin/checkout.c: struct checkout_opts {
      	int force;
      	int force_detach;
      	int implicit_detach;
    -+	int switch_detach;  // For checkout.switchDetach configuration
    ++	int switch_detach;
      	int writeout_stage;
      	int overwrite_ignore;
      	int ignore_skipworktree;
    @@ builtin/checkout.c: static void die_expecting_a_branch(const struct =
branch_info
     -	if (advice_enabled(ADVICE_SUGGEST_DETACHING_HEAD))
     +	if (advice_enabled(ADVICE_SUGGEST_DETACHING_HEAD)) {
      		advise(_("If you want to detach HEAD at the commit, try again with =
the --detach option."));
    -+		advise(_("Also you can detach by default by setting the config vari=
able "
    -+		         "checkout.switchDetach to true."));
    ++		advise(_("You can also detach by default by setting the config "
    ++		         "variable checkout.switchDetach to true."));
     +	}
     =20
      	exit(code);
    @@ builtin/checkout.c: int cmd_switch(int argc,
      	options =3D add_common_options(&opts, options);
      	options =3D add_common_switch_branch_options(&opts, options);
     =20
    -+	repo_config_get_bool(the_repository, "checkout.switchDetach", &opts.=
switch_detach);
    ++	repo_config_get_bool(the_repository, "checkout.switchDetach",
    ++	                     &opts.switch_detach);
     +
      	cb_option =3D 'c';
     =20
    @@ t/t2060-switch.sh: test_expect_success 'switch back when temporarily=
 detached an
      	git -C wt2 switch --ignore-other-worktrees shared
      '
     =20
    -+test_expect_success 'switch with configured detach behavior from conf=
iguration ' '
    ++test_expect_success 'switch with configured detach behavior from conf=
iguration' '
     +	test_when_finished "
    -+		test_config checkout.switchDetach false;
    ++		git config --unset checkout.switchDetach;
     +		git switch main
     +	" &&
     +	test_config checkout.switchDetach true &&
    @@ t/t2060-switch.sh: test_expect_success 'switch back when temporarily=
 detached an
     +	test_must_fail git symbolic-ref HEAD
     +'
     +
    -+test_expect_success 'switch without configured detach behavior from c=
onfiguration ' '
    ++test_expect_success 'switch without configured detach behavior from c=
onfiguration' '
     +	test_when_finished "
    -+		test_config checkout.switchDetach false;
    ++		git config --unset checkout.switchDetach;
     +		git switch main
     +	" &&
     +	test_config checkout.switchDetach false &&
--=20
Thibaud CANALE
thican [at] thican [dot] net
https://thican.net/
GPG: rsa4096 2013-10-14 485EF628CB85CDD4CB7CFF0D52F5127650733A18

--gpdvj3w2wnbudjkl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJPBAABCAA5FiEESF72KMuFzdTLfP8NUvUSdlBzOhgFAmnRfzYbFIAAAAAABAAO
bWFudTIsMi41KzEuMTEsMiwyAAoJEFL1EnZQczoYEv0P/iz5nkOPChU/Y2WnVf6D
1gHA6dWs60TEGQtiqOQ7w8P0vWaVffjM4MHFDlZo5/7mfBs6AOqSwP0K//kVb2Ic
AuRPGKVuhSfqsxbugAukj+uXMn5yMFziJRm8MMpHOAjkTdoGGKqGn08g/UswuNrg
n7rInjliFnVMoqOK1mitdlJsqugEsNL84tTZTHCW5763Fa6SaxccCS+zbwy8cu2o
NIzauFKTd2taGh300iUunz1MGm9+X0FpMt5KDP4MYNyusdfs+GiAhgcuQqe+8UG3
tHaPo8DQCcZTzI8yiIPW+YHQpHc3M3IN+mqSr/UCD4pGu3aRR+uwM0iY2KZKqAmo
rZduk7LQyklRgVVakaOHOBICXnfItoc3+/W7I0S7xpSaeMwv0mJ2UeXo17MBJuh2
bQHC+XXu7IG9yck+PR8z52szBS7dQ6qIVlS9OQ8UuaASjwzOXif5+ob4PF8M3KQp
qHPmqgok4Dgw+WorwjVEovX2eeq0DmyjGFh/qOFao9KmWYo4HNJ1NEin8O4lzfSW
SElqCXzONJwK/183Wz3bpEzTfHz0bF8hEeLsKySkCVjmsfTGLfxUjXXWMabJwOan
Pcxm9WMk1+kZUnPih92m4+Jk9FCP47kK3wtVOH7Em4l7c4nKLN2kWg1iEp23CXUI
SiolQnxpaDC33KoFkCoHHuYh
=T5GK
-----END PGP SIGNATURE-----

--gpdvj3w2wnbudjkl--
