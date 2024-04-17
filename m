Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840DA2C9A
	for <git@vger.kernel.org>; Wed, 17 Apr 2024 00:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.110.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713312183; cv=none; b=GlkLQbFQA8MDr0/j2KEsAEFoHetr0Quw+rOkF0Gh1CWHaHUKQWllWgOT6VNqkz7utfgpmY8TVgaCDmQAEC5Fd+ul9odcCHn20vU2JNxSmIR1bdLjWoHWxJjxRyusn8Nae/KNnJsh6aXbBafczObxLP/m/+Ggerc0CkeFJqRU51A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713312183; c=relaxed/simple;
	bh=HyRf5wjEBXc1r6bcycyCi0YhOBVc+4RxkRuWY1vmj5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lagucDAYab0fUOIGYWiC041HTLOWkypjXRy5wy7iNNvP9jo9zVreB9qwtCNo6VCjx7BVJx4PeCqSnLQeauSBujAa7+g/n4k0kLAkKAIzaPXkw2EZCcj7XEDnwBfx0sxl0iw6foiwgbw0XJLlzgtlgeHuC89scQqvbBRaR2Z0sMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=KnK4e0Ce; arc=none smtp.client-ip=172.105.110.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="KnK4e0Ce"
Received: from tapette.tailf784c.ts.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by ring.crustytoothpaste.net (Postfix) with ESMTPSA id D62F85D4E0;
	Wed, 17 Apr 2024 00:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1713312176;
	bh=HyRf5wjEBXc1r6bcycyCi0YhOBVc+4RxkRuWY1vmj5A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=KnK4e0CeCe+Rr4ZDRlAIGd2MzzV/DkuDbSx+qPx/UtIqEjX1q2SNxhno0UbarotWi
	 ZICjgtjGupj/6YCsr4M/4Whu+XKHVEQxjtP458gu2PlsvjBWD3ccSOv+2J04zvY030
	 PEMUrXbi0hsnhJtmRebOzaO611LE9l7kjEWeLAPVANLU9ff/yev+ZXfLfTss5dMpYp
	 TFDwcItFNnoL/l3WWHWzNq9epLHc+WCG2uYjG56ndmOazdYiXXrmzq/GMakFAQ3Q6Z
	 MReWZloVHZqTY8DT8uZtA4hU+95YloiAgLkvM6Js59VkyMKYEB6teMSIlzMEjZH2RC
	 r5FavHxdI3jL760ezeJ4dL0B1jHn2M32kIGFcdioENKpfSvuj1KJW64y3/KOoUnBpJ
	 M8FQwwGcWsjZuWPs7gSRNrrGHHh0IaEEtxIPYmegIavMfy0MBYSEYCmVNQMiKeWzej
	 ZfhW7bSCjK5uvqRdzEhfsoypxXI8e57VQUC9Z3KY6s0YrNbCAnC
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthew John Cheetham <mjcheetham@outlook.com>,
	M Hickford <mirth.hickford@gmail.com>,
	Jeff King <peff@peff.net>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 00/16] Support for arbitrary schemes in credentials
Date: Wed, 17 Apr 2024 00:02:24 +0000
Message-ID: <20240417000240.3611948-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.43.0.381.gb435a96ce8
In-Reply-To: <20240324011301.1553072-1-sandals@crustytoothpaste.net>
References: <20240324011301.1553072-1-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series introduces support for multiple schemes into the credential
helper protocol and Git (currently only for HTTP) so that we can support
other types of authentication, such as Bearer, that libcurl doesn't
support natively.  Special consideration has been given to making this
functionality work for external users of `git credential`.

For the truly gory details, please see v1's cover letter.

Changes from v1:
* Add support for indicating that a credential is ephemeral.
* Add support for the authtype capability to git credential-cache.
* Fix a bug where credential helpers might not be passed the capability
  correctly.
* Add a method for querying capabilities from `git credential` and
  helpers, giving due consideration to gracefully handling simple shell
  scripts as credential helpers.
* Remove `strvec_swap` in favour of `SWAP`.
* Add support for testing authtype support in credential helpers.
* Fix a bug in the test that caused errors with bash.
* Use an enum instead of define constants for credential stages.
* Documentation improvements.
* Possibly other cleanups and fixes mentioned in review which I have
  forgotten about fixing by now.

brian m. carlson (16):
  credential: add an authtype field
  remote-curl: reset headers on new request
  http: use new headers for each object request
  credential: add a field for pre-encoded credentials
  credential: gate new fields on capability
  credential: add a field called "ephemeral"
  docs: indicate new credential protocol fields
  http: add support for authtype and credential
  credential: add an argument to keep state
  credential: enable state capability
  docs: set a limit on credential line length
  t5563: refactor for multi-stage authentication
  credential: add support for multistage credential rounds
  t: add credential tests for authtype
  credential-cache: implement authtype capability
  credential: add method for querying capabilities

 Documentation/git-credential.txt   | 104 +++++++++-
 builtin/credential-cache--daemon.c |  22 ++-
 builtin/credential-cache.c         |  10 +
 builtin/credential-store.c         |   2 +-
 builtin/credential.c               |  15 +-
 credential.c                       | 138 ++++++++++++-
 credential.h                       |  92 ++++++++-
 http.c                             | 129 +++++++-----
 http.h                             |   5 +
 imap-send.c                        |   2 +-
 remote-curl.c                      |  14 +-
 t/lib-credential.sh                | 123 ++++++++++++
 t/lib-httpd/nph-custom-auth.sh     |  17 +-
 t/t0300-credentials.sh             | 165 +++++++++++++++-
 t/t0301-credential-cache.sh        |   1 +
 t/t5563-simple-http-auth.sh        | 308 +++++++++++++++++++++++++----
 16 files changed, 1026 insertions(+), 121 deletions(-)

Range-diff against v1:
 1:  ac2507fabb =  1:  ac2507fabb credential: add an authtype field
 2:  f1f3367826 =  2:  f1f3367826 remote-curl: reset headers on new request
 3:  1cccbc9d8b !  3:  cd3b1a8c3a http: use new headers for each object request
    @@ http.c: void http_cleanup(void)
      
     -	curl_slist_free_all(no_pragma_header);
     -	no_pragma_header = NULL;
    - 
    +-
      	curl_slist_free_all(host_resolutions);
      	host_resolutions = NULL;
    + 
     @@ http.c: void release_http_pack_request(struct http_pack_request *preq)
      	}
      	preq->slot = NULL;
 4:  a88e6b26c8 =  4:  7b88a32294 credential: add a field for pre-encoded credentials
 5:  e0df6734a3 !  5:  912d06b70b credential: gate new fields on capability
    @@ Commit message
         internal user, then we know about all capabilities and will request
         them.
     
    +    For "git credential approve" and "git credential reject", we set the
    +    helper capability before calling the helper, since we assume that the
    +    input we're getting from the external program comes from a previous call
    +    to "git credential fill", and thus we'll invoke send a capability to the
    +    helper if and only if we got one from the standard input, which is the
    +    correct behavior.
    +
         Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
     
      ## builtin/credential-cache--daemon.c ##
    @@ builtin/credential.c: int cmd_credential(int argc, const char **argv, const char
     +		credential_fill(&c, 0);
     +		credential_write(&c, stdout, CREDENTIAL_OP_RESPONSE);
      	} else if (!strcmp(op, "approve")) {
    ++		credential_set_all_capabilities(&c, CREDENTIAL_OP_HELPER);
      		credential_approve(&c);
      	} else if (!strcmp(op, "reject")) {
    ++		credential_set_all_capabilities(&c, CREDENTIAL_OP_HELPER);
    + 		credential_reject(&c);
    + 	} else {
    + 		usage(usage_msg);
     
      ## credential.c ##
     @@ credential.c: void credential_clear(struct credential *c)
      	credential_init(c);
      }
      
    -+static void credential_set_all_capabilities(struct credential *c)
    -+{
    -+	c->capa_authtype.request_initial = 1;
    -+}
    -+
    - int credential_match(const struct credential *want,
    - 		     const struct credential *have, int match_password)
    - {
    -@@ credential.c: static void credential_getpass(struct credential *c)
    - 						 PROMPT_ASKPASS);
    - }
    - 
    --int credential_read(struct credential *c, FILE *fp)
    -+static void credential_set_capability(struct credential_capability *capa, int op_type)
    ++static void credential_set_capability(struct credential_capability *capa,
    ++				      enum credential_op_type op_type)
     +{
     +	switch (op_type) {
     +	case CREDENTIAL_OP_INITIAL:
    @@ credential.c: static void credential_getpass(struct credential *c)
     +	}
     +}
     +
    -+static int credential_has_capability(const struct credential_capability *capa, int op_type)
    ++
    ++void credential_set_all_capabilities(struct credential *c,
    ++				     enum credential_op_type op_type)
    ++{
    ++	credential_set_capability(&c->capa_authtype, op_type);
    ++}
    ++
    + int credential_match(const struct credential *want,
    + 		     const struct credential *have, int match_password)
    + {
    +@@ credential.c: static void credential_getpass(struct credential *c)
    + 						 PROMPT_ASKPASS);
    + }
    + 
    +-int credential_read(struct credential *c, FILE *fp)
    ++static int credential_has_capability(const struct credential_capability *capa,
    ++				     enum credential_op_type op_type)
     +{
     +	/*
     +	 * We're checking here if each previous step indicated that we had the
    @@ credential.c: static void credential_getpass(struct credential *c)
     +	}
     +}
     +
    -+int credential_read(struct credential *c, FILE *fp, int op_type)
    ++int credential_read(struct credential *c, FILE *fp,
    ++		    enum credential_op_type op_type)
      {
      	struct strbuf line = STRBUF_INIT;
      
    @@ credential.c: static void credential_write_item(FILE *fp, const char *key, const
      }
      
     -void credential_write(const struct credential *c, FILE *fp)
    -+void credential_write(const struct credential *c, FILE *fp, int op_type)
    ++void credential_write(const struct credential *c, FILE *fp,
    ++		      enum credential_op_type op_type)
      {
     +	if (credential_has_capability(&c->capa_authtype, op_type)) {
     +		credential_write_item(fp, "capability[]", "authtype", 0);
    @@ credential.c: void credential_fill(struct credential *c)
      
      	credential_apply_config(c);
     +	if (all_capabilities)
    -+		credential_set_all_capabilities(c);
    ++		credential_set_all_capabilities(c, CREDENTIAL_OP_INITIAL);
      
      	for (i = 0; i < c->helpers.nr; i++) {
      		credential_do(c, c->helpers.items[i].string, "get");
    @@ credential.h
     + * At each stage, we will emit the capability only if the previous stage
     + * supported it.
     + */
    -+#define CREDENTIAL_OP_INITIAL  1
    -+#define CREDENTIAL_OP_HELPER   2
    -+#define CREDENTIAL_OP_RESPONSE 3
    ++enum credential_op_type {
    ++	CREDENTIAL_OP_INITIAL  = 1,
    ++	CREDENTIAL_OP_HELPER   = 2,
    ++	CREDENTIAL_OP_RESPONSE = 3,
    ++};
     +
     +struct credential_capability {
     +	unsigned request_initial:1,
    @@ credential.h: void credential_approve(struct credential *);
      
     -int credential_read(struct credential *, FILE *);
     -void credential_write(const struct credential *, FILE *);
    -+int credential_read(struct credential *, FILE *, int);
    -+void credential_write(const struct credential *, FILE *, int);
    ++/**
    ++ * Enable all of the supported credential flags in this credential.
    ++ */
    ++void credential_set_all_capabilities(struct credential *c,
    ++				     enum credential_op_type op_type);
    ++
    ++int credential_read(struct credential *, FILE *,
    ++		    enum credential_op_type);
    ++void credential_write(const struct credential *, FILE *,
    ++		      enum credential_op_type);
      
      /*
       * Parse a url into a credential struct, replacing any existing contents.
    @@ t/t0300-credentials.sh: test_expect_success 'setup helper scripts' '
     +	credential=$1; shift
     +	. ./dump
     +	echo capability[]=authtype
    -+	test -z "${capability##*authtype*}" || return
    ++	test -z "${capability##*authtype*}" || exit 0
     +	test -z "$authtype" || echo authtype=$authtype
     +	test -z "$credential" || echo credential=$credential
     +	EOF
 -:  ---------- >  6:  f96183e273 credential: add a field called "ephemeral"
 6:  78fc8cdccf !  7:  efaab8eba4 docs: indicate new credential protocol fields
    @@ Documentation/git-credential.txt: empty string.
      
     +`authtype`::
     +	This indicates that the authentication scheme in question should be used.
    -+	Common values for HTTP and HTTPS include `basic`, `digest`, and `ntlm`,
    -+	although the latter two are insecure and should not be used.  If `credential`
    ++	Common values for HTTP and HTTPS include `basic`, `bearer`, and `digest`,
    ++	although the latter is insecure and should not be used.  If `credential`
     +	is used, this may be set to an arbitrary string suitable for the protocol in
     +	question (usually HTTP).
     ++
    @@ Documentation/git-credential.txt: empty string.
     +`credential`::
     +	The pre-encoded credential, suitable for the protocol in question (usually
     +	HTTP).  If this key is sent, `authtype` is mandatory, and `username` and
    -+	`password` are not used.
    ++	`password` are not used.  For HTTP, Git concatenates the `authtype` value and
    ++	this value with a single space to determine the `Authorization` header.
    +++
    ++This value should not be sent unless the appropriate capability (see below) is
    ++provided on input.
    ++
    ++`ephemeral`::
    ++	This boolean value indicates, if true, that the value in the `credential`
    ++	field should not be saved by the credential helper because its usefulness is
    ++	limited in time.  For example, an HTTP Digest `credential` value is computed
    ++	using a nonce and reusing it will not result in successful authentication.
    ++	This may also be used for situations with short duration (e.g., 24-hour)
    ++	credentials.  The default value is false.
    +++
    ++The credential helper will still be invoked with `store` or `erase` so that it
    ++can determine whether the operation was successful.
     ++
     +This value should not be sent unless the appropriate capability (see below) is
     +provided on input.
    @@ Documentation/git-credential.txt: attribute 'wwwauth[]', where the order of the
     +	protocol.
     ++
     +The only capability currently supported is `authtype`, which indicates that the
    -+`authtype` and `credential` values are understood.  It is not obligatory to use
    -+these values in such a case, but they should not be provided without this
    -+capability.
    ++`authtype`, `credential`, and `ephemeral` values are understood.  It is not
    ++obligatory to use these values in such a case, but they should not be provided
    ++without this capability.
     ++
     +Callers of `git credential` and credential helpers should emit the
     +capabilities they support unconditionally, and Git will gracefully
 7:  82f7582268 =  8:  3b0a426fa1 http: add support for authtype and credential
 8:  c67540de6f !  9:  8897ecf5e0 credential: add an argument to keep state
    @@ Commit message
         Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
     
      ## Documentation/git-credential.txt ##
    -@@ Documentation/git-credential.txt: provided on input.
    +@@ Documentation/git-credential.txt: can determine whether the operation was successful.
      This value should not be sent unless the appropriate capability (see below) is
      provided on input.
      
    @@ Documentation/git-credential.txt: they appear in the HTTP response. This attribu
      `capability[]`::
     -	This signals that the caller supports the capability in question.
     -	This can be used to provide better, more specific data as part of the
    --	protocol.
    -+  This signals that Git, or the helper, as appropriate, supports the
    -+	capability in question.  This can be used to provide better, more specific
    -+	data as part of the protocol.
    ++	This signals that Git, or the helper, as appropriate, supports the capability
    ++	in question.  This can be used to provide better, more specific data as part
    ++	of the protocol.  A `capability[]` directive must precede any value depending
    ++	on it and these directives _should_ be the first item announced in the
    + 	protocol.
      +
     -The only capability currently supported is `authtype`, which indicates that the
    --`authtype` and `credential` values are understood.  It is not obligatory to use
    --these values in such a case, but they should not be provided without this
    --capability.
    --+
    +-`authtype`, `credential`, and `ephemeral` values are understood.  It is not
    +-obligatory to use these values in such a case, but they should not be provided
    +-without this capability.
    ++There are two currently supported capabilities.  The first is `authtype`, which
    ++indicates that the `authtype`, `credential`, and `ephemeral` values are
    ++understood.  The second is `state`, which indicates that the `state[]` and
    ++`continue` values are understood.
    + +
     -Callers of `git credential` and credential helpers should emit the
     -capabilities they support unconditionally, and Git will gracefully
     -handle passing them on.
    -+There are two currently supported capabilities.  The first is `authtype`, which
    -+indicates that the `authtype` and `credential` values are understood.  The
    -+second is `state`, which indicates that the `state[]` value is understood.
    -+
     +It is not obligatory to use the additional features just because the capability
    -+is supported, but they should not be provided without this capability.
    ++is supported, but they should not be provided without the capability.
      
      Unrecognised attributes and capabilities are silently discarded.
      
    @@ credential.c: void credential_clear(struct credential *c)
      
      	credential_init(c);
      }
    -@@ credential.c: int credential_read(struct credential *c, FILE *fp, int op_type)
    - 			c->path = xstrdup(value);
    +@@ credential.c: int credential_read(struct credential *c, FILE *fp,
    + 			c->ephemeral = !!git_config_bool("ephemeral", value);
      		} else if (!strcmp(key, "wwwauth[]")) {
      			strvec_push(&c->wwwauth_headers, value);
     -		} else if (!strcmp(key, "capability[]") && !strcmp(value, "authtype")) {
    @@ credential.c: int credential_read(struct credential *c, FILE *fp, int op_type)
      			errno = 0;
      			c->password_expiry_utc = parse_timestamp(value, NULL, 10);
     @@ credential.c: static void credential_write_item(FILE *fp, const char *key, const char *value,
    - 
    - void credential_write(const struct credential *c, FILE *fp, int op_type)
    + void credential_write(const struct credential *c, FILE *fp,
    + 		      enum credential_op_type op_type)
      {
     -	if (credential_has_capability(&c->capa_authtype, op_type)) {
     +	if (credential_has_capability(&c->capa_authtype, op_type))
    @@ credential.c: static void credential_write_item(FILE *fp, const char *key, const
     +	if (credential_has_capability(&c->capa_authtype, op_type)) {
      		credential_write_item(fp, "authtype", c->authtype, 0);
      		credential_write_item(fp, "credential", c->credential, 0);
    - 	}
    -@@ credential.c: void credential_write(const struct credential *c, FILE *fp, int op_type)
    + 		if (c->ephemeral)
    +@@ credential.c: void credential_write(const struct credential *c, FILE *fp,
      	}
      	for (size_t i = 0; i < c->wwwauth_headers.nr; i++)
      		credential_write_item(fp, "wwwauth[]", c->wwwauth_headers.v[i], 0);
    @@ t/t0300-credentials.sh: test_expect_success 'setup helper scripts' '
      	. ./dump
      	echo capability[]=authtype
     +	echo capability[]=state
    - 	test -z "${capability##*authtype*}" || return
    + 	test -z "${capability##*authtype*}" || exit 0
      	test -z "$authtype" || echo authtype=$authtype
      	test -z "$credential" || echo credential=$credential
    -+	test -z "${capability##*state*}" || return
    ++	test -z "${capability##*state*}" || exit 0
     +	echo state[]=verbatim-cred:foo
      	EOF
      
    - 	write_script git-credential-verbatim-with-expiry <<-\EOF &&
    -@@ t/t0300-credentials.sh: test_expect_success 'credential_fill invokes helper with credential' '
    + 	write_script git-credential-verbatim-ephemeral <<-\EOF &&
    +@@ t/t0300-credentials.sh: test_expect_success 'credential_fill invokes helper with ephemeral credential' '
    + 	verbatim-ephemeral: host=example.com
      	EOF
      '
    - 
     +test_expect_success 'credential_fill invokes helper with credential and state' '
     +	check fill "verbatim-cred Bearer token" <<-\EOF
     +	capability[]=authtype
    @@ t/t0300-credentials.sh: test_expect_success 'credential_fill invokes helper with
     +	verbatim-cred: host=example.com
     +	EOF
     +'
    -+
      
      test_expect_success 'credential_fill invokes multiple helpers' '
      	check fill useless "verbatim foo bar" <<-\EOF
 9:  6321e0d5e6 ! 10:  6e56145ace credential: enable state capability
    @@ Commit message
         Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
     
      ## credential.c ##
    -@@ credential.c: void credential_clear(struct credential *c)
    - static void credential_set_all_capabilities(struct credential *c)
    +@@ credential.c: void credential_set_all_capabilities(struct credential *c,
    + 				     enum credential_op_type op_type)
      {
    - 	c->capa_authtype.request_initial = 1;
    -+	c->capa_state.request_initial = 1;
    + 	credential_set_capability(&c->capa_authtype, op_type);
    ++	credential_set_capability(&c->capa_state, op_type);
      }
      
      int credential_match(const struct credential *want,
10:  aaac77a3ce = 11:  3f5d2aa5e0 docs: set a limit on credential line length
11:  f4b01b3ba5 = 12:  1dd81f7859 t5563: refactor for multi-stage authentication
12:  a2f82a4043 <  -:  ---------- strvec: implement swapping two strvecs
13:  ec925ae9fb ! 13:  4a0ed175a6 credential: add support for multistage credential rounds
    @@ Documentation/git-credential.txt: provided on input.
      `wwwauth[]`::
      
      	When an HTTP response is received by Git that includes one or more
    -@@ Documentation/git-credential.txt: to pass additional information to credential helpers.
    - +
    - There are two currently supported capabilities.  The first is `authtype`, which
    - indicates that the `authtype` and `credential` values are understood.  The
    --second is `state`, which indicates that the `state[]` value is understood.
    -+second is `state`, which indicates that the `state[]` and `continue` values are
    -+understood.
    - 
    - It is not obligatory to use the additional features just because the capability
    - is supported, but they should not be provided without this capability.
     
      ## builtin/credential.c ##
     @@ builtin/credential.c: int cmd_credential(int argc, const char **argv, const char *prefix UNUSED)
    @@ builtin/credential.c: int cmd_credential(int argc, const char **argv, const char
     +		credential_next_state(&c);
      		credential_write(&c, stdout, CREDENTIAL_OP_RESPONSE);
      	} else if (!strcmp(op, "approve")) {
    - 		credential_approve(&c);
    + 		credential_set_all_capabilities(&c, CREDENTIAL_OP_HELPER);
     
      ## credential.c ##
     @@ credential.c: void credential_clear(struct credential *c)
    @@ credential.c: void credential_clear(struct credential *c)
     +void credential_next_state(struct credential *c)
     +{
     +	strvec_clear(&c->state_headers_to_send);
    -+	strvec_swap(&c->state_headers, &c->state_headers_to_send);
    ++	SWAP(c->state_headers, c->state_headers_to_send);
     +}
     +
     +void credential_clear_secrets(struct credential *c)
    @@ credential.c: void credential_clear(struct credential *c)
     +	FREE_AND_NULL(c->credential);
     +}
     +
    - static void credential_set_all_capabilities(struct credential *c)
    + static void credential_set_capability(struct credential_capability *capa,
    + 				      enum credential_op_type op_type)
      {
    - 	c->capa_authtype.request_initial = 1;
    -@@ credential.c: int credential_read(struct credential *c, FILE *fp, int op_type)
    +@@ credential.c: int credential_read(struct credential *c, FILE *fp,
      				credential_set_capability(&c->capa_authtype, op_type);
      			else if (!strcmp(value, "state"))
      				credential_set_capability(&c->capa_state, op_type);
    @@ credential.c: int credential_read(struct credential *c, FILE *fp, int op_type)
      		} else if (!strcmp(key, "password_expiry_utc")) {
      			errno = 0;
      			c->password_expiry_utc = parse_timestamp(value, NULL, 10);
    -@@ credential.c: void credential_write(const struct credential *c, FILE *fp, int op_type)
    +@@ credential.c: void credential_write(const struct credential *c, FILE *fp,
      	for (size_t i = 0; i < c->wwwauth_headers.nr; i++)
      		credential_write_item(fp, "wwwauth[]", c->wwwauth_headers.v[i], 0);
      	if (credential_has_capability(&c->capa_state, op_type)) {
    @@ credential.c: void credential_fill(struct credential *c, int all_capabilities)
     +
      	credential_apply_config(c);
      	if (all_capabilities)
    - 		credential_set_all_capabilities(c);
    + 		credential_set_all_capabilities(c, CREDENTIAL_OP_INITIAL);
     @@ credential.c: void credential_fill(struct credential *c, int all_capabilities)
      			/* Reset expiry to maintain consistency */
      			c->password_expiry_utc = TIME_MAX;
    @@ credential.h: struct credential {
      	 * Internal use only. Keeps track of if we previously matched against a
      	 * WWW-Authenticate header line in order to re-fold future continuation
     @@ credential.h: struct credential {
    - 
      	unsigned approved:1,
    + 		 ephemeral:1,
      		 configured:1,
     +		 multistage: 1,
      		 quit:1,
    @@ credential.h: struct credential {
      }
      
      /* Initialize a credential structure, setting all fields to empty. */
    -@@ credential.h: void credential_approve(struct credential *);
    -  */
    - void credential_reject(struct credential *);
    +@@ credential.h: void credential_reject(struct credential *);
    + void credential_set_all_capabilities(struct credential *c,
    + 				     enum credential_op_type op_type);
      
     +/**
     + * Clear the secrets in this credential, but leave other data intact.
    @@ credential.h: void credential_approve(struct credential *);
     + */
     +void credential_next_state(struct credential *c);
     +
    - int credential_read(struct credential *, FILE *, int);
    - void credential_write(const struct credential *, FILE *, int);
    - 
    + int credential_read(struct credential *, FILE *,
    + 		    enum credential_op_type);
    + void credential_write(const struct credential *, FILE *,
     
      ## http.c ##
     @@ http.c: static int handle_curl_result(struct slot_results *results)
 -:  ---------- > 14:  c4c07c1539 t: add credential tests for authtype
 -:  ---------- > 15:  b82650e219 credential-cache: implement authtype capability
 -:  ---------- > 16:  2f6e160693 credential: add method for querying capabilities
