Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D8CBC64E7A
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 09:57:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A94C1204FD
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 09:57:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RNCPwuc1";
	dkim=temperror (0-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qUjhOsh0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391040AbgLAJ5U (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Dec 2020 04:57:20 -0500
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:58555 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391026AbgLAJ5T (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 1 Dec 2020 04:57:19 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 8619CF90;
        Tue,  1 Dec 2020 04:56:13 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 01 Dec 2020 04:56:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=3KGiA/R4Ku+GD6MHbJ9z10B53u4
        eyh81/JqDiQjNOn8=; b=RNCPwuc1QM1hBvBE+AIQij5cATaBfKDtvkanki5CGWf
        xcAoCOX1lISO/5lHKFVsfVfUnLfQThIiHMFSt7JKswbxU3bpdeE6Go9AYq1jA5oo
        izjgSMCSvc+6+/O7+Se/nxZtrrHkh8PPf21ra5lv3WMzSJxA0eobQoiVEpXLnlUO
        I8SuXOmQjIImvCvRsy4N85sN4kn3UZ5/ekAqrzsv4XON6/i78VaRRPgbtQ/HR1x3
        k+aN0holVKEv1OZ8Y40HAhrr3MSH/3ddwE1kEgogEq4mlTqiqVwkUk93+f+hwn1e
        5pRgq1j5n4ucj0LwQlrsPqJwTpYai+xpJ7YiELnhltg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=3KGiA/
        R4Ku+GD6MHbJ9z10B53u4eyh81/JqDiQjNOn8=; b=qUjhOsh0RD9X5sxbfD+Eg3
        Rb4NFdJW4ehfZYeEPsCsKAsraRYLBtSdCEzib4tjcfam8Er8XAxIQ6xlCGDo6wA4
        tXFX0g9zDWq/lE1HF7DLNrBClLcDRBVVD14EXLGymOSywjNDaDTKCYHGItj0Cn74
        vFdRsQPn/+ASvuvRUcsk1jwaQtRwqZLJz9b2j3gT4nQYI137wLuPJ0x77RWRzTE0
        XjLPZJS31Z5ty+hga9RoccLbqqviETKt43PLZ/sjEmKBQb+UbTuY3WAiehHoC8Zs
        yEcEY9B8yoS6xan/0O3hxuVy5bLtpVgbVNhDTCN+nFCixKk49GeymE3BJkyDZ74w
        ==
X-ME-Sender: <xms:PRPGX8jOHzeyVNwkYL3l8RgzxYvusM-5D2TMWP9DCkHuWjLKlIvQag>
    <xme:PRPGX1DXqGQVbN4NGPDR3bzWP1FEPySpy0mYrCgH8Mb_LoeLu7XwLeWDzMBhNufOK
    Bumquyw9Xx7tc_Isw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudeivddgudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucfkphepjeekrdehgedrudegrdehjeenucevlhhushhtvghrufhiiigvpeefnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:PRPGX0HldWLcxbPVIgIPgZA-RfcW4kiELgAKWOcnxGunmAo00YwpyQ>
    <xmx:PRPGX9Ru-tJ-kBv34dDPZP3TTPb1gjT2Ng1JutpVlCrBeUhRsXWvjA>
    <xmx:PRPGX5xs5xPql4lx6yUh7vb5SYKmZpPtIAWFUtWcFsv5tCHPeyFU6Q>
    <xmx:PRPGXx_CJgO03uiHD2MX3WMHgoyjjU-kzNTHf7hstFNoDpWL1Tqb5A>
Received: from vm-mail.pks.im (dynamic-078-054-014-057.78.54.pool.telefonica.de [78.54.14.57])
        by mail.messagingengine.com (Postfix) with ESMTPA id 30D37108005B;
        Tue,  1 Dec 2020 04:56:12 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 2526cb58 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 1 Dec 2020 09:56:11 +0000 (UTC)
Date:   Tue, 1 Dec 2020 10:56:10 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Philip Oakley <philipoakley@iee.email>
Subject: [PATCH v3 4/4] config: allow specifying config entries via envvar
 pairs
Message-ID: <4aadaeba993a746341d8fdf4028611826c0963e8.1606816110.git.ps@pks.im>
References: <cover.1606214397.git.ps@pks.im>
 <cover.1606816110.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4todlFnwNOkjTTW+"
Content-Disposition: inline
In-Reply-To: <cover.1606816110.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--4todlFnwNOkjTTW+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

While we currently have the `GIT_CONFIG_PARAMETERS` environment variable
which can be used to pass runtime configuration data to git processes,
it's an internal implementation detail and not supposed to be used by
end users.

Next to being for internal use only, this way of passing config entries
has a major downside: the config keys need to be parsed as they contain
both key and value in a single variable. As such, it is left to the user
to escape any potentially harmful characters in the value, which is
quite hard to do if values are controlled by a third party.

This commit thus adds a new way of adding config entries via the
environment which gets rid of this shortcoming. If the user passes the
`GIT_CONFIG_COUNT=3D$n` environment variable, Git will parse environment
variable pairs `GIT_CONFIG_KEY_$i` and `GIT_CONFIG_VALUE_$i` for each
`i` in `[0,n)`.

While the same can be achieved with `git -c <name>=3D<value>`, one may
wish to not do so for potentially sensitive information. E.g. if one
wants to set `http.extraHeader` to contain an authentication token,
doing so via `-c` would trivially leak those credentials via e.g. ps(1),
which typically also shows command arguments.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/git-config.txt |  12 ++++
 cache.h                      |   1 +
 config.c                     |  46 ++++++++++++++
 environment.c                |   1 +
 t/t1300-config.sh            | 115 ++++++++++++++++++++++++++++++++++-
 5 files changed, 174 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index 7573160f21..073fb5229a 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -337,6 +337,18 @@ GIT_CONFIG_NOSYSTEM::
=20
 See also <<FILES>>.
=20
+GIT_CONFIG_COUNT::
+GIT_CONFIG_KEY_<n>::
+GIT_CONFIG_VALUE_<n>::
+	If GIT_CONFIG_COUNT is set to a positive number, all environment pairs
+	GIT_CONFIG_KEY_<n> and GIT_CONFIG_VALUE_<n> up to that number will be
+	added to the process's runtime configuration. The config pairs are
+	zero-indexed. Any missing key or value is treated as an error. An empty
+	GIT_CONFIG_COUNT is treated the same as GIT_CONFIG_COUNT=3D0, namely no
+	pairs are processed. These environment variables will override values
+	in configuration files, but will be overridden by any explicit options
+	passed via `git -c`.
+
=20
 [[EXAMPLES]]
 EXAMPLES
diff --git a/cache.h b/cache.h
index c0072d43b1..8a36146337 100644
--- a/cache.h
+++ b/cache.h
@@ -472,6 +472,7 @@ static inline enum object_type object_type(unsigned int=
 mode)
 #define TEMPLATE_DIR_ENVIRONMENT "GIT_TEMPLATE_DIR"
 #define CONFIG_ENVIRONMENT "GIT_CONFIG"
 #define CONFIG_DATA_ENVIRONMENT "GIT_CONFIG_PARAMETERS"
+#define CONFIG_COUNT_ENVIRONMENT "GIT_CONFIG_COUNT"
 #define EXEC_PATH_ENVIRONMENT "GIT_EXEC_PATH"
 #define CEILING_DIRECTORIES_ENVIRONMENT "GIT_CEILING_DIRECTORIES"
 #define NO_REPLACE_OBJECTS_ENVIRONMENT "GIT_NO_REPLACE_OBJECTS"
diff --git a/config.c b/config.c
index ba67706854..0b4d0b45d1 100644
--- a/config.c
+++ b/config.c
@@ -8,6 +8,7 @@
 #include "cache.h"
 #include "branch.h"
 #include "config.h"
+#include "environment.h"
 #include "repository.h"
 #include "lockfile.h"
 #include "exec-cmd.h"
@@ -485,6 +486,8 @@ int git_config_parse_parameter(const char *text,
 int git_config_from_parameters(config_fn_t fn, void *data)
 {
 	const char *env;
+	struct strbuf envvar =3D STRBUF_INIT;
+	struct strvec to_free =3D STRVEC_INIT;
 	int ret =3D 0;
 	char *envw =3D NULL;
 	const char **argv =3D NULL;
@@ -496,6 +499,47 @@ int git_config_from_parameters(config_fn_t fn, void *d=
ata)
 	source.origin_type =3D CONFIG_ORIGIN_CMDLINE;
 	cf =3D &source;
=20
+	env =3D getenv(CONFIG_COUNT_ENVIRONMENT);
+	if (env) {
+		unsigned long count;
+		char *endp;
+
+		count =3D strtoul(env, &endp, 10);
+		if (*endp) {
+			ret =3D error(_("bogus count in %s"), CONFIG_COUNT_ENVIRONMENT);
+			goto out;
+		}
+		if (count > INT_MAX) {
+			ret =3D error(_("too many entries in %s"), CONFIG_COUNT_ENVIRONMENT);
+			goto out;
+		}
+
+		for (i =3D 0; i < count; i++) {
+			const char *key, *value;
+
+			strbuf_addf(&envvar, "GIT_CONFIG_KEY_%d", i);
+			key =3D getenv_safe(&to_free, envvar.buf);
+			if (!key) {
+				ret =3D error(_("missing config key %s"), envvar.buf);
+				goto out;
+			}
+			strbuf_reset(&envvar);
+
+			strbuf_addf(&envvar, "GIT_CONFIG_VALUE_%d", i);
+			value =3D getenv_safe(&to_free, envvar.buf);
+			if (!value) {
+				ret =3D error(_("missing config value %s"), envvar.buf);
+				goto out;
+			}
+			strbuf_reset(&envvar);
+
+			if (config_parse_pair(key, value, fn, data) < 0) {
+				ret =3D -1;
+				goto out;
+			}
+		}
+	}
+
 	env =3D getenv(CONFIG_DATA_ENVIRONMENT);
 	if (env) {
 		int nr =3D 0, alloc =3D 0;
@@ -517,6 +561,8 @@ int git_config_from_parameters(config_fn_t fn, void *da=
ta)
 	}
=20
 out:
+	strbuf_release(&envvar);
+	strvec_clear(&to_free);
 	free(argv);
 	free(envw);
 	cf =3D source.prev;
diff --git a/environment.c b/environment.c
index 2234af462c..2f27008424 100644
--- a/environment.c
+++ b/environment.c
@@ -117,6 +117,7 @@ const char * const local_repo_env[] =3D {
 	ALTERNATE_DB_ENVIRONMENT,
 	CONFIG_ENVIRONMENT,
 	CONFIG_DATA_ENVIRONMENT,
+	CONFIG_COUNT_ENVIRONMENT,
 	DB_ENVIRONMENT,
 	GIT_DIR_ENVIRONMENT,
 	GIT_WORK_TREE_ENVIRONMENT,
diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index 825d9a184f..756536067b 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -1316,6 +1316,117 @@ test_expect_success 'detect bogus GIT_CONFIG_PARAME=
TERS' '
 		git config --get-regexp "env.*"
 '
=20
+test_expect_success 'git config handles environment config pairs' '
+	GIT_CONFIG_COUNT=3D2 \
+		GIT_CONFIG_KEY_0=3D"pair.one" GIT_CONFIG_VALUE_0=3D"foo" \
+		GIT_CONFIG_KEY_1=3D"pair.two" GIT_CONFIG_VALUE_1=3D"bar" \
+		git config --get-regexp "pair.*" >actual &&
+	cat >expect <<-EOF &&
+	pair.one foo
+	pair.two bar
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'git config ignores pairs without count' '
+	test_must_fail env GIT_CONFIG_KEY_0=3D"pair.one" GIT_CONFIG_VALUE_0=3D"va=
lue" \
+		git config pair.one 2>error &&
+	test_must_be_empty error
+'
+
+test_expect_success 'git config ignores pairs with zero count' '
+	test_must_fail env \
+		GIT_CONFIG_COUNT=3D0 \
+		GIT_CONFIG_KEY_0=3D"pair.one" GIT_CONFIG_VALUE_0=3D"value" \
+		git config pair.one
+'
+
+test_expect_success 'git config ignores pairs exceeding count' '
+	GIT_CONFIG_COUNT=3D1 \
+		GIT_CONFIG_KEY_0=3D"pair.one" GIT_CONFIG_VALUE_0=3D"value" \
+		GIT_CONFIG_KEY_1=3D"pair.two" GIT_CONFIG_VALUE_1=3D"value" \
+		git config --get-regexp "pair.*" >actual &&
+	cat >expect <<-EOF &&
+	pair.one value
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'git config ignores pairs with zero count' '
+	test_must_fail env \
+		GIT_CONFIG_COUNT=3D0 GIT_CONFIG_KEY_0=3D"pair.one" GIT_CONFIG_VALUE_0=3D=
"value" \
+		git config pair.one >error &&
+	test_must_be_empty error
+'
+
+test_expect_success 'git config ignores pairs with empty count' '
+	test_must_fail env \
+		GIT_CONFIG_COUNT=3D GIT_CONFIG_KEY_0=3D"pair.one" GIT_CONFIG_VALUE_0=3D"=
value" \
+		git config pair.one >error &&
+	test_must_be_empty error
+'
+
+test_expect_success 'git config fails with invalid count' '
+	test_must_fail env GIT_CONFIG_COUNT=3D10a git config --list 2>error &&
+	test_i18ngrep "bogus count" error &&
+	test_must_fail env GIT_CONFIG_COUNT=3D9999999999999999 git config --list =
2>error &&
+	test_i18ngrep "too many entries" error
+'
+
+test_expect_success 'git config fails with missing config key' '
+	test_must_fail env GIT_CONFIG_COUNT=3D1 GIT_CONFIG_VALUE_0=3D"value" \
+		git config --list 2>error &&
+	test_i18ngrep "missing config key" error
+'
+
+test_expect_success 'git config fails with missing config value' '
+	test_must_fail env GIT_CONFIG_COUNT=3D1 GIT_CONFIG_KEY_0=3D"pair.one" \
+		git config --list 2>error &&
+	test_i18ngrep "missing config value" error
+'
+
+test_expect_success 'git config fails with invalid config pair key' '
+	test_must_fail env GIT_CONFIG_COUNT=3D1 \
+		GIT_CONFIG_KEY_0=3D GIT_CONFIG_VALUE_0=3Dvalue \
+		git config --list &&
+	test_must_fail env GIT_CONFIG_COUNT=3D1 \
+		GIT_CONFIG_KEY_0=3Dmissing-section GIT_CONFIG_VALUE_0=3Dvalue \
+		git config --list
+'
+
+test_expect_success 'environment overrides config file' '
+	test_when_finished "rm -f .git/config" &&
+	cat >.git/config <<-EOF &&
+	[pair]
+	one =3D value
+	EOF
+	GIT_CONFIG_COUNT=3D1 GIT_CONFIG_KEY_0=3Dpair.one GIT_CONFIG_VALUE_0=3Dove=
rride \
+		git config pair.one >actual &&
+	cat >expect <<-EOF &&
+	override
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'GIT_CONFIG_PARAMETERS overrides environment config' '
+	GIT_CONFIG_COUNT=3D1 GIT_CONFIG_KEY_0=3Dpair.one GIT_CONFIG_VALUE_0=3Dval=
ue \
+		GIT_CONFIG_PARAMETERS=3D"${SQ}pair.one=3Doverride${SQ}" \
+		git config pair.one >actual &&
+	cat >expect <<-EOF &&
+	override
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'command line overrides environment config' '
+	GIT_CONFIG_COUNT=3D1 GIT_CONFIG_KEY_0=3Dpair.one GIT_CONFIG_VALUE_0=3Dval=
ue \
+		git -c pair.one=3Doverride config pair.one >actual &&
+	cat >expect <<-EOF &&
+	override
+	EOF
+	test_cmp expect actual
+'
+
 test_expect_success 'git config --edit works' '
 	git config -f tmp test.value no &&
 	echo test.value=3Dyes >expect &&
@@ -1661,9 +1772,11 @@ test_expect_success '--show-origin with --list' '
 	file:.git/config	user.override=3Dlocal
 	file:.git/config	include.path=3D../include/relative.include
 	file:.git/../include/relative.include	user.relative=3Dinclude
+	command line:	user.environ=3Dtrue
 	command line:	user.cmdline=3Dtrue
 	EOF
-	git -c user.cmdline=3Dtrue config --list --show-origin >output &&
+	GIT_CONFIG_COUNT=3D1 GIT_CONFIG_KEY_0=3Duser.environ GIT_CONFIG_VALUE_0=
=3Dtrue\
+		git -c user.cmdline=3Dtrue config --list --show-origin >output &&
 	test_cmp expect output
 '
=20
--=20
2.29.2


--4todlFnwNOkjTTW+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl/GEzkACgkQVbJhu7ck
PpRSmg/8CzgaBFdyi0NpVTolKTkCjuDLYLVmsQlw1frRaJmUCZch0OA92GhmZ3Gs
+ufafL+9emVwsAOUbFigUTzdnWt/J6Px4tmcif+c6RcvUCBAYCCWOAA08GD/z2/O
vdCmve9fYf6EEo/k1etqnRHNITKQrR9fPkxcSuLGu4GG3sIfq713TSMSe2RkeiaM
m8lax4W6caM324gx6IDVrcS8j6wqivdsxkUnHNPBZeK94hcE/AJrJADsWW3uIZqX
WcLlcjTcXxAxDBAQaDgcoD1ocRQrROsXysfPRnPAcb1QOlLKMH/h6v9raDgL64D8
bkDTc45BvQ5CSqwFLNtopjYgDWry7W466pMXBmZYnhZa2szk517uZZoPe7wGpGWA
T4EOC55zCSAIiXVj1kf+G81IkHYYDOyvZy3aD1NflH8URgxIzoEXqhVDKMm30AOZ
ujG0gHyRqg0a8VmEzvLxRxs9Rutv/Jknj0cjpxgJi1s4L+dByUp5FlHYsOc7Sf+6
ZwemPohO0OOgv87XtnbOnU/+PsSEV2x+RCNqPp1b5Vd2WcqfIs9VpfH39M+7khyL
FZlRgiBLENJcxfLquYMvqXnrFi+/XE9vNVmx4tTOBETWrgVCxaxVL/jiVv63i05G
uVE8h9AAyAtl+6QqoZ044L6haRyIY0g/oU8DNtC/hBanlspAQiY=
=7oPl
-----END PGP SIGNATURE-----

--4todlFnwNOkjTTW+--
