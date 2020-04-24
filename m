Return-Path: <SRS0=LF8V=6I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02851C54FD0
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 11:49:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFA3720728
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 11:49:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SppK34WV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbgDXLt4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Apr 2020 07:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbgDXLt4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Apr 2020 07:49:56 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C781DC09B045
        for <git@vger.kernel.org>; Fri, 24 Apr 2020 04:49:55 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id 188so10104413wmc.2
        for <git@vger.kernel.org>; Fri, 24 Apr 2020 04:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=lKrgIgpfGs6gTRmNygp6gXz1CLlHjLl4yoyTxQLVJvM=;
        b=SppK34WVLVaGAiSqeRSZugO7v3gZ1ZUlMMoFoWnRJdhSECVjhvmFHenAHHJtNv+GdC
         RG9pKIqXI4/gNmcAefpvv0dQ2MTQdY5GoqLZgwJD0BqoejYfuixs+x6ut+bStMwGpdqm
         rPxtSDelvMOI3XQDLC15FQHfPGa/dqrO9bIaaCN5ZNBKnzLegVxW0IOYJfZqaXFgi5zJ
         ztpSeLGvzsqXRc6WX/ZOPjKpotAgkFK1Qn7cyjUrS04XxCqqvHpyeB1oUV4Bo3Qy/iiH
         kEhxZaiyp7QFk0+r84oW9XXWEIN/bRK12gXbbbS3vdE1BXMlHxPQjaPsXBZTkDyGAJKn
         OFBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=lKrgIgpfGs6gTRmNygp6gXz1CLlHjLl4yoyTxQLVJvM=;
        b=ssmloc5nWkb5hCxNjDAZG5DZjB/3g3PRieY+a4Yrlun3AhnYmg8xv2YFJ5MeMDGXHl
         45NKIxSNKKhC2TSBMAOYPFT50OuyxeFVnBrBPSLliv77P+lZm6DE4ON1Vx1H9b+58/Ja
         sMyDvUAnnwafRDiOzouNoM+A3YEHVtKD3X7+CfJ81YTPUXJOxTNBnuGdJVKZux+CUA/K
         O8NdBKmxfrXm7V8m78UVyJ9FFnu1fbD3RyUKMoweTyYZFYa+Yz515J7vcFwIWXXlzDh1
         fbg6bQFELQpjrIb59H3Y+nzpH8rDU3j7PSe1leROl3qGkSE6bYMW4g6xtVNUn2md6t4P
         dVmw==
X-Gm-Message-State: AGi0PuZxE624FeGgGEdZ7AA0XoShwQHLogXxdJ/xw+9hTzV4kADmaNdE
        NMfr+5Lrl4VlUW3DpJ99egxi0ZvP
X-Google-Smtp-Source: APiQypIoGhD9yn/qqw9CZ96FvwoGbgTuRSXGw1bc0skpdbzl2LEcTHOWPFniKGGLRreJ0ou+dOx51w==
X-Received: by 2002:a1c:2b81:: with SMTP id r123mr9664062wmr.34.1587728993706;
        Fri, 24 Apr 2020 04:49:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d7sm7719044wrn.78.2020.04.24.04.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 04:49:53 -0700 (PDT)
Message-Id: <pull.615.v3.git.1587728992.gitgitgadget@gmail.com>
In-Reply-To: <pull.615.v2.git.1587685397.gitgitgadget@gmail.com>
References: <pull.615.v2.git.1587685397.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 24 Apr 2020 11:49:49 +0000
Subject: [PATCH v3 0/3] credential: handle partial URLs in config settings again
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

Changes since v2:

 * Refactored out the credential_from_potentially_partial_url() function so
   that existing callers (except for the one we want to change) stay
   untouched.
 * When encountering an invalid URL while parsing the config, we no longer
   suppress the parser's warning.
 * The test now uses the file name convention stdin/stdout/stderr of 
   t/lib-credential.sh.

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

 credential.c           | 60 +++++++++++++++++++++++++++++++++++++-----
 credential.h           |  2 +-
 t/t0300-credentials.sh | 39 +++++++++++++++++++++++++++
 3 files changed, 93 insertions(+), 8 deletions(-)


base-commit: df5be6dc3fd18c294ec93a9af0321334e3f92c9c
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-615%2Fdscho%2Fcredential-config-partial-url-maint-2.17-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-615/dscho/credential-config-partial-url-maint-2.17-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/615

Range-diff vs v2:

 1:  2c1c0ae91eb = 1:  2c1c0ae91eb credential: fix grammar
 2:  fc772d21b74 ! 2:  e92f139dfc7 credential: optionally allow partial URLs in credential_from_url_gently()
     @@ Commit message
          Settings like this might be desired when users want to use, say, a given
          user name on a given host, regardless of the protocol to be used.
      
     -    In preparation for fixing that bug, let's add a parameter called
     -    `allow_partial_url` to the `credential_from_url_gently()` function and
     -    convert the existing callers to set that parameter to 0, i.e. do not
     -    change the existing behavior, just add the option to be more lenient.
     +    In preparation for fixing that bug, let's refactor the code to
     +    optionally allow for partial URLs. For the moment, this functionality is
     +    only exposed via the now-renamed function `credential_from_url_1()`, but
     +    it is not used. The intention is to make it easier to verify that this
     +    commit does not change the existing behavior unless explicitly allowing
     +    for partial URLs.
      
          Please note that this patch does more than just reinstating a way to
          imitate the behavior before those CVE-2020-11008 fixes: Before that, we
     @@ Commit message
      
       ## credential.c ##
      @@ credential.c: static int check_url_component(const char *url, int quiet,
     + 	return -1;
       }
       
     - int credential_from_url_gently(struct credential *c, const char *url,
     +-int credential_from_url_gently(struct credential *c, const char *url,
      -			       int quiet)
     -+			       int allow_partial_url, int quiet)
     ++/*
     ++ * Potentially-partial URLs can, but do not have to, contain
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
     ++ * Note that an empty host name in an otherwise fully-qualified URL (e.g.
     ++ * `cert:///path/to/cert.pem`) will be treated as unset if we expect the URL to
     ++ * be potentially partial, and only then (otherwise, the empty string is used).
     ++ *
     ++ * The credential_from_url() function does not allow partial URLs.
     ++ */
     ++static int credential_from_url_1(struct credential *c, const char *url,
     ++				 int allow_partial_url, int quiet)
       {
       	const char *at, *colon, *cp, *slash, *host, *proto_end;
       
     @@ credential.c: int credential_from_url_gently(struct credential *c, const char *u
       	while (*slash == '/')
       		slash++;
      @@ credential.c: int credential_from_url_gently(struct credential *c, const char *url,
     + 	return 0;
     + }
       
     ++int credential_from_url_gently(struct credential *c, const char *url, int quiet)
     ++{
     ++	return credential_from_url_1(c, url, 0, quiet);
     ++}
     ++
       void credential_from_url(struct credential *c, const char *url)
       {
     --	if (credential_from_url_gently(c, url, 0) < 0)
     -+	if (credential_from_url_gently(c, url, 0, 0) < 0)
     - 		die(_("credential url cannot be parsed: %s"), url);
     - }
     -
     - ## credential.h ##
     -@@ credential.h: void credential_write(const struct credential *, FILE *);
     -  * an error but leave the broken state in the credential object for further
     -  * examination.  The non-gentle form will issue a warning to stderr and return
     -  * an empty credential.
     -+ *
     -+ * If allow_partial_url is non-zero, partial URLs are allowed, i.e. it can, but
     -+ * does not have to, contain
     -+ *
     -+ * - a protocol (or scheme) of the form "<protocol>://"
     -+ *
     -+ * - a host name (the part after the protocol and before the first slash after
     -+ *   that, if any)
     -+ *
     -+ * - a user name and potentially a password (as "<user>[:<password>]@" part of
     -+ *   the host name)
     -+ *
     -+ * - a path (the part after the host name, if any, starting with the slash)
     -+ *
     -+ * Missing parts will be left unset in `struct credential`. Thus, `https://`
     -+ * will have only the `protocol` set, `example.com` only the host name, and
     -+ * `/git` only the path.
     -+ *
     -+ * Note that an empty host name in an otherwise fully-qualified URL will be
     -+ * treated as unset when allow_partial_url is non-zero (and only then,
     -+ * otherwise it is treated as the empty string).
     -+ *
     -+ * The credential_from_url() function does not allow partial URLs.
     -  */
     - void credential_from_url(struct credential *, const char *url);
     --int credential_from_url_gently(struct credential *, const char *url, int quiet);
     -+int credential_from_url_gently(struct credential *, const char *url,
     -+			       int allow_partial_url, int quiet);
     - 
     - int credential_match(const struct credential *have,
     - 		     const struct credential *want);
     -
     - ## fsck.c ##
     -@@ fsck.c: static int check_submodule_url(const char *url)
     - 	else if (url_to_curl_url(url, &curl_url)) {
     - 		struct credential c = CREDENTIAL_INIT;
     - 		int ret = 0;
     --		if (credential_from_url_gently(&c, curl_url, 1) ||
     -+		if (credential_from_url_gently(&c, curl_url, 0, 1) ||
     - 		    !*c.host)
     - 			ret = -1;
     - 		credential_clear(&c);
     + 	if (credential_from_url_gently(c, url, 0) < 0)
 3:  daedaffe960 ! 3:  0535908dd7e credential: handle `credential.<partial-URL>.<key>` again
     @@ Commit message
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## credential.c ##
     +@@ credential.c: int credential_match(const struct credential *want,
     + #undef CHECK
     + }
     + 
     ++
     ++static int credential_from_potentially_partial_url(struct credential *c,
     ++						   const char *url);
     ++
     + static int credential_config_callback(const char *var, const char *value,
     + 				      void *data)
     + {
      @@ credential.c: static int credential_config_callback(const char *var, const char *value,
       		char *url = xmemdupz(key, dot - key);
       		int matched;
       
      -		credential_from_url(&want, url);
     -+		if (credential_from_url_gently(&want, url, 1, 0) < 0) {
     ++		if (credential_from_potentially_partial_url(&want, url) < 0) {
      +			warning(_("skipping credential lookup for key: %s"),
      +				var);
      +			credential_clear(&want);
     @@ credential.c: static int credential_config_callback(const char *var, const char
       		matched = credential_match(&want, c);
       
       		credential_clear(&want);
     +@@ credential.c: static int credential_from_url_1(struct credential *c, const char *url,
     + 	return 0;
     + }
     + 
     ++static int credential_from_potentially_partial_url(struct credential *c,
     ++						   const char *url)
     ++{
     ++	return credential_from_url_1(c, url, 1, 0);
     ++}
     ++
     + int credential_from_url_gently(struct credential *c, const char *url, int quiet)
     + {
     + 	return credential_from_url_1(c, url, 0, quiet);
      
       ## t/t0300-credentials.sh ##
      @@ t/t0300-credentials.sh: test_expect_success 'credential system refuses to work with missing protocol' '
     @@ t/t0300-credentials.sh: test_expect_success 'credential system refuses to work w
       
      +test_expect_success 'credential config with partial URLs' '
      +	echo "echo password=yep" | write_script git-credential-yep &&
     -+	test_write_lines url=https://user@example.com/repo.git >input &&
     ++	test_write_lines url=https://user@example.com/repo.git >stdin &&
      +	for partial in \
      +		example.com \
      +		user@example.com \
     @@ t/t0300-credentials.sh: test_expect_success 'credential system refuses to work w
      +		/repo.git
      +	do
      +		git -c credential.$partial.helper=yep \
     -+			credential fill <input >output &&
     -+		grep yep output ||
     ++			credential fill <stdin >stdout &&
     ++		grep yep stdout ||
      +		return 1
      +	done &&
      +
     @@ t/t0300-credentials.sh: test_expect_success 'credential system refuses to work w
      +		/repo
      +	do
      +		git -c credential.$partial.helper=yep \
     -+			credential fill <input >output &&
     -+		! grep yep output ||
     ++			credential fill <stdin >stdout &&
     ++		! grep yep stdout ||
      +		return 1
      +	done &&
      +
      +	git -c credential.$partial.helper=yep \
      +		-c credential.with%0anewline.username=uh-oh \
     -+		credential fill <input >output 2>error &&
     -+	test_i18ngrep "skipping credential lookup for key" error
     ++		credential fill <stdin >stdout 2>stderr &&
     ++	test_i18ngrep "skipping credential lookup for key" stderr
      +
      +'
      +

-- 
gitgitgadget
