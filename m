Return-Path: <SRS0=PG55=2K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 416BBC43603
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 22:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFBF221655
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 22:57:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LiSyAvy3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbfLTW5y (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Dec 2019 17:57:54 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55111 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbfLTW5y (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Dec 2019 17:57:54 -0500
Received: by mail-wm1-f65.google.com with SMTP id b19so10466664wmj.4
        for <git@vger.kernel.org>; Fri, 20 Dec 2019 14:57:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sqvr4GBvOq0rNdgeXjxUoJWA4saxkErRxRqFY9iNJcc=;
        b=LiSyAvy3sf92gSLpRegMtd2WQUYodXxa8PT9iWJkJwPs1nguBQEybDGETRFTnaHUOX
         SP0s2s/T2/nhfO4371DBqBm+tEpioaBSy4jwSdufvpWoGUSdGOZWl/MX1uXvJq0hDDqv
         aX8CvaItJ1fuBvUDD8xHzf07hjZ+xktPvz4bIQll4PQR/tOP3Q5sUH6JKmlNZEPCWQiQ
         8gztPal+M4j665GY7CzIKgv4d8VwsuJfbtf762wgNgzu7UJzKin5ApRpaw6Ti7o9FZga
         QytJLYIe0kUNBFyGYzSlieqkSnV6uizcriCCetFXHlWLDQcoWj/riBfb5AhTk89ug7io
         5cug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sqvr4GBvOq0rNdgeXjxUoJWA4saxkErRxRqFY9iNJcc=;
        b=E/xVbyaZ0e3560q267pov5fux1fsOd+6sqxx91aEG+u3k8q449+58B33PPH3d/mXHk
         sf8O2uNKOcJ1YKHWYeo4TZL98AZPR3Y0WnQEdy8GxJ9D+/YIAH4hi80TxRDB5TkNamuE
         Yo+4ie9Ks4Myc8gVF4pzOb7Q+Ys9yG2kpU9KwWL+80FqB94hqVgR8Vw1NJ05PGDu0oWM
         cueYTBF6X5zmR6nOc+TuD7BzhGjbhxznfjcgf/NiAKmURNUyROnI0SgNqB3b0A/YwEHl
         0jMyJEiTpkkuc6/7kaSgI/Ukvd/1Bwvpplv5BQRivFHa3nP16lvOuqCTkYLr0euFHjM5
         3jKw==
X-Gm-Message-State: APjAAAU5HIBEVkqVy7oO+Wg5PgIxn5pFDNP+iRQjXzCBA2WtZIwB96cE
        V8vxmbd/l0eCF9CUaVQC7I7Y2s1e
X-Google-Smtp-Source: APXvYqzkpx4YjHu5PqKazojyfabeW5Q+k7+3hl7yG/aPNytAuaOO4j/uA4IDdNghWqYZzbhfnd/iEA==
X-Received: by 2002:a1c:81c9:: with SMTP id c192mr18744754wmd.44.1576882669319;
        Fri, 20 Dec 2019 14:57:49 -0800 (PST)
Received: from szeder.dev (x4db40310.dyn.telefonica.de. [77.180.3.16])
        by smtp.gmail.com with ESMTPSA id m7sm10261547wma.39.2019.12.20.14.57.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Dec 2019 14:57:48 -0800 (PST)
Date:   Fri, 20 Dec 2019 23:57:46 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Hans Jerry Illikainen <hji@dyntopia.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/1] gpg-interface: add minTrustLevel as a configuration
 option
Message-ID: <20191220225746.GF8609@szeder.dev>
References: <20191216153204.8906-1-hji@dyntopia.com>
 <20191216153204.8906-2-hji@dyntopia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191216153204.8906-2-hji@dyntopia.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 16, 2019 at 03:32:04PM +0000, Hans Jerry Illikainen wrote:
> Previously, signature verification for merge and pull operations checked
> if the key had a trust-level of either TRUST_NEVER or TRUST_UNDEFINED in
> verify_merge_signature().  If that was the case, the process die()d.
> 
> The other code paths that did signature verification relied entirely on
> the return code from check_commit_signature().  And signatures made with
> a good key, irregardless of its trust level, was considered valid by
> check_commit_signature().
> 
> This difference in behavior might induce users to erroneously assume
> that the trust level of a key in their keyring is always considered by
> Git, even for operations where it is not (e.g. during a verify-commit or
> verify-tag).
> 
> The way it worked was by gpg-interface.c storing the result from the
> key/signature status *and* the lowest-two trust levels in the `result`
> member of the signature_check structure (the last of these status lines
> that were encountered got written to `result`).  These are documented in
> GPG under the subsection `General status codes` and `Key related`,
> respectively [1].
> 
> The GPG documentation says the following on the TRUST_ status codes [1]:
> 
>     """
>     These are several similar status codes:
> 
>     - TRUST_UNDEFINED <error_token>
>     - TRUST_NEVER     <error_token>
>     - TRUST_MARGINAL  [0  [<validation_model>]]
>     - TRUST_FULLY     [0  [<validation_model>]]
>     - TRUST_ULTIMATE  [0  [<validation_model>]]
> 
>     For good signatures one of these status lines are emitted to
>     indicate the validity of the key used to create the signature.
>     The error token values are currently only emitted by gpgsm.
>     """
> 
> My interpretation is that the trust level is conceptionally different
> from the validity of the key and/or signature.  That seems to also have
> been the assumption of the old code in check_signature() where a result
> of 'G' (as in GOODSIG) and 'U' (as in TRUST_NEVER or TRUST_UNDEFINED)
> were both considered a success.
> 
> The two cases where a result of 'U' had special meaning were in
> verify_merge_signature() (where this caused git to die()) and in
> format_commit_one() (where it affected the output of the %G? format
> specifier).
> 
> I think it makes sense to refactor the processing of TRUST_ status lines
> such that users can configure a minimum trust level that is enforced
> globally, rather than have individual parts of git (e.g. merge) do it
> themselves.
> 
> I also think it makes sense to not store the trust level in the same
> struct member as the key/signature status.  While the presence of a
> TRUST_ status code does imply that the signature is good (see the first
> paragraph in the included snippet above), as far as I can tell, the
> order of the status lines from GPG isn't well-defined; thus it would
> seem plausible that the trust level could be overwritten with the
> key/signature status if they were stored in the same member of the
> signature_check structure.
> 
> This patch introduces a new configuration option: gpg.minTrustLevel.  It
> consolidates trust-level verification to gpg-interface.c and adds a new
> `trust_level` member to the signature_check structure.
> 
> Unfortunately, it breaks backward-compatibility in two ways:
> 
> 1. The default trust level is TRUST_UNDEFINED.  This is compatible with
>    the old behavior of every code path *except* for
>    verify_merge_signature() (since, again, it used to die()s on trust
>    levels below TRUST_MARGINAL).
> 
> 2. The %G? format specifier no longer includes 'U' for signatures made
>    with a key that is either TRUST_UNDEFINED or TRUST_NEVER.  Instead, a
>    new %GT format specifier is introduced that outputs the trust level
>    (as a complete string to avoid ambiguity with TRUST_UNDEFINED and
>    TRUST_ULTIMATE).
> 
> Another approach would have been to simply drop the trust-level
> requirement in verify_merge_signature().  This would also have made the
> behavior consistent with other parts of git that perform signature
> verification (and it would also have broken backward-compatibility #1).
> However, requiring a minimum trust level for signing keys does seem to
> have a real-world use-case.  For example, the build system used by the
> Qubes OS project currently parses the raw output from verify-tag in
> order to assert a minimum trust level for keys used to sign git tags
> [2].
> 
> [1] https://git.gnupg.org/cgi-bin/gitweb.cgi?p=gnupg.git;a=blob;f=doc/doc/DETAILS;h=bd00006e933ac56719b1edd2478ecd79273eae72;hb=refs/heads/master
> [2] https://github.com/QubesOS/qubes-builder/blob/9674c1991deef45b1a1b1c71fddfab14ba50dccf/scripts/verify-git-tag#L43

This patch causes several test failures:

  https://travis-ci.org/git/git/jobs/627909430#L2259

I see you've already posted an updated version, so I tried it locally,
and the same test scripts fail with the updated version as well.

I noticed that only Linux CI jobs failed, while the OSX jobs
succeeded.  Our Linux CI jobs (and my box) are based on Ubuntu 16.04,
and thus use GnuPG v1.4, while the OSX jobs use v2.something.  Not
sure that the version difference is connected to the test failures,
but I figured it's worth pointing out.

> Signed-off-by: Hans Jerry Illikainen <hji@dyntopia.com>
> ---
>  Documentation/config/gpg.txt       | 11 ++++
>  Documentation/pretty-formats.txt   |  2 +-
>  commit.c                           |  9 ++--
>  gpg-interface.c                    | 85 +++++++++++++++++++++++++-----
>  gpg-interface.h                    | 10 +++-
>  pretty.c                           | 20 ++++++-
>  t/t5573-pull-verify-signatures.sh  |  7 +++
>  t/t7510-signed-commit.sh           | 19 ++++++-
>  t/t7612-merge-verify-signatures.sh | 15 ++++++
>  9 files changed, 157 insertions(+), 21 deletions(-)
> 
> diff --git a/Documentation/config/gpg.txt b/Documentation/config/gpg.txt
> index cce2c89245..030311fce3 100644
> --- a/Documentation/config/gpg.txt
> +++ b/Documentation/config/gpg.txt
> @@ -18,3 +18,14 @@ gpg.<format>.program::
>  	chose. (see `gpg.program` and `gpg.format`) `gpg.program` can still
>  	be used as a legacy synonym for `gpg.openpgp.program`. The default
>  	value for `gpg.x509.program` is "gpgsm".
> +
> +gpg.minTrustLevel::
> +	Specifies a minimum trust level for signature verification.  The
> +	default value is "undefined".  Supported values (in increasing
> +	order of significance):
> ++
> +* `undefined`
> +* `never`
> +* `marginal`
> +* `fully`
> +* `ultimate`
> diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
> index 1a7212ce5a..f2e74241fe 100644
> --- a/Documentation/pretty-formats.txt
> +++ b/Documentation/pretty-formats.txt
> @@ -215,7 +215,6 @@ endif::git-rev-list[]
>  '%GG':: raw verification message from GPG for a signed commit
>  '%G?':: show "G" for a good (valid) signature,
>  	"B" for a bad signature,
> -	"U" for a good signature with unknown validity,
>  	"X" for a good signature that has expired,
>  	"Y" for a good signature made by an expired key,
>  	"R" for a good signature made by a revoked key,
> @@ -226,6 +225,7 @@ endif::git-rev-list[]
>  '%GF':: show the fingerprint of the key used to sign a signed commit
>  '%GP':: show the fingerprint of the primary key whose subkey was used
>  	to sign a signed commit
> +'%GT':: show the trust level for the key used to sign a signed commit
>  '%gD':: reflog selector, e.g., `refs/stash@{1}` or `refs/stash@{2
>  	minutes ago}`; the format follows the rules described for the
>  	`-g` option. The portion before the `@` is the refname as
> diff --git a/commit.c b/commit.c
> index 434ec030d6..f6d3ce4a6e 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -1140,17 +1140,18 @@ void verify_merge_signature(struct commit *commit, int verbosity)
>  {
>  	char hex[GIT_MAX_HEXSZ + 1];
>  	struct signature_check signature_check;
> +	int ret;
>  	memset(&signature_check, 0, sizeof(signature_check));
>  
> -	check_commit_signature(commit, &signature_check);
> +	ret = check_commit_signature(commit, &signature_check);
>  
>  	find_unique_abbrev_r(hex, &commit->object.oid, DEFAULT_ABBREV);
>  	switch (signature_check.result) {
>  	case 'G':
> +		if (ret)
> +			die(_("Commit %s has an untrusted GPG signature, "
> +			      "allegedly by %s."), hex, signature_check.signer);
>  		break;
> -	case 'U':
> -		die(_("Commit %s has an untrusted GPG signature, "
> -		      "allegedly by %s."), hex, signature_check.signer);
>  	case 'B':
>  		die(_("Commit %s has a bad GPG signature "
>  		      "allegedly by %s."), hex, signature_check.signer);
> diff --git a/gpg-interface.c b/gpg-interface.c
> index 5134ce2780..f7b11480fb 100644
> --- a/gpg-interface.c
> +++ b/gpg-interface.c
> @@ -7,6 +7,8 @@
>  #include "tempfile.h"
>  
>  static char *configured_signing_key;
> +static enum signature_trust_level configured_min_trust_level = TRUST_UNDEFINED;
> +
>  struct gpg_format {
>  	const char *name;
>  	const char *program;
> @@ -85,6 +87,8 @@ void signature_check_clear(struct signature_check *sigc)
>  #define GPG_STATUS_UID		(1<<2)
>  /* The status includes key fingerprints */
>  #define GPG_STATUS_FINGERPRINT	(1<<3)
> +/* The status includes trust level */
> +#define GPG_STATUS_TRUST_LEVEL	(1<<4)
>  
>  /* Short-hand for standard exclusive *SIG status with keyid & UID */
>  #define GPG_STATUS_STDSIG	(GPG_STATUS_EXCLUSIVE|GPG_STATUS_KEYID|GPG_STATUS_UID)
> @@ -96,13 +100,23 @@ static struct {
>  } sigcheck_gpg_status[] = {
>  	{ 'G', "GOODSIG ", GPG_STATUS_STDSIG },
>  	{ 'B', "BADSIG ", GPG_STATUS_STDSIG },
> -	{ 'U', "TRUST_NEVER", 0 },
> -	{ 'U', "TRUST_UNDEFINED", 0 },
>  	{ 'E', "ERRSIG ", GPG_STATUS_EXCLUSIVE|GPG_STATUS_KEYID },
>  	{ 'X', "EXPSIG ", GPG_STATUS_STDSIG },
>  	{ 'Y', "EXPKEYSIG ", GPG_STATUS_STDSIG },
>  	{ 'R', "REVKEYSIG ", GPG_STATUS_STDSIG },
>  	{ 0, "VALIDSIG ", GPG_STATUS_FINGERPRINT },
> +	{ 0, "TRUST_", GPG_STATUS_TRUST_LEVEL },
> +};
> +
> +static struct {
> +	const char *key;
> +	enum signature_trust_level value;
> +} sigcheck_gpg_trust_level[] = {
> +	{ "UNDEFINED", TRUST_UNDEFINED },
> +	{ "NEVER", TRUST_NEVER },
> +	{ "MARGINAL", TRUST_MARGINAL },
> +	{ "FULLY", TRUST_FULLY },
> +	{ "ULTIMATE", TRUST_ULTIMATE },
>  };
>  
>  static void replace_cstring(char **field, const char *line, const char *next)
> @@ -115,10 +129,25 @@ static void replace_cstring(char **field, const char *line, const char *next)
>  		*field = NULL;
>  }
>  
> +static int parse_gpg_trust_level(const char *level,
> +				 enum signature_trust_level *res)
> +{
> +	size_t i;
> +
> +	for (i = 0; i < ARRAY_SIZE(sigcheck_gpg_trust_level); i++) {
> +		if (!strcmp(sigcheck_gpg_trust_level[i].key, level)) {
> +			*res = sigcheck_gpg_trust_level[i].value;
> +			return 0;
> +		}
> +	}
> +	return 1;
> +}
> +
>  static void parse_gpg_output(struct signature_check *sigc)
>  {
>  	const char *buf = sigc->gpg_status;
>  	const char *line, *next;
> +	char *trust;
>  	int i, j;
>  	int seen_exclusive_status = 0;
>  
> @@ -136,9 +165,18 @@ static void parse_gpg_output(struct signature_check *sigc)
>  		/* Iterate over all search strings */
>  		for (i = 0; i < ARRAY_SIZE(sigcheck_gpg_status); i++) {
>  			if (skip_prefix(line, sigcheck_gpg_status[i].check, &line)) {
> +				/*
> +				 * GOODSIG, BADSIG etc. can occur only once for
> +				 * each signature.  Therefore, if we had more
> +				 * than one then we're dealing with multiple
> +				 * signatures.  We don't support them
> +				 * currently, and they're rather hard to
> +				 * create, so something is likely fishy and we
> +				 * should reject them altogether.
> +				 */
>  				if (sigcheck_gpg_status[i].flags & GPG_STATUS_EXCLUSIVE) {
>  					if (seen_exclusive_status++)
> -						goto found_duplicate_status;
> +						goto error;
>  				}
>  
>  				if (sigcheck_gpg_status[i].result)
> @@ -154,6 +192,18 @@ static void parse_gpg_output(struct signature_check *sigc)
>  						replace_cstring(&sigc->signer, line, next);
>  					}
>  				}
> +
> +				/* Do we have trust level? */
> +				if (sigcheck_gpg_status[i].flags & GPG_STATUS_TRUST_LEVEL) {
> +					next = strchrnul(line, ' ');
> +					trust = xmemdupz(line, next - line);
> +					if (parse_gpg_trust_level(trust, &sigc->trust_level)) {
> +						free(trust);
> +						goto error;
> +					}
> +					free(trust);
> +				}
> +
>  				/* Do we have fingerprint? */
>  				if (sigcheck_gpg_status[i].flags & GPG_STATUS_FINGERPRINT) {
>  					const char *limit;
> @@ -191,14 +241,7 @@ static void parse_gpg_output(struct signature_check *sigc)
>  	}
>  	return;
>  
> -found_duplicate_status:
> -	/*
> -	 * GOODSIG, BADSIG etc. can occur only once for each signature.
> -	 * Therefore, if we had more than one then we're dealing with multiple
> -	 * signatures.  We don't support them currently, and they're rather
> -	 * hard to create, so something is likely fishy and we should reject
> -	 * them altogether.
> -	 */
> +error:
>  	sigc->result = 'E';
>  	/* Clear partial data to avoid confusion */
>  	FREE_AND_NULL(sigc->primary_key_fingerprint);
> @@ -264,6 +307,7 @@ int check_signature(const char *payload, size_t plen, const char *signature,
>  	int status;
>  
>  	sigc->result = 'N';
> +	sigc->trust_level = -1;
>  
>  	status = verify_signed_buffer(payload, plen, signature, slen,
>  				      &gpg_output, &gpg_status);
> @@ -273,7 +317,8 @@ int check_signature(const char *payload, size_t plen, const char *signature,
>  	sigc->gpg_output = strbuf_detach(&gpg_output, NULL);
>  	sigc->gpg_status = strbuf_detach(&gpg_status, NULL);
>  	parse_gpg_output(sigc);
> -	status |= sigc->result != 'G' && sigc->result != 'U';
> +	status |= sigc->result != 'G';
> +	status |= sigc->trust_level < configured_min_trust_level;
>  
>   out:
>  	strbuf_release(&gpg_status);
> @@ -320,6 +365,8 @@ int git_gpg_config(const char *var, const char *value, void *cb)
>  {
>  	struct gpg_format *fmt = NULL;
>  	char *fmtname = NULL;
> +	char *trust;
> +	int ret;
>  
>  	if (!strcmp(var, "user.signingkey")) {
>  		if (!value)
> @@ -339,6 +386,20 @@ int git_gpg_config(const char *var, const char *value, void *cb)
>  		return 0;
>  	}
>  
> +	if (!strcmp(var, "gpg.mintrustlevel")) {
> +		if (!value)
> +			return config_error_nonbool(var);
> +
> +		trust = xstrdup_toupper(value);
> +		ret = parse_gpg_trust_level(trust, &configured_min_trust_level);
> +		free(trust);
> +
> +		if (ret)
> +			return error("unsupported value for %s: %s", var,
> +				     value);
> +		return 0;
> +	}
> +
>  	if (!strcmp(var, "gpg.program") || !strcmp(var, "gpg.openpgp.program"))
>  		fmtname = "openpgp";
>  
> diff --git a/gpg-interface.h b/gpg-interface.h
> index 93cc3aff5c..f4e9b4f371 100644
> --- a/gpg-interface.h
> +++ b/gpg-interface.h
> @@ -7,6 +7,14 @@ struct strbuf;
>  #define GPG_VERIFY_RAW			2
>  #define GPG_VERIFY_OMIT_STATUS	4
>  
> +enum signature_trust_level {
> +	TRUST_UNDEFINED,
> +	TRUST_NEVER,
> +	TRUST_MARGINAL,
> +	TRUST_FULLY,
> +	TRUST_ULTIMATE,
> +};
> +
>  struct signature_check {
>  	char *payload;
>  	char *gpg_output;
> @@ -16,7 +24,6 @@ struct signature_check {
>  	 * possible "result":
>  	 * 0 (not checked)
>  	 * N (checked but no further result)
> -	 * U (untrusted good)
>  	 * G (good)
>  	 * B (bad)
>  	 */
> @@ -25,6 +32,7 @@ struct signature_check {
>  	char *key;
>  	char *fingerprint;
>  	char *primary_key_fingerprint;
> +	enum signature_trust_level trust_level;
>  };
>  
>  void signature_check_clear(struct signature_check *sigc);
> diff --git a/pretty.c b/pretty.c
> index 305e903192..0afe05714d 100644
> --- a/pretty.c
> +++ b/pretty.c
> @@ -1313,7 +1313,6 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
>  			case 'G':
>  			case 'B':
>  			case 'E':
> -			case 'U':
>  			case 'N':
>  			case 'X':
>  			case 'Y':
> @@ -1337,6 +1336,25 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
>  			if (c->signature_check.primary_key_fingerprint)
>  				strbuf_addstr(sb, c->signature_check.primary_key_fingerprint);
>  			break;
> +		case 'T':
> +			switch (c->signature_check.trust_level) {
> +			case TRUST_UNDEFINED:
> +				strbuf_addstr(sb, "undefined");
> +				break;
> +			case TRUST_NEVER:
> +				strbuf_addstr(sb, "never");
> +				break;
> +			case TRUST_MARGINAL:
> +				strbuf_addstr(sb, "marginal");
> +				break;
> +			case TRUST_FULLY:
> +				strbuf_addstr(sb, "fully");
> +				break;
> +			case TRUST_ULTIMATE:
> +				strbuf_addstr(sb, "ultimate");
> +				break;
> +			}
> +			break;
>  		default:
>  			return 0;
>  		}
> diff --git a/t/t5573-pull-verify-signatures.sh b/t/t5573-pull-verify-signatures.sh
> index 3e9876e197..d7d46d9382 100755
> --- a/t/t5573-pull-verify-signatures.sh
> +++ b/t/t5573-pull-verify-signatures.sh
> @@ -56,6 +56,13 @@ test_expect_success GPG 'pull commit with bad signature with --verify-signatures
>  
>  test_expect_success GPG 'pull commit with untrusted signature with --verify-signatures' '
>  	test_when_finished "git reset --hard && git checkout initial" &&
> +	git pull --ff-only --verify-signatures untrusted >pulloutput &&
> +	test_i18ngrep "has a good GPG signature" pulloutput
> +'
> +
> +test_expect_success GPG 'pull commit with untrusted signature with --verify-signatures and minTrustLevel' '
> +	test_when_finished "git reset --hard && git checkout initial" &&
> +	test_config gpg.minTrustLevel marginal &&
>  	test_must_fail git pull --ff-only --verify-signatures untrusted 2>pullerror &&
>  	test_i18ngrep "has an untrusted GPG signature" pullerror
>  '
> diff --git a/t/t7510-signed-commit.sh b/t/t7510-signed-commit.sh
> index 682b23a068..8ab29e80ce 100755
> --- a/t/t7510-signed-commit.sh
> +++ b/t/t7510-signed-commit.sh
> @@ -109,6 +109,21 @@ test_expect_success GPG 'verify-commit exits success on untrusted signature' '
>  	grep "not certified" actual
>  '
>  
> +test_expect_success GPG 'verify-commit exits success with matching minTrustLevel' '
> +	test_config gpg.minTrustLevel ultimate &&
> +	git verify-commit sixth-signed
> +'
> +
> +test_expect_success GPG 'verify-commit exits success with low minTrustLevel' '
> +	test_config gpg.minTrustLevel fully &&
> +	git verify-commit sixth-signed
> +'
> +
> +test_expect_success GPG 'verify-commit exits failure with high minTrustLevel' '
> +	test_config gpg.minTrustLevel ultimate &&
> +	test_must_fail git verify-commit eighth-signed-alt
> +'
> +
>  test_expect_success GPG 'verify signatures with --raw' '
>  	(
>  		for commit in initial second merge fourth-signed fifth-signed sixth-signed seventh-signed
> @@ -209,13 +224,13 @@ test_expect_success GPG 'show bad signature with custom format' '
>  
>  test_expect_success GPG 'show untrusted signature with custom format' '
>  	cat >expect <<-\EOF &&
> -	U
> +	undefined
>  	65A0EEA02E30CAD7
>  	Eris Discordia <discord@example.net>
>  	F8364A59E07FFE9F4D63005A65A0EEA02E30CAD7
>  	D4BE22311AD3131E5EDA29A461092E85B7227189
>  	EOF
> -	git log -1 --format="%G?%n%GK%n%GS%n%GF%n%GP" eighth-signed-alt >actual &&
> +	git log -1 --format="%GT%n%GK%n%GS%n%GF%n%GP" eighth-signed-alt >actual &&
>  	test_cmp expect actual
>  '
>  
> diff --git a/t/t7612-merge-verify-signatures.sh b/t/t7612-merge-verify-signatures.sh
> index d99218a725..5a8e9afd8e 100755
> --- a/t/t7612-merge-verify-signatures.sh
> +++ b/t/t7612-merge-verify-signatures.sh
> @@ -62,6 +62,13 @@ test_expect_success GPG 'merge commit with bad signature with merge.verifySignat
>  
>  test_expect_success GPG 'merge commit with untrusted signature with verification' '
>  	test_when_finished "git reset --hard && git checkout initial" &&
> +	git merge --ff-only --verify-signatures side-untrusted >mergeoutput &&
> +	test_i18ngrep "has a good GPG signature" mergeoutput
> +'
> +
> +test_expect_success GPG 'merge commit with untrusted signature with verification and minTrustLevel' '
> +	test_when_finished "git reset --hard && git checkout initial" &&
> +	test_config gpg.minTrustLevel marginal &&
>  	test_must_fail git merge --ff-only --verify-signatures side-untrusted 2>mergeerror &&
>  	test_i18ngrep "has an untrusted GPG signature" mergeerror
>  '
> @@ -69,6 +76,14 @@ test_expect_success GPG 'merge commit with untrusted signature with verification
>  test_expect_success GPG 'merge commit with untrusted signature with merge.verifySignatures=true' '
>  	test_when_finished "git reset --hard && git checkout initial" &&
>  	test_config merge.verifySignatures true &&
> +	git merge --ff-only side-untrusted >mergeoutput &&
> +	test_i18ngrep "has a good GPG signature" mergeoutput
> +'
> +
> +test_expect_success GPG 'merge commit with untrusted signature with merge.verifySignatures=true and minTrustLevel' '
> +	test_when_finished "git reset --hard && git checkout initial" &&
> +	test_config merge.verifySignatures true &&
> +	test_config gpg.minTrustLevel marginal &&
>  	test_must_fail git merge --ff-only side-untrusted 2>mergeerror &&
>  	test_i18ngrep "has an untrusted GPG signature" mergeerror
>  '
> -- 
> 2.24.1.485.gad05a3d8e5.dirty
> 
