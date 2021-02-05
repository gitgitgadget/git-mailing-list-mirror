Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2FDEC433E0
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 04:59:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9826264E22
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 04:59:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbhBEE7Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Feb 2021 23:59:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbhBEE7S (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Feb 2021 23:59:18 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56D42C061786
        for <git@vger.kernel.org>; Thu,  4 Feb 2021 20:58:38 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id e23so4028520pfl.20
        for <git@vger.kernel.org>; Thu, 04 Feb 2021 20:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=hSDjlzoL8yJQM+iQ+NY+IMfQLmZiAhYCsEGLQrYJ61s=;
        b=hecMMlDCx1L5VtHxuuXVdNReSxLuhiwrVU4lZpcZArcHBs056mR/sURyW3upA/0O6/
         EJTfxqrxXl1N35jtm56pErzcRBhy0oAO5Jq80vNOtto11eDek4yKsE8k/EwpcF3PtG93
         3gSdM+N9XeWYHtSh9MmM8FdalJYCwWgO3NvDwYNz5eSAPtOmSxZlifXcUZSDmulIfzFJ
         pPCpNXQ4awdKtx7dWVMBPqtvSPOoSskJHo4tqMPZo/bt8+Ow7IfK30u609gPC4uCUwBV
         S2GUInBkmsSlIn21BaYYbaHvdRXL55oThQUVOhqm7Lf9nFgM1yg5OiBH4sgtL837HBNe
         01+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=hSDjlzoL8yJQM+iQ+NY+IMfQLmZiAhYCsEGLQrYJ61s=;
        b=o7VvvkQ4KSI89zEAzmwvqtBm+VPUdur0fLcI/gmP+agh7fqmkY18z5TIuZRt7QCByl
         GYyBxap5cqfdKpknl7RReSb4VFAEQpszZZUgtq0sAqnzMPt2VBw05Dn0bkaup8fui3Kh
         XwtnM4HVMkeLO2ZbIBaCI5mwxpqS9Xd601ZapCFkoHPU06xxRQNvI4VxmgS8b0kP389F
         8Um8LCJWQhE62W35jQaWKQcoc1LN3ihh8p5YcwehPLzfJFcIHCHXUZYj5qZNZr29PApH
         X08hPCk/MNIRh5ptcfenytnqPtEus7gPS3xpnoGD9e77Qj815lpWxe0bJn5snHis+7BY
         Kl3g==
X-Gm-Message-State: AOAM533kU+LD7EP04lKI2adKww8WePw9rnbdj535wMbahWFYF3as4unI
        2H2mpwN//92Ry6LSsXYQz/zSlFYBiMAoFS2ATtXwx92ac4MY1Q4y+wuO/0q3zxg3CjyztmVVAxd
        TzZT/utXRngxxL11mhYatqW7NDvnHhbnHoTKX1Xl4I4wOIYDz/gykjokeU8anuW/ijqkHmqwyth
        iL
X-Google-Smtp-Source: ABdhPJxj20Gqv/OHaBWt6SFNxzf6GMKunIfTgZQRokWmSjl5GIzBJU/EeXMEtYyequgRTkcTw849I8S8QzxRIUe5ein7
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a62:158c:0:b029:1bf:15c6:33be with
 SMTP id 134-20020a62158c0000b02901bf15c633bemr2722976pfv.56.1612501117542;
 Thu, 04 Feb 2021 20:58:37 -0800 (PST)
Date:   Thu,  4 Feb 2021 20:58:30 -0800
In-Reply-To: <20201208013121.677494-1-jonathantanmy@google.com>
Message-Id: <cover.1612493309.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <20201208013121.677494-1-jonathantanmy@google.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH v7 0/3] Cloning with remote unborn HEAD
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For what it's worth, here's v7 with advertise/allow/ignore and by
default, advertise. I think that some server operators will have use for
this feature, and people who want to disable it for whatever reason can
still do so. The main disadvantage is complexity - the server knob that
server administrators will need to control (but between a simpler
allow/ignore knob and a more complicated advertise/allow/ignore knob, I
think we might as well go for the slightly more complex one) and
complexity in the code (but now that is constrained to one function and
a few global variables).

As you can see from the range-diff, not much has changed from v6.

I've also included Junio's suggestion of tightening the promise made by
the server (when the client says "unborn").

Jonathan Tan (3):
  ls-refs: report unborn targets of symrefs
  connect, transport: encapsulate arg in struct
  clone: respect remote unborn HEAD

 Documentation/config.txt                |  2 +
 Documentation/config/init.txt           |  2 +-
 Documentation/config/lsrefs.txt         |  9 +++
 Documentation/technical/protocol-v2.txt | 11 +++-
 builtin/clone.c                         | 34 +++++++++---
 builtin/fetch-pack.c                    |  3 +-
 builtin/fetch.c                         | 18 +++---
 builtin/ls-remote.c                     |  9 +--
 connect.c                               | 32 ++++++++++-
 ls-refs.c                               | 74 ++++++++++++++++++++++++-
 ls-refs.h                               |  1 +
 remote.h                                |  4 +-
 serve.c                                 |  2 +-
 t/t5606-clone-options.sh                |  8 ++-
 t/t5701-git-serve.sh                    |  2 +-
 t/t5702-protocol-v2.sh                  | 25 +++++++++
 transport-helper.c                      |  5 +-
 transport-internal.h                    | 10 +---
 transport.c                             | 23 ++++----
 transport.h                             | 29 +++++++---
 20 files changed, 240 insertions(+), 63 deletions(-)
 create mode 100644 Documentation/config/lsrefs.txt

Range-diff against v6:
1:  411bbafe25 ! 1:  2d35075369 ls-refs: report unborn targets of symrefs
    @@ Commit message
         Currently, symrefs that have unborn targets (such as in this case) are
         not communicated by the protocol. Teach Git to advertise and support the
         "unborn" feature in "ls-refs" (by default, this is advertised, but
    -    server administrators may turn this off through the lsrefs.allowunborn
    +    server administrators may turn this off through the lsrefs.unborn
         config). This feature indicates that "ls-refs" supports the "unborn"
         argument; when it is specified, "ls-refs" will send the HEAD symref with
         the name of its unborn target.
    @@ Documentation/config.txt: include::config/interactive.txt[]
     
      ## Documentation/config/lsrefs.txt (new) ##
     @@
    -+lsrefs.allowUnborn::
    -+	Allow the server to send information about unborn symrefs during the
    -+	protocol v2 ref advertisement.
    ++lsrefs.unborn::
    ++	May be "advertise" (the default), "allow", or "ignore". If "advertise",
    ++	the server will respond to the client sending "unborn" (as described in
    ++	protocol-v2.txt) and will advertise support for this feature during the
    ++	protocol v2 capability advertisement. "allow" is the same as
    ++	"advertise" except that the server will not advertise support for this
    ++	feature; this is useful for load-balanced servers that cannot be
    ++	updated automatically (for example), since the administrator could
    ++	configure "allow", then after a delay, configure "advertise".
     
      ## Documentation/technical/protocol-v2.txt ##
     @@ Documentation/technical/protocol-v2.txt: ls-refs takes in the following arguments:
    @@ Documentation/technical/protocol-v2.txt: ls-refs takes in the following argument
     +included in the client's request.
     +
     +    unborn
    -+	The server may send symrefs pointing to unborn branches in the form
    -+	"unborn <refname> symref-target:<target>".
    ++	The server will send information about HEAD even if it is a symref
    ++	pointing to an unborn branch in the form "unborn HEAD
    ++	symref-target:<target>".
     +
      The output of ls-refs is as follows:
      
    @@ ls-refs.c
      #include "config.h"
      
     +static int config_read;
    ++static int advertise_unborn;
     +static int allow_unborn;
     +
     +static void ensure_config_read(void)
     +{
    ++	char *str = NULL;
    ++
     +	if (config_read)
     +		return;
     +
    -+	if (repo_config_get_bool(the_repository, "lsrefs.allowunborn",
    -+				 &allow_unborn))
    ++	if (repo_config_get_string(the_repository, "lsrefs.unborn", &str)) {
     +		/*
    -+		 * If there is no such config, set it to 1 to allow it by
    ++		 * If there is no such config, advertise and allow it by
     +		 * default.
     +		 */
    ++		advertise_unborn = 1;
     +		allow_unborn = 1;
    ++	} else {
    ++		if (!strcmp(str, "advertise")) {
    ++			advertise_unborn = 1;
    ++			allow_unborn = 1;
    ++		} else if (!strcmp(str, "allow")) {
    ++			allow_unborn = 1;
    ++		} else if (!strcmp(str, "ignore")) {
    ++			/* do nothing */
    ++		} else {
    ++			die(_("invalid value '%s' for lsrefs.unborn"), str);
    ++		}
    ++	}
     +	config_read = 1;
     +}
     +
    @@ ls-refs.c: int ls_refs(struct repository *r, struct strvec *keys,
     +{
     +	if (value) {
     +		ensure_config_read();
    -+		if (allow_unborn)
    ++		if (advertise_unborn)
     +			strbuf_addstr(value, "unborn");
     +	}
     +
2:  fad1ebe6b6 = 2:  d4ed13d02e connect, transport: encapsulate arg in struct
3:  45a48ccc0d ! 3:  a3e5a0a7c5 clone: respect remote unborn HEAD
    @@ t/t5606-clone-options.sh: test_expect_success 'redirected clone -v does show pro
     -	git init --bare empty &&
     +	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME= \
     +	git -c init.defaultBranch=foo init --bare empty &&
    -+	test_config -C empty lsrefs.allowUnborn true &&
    ++	test_config -C empty lsrefs.unborn advertise &&
      	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME= \
      	git -c init.defaultBranch=up clone empty whats-up &&
     -	test refs/heads/up = $(git -C whats-up symbolic-ref HEAD) &&
    @@ t/t5702-protocol-v2.sh: test_expect_success 'clone with file:// using protocol v
     +
     +	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME= \
     +	git -c init.defaultBranch=mydefaultbranch init file_empty_parent &&
    -+	test_config -C file_empty_parent lsrefs.allowUnborn false &&
    ++	test_config -C file_empty_parent lsrefs.unborn ignore &&
     +
     +	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME= \
     +	git -c init.defaultBranch=main -c protocol.version=2 \
-- 
2.30.0.365.g02bc693789-goog

