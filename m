Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD96FC6377A
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 22:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B884761244
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 22:22:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbhGUVls (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jul 2021 17:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbhGUVlr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jul 2021 17:41:47 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B920C061575
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 15:22:22 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id k4so3762085wrc.8
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 15:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HpOHDtp5Euy/vUD3pm/Tmrk3vOFZin6fhoXkc2pqZew=;
        b=EP/yUziXOuf3eqmJMHJ+CVKd6U37EpUJbG4X9J1va0Lj3RZb3RATgE2yabEFcrFzh/
         J0Tc/TEQxjKOYwDm+wqMq0RIVfSaU9gNuJV6puRC0g+hFlpAB/NEoe+L/X/Z/EzK53ZJ
         pCsR4n7YnxwyxFrIv5lOdNVw4Kt4+p15bfQvSN/5geUpgcaxQYsubYneB0H+rxKrSvZp
         kz04jJSPthHrhvVAPNyjNDrGLOOxAHXfD5Prdf5RiQKvtrI1hddUegbB955t6I5XONG3
         1+zJ9+ajFi7zvQV3MI6JCulEsG3CU+cqeOx//Ph+5bi9YcrZ9/7wDAX0oXuqnp5rsrUp
         Za0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HpOHDtp5Euy/vUD3pm/Tmrk3vOFZin6fhoXkc2pqZew=;
        b=M3NO0UkpRrM5PQrtZSqZDAfl95tGxAeMbwQEBqpwJwkj58UJZb07fl8o+ADyoocWfG
         SK/QKn3tPMHSBIEu6WoU+poedONix3MPQ/HQBDXmIcFGBnIeRwoUGy1PKHaH3RAWXrph
         Vv2vl3CnWmSviZOSKQczWtqF9fKrWLL9qAYjCvbvJ3BnAVYxaSH9hIVhvv/M1TDsyjH3
         7bMdc9X0YkZ2kMXzWfOXoQnNCQ/v8ZjeYZmDVU081twK1Bai+D+o5L/VSAyIXMkq6hb4
         hxQSp2I/+oSRkKVttzabgAytMjfqrbfqbB5aCofNVpL6eAYpygJ5B+etAmiWSB1DZO/2
         HDOw==
X-Gm-Message-State: AOAM533hfYPu8ia7ANE5GcOwhEvwGY9E7JlkN63qGZQ1uG9ef3mYodhk
        XLprfYnHY9BJpn7I4IDe7G9WE6E7h3KGgQ==
X-Google-Smtp-Source: ABdhPJz7cQGM4jl2OwEBGRTeVnZz7lgQL4K/rBvx6kklEXiykNCkRObNWBaGnnFcDwhIg2Pa91U8Zw==
X-Received: by 2002:a05:6000:1201:: with SMTP id e1mr45686543wrx.0.1626906140442;
        Wed, 21 Jul 2021 15:22:20 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id d9sm27792132wrx.76.2021.07.21.15.22.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 15:22:19 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Nicolas Morey-Chaisemartin <NMoreyChaisemartin@suse.de>,
        "Tom G . Christensen" <tgc@jupiterrise.com>,
        Mischa POSLAWSKY <git@shiar.nl>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 0/5] drop support for ancient curl
Date:   Thu, 22 Jul 2021 00:22:11 +0200
Message-Id: <cover-0.5-00000000000-20210721T220402Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.874.ge7a9d58bfcf
In-Reply-To: <20170809120024.7phdjzjv54uv5dpz@sigill.intra.peff.net>
References: <20170809120024.7phdjzjv54uv5dpz@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series simplifies the http code by dropping support for curl
versions older than 7.19.4, released in March 2009.

This was last discussed on-list in 2017:
http://lore.kernel.org/git/20170809120024.7phdjzjv54uv5dpz@sigill.intra.peff.net

My reading of why it didn't get integrated at the time was:

 - The original commit messages are opinionated about git not working
   on these versions anyway, as noted in the original thread that's
   only true of vanilla curl, but anyone impacted by these issues at
   the time was probably using e.g. RHEL, which had backports that
   confused the issue.

 - While in 2017 these versions were already ancient, RHEL 5 (released
   in 2007) was still seeing some notable production use.

   It finally got "we really mean it now" EOL'd in late 2020 when
   extended life-cycle support ended (see
   https://access.redhat.com/support/policy/updates/errata). RHEL 6
   does not have a libcurl affected by these changes.

 - It ended with a patch to "error on too-old curl", i.e. to make
   compiling on versions older than 7.19.4 an error. I've ejected that
   per the discussion about backports confusing that issue.

This series is a re-roll of patches found in Peff's GitHub repo at
jk/no-ancient-curl, which were already-rebased versions of those
patches. His original on-list version had his Signed-off-by, but the
range-diff is against that branch, hence the addition of
Signed-off-by in the range-diff.

Peff's original 3/4 had a subtle bug in keeping the "CURLOPT_POST301"
branch of an ifdef/elif, spotted by Mischa POSLAWSKY, a fix for that
is squashed in here. See
https://lore.kernel.org/git/20170810123641.GG2363@shiar.net/

I then added a couple of patches on top, one is based on my comments
on the v1 http://lore.kernel.org/git/871sokhoi9.fsf@gmail.com,
i.e. the CURLAUTH_DIGEST_IE and CURLOPT_USE_SSL flags are also
version-based, and we can drop support for curls that don't have them.

I then renamed the ancient CURLOPT_FILE alias to
CURLOPT_WRITEDATA. Incidentally that's how I remembered to dig up this
series, i.e. I tried to search for "CURLOPT_FILE" in API documentation
while reading our HTTP code, but had a hard time finding it, turns out
we were using a very ancient synonym for the preferred name.

Jeff King (3):
  http: drop support for curl < 7.11.1
  http: drop support for curl < 7.16.0
  http: drop support for curl < 7.19.4

Ævar Arnfjörð Bjarmason (2):
  http: drop support for curl < 7.19.3 and < 7.16.4 (again)
  http: rename CURLOPT_FILE to CURLOPT_WRITEDATA

 http-push.c   |  29 +--------
 http-walker.c |  14 +----
 http.c        | 169 ++------------------------------------------------
 http.h        |  46 --------------
 imap-send.c   |   4 --
 remote-curl.c |  11 +---
 6 files changed, 10 insertions(+), 263 deletions(-)

Range-diff against v1:
1:  8793735cc2c ! 1:  dcbb6f95652 http: drop support for curl < 7.11.1
    @@ Metadata
      ## Commit message ##
         http: drop support for curl < 7.11.1
     
    -    Recent versions of Git will not build with curl older than
    -    7.11.1 due to (at least) two issues:
    +    Drop support for this ancient version of curl and simplify the code by
    +    allowing us get rid of some "#ifdef"'s.
    +
    +    Git will not build with vanilla curl older than 7.11.1 due to (at
    +    least) two issues:
     
           - our use of CURLOPT_POSTFIELDSIZE in 37ee680d9b
             (http.postbuffer: allow full range of ssize_t values,
    @@ Commit message
         obvious benefit is that we'll have fewer conditional bits
         cluttering the code.
     
    -    But more importantly, we're doing a disservice to users to
    -    pretend that Git works with old versions. It's clear that
    -    nobody is testing modern Git with such old versions of curl
    -    (we've had 3 released versions with the CURLPROTO issue
    -    without a report of anyone seeing the breakage in the wild).
    -    And there are a lot of subtle ways we could be getting this
    -    wrong (for instance, curl prior to 7.17.0 did not copy
    -    string arguments to curl_easy_setopt(), which means that
    -    using an old copy of curl could produce use-after-free
    -    bugs that are not present with more recent versions).
    -
         This patch drops all #ifdefs that reference older versions
         (note that curl's preprocessor macros are in hex, so we're
         looking for 070b01, not 071101).
     
    +    Signed-off-by: Jeff King <peff@peff.net>
    +    Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
    +
      ## http.c ##
     @@
      static struct trace_key trace_curl = TRACE_KEY_INIT(CURL);
2:  15638cd1856 ! 2:  1c9f3bc031b http: drop support for curl < 7.16.0
    @@ Metadata
      ## Commit message ##
         http: drop support for curl < 7.16.0
     
    -    As discussed in the previous commit, Git is not well-tested
    -    with old versions of curl (and in fact since v2.12.0 does
    -    not even compile with versions older than 7.19.4). Let's
    -    stop pretending we support curl that old and drop any
    -    now-obslete #ifdefs.
    +    In the last commit we dropped support for curl < 7.11.1, let's
    +    continue that and drop support for versions older than 7.16.0. This
    +    allows us to get rid of some now-obsolete #ifdefs.
     
    -    Choosing 7.16.0 is a somewhat arbitrary cutoff, but:
    +    Choosing 7.16.0 is a somewhat arbitrary cutoff:
     
    -      1. it came out in October of 2006, over 10 years ago.
    -         Besides being a nice round number, it's a common
    -         end-of-life support period, even for conservative
    +      1. It came out in October of 2006, almost 15 years ago.
    +         Besides being a nice round number, around 10 years is
    +         a common end-of-life support period, even for conservative
              distributions.
     
    -      2. that version introduced the curl_multi interface, which
    +      2. That version introduced the curl_multi interface, which
              gives us a lot of bang for the buck in removing #ifdefs
     
    +    RHEL 5 came with curl 7.15.5[1] (released in August 2006). RHEL 5's
    +    extended life cycle program ended on 2020-11-30[1]. RHEL 6 comes with
    +    curl 7.19.7 (released in November 2009), and RHEL 7 comes with
    +    7.29.0 (released in February 2013).
    +
    +    1. http://lore.kernel.org/git/873e1f31-2a96-5b72-2f20-a5816cad1b51@jupiterrise.com
    +
    +    Signed-off-by: Jeff King <peff@peff.net>
    +    Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
    +
      ## http-push.c ##
     @@ http-push.c: static void curl_setup_http(CURL *curl, const char *url,
      	curl_easy_setopt(curl, CURLOPT_INFILE, buffer);
    @@ http.h: void finish_all_active_slots(void);
      void http_init(struct remote *remote, const char *url,
      	       int proactive_auth);
     
    + ## imap-send.c ##
    +@@ imap-send.c: static int curl_append_msgs_to_imap(struct imap_server_conf *server,
    + 	if (cred.username) {
    + 		if (res == CURLE_OK)
    + 			credential_approve(&cred);
    +-#if LIBCURL_VERSION_NUM >= 0x070d01
    + 		else if (res == CURLE_LOGIN_DENIED)
    +-#else
    +-		else
    +-#endif
    + 			credential_reject(&cred);
    + 	}
    + 
    +
      ## remote-curl.c ##
     @@ remote-curl.c: static size_t rpc_out(void *ptr, size_t eltsize,
      	return avail;
3:  335046de7bc ! 3:  faae88b7fec http: drop support for curl < 7.19.4
    @@ Metadata
      ## Commit message ##
         http: drop support for curl < 7.19.4
     
    -    Since v2.12.0, Git does not compile with versions of curl
    -    older than 7.19.4. That version of curl is about 8 years
    -    old. This means it may still be used in some distributions
    -    with long-running support periods. But the fact that we
    -    haven't received a single bug report about the compile-time
    -    breakage implies that nobody cares about building recent
    -    releases on such platforms.
    +    In the last commit we dropped support for curl < 7.16.0, let's
    +    continue that and drop support for versions older than 7.19.4. This
    +    allows us to simplify the code by getting rid of some "#ifdef"'s.
     
    -    As discussed in the previous two commits, this cleans up the
    -    code and gives a more realistic signal to users about which
    -    versions of Git are actually tested (in particular, this
    -    moves us past the potential use-after-free issues with curl
    -    older than 7.17.0).
    +    Git was broken with vanilla curl < 7.19.4 from v2.12.0 until
    +    v2.15.0. Compiling with it was broken by using CURLPROTO_* outside any
    +    "#ifdef" in aeae4db174 (http: create function to get curl allowed
    +    protocols, 2016-12-14), and fixed in v2.15.0 in f18777ba6ef (http: fix
    +    handling of missing CURLPROTO_*, 2017-08-11).
    +
    +    It's unclear how much anyone was impacted by that in practice, since
    +    as noted in [1] RHEL versions using curl older than that still
    +    compiled, because RedHat backported some features. Perhaps other
    +    vendors did the same.
    +
    +    Still, it's one datapoint indicating that it wasn't in active use at
    +    the time. That (the v2.12.0 release) was in Feb 24, 2017, with v2.15.0
    +    on Oct 30, 2017, it's now mid-2021.
    +
    +    1. http://lore.kernel.org/git/c8a2716d-76ac-735c-57f9-175ca3acbcb0@jupiterrise.com;
    +       followed-up by f18777ba6ef (http: fix handling of missing CURLPROTO_*,
    +       2017-08-11)
    +
    +    Signed-off-by: Jeff King <peff@peff.net>
    +    Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## http.c ##
     @@ http.c: static int min_curl_sessions = 1;
    @@ http.c: static void var_override(const char **var, char *value)
      }
      
      static void init_curl_proxy_auth(CURL *result)
    +@@ http.c: void setup_curl_trace(CURL *handle)
    + 	curl_easy_setopt(handle, CURLOPT_DEBUGDATA, NULL);
    + }
    + 
    +-#ifdef CURLPROTO_HTTP
    + static long get_curl_allowed_protocols(int from_user)
    + {
    + 	long allowed_protocols = 0;
    +@@ http.c: static long get_curl_allowed_protocols(int from_user)
    + 
    + 	return allowed_protocols;
    + }
    +-#endif
    + 
    + #if LIBCURL_VERSION_NUM >=0x072f00
    + static int get_curl_http_version_opt(const char *version_string, long *opt)
     @@ http.c: static CURL *get_curl_handle(void)
      	}
      
    @@ http.c: static CURL *get_curl_handle(void)
     -#if LIBCURL_VERSION_NUM >= 0x071301
      	curl_easy_setopt(result, CURLOPT_POSTREDIR, CURL_REDIR_POST_ALL);
     -#elif LIBCURL_VERSION_NUM >= 0x071101
    - 	curl_easy_setopt(result, CURLOPT_POST301, 1);
    +-	curl_easy_setopt(result, CURLOPT_POST301, 1);
     -#endif
     -#ifdef CURLPROTO_HTTP
      	curl_easy_setopt(result, CURLOPT_REDIR_PROTOCOLS,
4:  e049f37357a < -:  ----------- http: #error on too-old curl
-:  ----------- > 4:  9a30e92520c http: drop support for curl < 7.19.3 and < 7.16.4 (again)
-:  ----------- > 5:  64e510b4a6b http: rename CURLOPT_FILE to CURLOPT_WRITEDATA
-- 
2.32.0.874.ge7a9d58bfcf

