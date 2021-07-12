Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6CB7C07E99
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 17:18:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C8E26120A
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 17:18:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234973AbhGLRVL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jul 2021 13:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbhGLRVK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jul 2021 13:21:10 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 190A4C0613DD
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 10:18:22 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id he13so35979994ejc.11
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 10:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=bF8sXgFRQTO32xsy5W01uwWwT6KZ5Pz39HNEYvyd0y4=;
        b=ezGH0fiiUmbGSlk7eJS9bGEedeMN66vvNq+meTCP2FeQvl3HcD+n/T4p+gCNw/UAXR
         DPIVyACLT3FLH9bZIvk4hTlH2Y+gZqjyK1S0C+Bv823T451HVAxC6JfhqVPezTT7xtIg
         s7n56p3fDlyof1IlwYOIBAIVaG9oSgjBZS0hRwYm7QnKoVOR+5jDlR7nEXKBxcdGsq+U
         /kESbT4md8bkYZ+iN6NgILdUp3sMmG8mP8hxbcnj0V6AFyo80XsagmbnP+i6xTG/rkPE
         8Wh+Cr4ogllF1CzO7S0nwBhN75+zcrqzZ6tGjjYm8DY7PMbNdeaTJz3BQf19ZQeSeGRo
         h6bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=bF8sXgFRQTO32xsy5W01uwWwT6KZ5Pz39HNEYvyd0y4=;
        b=AuYEgXIt7IKR1bp8G2YSTucIl5o5NayXyiQbS+gPg+PgojFoCMc7FQAd/m5Rutx/ok
         LPHauQYcB/GelzuJ3WXQl3pjSf/zZgOX8gFl25/ZQHUH0Qj++E0yIeMRMAdh/bj1CmJq
         K2/ErbKWdf8XWb1QAEgGYVofs8bo3PGukThmQV+9JYKlY7sdB1wcdT3oDSzC9ynUNEhI
         Nwn6U9OgDG+FEuXpGf84uRisBWx1Y+JDjtxY5toc9ZsaD9VxPcKYmqf/CV7FPaTMsTWH
         sUhs7y90ikNxlFC/3/WJSwxMBRO382ttoLMwB6RHtfvwWj1kklZsLsswpjP76cSRlezr
         pw8w==
X-Gm-Message-State: AOAM5303dbfH8Tgr2V86InqfRDpqZRHzE3vsI/Kp8aZVHVx6UTman9gX
        G273dDmfgz4dcjpdvt6rdlGu7eYZWehLJJxJ
X-Google-Smtp-Source: ABdhPJxXXfuZcKqBltaYdOpyc/C0QlDCh320dNAzWmYo5LFYCBT0VDoMKXqM4JmfS0h01Bt9weOljQ==
X-Received: by 2002:a17:906:f2d7:: with SMTP id gz23mr161451ejb.314.1626110300359;
        Mon, 12 Jul 2021 10:18:20 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id c6sm8023871ede.17.2021.07.12.10.18.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 10:18:19 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Fabian Stelzer via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Hans Jerry Illikainen <hji@dyntopia.com>,
        Fabian Stelzer <fs@gigacodes.de>
Subject: Re: [PATCH v2] Add commit, tag & push signing/verification via SSH
 keys using ssh-keygen
Date:   Mon, 12 Jul 2021 18:55:02 +0200
References: <pull.1041.git.git.1625559593910.gitgitgadget@gmail.com>
 <pull.1041.v2.git.git.1626092359713.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <pull.1041.v2.git.git.1626092359713.gitgitgadget@gmail.com>
Message-ID: <87y2ab30yr.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jul 12 2021, Fabian Stelzer via GitGitGadget wrote:

>  gpg.format::
>  	Specifies which key format to use when signing with `--gpg-sign`.
> -	Default is "openpgp" and another possible value is "x509".
> +	Default is "openpgp". Other possible values are "x509", "ssh".
>  
>  gpg.<format>.program::
>  	Use this to customize the program used for the signing format you
>  	chose. (see `gpg.program` and `gpg.format`) `gpg.program` can still
>  	be used as a legacy synonym for `gpg.openpgp.program`. The default
> -	value for `gpg.x509.program` is "gpgsm".
> +	value for `gpg.x509.program` is "gpgsm" and `gpg.ssh.program` is "ssh-keygen".
>  
>  gpg.minTrustLevel::
>  	Specifies a minimum trust level for signature verification.  If
> @@ -33,3 +33,34 @@ gpg.minTrustLevel::
>  * `marginal`
>  * `fully`
>  * `ultimate`
> +
> +gpg.ssh.keyring::
> +	A file containing all valid SSH public signing keys. 
> +	Similar to an .ssh/authorized_keys file.
> +	See ssh-keygen(1) "ALLOWED SIGNERS" for details.
> +	If a signing key is found in this file then the trust level will
> +	be set to "fully". Otherwise if the key is not present
> +	but the signature is still valid then the trust level will be "undefined".
> +
> +	This file can be set to a location outside of the repository
> +	and every developer maintains their own trust store.
> +	A central repository server could generate this file automatically
> +	from ssh keys with push	access to verify the code against.
> +	In a corporate setting this file is probably generated at a global location
> +	from some automation that already handles developer ssh keys. 
> +	
> +	A repository that is only allowing signed commits can store the file 
> +	in the repository itself using a relative path. This way only committers
> +	with an already valid key can add or change keys in the keyring.
> +
> +	Using a SSH CA key with the cert-authority option 
> +	(see ssh-keygen(1) "CERTIFICATES") is also valid.
> +
> +	To revoke a key place the public key without the principal into the 
> +	revocationKeyring.
> +
> +gpg.ssh.revocationKeyring::
> +	Either a SSH KRL or a list of revoked public keys (without the principal prefix).
> +	See ssh-keygen(1) for details.
> +	If a public key is found in this file then it will always be treated
> +	as having trust level "never" and signatures will show as invalid.
> diff --git a/Documentation/config/user.txt b/Documentation/config/user.txt
> index 59aec7c3aed..e71a099b8b8 100644
> --- a/Documentation/config/user.txt
> +++ b/Documentation/config/user.txt
> @@ -36,3 +36,9 @@ user.signingKey::
>  	commit, you can override the default selection with this variable.
>  	This option is passed unchanged to gpg's --local-user parameter,
>  	so you may specify a key using any method that gpg supports.
> +	If gpg.format is set to "ssh" this can contain the literal ssh public
> +	key (e.g.: "ssh-rsa XXXXXX identifier") or a file which contains it and 
> +	corresponds to the private key used for signing. The private key 
> +	needs to be available via ssh-agent. Alternatively it can be set to
> +	a file containing a private key directly. If not set git will call 
> +	"ssh-add -L" and try to use the first key available.
> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> index a34742513ac..fd790f7fd72 100644
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -131,6 +131,8 @@ static int receive_pack_config(const char *var, const char *value, void *cb)
>  {
>  	int status = parse_hide_refs_config(var, value, "receive");
>  
> +	git_gpg_config(var, value, NULL);
> +
>  	if (status)
>  		return status;
>  
> @@ -767,7 +769,7 @@ static void prepare_push_cert_sha1(struct child_process *proc)
>  		bogs = parse_signed_buffer(push_cert.buf, push_cert.len);
>  		check_signature(push_cert.buf, bogs, push_cert.buf + bogs,
>  				push_cert.len - bogs, &sigcheck);
> -
> +		

Stray whitespace change.

> +static void parse_ssh_output(struct signature_check *sigc)
> +{
> +	const char *output = NULL;
> +	char *next = NULL;
> +
> +	/* ssh-keysign output should be:
> +	 * Good "git" signature for PRINCIPAL with RSA key SHA256:FINGERPRINT
> +	 * or for valid but unknown keys:
> +	 * Good "git" signature with RSA key SHA256:FINGERPRINT
> +	 */

Style:

 /*
  * Comments like this
  */

Not /* Comments [...]

> +
> +	output = xmemdupz(sigc->output, strcspn(sigc->output, " \n"));
> +	if (skip_prefix(sigc->output, "Good \"git\" signature for ", &output)) {
> +		// Valid signature for a trusted signer

We don't use C99 comments, so /* ... */ (but perhaps we should nowadays,
but that's another topic...).

> +		sigc->result = 'G';
> +		sigc->trust_level = TRUST_FULLY;
> +
> +		next = strchrnul(output, ' '); // 'principal'
> +		replace_cstring(&sigc->signer, output, next);
> +		output = next + 1;
> +		next = strchrnul(output, ' '); // 'with'
> +		output = next + 1;
> +		next = strchrnul(output, ' '); // KEY Type
> +		output = next + 1;
> +		next = strchrnul(output, ' '); // 'key'
> +		output = next + 1;

FWIW for new code we'd probably use string_list_split() or
string_list_split_in_place() or strbuf_split_buf() or something, but I
see this is following the existing pattern in the file...

> +		next = strchrnul(output, '\n'); // key
>
> +		replace_cstring(&sigc->fingerprint, output, next);
> +		replace_cstring(&sigc->key, output, next);
> +	} else if (skip_prefix(sigc->output, "Good \"git\" signature with ", &output)) {
> +		// Valid signature, but key unknown
> +		sigc->result = 'G';
> +		sigc->trust_level = TRUST_UNDEFINED;
> +
> +		next = strchrnul(output, ' '); // KEY Type
> +		output = next + 1;
> +		next = strchrnul(output, ' '); // 'key'
> +		output = next + 1;
> +		next = strchrnul(output, '\n'); // key
> +		replace_cstring(&sigc->fingerprint, output, next);
> +		replace_cstring(&sigc->key, output, next);
> +	} else {
> +		sigc->result = 'B';
> +		sigc->trust_level = TRUST_NEVER;
> +	}
> +}
> +
>  static void parse_gpg_output(struct signature_check *sigc)
>  {
>  	const char *buf = sigc->gpg_status;
> @@ -257,16 +318,18 @@ error:
>  	FREE_AND_NULL(sigc->key);
>  }
>  
> -static int verify_signed_buffer(const char *payload, size_t payload_size,
> -				const char *signature, size_t signature_size,
> -				struct strbuf *gpg_output,
> -				struct strbuf *gpg_status)
> +static int verify_ssh_signature(struct signature_check *sigc, struct gpg_format *fmt,

We usually wrap at 80 characters, so since you're wrapping anyway...

> +	const char *payload, size_t payload_size,
> +	const char *signature, size_t signature_size)
>  {
> -	struct child_process gpg = CHILD_PROCESS_INIT;
> -	struct gpg_format *fmt;
> +	struct child_process ssh_keygen = CHILD_PROCESS_INIT;
>  	struct tempfile *temp;
>  	int ret;
> -	struct strbuf buf = STRBUF_INIT;
> +	const char *line;
> +	size_t trust_size;
> +	char *principal;
> +	struct strbuf ssh_keygen_out = STRBUF_INIT;
> +	struct strbuf ssh_keygen_err = STRBUF_INIT;
>  
>  	temp = mks_tempfile_t(".git_vtag_tmpXXXXXX");
>  	if (!temp)
> @@ -279,29 +342,125 @@ static int verify_signed_buffer(const char *payload, size_t payload_size,
>  		return -1;
>  	}
>  
> -	fmt = get_format_by_sig(signature);
> -	if (!fmt)
> -		BUG("bad signature '%s'", signature);
> +	// Find the principal from the  signers
> +	strvec_pushl(&ssh_keygen.args,  fmt->program,
> +					"-Y", "find-principals",
> +					"-f", get_ssh_allowed_signers(),
> +					"-s", temp->filename.buf,
> +					NULL);
> +	ret = pipe_command(&ssh_keygen, NULL, 0, &ssh_keygen_out, 0, &ssh_keygen_err, 0);
> +	if (strstr(ssh_keygen_err.buf, "unknown option")) {
> +		error(_("openssh version > 8.2p1 is needed for ssh signature verification (ssh-keygen needs -Y find-principals/verify option)"));
> +	}
> +	if (ret || !ssh_keygen_out.len) {
> +		// We did not find a matching principal in the keyring - Check without validation
> +		child_process_init(&ssh_keygen);
> +		strvec_pushl(&ssh_keygen.args,  fmt->program,
> +						"-Y", "check-novalidate",
> +						"-n", "git",
> +						"-s", temp->filename.buf,
> +						NULL);
> +		ret = pipe_command(&ssh_keygen, payload, payload_size, &ssh_keygen_out, 0, &ssh_keygen_err, 0);
> +	} else {
> +		// Check every principal we found (one per line)
> +		for (line = ssh_keygen_out.buf; *line; line = strchrnul(line + 1, '\n')) {

Hrm, can't we use strbuf_getline() here with the underlying io_pump API
that pipe_command() uses, instead of slurping it all up, and then
splitting on '\n' ourselves? (I'm not sure)

> +			while (*line == '\n')
> +				line++;
> +			if (!*line)
> +				break;
> +
> +			trust_size = strcspn(line, " \n");
> +			principal = xmemdupz(line, trust_size);
> +
> +			child_process_init(&ssh_keygen);
> +			strbuf_release(&ssh_keygen_out);
> +			strbuf_release(&ssh_keygen_err);
> +			strvec_push(&ssh_keygen.args,fmt->program);
> +			// We found principals - Try with each until we find a match
> +			strvec_pushl(&ssh_keygen.args,  "-Y", "verify",
> +							//TODO: sprintf("-Overify-time=%s", commit->date...),
> +							"-n", "git",
> +							"-f", get_ssh_allowed_signers(),
> +							"-I", principal,
> +							"-s", temp->filename.buf,
> +							NULL);
> +
> +			if (ssh_revocation_file && file_exists(ssh_revocation_file)) {
> +				strvec_pushl(&ssh_keygen.args, "-r", ssh_revocation_file, NULL);

Do we want to silently ignore missing but configured revocation files?

> +			}
> +
> +			sigchain_push(SIGPIPE, SIG_IGN);
> +			ret = pipe_command(&ssh_keygen, payload, payload_size,
> +					&ssh_keygen_out, 0, &ssh_keygen_err, 0);
> +			sigchain_pop(SIGPIPE);
> +
> +			ret &= starts_with(ssh_keygen_out.buf, "Good");
> +			if (ret == 0)
> +				break;
> +		}
> +	}
> +
> +	sigc->payload = xmemdupz(payload, payload_size);
> +	strbuf_stripspace(&ssh_keygen_out, 0);
> +	strbuf_stripspace(&ssh_keygen_err, 0);
> +	strbuf_add(&ssh_keygen_out, ssh_keygen_err.buf, ssh_keygen_err.len);
> +	sigc->output = strbuf_detach(&ssh_keygen_out, NULL);
> +
> +	//sigc->gpg_output = strbuf_detach(&ssh_keygen_err, NULL); // This flip around is broken...

Broken how? And why the commented-out code as part of the patch?

> -	status = verify_signed_buffer(payload, plen, signature, slen,
> -				      &gpg_output, &gpg_status);
> -	if (status && !gpg_output.len)
> -		goto out;
> -	sigc->payload = xmemdupz(payload, plen);
> -	sigc->gpg_output = strbuf_detach(&gpg_output, NULL);
> -	sigc->gpg_status = strbuf_detach(&gpg_status, NULL);
> -	parse_gpg_output(sigc);
> +	fmt = get_format_by_sig(signature);
> +	if (!fmt)
> +		BUG("bad signature '%s'", signature);

So if we run this from receive-pack or whatever we'll BUG() out? I.e. I
think this should be an fsck check or something, but not a BUG(), or
does this not rely on potentially bad object-store state?

> +static char *get_ssh_key_fingerprint(const char *signing_key) {
> +	struct child_process ssh_keygen = CHILD_PROCESS_INIT;
> +	int ret = -1;
> +	struct strbuf fingerprint_stdout = STRBUF_INIT;
> +	struct strbuf **fingerprint;
> +
> +	/* For SSH Signing this can contain a filename or a public key
> +	* For textual representation we usually want a fingerprint
> +	*/
> +	if (istarts_with(signing_key, "ssh-")) {
> +		strvec_pushl(&ssh_keygen.args, "ssh-keygen",
> +					"-lf", "-",
> +					NULL);
> +		ret = pipe_command(&ssh_keygen, signing_key, strlen(signing_key), &fingerprint_stdout, 0,  NULL, 0);
> +	} else {
> +		strvec_pushl(&ssh_keygen.args, "ssh-keygen",
> +					"-lf", configured_signing_key,
> +					NULL);
> +		ret = pipe_command(&ssh_keygen, NULL, 0, &fingerprint_stdout, 0, NULL, 0);
> +		if (!!ret)
> +			die_errno(_("failed to get the ssh fingerprint for key '%s'"), signing_key);
> +		fingerprint = strbuf_split_max(&fingerprint_stdout, ' ', 3);
> +		if (fingerprint[1]) {
> +			return strbuf_detach(fingerprint[1], NULL);
> +		}
> +	}
> +	die_errno(_("failed to get the ssh fingerprint for key '%s'"), signing_key);
> +}

Her you declare a ret that's not used at all in the "istarts_with"
branch, and we fall through to die_errno()?

[I stopped reading mostly at this point]

> [...]
> +# test_expect_success GPGSSH 'detect fudged commit with double signature' '
> +# 	sed -e "/gpgsig/,/END PGP/d" forged1 >double-base &&
> +# 	sed -n -e "/gpgsig/,/END PGP/p" forged1 | \
> +# 		sed -e "s/^$(test_oid header)//;s/^ //" | gpg --dearmor >double-sig1.sig &&
> +# 	gpg -o double-sig2.sig -u 29472784 --detach-sign double-base &&
> +# 	cat double-sig1.sig double-sig2.sig | gpg --enarmor >double-combined.asc &&
> +# 	sed -e "s/^\(-.*\)ARMORED FILE/\1SIGNATURE/;1s/^/$(test_oid header) /;2,\$s/^/ /" \
> +# 		double-combined.asc > double-gpgsig &&
> +# 	sed -e "/committer/r double-gpgsig" double-base >double-commit &&
> +# 	git hash-object -w -t commit double-commit >double-commit.commit &&
> +# 	test_must_fail git verify-commit $(cat double-commit.commit) &&
> +# 	git show --pretty=short --show-signature $(cat double-commit.commit) >double-actual &&
> +# 	grep "BAD signature from" double-actual &&
> +# 	grep "Good signature from" double-actual
> +# '
> +
> +# test_expect_success GPGSSH 'show double signature with custom format' '
> +# 	cat >expect <<-\EOF &&
> +# 	E
> +
> +
> +
> +
> +# 	EOF
> +# 	git log -1 --format="%G?%n%GK%n%GS%n%GF%n%GP" $(cat double-commit.commit) >actual &&
> +# 	test_cmp expect actual
> +# '

Perhaps you're looking for test_expect_failure for TODO tests?

I think this patch is *way* past the point of benefitting from being
split into a patch series. It grew from ~200 lines added to ~1k.
