Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A048AC433FE
	for <git@archiver.kernel.org>; Wed, 19 Jan 2022 00:01:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350338AbiASABM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Jan 2022 19:01:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350322AbiASABL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jan 2022 19:01:11 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE74C061574
        for <git@vger.kernel.org>; Tue, 18 Jan 2022 16:01:11 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id a22-20020a17090abe1600b001b39929b5fdso581361pjs.0
        for <git@vger.kernel.org>; Tue, 18 Jan 2022 16:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=rf33oGAQGLNE3IYbv2nOi5fRqqva1j1Bb2HcZzPRLNw=;
        b=UqKICOVKQ7Hfoy4iHUmNp9hYm9lsX+GJGQF6TSVdGgEJX0es3NKZyWMR8aaMHSqHGz
         Ek2wVOmn2g2zI8TeSwjN7EevyJooUVFHxPQaXfuzOwO6UPvwF5voASAPxJvNKhQFFzOj
         4Cj/seYagYez8zMiJnHGEPxs5dtgDeIjVpxOeKZQyW4/tDBPodLV4gudP3I9GseFfrFY
         ht68Zebjf8+AD4osv52p4s+42W9lCnNeirJ2dsIij55lLoExodioL89MhQT2LF/2e9Xw
         VOzWNWeSZEHYhYnnWD48Stfq2SB5iV1f8bdCbBUY3Fv1h6tm16pmCv5CoLCnlEBF/JJ9
         ciUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=rf33oGAQGLNE3IYbv2nOi5fRqqva1j1Bb2HcZzPRLNw=;
        b=SWqYmAZ7iYzZt7ZUUMU1jKOy+ViMrFE2xKnzoQSfTGwP1v0PHGFVtu2ka70GgonHTa
         JDfQ61wUEbULWbNYYpo9PKfZaDDuzWV/twI/Rc6IUHXco/Yd3IekDKsifWCo90zKc1BI
         BwO+MWAF+ySOcmOK4n5FBxBRemUL7Y4N7qY+m63criSNylGH+x7rVmp8UhQaVQg4Iky8
         AjurOIlfUO+bYAjuaLQXg9NQs3o/tCsYrj4a/3ELqC1gvaBUC6GCD2pAcikufwxbuYJ6
         +JQ7IR+vITbB2y2Xi4azxPuO6T3ujCmYU/HUFnZO/EN1Zy2/akCCwIgjhBN3G8GF9S19
         cSsQ==
X-Gm-Message-State: AOAM530bI3YtOPx2VWehu99Qn391hoT8daPRpCvXQkEcEwcK0FlRdpgj
        xB9KtgvgfxdM23o3f4Wk4/wX6XHutBlXdLjY4DAUR0CM5ugJQQ5TXfi/KWZ8dUnoYbCIpfm0QMp
        uI841Tqf9lhGj2zsmHa3Bm+nfM2H1IIuDKE1MJdIlwYpFORvXmf8cmtcLR0qCs/c=
X-Google-Smtp-Source: ABdhPJwaBwOMLa8MQ9QYBn2BtjUXWRcweE1PUm22Rb6isOvRcRAIyqLuWMHXgJTzNYXcatIWU9AWNA+VFBRpNA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:903:1249:b0:149:a59c:145a with SMTP
 id u9-20020a170903124900b00149a59c145amr30164850plh.108.1642550470894; Tue,
 18 Jan 2022 16:01:10 -0800 (PST)
Date:   Tue, 18 Jan 2022 16:00:56 -0800
In-Reply-To: <20220119000056.58503-1-chooglen@google.com>
Message-Id: <20220119000056.58503-4-chooglen@google.com>
Mime-Version: 1.0
References: <20220118185453.33710-1-chooglen@google.com> <20220119000056.58503-1-chooglen@google.com>
X-Mailer: git-send-email 2.34.1.703.g22d0c6ccf7-goog
Subject: [PATCH v6 3/3] fetch --negotiate-only: do not update submodules
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

`git fetch --negotiate-only` is an implementation detail of push
negotiation and, unlike most `git fetch` invocations, does not actually
update the main repository. Thus it should not update submodules even
if submodule recursion is enabled.

This is not just slow, it is wrong e.g. push negotiation with
"submodule.recurse=true" will cause submodules to be updated because it
invokes `git fetch --negotiate-only`.

Fix this by disabling submodule recursion if --negotiate-only was given.
Since this makes --negotiate-only and --recurse-submodules incompatible,
check for this invalid combination and die.

This does not use the "goto cleanup" introduced in the previous commit
because we want to recurse through submodules whenever a ref is fetched,
and this can happen without introducing new objects.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 Documentation/fetch-options.txt |  1 +
 builtin/fetch.c                 | 24 +++++++++++++++++++++++-
 t/t5516-fetch-push.sh           | 12 ++++++++++++
 t/t5702-protocol-v2.sh          | 12 ++++++++++++
 4 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
index e967ff1874..f903683189 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -71,6 +71,7 @@ configuration variables documented in linkgit:git-config[1], and the
 	ancestors of the provided `--negotiation-tip=*` arguments,
 	which we have in common with the server.
 +
+This is incompatible with `--recurse-submodules=[yes|on-demand]`.
 Internally this is used to implement the `push.negotiate` option, see
 linkgit:git-config[1].
 
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 7bbff5a029..fef4332fb1 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -76,6 +76,7 @@ static struct transport *gtransport;
 static struct transport *gsecondary;
 static const char *submodule_prefix = "";
 static int recurse_submodules = RECURSE_SUBMODULES_DEFAULT;
+static int recurse_submodules_cli = RECURSE_SUBMODULES_DEFAULT;
 static int recurse_submodules_default = RECURSE_SUBMODULES_ON_DEMAND;
 static int shown_url = 0;
 static struct refspec refmap = REFSPEC_INIT_FETCH;
@@ -167,7 +168,7 @@ static struct option builtin_fetch_options[] = {
 		 N_("prune remote-tracking branches no longer on remote")),
 	OPT_BOOL('P', "prune-tags", &prune_tags,
 		 N_("prune local tags no longer on remote and clobber changed tags")),
-	OPT_CALLBACK_F(0, "recurse-submodules", &recurse_submodules, N_("on-demand"),
+	OPT_CALLBACK_F(0, "recurse-submodules", &recurse_submodules_cli, N_("on-demand"),
 		    N_("control recursive fetching of submodules"),
 		    PARSE_OPT_OPTARG, option_fetch_parse_recurse_submodules),
 	OPT_BOOL(0, "dry-run", &dry_run,
@@ -2014,6 +2015,27 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 
 	argc = parse_options(argc, argv, prefix,
 			     builtin_fetch_options, builtin_fetch_usage, 0);
+
+	if (recurse_submodules_cli != RECURSE_SUBMODULES_DEFAULT)
+		recurse_submodules = recurse_submodules_cli;
+
+	if (negotiate_only) {
+		switch (recurse_submodules_cli) {
+		case RECURSE_SUBMODULES_OFF:
+		case RECURSE_SUBMODULES_DEFAULT:
+			/*
+			 * --negotiate-only should never recurse into
+			 * submodules. Skip it by setting recurse_submodules to
+			 * RECURSE_SUBMODULES_OFF.
+			 */
+			recurse_submodules = RECURSE_SUBMODULES_OFF;
+			break;
+
+		default:
+			die(_("--negotiate-only and --recurse-submodules cannot be used together"));
+		}
+	}
+
 	if (recurse_submodules != RECURSE_SUBMODULES_OFF) {
 		int *sfjc = submodule_fetch_jobs_config == -1
 			    ? &submodule_fetch_jobs_config : NULL;
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 2f04cf9a1c..87881726ed 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -229,6 +229,18 @@ test_expect_success 'push with negotiation proceeds anyway even if negotiation f
 	test_i18ngrep "push negotiation failed" err
 '
 
+test_expect_success 'push with negotiation does not attempt to fetch submodules' '
+	mk_empty submodule_upstream &&
+	test_commit -C submodule_upstream submodule_commit &&
+	git submodule add ./submodule_upstream submodule &&
+	mk_empty testrepo &&
+	git push testrepo $the_first_commit:refs/remotes/origin/first_commit &&
+	test_commit -C testrepo unrelated_commit &&
+	git -C testrepo config receive.hideRefs refs/remotes/origin/first_commit &&
+	git -c submodule.recurse=true -c protocol.version=2 -c push.negotiate=1 push testrepo refs/heads/main:refs/remotes/origin/main 2>err &&
+	! grep "Fetching submodule" err
+'
+
 test_expect_success 'push without wildcard' '
 	mk_empty testrepo &&
 
diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index 710f33e2aa..1b9023d3f0 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -628,6 +628,18 @@ test_expect_success 'usage: --negotiate-only without --negotiation-tip' '
 	test_cmp err.expect err.actual
 '
 
+test_expect_success 'usage: --negotiate-only with --recurse-submodules' '
+	cat >err.expect <<-\EOF &&
+	fatal: --negotiate-only and --recurse-submodules cannot be used together
+	EOF
+
+	test_must_fail git -c protocol.version=2 -C client fetch \
+		--negotiate-only \
+		--recurse-submodules \
+		origin 2>err.actual &&
+	test_cmp err.expect err.actual
+'
+
 test_expect_success 'file:// --negotiate-only' '
 	SERVER="server" &&
 	URI="file://$(pwd)/server" &&
-- 
2.33.GIT

