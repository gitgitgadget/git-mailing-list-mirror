Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236BC137E
	for <git@vger.kernel.org>; Fri, 19 Apr 2024 02:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713495508; cv=none; b=LaXOasHGoyvJWZDfYSwZTWtKXEAjbJMRvamGUn/F4l6BQJRUePJfPxg00zNYh+xspjwThMI9aJ4ODHe4yK4z6at6toPGtSJMCNaLeFieol0oKi+t7oOZVY/x32jY287vNvMfEdsRXiFhnBI+ap3xH1LkIWJMOxxe7udlNix38X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713495508; c=relaxed/simple;
	bh=EhcGCo3/cUPeNpJ6JX0g3g8vN8k/bsKHQznCg1s8Mzc=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=usV2R2kf5oMniqo988r+BfGKKFBjrMVRSpMXI1YPCvul/bdUh0DKuGJGhcNBdcfn8UW3D4gWIp9m02S1vrlXOCdy+ANfm+xKxzzesq92jDpGNXpJD9Q7bohlpJ3lppAllhcr2lSgjF9KYRZo6M88ldL9jO3omU4MRD9wQ0oC+ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=BaeyoX1R; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="BaeyoX1R"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1713495500;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CXwUd3sz30lkt53ytAcKXDNzEM8gwR310TBuMAFJ8po=;
	b=BaeyoX1R+dB7RM6BKuSmjFOpqNtRXtHo7DNwovg2XokPfBS6UD5IqQzf1MvkeOYKKmeOnH
	wME3RLG2G35ufku/ffnPdUYMHHDDFEakFB/AG0A29aKKBYyLHpmWTX36B56nFm+6UGss15
	gfRDiTvrIaImNQeby8mu1YE2UVPOjQBC7SSidPkVt9HmXtaTLSyf8B/OZdMngnBeUYEuzQ
	QjCrDixOCuvVghuXO86nvo4LvRNn1QldUITp49YhUI0qdBFDrN6J7g7X1ejRLXbUPtxmv1
	aTm3QOQpJzYWJqLwetOw8LSL/4H6SQJbz+1Wd38Oi2XoR4Z4LeRiTusnKmjnWg==
Date: Fri, 19 Apr 2024 04:58:20 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: git@vger.kernel.org
Cc: gitster@pobox.com, sunshine@sunshineco.com, code@khaugsbakk.name,
 phillip.wood123@gmail.com, ps@pks.im, Drew DeVault <sir@cmpwn.com>
Subject: Re: [PATCH] format-patch: ensure that --rfc and -k are mutually
 exclusive
In-Reply-To: <71d195c248879e7c46fac0e84c6b0a8aa90bd2c2.1713488563.git.dsimic@manjaro.org>
References: <71d195c248879e7c46fac0e84c6b0a8aa90bd2c2.1713488563.git.dsimic@manjaro.org>
Message-ID: <b4c6cbf5f3246ecd0cf27c7e87bf6dfc@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

+Cc: Drew DeVault <sir@cmpwn.com>

On 2024-04-19 03:05, Dragan Simic wrote:
> Fix a bug that allows the "--rfc" and "-k" options to be specified 
> together
> when "git format-patch" is executed, which was introduced in the commit
> e0d7db7423a9 ("format-patch: --rfc honors what --subject-prefix sets").
> 
> Add a couple of additional tests to t4014, to cover additional cases of
> the mutual exclusivity between different "git format-patch" options.
> 
> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
> ---
> 
> Notes:
>     This patch originates from my earlier patch series, [1] for which
>     it was concluded to not be acceptable in its entirety. [2]
> 
>     This version of the patch includes improvements based on the 
> valuable
>     and appreciated feedback from the reviewers:
>       - Improved and simplified the patch subject and patch 
> description, as
>         suggested by Eric Sunshine [3] and Kristoffer Haugsbakk [4]
>       - Removed a redundant comment from the bugfix, as suggested by 
> Eric
>         Sunshine and Kristoffer Haugsbakk [5]
>       - Squashed the bugfix and the new tests into a single patch, for 
> easier
>         reviewing, as suggested by Eric Sunshine [6]
>       - Improved the main new test, as suggested by Kristoffer 
> Haugsbakk, [4]
>         and added validation of both stdout and stderr outputs
>       - Added a couple of more tests, to cover additional cases of the 
> mutual
>         exclusivity of the available command-line options
> 
>     [1]
> https://lore.kernel.org/git/b7568429acad91ff2d9a1574111441a3@manjaro.org/T/#mfcbbcf38e23698d09f524cc3b49ed1d855b90018
>     [2]
> https://lore.kernel.org/git/b7568429acad91ff2d9a1574111441a3@manjaro.org/T/#m9441b5486ca9229d5bfff9c2a92bc80eef341baf
>     [3]
> https://lore.kernel.org/git/CAPig+cTEp799w2-VEACYThW0COyo0SJLRS_sr-PG=LX++Tompw@mail.gmail.com/T/#u
>     [4]
> https://lore.kernel.org/git/e4aa5235-c6ad-45c7-930e-de991cc375f2@app.fastmail.com/T/#u
>     [5]
> https://lore.kernel.org/git/CAPig+cSGZr4zE=Dp7Z58CN0kmkpXdc8SOopXmB9=ry4gwNkq=w@mail.gmail.com/T/#u
>     [6]
> https://lore.kernel.org/git/CAPig+cRBjosyadQHO03fcCz7YBc=T04ytHkpt9UU87tLaiSOgw@mail.gmail.com/T/#u
> 
> Range-diff:
> 1:  25b90d065744 < -:  ------------ format-patch docs: avoid use of
> parentheses to improve readability
> 2:  c975f961779b ! 1:  71d195c24887 format-patch: fix a bug in option
> exclusivity and add a test to t4014
>     @@ Metadata
>      Author: Dragan Simic <dsimic@manjaro.org>
> 
>       ## Commit message ##
>     -    format-patch: fix a bug in option exclusivity and add a test 
> to t4014
>     +    format-patch: ensure that --rfc and -k are mutually exclusive
> 
>     -    Fix a bug that allows --rfc and -k options to be specified
> together when
>     -    executing "git format-patch".  This bug was introduced back
> in the commit
>     -    e0d7db7423a9 ("format-patch: --rfc honors what 
> --subject-prefix sets"),
>     -    about eight months ago, but it has remained undetected so
> far, presumably
>     -    because of no associated test coverage.
>     +    Fix a bug that allows the "--rfc" and "-k" options to be
> specified together
>     +    when "git format-patch" is executed, which was introduced in 
> the commit
>     +    e0d7db7423a9 ("format-patch: --rfc honors what 
> --subject-prefix sets").
> 
>     -    Add a new test to the t4014 that covers the mutual
> exclusivity of the --rfc
>     -    and -k command-line options for "git format-patch", for
> future coverage.
>     +    Add a couple of additional tests to t4014, to cover additional 
> cases of
>     +    the mutual exclusivity between different "git format-patch" 
> options.
> 
>          Signed-off-by: Dragan Simic <dsimic@manjaro.org>
> 
>     +
>     + ## Notes ##
>     +    This patch originates from my earlier patch series, [1] for 
> which
>     +    it was concluded to not be acceptable in its entirety. [2]
>     +
>     +    This version of the patch includes improvements based on the 
> valuable
>     +    and appreciated feedback from the reviewers:
>     +      - Improved and simplified the patch subject and patch 
> description, as
>     +        suggested by Eric Sunshine [3] and Kristoffer Haugsbakk 
> [4]
>     +      - Removed a redundant comment from the bugfix, as suggested 
> by Eric
>     +        Sunshine and Kristoffer Haugsbakk [5]
>     +      - Squashed the bugfix and the new tests into a single
> patch, for easier
>     +        reviewing, as suggested by Eric Sunshine [6]
>     +      - Improved the main new test, as suggested by Kristoffer
> Haugsbakk, [4]
>     +        and added validation of both stdout and stderr outputs
>     +      - Added a couple of more tests, to cover additional cases
> of the mutual
>     +        exclusivity of the available command-line options
>     +
>     +    [1]
> https://lore.kernel.org/git/b7568429acad91ff2d9a1574111441a3@manjaro.org/T/#mfcbbcf38e23698d09f524cc3b49ed1d855b90018
>     +    [2]
> https://lore.kernel.org/git/b7568429acad91ff2d9a1574111441a3@manjaro.org/T/#m9441b5486ca9229d5bfff9c2a92bc80eef341baf
>     +    [3]
> https://lore.kernel.org/git/CAPig+cTEp799w2-VEACYThW0COyo0SJLRS_sr-PG=LX++Tompw@mail.gmail.com/T/#u
>     +    [4]
> https://lore.kernel.org/git/e4aa5235-c6ad-45c7-930e-de991cc375f2@app.fastmail.com/T/#u
>     +    [5]
> https://lore.kernel.org/git/CAPig+cSGZr4zE=Dp7Z58CN0kmkpXdc8SOopXmB9=ry4gwNkq=w@mail.gmail.com/T/#u
>     +    [6]
> https://lore.kernel.org/git/CAPig+cRBjosyadQHO03fcCz7YBc=T04ytHkpt9UU87tLaiSOgw@mail.gmail.com/T/#u
>     +
>       ## builtin/log.c ##
>      @@ builtin/log.c: int cmd_format_patch(int argc, const char
> **argv, const char *prefix)
>       	if (cover_from_description_arg)
>       		cover_from_description_mode =
> parse_cover_from_description(cover_from_description_arg);
> 
>      -	if (rfc)
>     -+	/* Also mark the subject prefix as modified, for later checks */
>      +	if (rfc) {
>       		strbuf_insertstr(&sprefix, 0, "RFC ");
>      +		subject_prefix = 1;
>      +	}
> 
>       	if (reroll_count) {
>       		strbuf_addf(&sprefix, " v%s", reroll_count);
> 
>       ## t/t4014-format-patch.sh ##
>      @@ t/t4014-format-patch.sh: test_expect_success '--rfc is
> argument order independent' '
>       	test_cmp expect actual
>       '
> 
>     ++test_expect_success '--subject-prefix="<non-empty>" and -k
> cannot be used together' '
>     ++	echo "fatal: options '\''--subject-prefix/--rfc'\'' and
> '\''-k'\'' cannot be used together" >expect.err &&
>     ++	test_must_fail git format-patch -1 --stdout
> --subject-prefix="MYPREFIX" -k >actual.out 2>actual.err &&
>     ++	test_must_be_empty actual.out &&
>     ++	test_cmp expect.err actual.err
>     ++'
>     ++
>     ++test_expect_success '--subject-prefix="" and -k cannot be used 
> together' '
>     ++	echo "fatal: options '\''--subject-prefix/--rfc'\'' and
> '\''-k'\'' cannot be used together" >expect.err &&
>     ++	test_must_fail git format-patch -1 --stdout --subject-prefix=""
> -k >actual.out 2>actual.err &&
>     ++	test_must_be_empty actual.out &&
>     ++	test_cmp expect.err actual.err
>     ++'
>     ++
>      +test_expect_success '--rfc and -k cannot be used together' '
>     -+	test_must_fail git format-patch -1 --stdout --rfc -k >patch
>     ++	echo "fatal: options '\''--subject-prefix/--rfc'\'' and
> '\''-k'\'' cannot be used together" >expect.err &&
>     ++	test_must_fail git format-patch -1 --stdout --rfc -k
> >actual.out 2>actual.err &&
>     ++	test_must_be_empty actual.out &&
>     ++	test_cmp expect.err actual.err
>      +'
>      +
>       test_expect_success '--from=ident notices bogus ident' '
> 3:  1d9c6ce3df71 < -:  ------------ format-patch: new --resend option
> for adding "RESEND" to patch subjects
> 4:  42865d6c6694 < -:  ------------ t4014: add tests to cover --resend
> option and its exclusivity
> 
>  builtin/log.c           |  4 +++-
>  t/t4014-format-patch.sh | 21 +++++++++++++++++++++
>  2 files changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/builtin/log.c b/builtin/log.c
> index c0a8bb95e983..8bab30fcc70d 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -2050,8 +2050,10 @@ int cmd_format_patch(int argc, const char
> **argv, const char *prefix)
>  	if (cover_from_description_arg)
>  		cover_from_description_mode =
> parse_cover_from_description(cover_from_description_arg);
> 
> -	if (rfc)
> +	if (rfc) {
>  		strbuf_insertstr(&sprefix, 0, "RFC ");
> +		subject_prefix = 1;
> +	}
> 
>  	if (reroll_count) {
>  		strbuf_addf(&sprefix, " v%s", reroll_count);
> diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
> index e37a1411ee24..90fe6d066cc0 100755
> --- a/t/t4014-format-patch.sh
> +++ b/t/t4014-format-patch.sh
> @@ -1397,6 +1397,27 @@ test_expect_success '--rfc is argument order
> independent' '
>  	test_cmp expect actual
>  '
> 
> +test_expect_success '--subject-prefix="<non-empty>" and -k cannot be
> used together' '
> +	echo "fatal: options '\''--subject-prefix/--rfc'\'' and '\''-k'\''
> cannot be used together" >expect.err &&
> +	test_must_fail git format-patch -1 --stdout
> --subject-prefix="MYPREFIX" -k >actual.out 2>actual.err &&
> +	test_must_be_empty actual.out &&
> +	test_cmp expect.err actual.err
> +'
> +
> +test_expect_success '--subject-prefix="" and -k cannot be used 
> together' '
> +	echo "fatal: options '\''--subject-prefix/--rfc'\'' and '\''-k'\''
> cannot be used together" >expect.err &&
> +	test_must_fail git format-patch -1 --stdout --subject-prefix="" -k
> >actual.out 2>actual.err &&
> +	test_must_be_empty actual.out &&
> +	test_cmp expect.err actual.err
> +'
> +
> +test_expect_success '--rfc and -k cannot be used together' '
> +	echo "fatal: options '\''--subject-prefix/--rfc'\'' and '\''-k'\''
> cannot be used together" >expect.err &&
> +	test_must_fail git format-patch -1 --stdout --rfc -k >actual.out
> 2>actual.err &&
> +	test_must_be_empty actual.out &&
> +	test_cmp expect.err actual.err
> +'
> +
>  test_expect_success '--from=ident notices bogus ident' '
>  	test_must_fail git format-patch -1 --stdout --from=foo >patch
>  '
