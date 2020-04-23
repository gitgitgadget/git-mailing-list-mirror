Return-Path: <SRS0=24D7=6H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 824AEC54FCB
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 23:43:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AF1B2087E
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 23:43:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="juSwo0kG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728134AbgDWXnV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Apr 2020 19:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726632AbgDWXnV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Apr 2020 19:43:21 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A80C3C09B042
        for <git@vger.kernel.org>; Thu, 23 Apr 2020 16:43:20 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id 188so8504974wmc.2
        for <git@vger.kernel.org>; Thu, 23 Apr 2020 16:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Nxhc48rAzy4RlrQKi2Aks1SXZZXeRoI/hxW1ZreMU0A=;
        b=juSwo0kGVq23snRBerNhuRnJigiPQtyP9qv3pWKWkGP6Ekn4qhTTP1Mqfb3EPN+Yo6
         i8fJNgLce2oCButOyJwEk1xgkMf8Y0EtWynjRivNu1gfpGePF/rCHnV56jXkRG4ebB/w
         JYWGhUV/PzFRWiyV55ldN8sJfA5wnnWzcB2byEKA0wyhLjaoVCndEVxPQ7/u/6Os1TOM
         bpVryt3/swW67Bx1TKnvvgYdesMTyvWG66CVHupZKdPmztnyh1vJwqxiZRgUr3W3O0ou
         hpeRkSoJ7R2SoxzKtAYD261dip+ZA0IrTSiAMmlEJtdYdfUm36EczoKdDsapccgBZFmD
         WWtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Nxhc48rAzy4RlrQKi2Aks1SXZZXeRoI/hxW1ZreMU0A=;
        b=orNc418cZLiQoEZ9gk6y3rgEe2Nq02l/DXODq0IK+YfN+XNolEeSEl7IH4gw2RHP5M
         jcw4hJ6N3Hb57+kmVRC6Rj4uDeGqSVgAexg8BpWyKItUjvGwURg0l/f9B+NwWlJqdW0v
         lMe2MVsLXrwmoOlBK/oQtPbBNwEkc1VlChF5Ukbf99/G0K2+i8KYrB4gw59GAnhVlCzd
         HmBC9dJZBohb9aAgX4cF1XwYVp128rlpSzoaDoEOyhSWT5FhC7AGor8FnRM0jplwBMJ1
         qt56byat5b5vPntlUfbhAlfwNx0eMsrg7+qAM8Me5FalyCVaicr/h1wtI79Xuuz14nDK
         6HoQ==
X-Gm-Message-State: AGi0Pub4HIpK4gaYJXbW+cMcef1aV+PEBuhl20mzoGzkX3yIxWj/gRsT
        7bMDymyysfBM0T7TtmsT+yAzFq5U
X-Google-Smtp-Source: APiQypIyW1H/dnliXEZJEKmuLZd1TvaSguKD9IOrS0cNv8NlRnrbvcFtV51wUdjsIDvlbyckaVEzPw==
X-Received: by 2002:a7b:c74d:: with SMTP id w13mr6497175wmk.36.1587685398595;
        Thu, 23 Apr 2020 16:43:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s14sm498610wme.33.2020.04.23.16.43.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2020 16:43:18 -0700 (PDT)
Message-Id: <pull.615.v2.git.1587685397.gitgitgadget@gmail.com>
In-Reply-To: <pull.615.git.1587588665.gitgitgadget@gmail.com>
References: <pull.615.git.1587588665.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 23 Apr 2020 23:43:14 +0000
Subject: [PATCH v2 0/3] credential: handle partial URLs in config settings again
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Ilya Tretyakov <it@it3xl.ru>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This fixes the problem illustrated by Peff's example
[https://lore.kernel.org/git/20200422040644.GC3559880@coredump.intra.peff.net/]
, in maint-2.17:

  $ echo url=https://example.com |
    git -c credential.example.com.username=foo credential fill
  warning: url has no scheme: example.com
  fatal: credential url cannot be parsed: example.com

The fix is necessarily different than what was proposed by brian
[https://lore.kernel.org/git/20200422012344.2051103-1-sandals@crustytoothpaste.net/] 
because that fix targets v2.26.x which has 46fd7b390034 (credential: allow
wildcard patterns when matching config, 2020-02-20).

This patch series targets maint-2.17 instead (and might actually not be able
to fix maint due to that wildcard pattern patch; I haven't had the time to
check yet).

Please note that Git v2.17.4 will not do what we would expect here: if any
host name (without protocol) is specified, e.g. -c
credential.golli.wog.username = boo, it will actually ignore the host name.
That is, this will populate the username:

  $ echo url=https://example.com |
    git -c credential.totally.bog.us.username=foo credential fill

Obviously, this is unexpected, as a Git config like this would leave the
last specified user name as "winner":

[credential "first.com"]
    username = Whos On
[credential "second.com"]
    username = Who

This patch series fixes this. The quoted part of [credential "<value>"] will
be interpreted as a partial URL:

 * It can start with a protocol followed by ://, but does not have to.
 * If it starts with a protocol, the host name will always be set (if the 
   :// is followed immediately by yet another slash, then it will be set to
   the empty string).
 * If it starts without a protocol, it is treated as a path if the value
   starts with a slash (and the host will be left unset).
 * If it starts without a protocol and the first character is not a slash,
   it will be treated as a host name, optionally followed by a slash and the
   path.

Changes since v1:

 * The condition when the c->host field is set was made more intuitive.
 * The "fix grammar" commit now has Jonathan's "reviewed-by" footer.
 * Inverted the meaning of the parameter strict and renamed it to 
   allow_partial_urls, to clarify its role.
 * Enhanced the commit message of the second patch to illustrate the
   motivation for the lenient mode a bit better.
 * [Not a change] I did leave the second and the third patch separate from
   one another. This makes it a lot easier to follow the iteration and to
   keep the reviews straight: it separates the "how do we make URL parts
   optional?" from the "where do we need URL parts to be optional?"
 * A partial URL https:// is now correctly interpreted as having only the
   protocol set, but not host name nor path.
 * The lenient mode is now explained a lot more verbosely in the code
   comment in credential.h.
 * When skipping a config setting, we now show the config key, not just the
   URL (which might be incomplete, i.e. not actually a URL).
 * When skipping a config setting, the correct struct credential is cleared
   (i.e. the just-parsed one, not the one against which we wanted to match
   the just-parsed one).
 * Added a ton more partial URLs to the test, and the test now also verifies
   that the warning comes out all right.

Johannes Schindelin (3):
  credential: fix grammar
  credential: optionally allow partial URLs in
    credential_from_url_gently()
  credential: handle `credential.<partial-URL>.<key>` again

 credential.c           | 22 +++++++++++++++-------
 credential.h           | 28 ++++++++++++++++++++++++++--
 fsck.c                 |  2 +-
 t/t0300-credentials.sh | 39 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 81 insertions(+), 10 deletions(-)


base-commit: df5be6dc3fd18c294ec93a9af0321334e3f92c9c
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-615%2Fdscho%2Fcredential-config-partial-url-maint-2.17-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-615/dscho/credential-config-partial-url-maint-2.17-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/615

Range-diff vs v1:

 1:  2bf781081d9 ! 1:  2c1c0ae91eb credential: fix grammar
     @@ Commit message
          possible solutions were discussed. Grammar was not a primary focus,
          that's why this slipped in.
      
     +    Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## credential.h ##
 2:  1081841b16d ! 2:  fc772d21b74 credential: teach `credential_from_url()` a non-strict mode
     @@ Metadata
      Author: Johannes Schindelin <Johannes.Schindelin@gmx.de>
      
       ## Commit message ##
     -    credential: teach `credential_from_url()` a non-strict mode
     +    credential: optionally allow partial URLs in credential_from_url_gently()
      
          Prior to the fixes for CVE-2020-11008, we were _very_ lenient in what we
          required from a URL in order to parse it into a `struct credential`.
     @@ Commit message
      
          There was one call site, though, that really needed that leniency: when
          parsing config settings a la `credential.dev.azure.com.useHTTPPath`.
     +    Settings like this might be desired when users want to use, say, a given
     +    user name on a given host, regardless of the protocol to be used.
      
     -    In preparation for fixing that regression, let's add a parameter called
     -    `strict` to the `credential_from_url()` function and convert the
     -    existing callers to enforce that strict mode.
     +    In preparation for fixing that bug, let's add a parameter called
     +    `allow_partial_url` to the `credential_from_url_gently()` function and
     +    convert the existing callers to set that parameter to 0, i.e. do not
     +    change the existing behavior, just add the option to be more lenient.
     +
     +    Please note that this patch does more than just reinstating a way to
     +    imitate the behavior before those CVE-2020-11008 fixes: Before that, we
     +    would simply ignore URLs without a protocol. In other words,
     +    misleadingly, the following setting would be applied to _all_ URLs:
     +
     +            [credential "example.com"]
     +                    username = that-me
     +
     +    The obvious intention is to match the host name only. With this patch,
     +    we allow precisely that: when parsing the URL with non-zero
     +    `allow_partial_url`, we do not simply return success if there was no
     +    protocol, but we simply leave the protocol unset and continue parsing
     +    the URL.
      
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
     @@ credential.c: static int check_url_component(const char *url, int quiet,
       
       int credential_from_url_gently(struct credential *c, const char *url,
      -			       int quiet)
     -+			       int strict, int quiet)
     ++			       int allow_partial_url, int quiet)
       {
       	const char *at, *colon, *cp, *slash, *host, *proto_end;
       
     @@ credential.c: int credential_from_url_gently(struct credential *c, const char *u
       	 */
       	proto_end = strstr(url, "://");
      -	if (!proto_end || proto_end == url) {
     -+	if (strict && (!proto_end || proto_end == url)) {
     ++	if (!allow_partial_url && (!proto_end || proto_end == url)) {
       		if (!quiet)
       			warning(_("url has no scheme: %s"), url);
       		return -1;
     @@ credential.c: int credential_from_url_gently(struct credential *c, const char *u
      -	c->host = url_decode_mem(host, slash - host);
      +	if (proto_end && proto_end - url > 0)
      +		c->protocol = xmemdupz(url, proto_end - url);
     -+	if (slash - url > 0)
     ++	if (!allow_partial_url || slash - host > 0)
      +		c->host = url_decode_mem(host, slash - host);
       	/* Trim leading and trailing slashes from path */
       	while (*slash == '/')
     @@ credential.c: int credential_from_url_gently(struct credential *c, const char *u
       void credential_from_url(struct credential *c, const char *url)
       {
      -	if (credential_from_url_gently(c, url, 0) < 0)
     -+	if (credential_from_url_gently(c, url, 1, 0) < 0)
     ++	if (credential_from_url_gently(c, url, 0, 0) < 0)
       		die(_("credential url cannot be parsed: %s"), url);
       }
      
     @@ credential.h: void credential_write(const struct credential *, FILE *);
        * examination.  The non-gentle form will issue a warning to stderr and return
        * an empty credential.
      + *
     -+ * In strict mode, an empty protocol or an empty host name are not allowed.
     -+ * The credential_from_url() function enforces strict mode.
     ++ * If allow_partial_url is non-zero, partial URLs are allowed, i.e. it can, but
     ++ * does not have to, contain
     ++ *
     ++ * - a protocol (or scheme) of the form "<protocol>://"
     ++ *
     ++ * - a host name (the part after the protocol and before the first slash after
     ++ *   that, if any)
     ++ *
     ++ * - a user name and potentially a password (as "<user>[:<password>]@" part of
     ++ *   the host name)
     ++ *
     ++ * - a path (the part after the host name, if any, starting with the slash)
     ++ *
     ++ * Missing parts will be left unset in `struct credential`. Thus, `https://`
     ++ * will have only the `protocol` set, `example.com` only the host name, and
     ++ * `/git` only the path.
     ++ *
     ++ * Note that an empty host name in an otherwise fully-qualified URL will be
     ++ * treated as unset when allow_partial_url is non-zero (and only then,
     ++ * otherwise it is treated as the empty string).
     ++ *
     ++ * The credential_from_url() function does not allow partial URLs.
        */
       void credential_from_url(struct credential *, const char *url);
      -int credential_from_url_gently(struct credential *, const char *url, int quiet);
      +int credential_from_url_gently(struct credential *, const char *url,
     -+			       int strict, int quiet);
     ++			       int allow_partial_url, int quiet);
       
       int credential_match(const struct credential *have,
       		     const struct credential *want);
     @@ fsck.c: static int check_submodule_url(const char *url)
       		struct credential c = CREDENTIAL_INIT;
       		int ret = 0;
      -		if (credential_from_url_gently(&c, curl_url, 1) ||
     -+		if (credential_from_url_gently(&c, curl_url, 1, 1) ||
     ++		if (credential_from_url_gently(&c, curl_url, 0, 1) ||
       		    !*c.host)
       			ret = -1;
       		credential_clear(&c);
 3:  66823c735b1 ! 3:  daedaffe960 credential: handle `credential.<partial-URL>.<key>` again
     @@ Commit message
      
          Let's reinstate this behavior.
      
     -    Original-test-case-by: Jeff King <peff@peff.net>
     +    While at it, increase the test coverage to document and verify the
     +    behavior with a couple other categories of partial URLs.
     +
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## credential.c ##
     @@ credential.c: static int credential_config_callback(const char *var, const char
       		int matched;
       
      -		credential_from_url(&want, url);
     -+		if (credential_from_url_gently(&want, url, 0, 0) < 0) {
     -+			warning(_("skipping credential lookup for url: %s"), url);
     -+			credential_clear(c);
     ++		if (credential_from_url_gently(&want, url, 1, 0) < 0) {
     ++			warning(_("skipping credential lookup for key: %s"),
     ++				var);
     ++			credential_clear(&want);
      +			free(url);
      +			return 0;
      +		}
     @@ t/t0300-credentials.sh: test_expect_success 'credential system refuses to work w
       	test_i18ncmp expect stderr
       '
       
     -+test_expect_success 'credential config accepts partial URLs' '
     -+	echo url=https://example.com |
     -+	git -c credential.example.com.username=boo \
     -+		credential fill >actual &&
     -+	cat >expect <<-EOF &&
     -+	protocol=https
     -+	host=example.com
     -+	username=boo
     -+	password=askpass-password
     -+	EOF
     -+	test_cmp expect actual
     ++test_expect_success 'credential config with partial URLs' '
     ++	echo "echo password=yep" | write_script git-credential-yep &&
     ++	test_write_lines url=https://user@example.com/repo.git >input &&
     ++	for partial in \
     ++		example.com \
     ++		user@example.com \
     ++		https:// \
     ++		https://example.com \
     ++		https://example.com/ \
     ++		https://user@example.com \
     ++		https://user@example.com/ \
     ++		https://example.com/repo.git \
     ++		https://user@example.com/repo.git \
     ++		/repo.git
     ++	do
     ++		git -c credential.$partial.helper=yep \
     ++			credential fill <input >output &&
     ++		grep yep output ||
     ++		return 1
     ++	done &&
     ++
     ++	for partial in \
     ++		dont.use.this \
     ++		http:// \
     ++		/repo
     ++	do
     ++		git -c credential.$partial.helper=yep \
     ++			credential fill <input >output &&
     ++		! grep yep output ||
     ++		return 1
     ++	done &&
     ++
     ++	git -c credential.$partial.helper=yep \
     ++		-c credential.with%0anewline.username=uh-oh \
     ++		credential fill <input >output 2>error &&
     ++	test_i18ngrep "skipping credential lookup for key" error
     ++
      +'
      +
       test_done

-- 
gitgitgadget
