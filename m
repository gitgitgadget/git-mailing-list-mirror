Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26BA0387
	for <git@vger.kernel.org>; Fri, 19 Apr 2024 01:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713488740; cv=none; b=CJ95e5cB13N9yL1Cdw6KyAdxrOd0iXM0B5qQ5Bq27j+rGHGCaeP/79/VMn/3Hkp5CUBHqc1JJDE66vKUTUYtwOeaGB5DFdavhWgxF1lYfaWTGtCr1UfOP69t7TxKAaeyW+yC+JYW2SKd+5CnFPJd+MwrBFU2J+eShRK5VFE1XdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713488740; c=relaxed/simple;
	bh=czvwzLGm4gYRCrHw5pzqFM1tJK0qR26azJvgdGyem9w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QihGNbDDXQ3FMoyHn6Dd/jEuXiAV7ZxdPYXSp9l4Xl/Bp4DZ4c21MagRvcDb4T9E8hnWeaie7zp6n2P37KQ97filSjQ9iDYbDfaqa1Q5GVx5PoEdKoucBvfJgDTzlSsixIsoPeB+tzbp2+KyDHlHoBYv2TwvUfQesci07ctDP4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=UYV9+6Me; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="UYV9+6Me"
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1713488734;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vFhIL6qDe1zZgxV7plb+KDy/EU+4jjXMc4HA2Orgmv4=;
	b=UYV9+6MevC49B3TsCaGGzMm5NWgayjT05OI8czD8ZTeXU8FsskUq4Mg1SPt21sddaVnO1X
	zTyZTeVdKMc3H7uFLwWeIMeyLsfPSch/nZUXcduQgacKLHavOevN9Ic6DEeDZhtf2+QExO
	ubjHm0AfUTkG+Yfvd3i76pxb9LcbYrqvTcYqkws8rR9PZljxQcCNn66FkOrP6cWVoRmlYN
	UpsYX4sLsCVEcz862QxWFBTEath5jHwQkjr7wJ4scXQrd/pQexzUdHgPk0mH8ZvZSsTvJN
	60hIAYP1CKM4t96eZyEKxBb7TOLH9iGe1g0nz14J27y/0bfe8E57voU6ELKCDg==
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	sunshine@sunshineco.com,
	code@khaugsbakk.name,
	phillip.wood123@gmail.com,
	ps@pks.im
Subject: [PATCH] format-patch: ensure that --rfc and -k are mutually exclusive
Date: Fri, 19 Apr 2024 03:05:30 +0200
Message-Id: <71d195c248879e7c46fac0e84c6b0a8aa90bd2c2.1713488563.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Fix a bug that allows the "--rfc" and "-k" options to be specified together
when "git format-patch" is executed, which was introduced in the commit
e0d7db7423a9 ("format-patch: --rfc honors what --subject-prefix sets").

Add a couple of additional tests to t4014, to cover additional cases of
the mutual exclusivity between different "git format-patch" options.

Signed-off-by: Dragan Simic <dsimic@manjaro.org>
---

Notes:
    This patch originates from my earlier patch series, [1] for which
    it was concluded to not be acceptable in its entirety. [2]
    
    This version of the patch includes improvements based on the valuable
    and appreciated feedback from the reviewers:
      - Improved and simplified the patch subject and patch description, as
        suggested by Eric Sunshine [3] and Kristoffer Haugsbakk [4]
      - Removed a redundant comment from the bugfix, as suggested by Eric
        Sunshine and Kristoffer Haugsbakk [5]
      - Squashed the bugfix and the new tests into a single patch, for easier
        reviewing, as suggested by Eric Sunshine [6]
      - Improved the main new test, as suggested by Kristoffer Haugsbakk, [4]
        and added validation of both stdout and stderr outputs
      - Added a couple of more tests, to cover additional cases of the mutual
        exclusivity of the available command-line options
    
    [1] https://lore.kernel.org/git/b7568429acad91ff2d9a1574111441a3@manjaro.org/T/#mfcbbcf38e23698d09f524cc3b49ed1d855b90018
    [2] https://lore.kernel.org/git/b7568429acad91ff2d9a1574111441a3@manjaro.org/T/#m9441b5486ca9229d5bfff9c2a92bc80eef341baf
    [3] https://lore.kernel.org/git/CAPig+cTEp799w2-VEACYThW0COyo0SJLRS_sr-PG=LX++Tompw@mail.gmail.com/T/#u
    [4] https://lore.kernel.org/git/e4aa5235-c6ad-45c7-930e-de991cc375f2@app.fastmail.com/T/#u
    [5] https://lore.kernel.org/git/CAPig+cSGZr4zE=Dp7Z58CN0kmkpXdc8SOopXmB9=ry4gwNkq=w@mail.gmail.com/T/#u
    [6] https://lore.kernel.org/git/CAPig+cRBjosyadQHO03fcCz7YBc=T04ytHkpt9UU87tLaiSOgw@mail.gmail.com/T/#u

Range-diff:
1:  25b90d065744 < -:  ------------ format-patch docs: avoid use of parentheses to improve readability
2:  c975f961779b ! 1:  71d195c24887 format-patch: fix a bug in option exclusivity and add a test to t4014
    @@ Metadata
     Author: Dragan Simic <dsimic@manjaro.org>
     
      ## Commit message ##
    -    format-patch: fix a bug in option exclusivity and add a test to t4014
    +    format-patch: ensure that --rfc and -k are mutually exclusive
     
    -    Fix a bug that allows --rfc and -k options to be specified together when
    -    executing "git format-patch".  This bug was introduced back in the commit
    -    e0d7db7423a9 ("format-patch: --rfc honors what --subject-prefix sets"),
    -    about eight months ago, but it has remained undetected so far, presumably
    -    because of no associated test coverage.
    +    Fix a bug that allows the "--rfc" and "-k" options to be specified together
    +    when "git format-patch" is executed, which was introduced in the commit
    +    e0d7db7423a9 ("format-patch: --rfc honors what --subject-prefix sets").
     
    -    Add a new test to the t4014 that covers the mutual exclusivity of the --rfc
    -    and -k command-line options for "git format-patch", for future coverage.
    +    Add a couple of additional tests to t4014, to cover additional cases of
    +    the mutual exclusivity between different "git format-patch" options.
     
         Signed-off-by: Dragan Simic <dsimic@manjaro.org>
     
    +
    + ## Notes ##
    +    This patch originates from my earlier patch series, [1] for which
    +    it was concluded to not be acceptable in its entirety. [2]
    +
    +    This version of the patch includes improvements based on the valuable
    +    and appreciated feedback from the reviewers:
    +      - Improved and simplified the patch subject and patch description, as
    +        suggested by Eric Sunshine [3] and Kristoffer Haugsbakk [4]
    +      - Removed a redundant comment from the bugfix, as suggested by Eric
    +        Sunshine and Kristoffer Haugsbakk [5]
    +      - Squashed the bugfix and the new tests into a single patch, for easier
    +        reviewing, as suggested by Eric Sunshine [6]
    +      - Improved the main new test, as suggested by Kristoffer Haugsbakk, [4]
    +        and added validation of both stdout and stderr outputs
    +      - Added a couple of more tests, to cover additional cases of the mutual
    +        exclusivity of the available command-line options
    +
    +    [1] https://lore.kernel.org/git/b7568429acad91ff2d9a1574111441a3@manjaro.org/T/#mfcbbcf38e23698d09f524cc3b49ed1d855b90018
    +    [2] https://lore.kernel.org/git/b7568429acad91ff2d9a1574111441a3@manjaro.org/T/#m9441b5486ca9229d5bfff9c2a92bc80eef341baf
    +    [3] https://lore.kernel.org/git/CAPig+cTEp799w2-VEACYThW0COyo0SJLRS_sr-PG=LX++Tompw@mail.gmail.com/T/#u
    +    [4] https://lore.kernel.org/git/e4aa5235-c6ad-45c7-930e-de991cc375f2@app.fastmail.com/T/#u
    +    [5] https://lore.kernel.org/git/CAPig+cSGZr4zE=Dp7Z58CN0kmkpXdc8SOopXmB9=ry4gwNkq=w@mail.gmail.com/T/#u
    +    [6] https://lore.kernel.org/git/CAPig+cRBjosyadQHO03fcCz7YBc=T04ytHkpt9UU87tLaiSOgw@mail.gmail.com/T/#u
    +
      ## builtin/log.c ##
     @@ builtin/log.c: int cmd_format_patch(int argc, const char **argv, const char *prefix)
      	if (cover_from_description_arg)
      		cover_from_description_mode = parse_cover_from_description(cover_from_description_arg);
      
     -	if (rfc)
    -+	/* Also mark the subject prefix as modified, for later checks */
     +	if (rfc) {
      		strbuf_insertstr(&sprefix, 0, "RFC ");
     +		subject_prefix = 1;
     +	}
      
      	if (reroll_count) {
      		strbuf_addf(&sprefix, " v%s", reroll_count);
     
      ## t/t4014-format-patch.sh ##
     @@ t/t4014-format-patch.sh: test_expect_success '--rfc is argument order independent' '
      	test_cmp expect actual
      '
      
    ++test_expect_success '--subject-prefix="<non-empty>" and -k cannot be used together' '
    ++	echo "fatal: options '\''--subject-prefix/--rfc'\'' and '\''-k'\'' cannot be used together" >expect.err &&
    ++	test_must_fail git format-patch -1 --stdout --subject-prefix="MYPREFIX" -k >actual.out 2>actual.err &&
    ++	test_must_be_empty actual.out &&
    ++	test_cmp expect.err actual.err
    ++'
    ++
    ++test_expect_success '--subject-prefix="" and -k cannot be used together' '
    ++	echo "fatal: options '\''--subject-prefix/--rfc'\'' and '\''-k'\'' cannot be used together" >expect.err &&
    ++	test_must_fail git format-patch -1 --stdout --subject-prefix="" -k >actual.out 2>actual.err &&
    ++	test_must_be_empty actual.out &&
    ++	test_cmp expect.err actual.err
    ++'
    ++
     +test_expect_success '--rfc and -k cannot be used together' '
    -+	test_must_fail git format-patch -1 --stdout --rfc -k >patch
    ++	echo "fatal: options '\''--subject-prefix/--rfc'\'' and '\''-k'\'' cannot be used together" >expect.err &&
    ++	test_must_fail git format-patch -1 --stdout --rfc -k >actual.out 2>actual.err &&
    ++	test_must_be_empty actual.out &&
    ++	test_cmp expect.err actual.err
     +'
     +
      test_expect_success '--from=ident notices bogus ident' '
3:  1d9c6ce3df71 < -:  ------------ format-patch: new --resend option for adding "RESEND" to patch subjects
4:  42865d6c6694 < -:  ------------ t4014: add tests to cover --resend option and its exclusivity

 builtin/log.c           |  4 +++-
 t/t4014-format-patch.sh | 21 +++++++++++++++++++++
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/builtin/log.c b/builtin/log.c
index c0a8bb95e983..8bab30fcc70d 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -2050,8 +2050,10 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	if (cover_from_description_arg)
 		cover_from_description_mode = parse_cover_from_description(cover_from_description_arg);
 
-	if (rfc)
+	if (rfc) {
 		strbuf_insertstr(&sprefix, 0, "RFC ");
+		subject_prefix = 1;
+	}
 
 	if (reroll_count) {
 		strbuf_addf(&sprefix, " v%s", reroll_count);
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index e37a1411ee24..90fe6d066cc0 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -1397,6 +1397,27 @@ test_expect_success '--rfc is argument order independent' '
 	test_cmp expect actual
 '
 
+test_expect_success '--subject-prefix="<non-empty>" and -k cannot be used together' '
+	echo "fatal: options '\''--subject-prefix/--rfc'\'' and '\''-k'\'' cannot be used together" >expect.err &&
+	test_must_fail git format-patch -1 --stdout --subject-prefix="MYPREFIX" -k >actual.out 2>actual.err &&
+	test_must_be_empty actual.out &&
+	test_cmp expect.err actual.err
+'
+
+test_expect_success '--subject-prefix="" and -k cannot be used together' '
+	echo "fatal: options '\''--subject-prefix/--rfc'\'' and '\''-k'\'' cannot be used together" >expect.err &&
+	test_must_fail git format-patch -1 --stdout --subject-prefix="" -k >actual.out 2>actual.err &&
+	test_must_be_empty actual.out &&
+	test_cmp expect.err actual.err
+'
+
+test_expect_success '--rfc and -k cannot be used together' '
+	echo "fatal: options '\''--subject-prefix/--rfc'\'' and '\''-k'\'' cannot be used together" >expect.err &&
+	test_must_fail git format-patch -1 --stdout --rfc -k >actual.out 2>actual.err &&
+	test_must_be_empty actual.out &&
+	test_cmp expect.err actual.err
+'
+
 test_expect_success '--from=ident notices bogus ident' '
 	test_must_fail git format-patch -1 --stdout --from=foo >patch
 '
