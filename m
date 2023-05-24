Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8263BC77B7C
	for <git@archiver.kernel.org>; Wed, 24 May 2023 16:03:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbjEXQDl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 May 2023 12:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjEXQDW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 May 2023 12:03:22 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF64E74
        for <git@vger.kernel.org>; Wed, 24 May 2023 09:02:39 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-561b65b34c4so16903887b3.1
        for <git@vger.kernel.org>; Wed, 24 May 2023 09:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1684944150; x=1687536150;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=x75bRTLDPv+wPv4paroKRkzmZjMtE3CmoEnjRM1Suso=;
        b=JG1upRM3Op+5teCUreAKUbS5Npn7908z4gIE5SvASY3qh7Vcdi/jAs6YIDM11LEdMR
         J/DP9EtQyHJLUQCaUXpn++TU+eLO/WtE+GILp4EkusM6ebXAhy/z5d68NJmbqKnoSmOc
         KM0RQvm87/ZrS1sIa018hCoI6MWJzHh8I7dfQjpgUNRVsjvHrWUabBja5+P8SsATbSig
         FLk42xAFp3lSnXm+H1iPMQR362q51CV5JBQTev5ptVxVUWfjQtb+mAiPiDy46G8b0iHX
         Rb6vUlq1E4RWDIpvQkm4rsOt//AiYQooQ4Ecpcsw4Rg/f7t59JWmhmoj4aXSpCGexM3K
         6LXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684944150; x=1687536150;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x75bRTLDPv+wPv4paroKRkzmZjMtE3CmoEnjRM1Suso=;
        b=KDOIEy+emUt28UjrTtE697QmmAZh1p9dcyj53AkaNrGJJ/1dVTlbUXCM3l+rh+1Flf
         8BXz7vmXFNzOEFEaTt3qCKzeKVthAG63PbF2S9bu6wCfAX3iOvvkFDPn46X5CrckIV9L
         /a57gduEu+02i9xk8V2oVzknlLb0F1EYSbz/XUFe7LWlcg1yVeODLEYzScbpwqXu9WhC
         A2k5Sv+oIXIQy5/jJiGPu3YB7b0qn279Tu9oRne0TRWPW1HQ43hU8Y/QixengS01x/lf
         ktlSPJ/Fxmwkz/361zyy3VJuEDkAQ9gRQK2+El6sH98bSmj9dEdHFjvK0ak3sUUCHIBI
         oHLw==
X-Gm-Message-State: AC+VfDytiggg3Vv220oc+Y5NW0ma/bjEuwE2id84M+Z/TL75vXLlpLux
        NKAS8FcEWpQPXvkx+VGjvkz1Oaw7KK9aipVb5o6GKA==
X-Google-Smtp-Source: ACHHUZ4q6qhlG54G7RJMJhI/4FFRioIW8bwzcKWR9eWEvpYbOQfP/9nA2EDNZ/wpNhU1YGKcLPs+Lg==
X-Received: by 2002:a0d:fd85:0:b0:565:7d7:1356 with SMTP id n127-20020a0dfd85000000b0056507d71356mr9981315ywf.22.1684944149968;
        Wed, 24 May 2023 09:02:29 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id c185-20020a0ddac2000000b00545a08184desm3818212ywe.110.2023.05.24.09.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 09:02:27 -0700 (PDT)
Date:   Wed, 24 May 2023 12:02:26 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Tribo Dar <3bodar@gmail.com>,
        Stefan Beller <stefanbeller@gmail.com>
Subject: [PATCH] builtin/submodule--helper.c: handle missing submodule URLs
Message-ID: <f7a8de14fe255286e62fc46d0a3083189f46bcc6.1684944140.git.me@ttaylorr.com>
References: <ZG4jcceXn2G6Xic0@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZG4jcceXn2G6Xic0@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In e0a862fdaf (submodule helper: convert relative URL to absolute URL if
needed, 2018-10-16), `prepare_to_clone_next_submodule()` lost the
ability to handle URL-less submodules, due to a change from:

    if (repo_get_config_string_const(the_repostiory, sb.buf, &url))
        url = sub->url;

to

    if (repo_get_config_string_const(the_repostiory, sb.buf, &url)) {
        if (starts_with_dot_slash(sub->url) ||
            starts_with_dot_dot_slash(sub->url)) {
                /* ... */
            }
    }

, which will segfault when `sub->url` is NULL, since both
`starts_with_dot_slash()` does not guard its arguments as non-NULL.

Guard the checks to both of the above functions by first whether
`sub->url` is non-NULL. There is no need to check whether `sub` itself
is NULL, since we already perform this check earlier in
`prepare_to_clone_next_submodule()`.

By adding a NULL-ness check on `sub->url`, we'll fall into the 'else'
branch, setting `url` to `sub->url` (which is NULL). When we then try
and invoke `git submodule-helper` below, we'll get the expected error
message:

    error: option `url' requires a value

Note that this means that `--url` and its value must come last when
preparing the argument list, to avoid confusing the next argument as the
value for `--url` if `url` itself is NULL.

Reported-by: Tribo Dar <3bodar@gmail.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/submodule--helper.c | 11 ++++++++---
 t/t7400-submodule-basic.sh  | 16 ++++++++++++++++
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 6bf8d666ce..a7b7ea374f 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2024,8 +2024,8 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
 	strbuf_reset(&sb);
 	strbuf_addf(&sb, "submodule.%s.url", sub->name);
 	if (repo_config_get_string_tmp(the_repository, sb.buf, &url)) {
-		if (starts_with_dot_slash(sub->url) ||
-		    starts_with_dot_dot_slash(sub->url)) {
+		if (sub->url && (starts_with_dot_slash(sub->url) ||
+				 starts_with_dot_dot_slash(sub->url))) {
 			url = resolve_relative_url(sub->url, NULL, 0);
 			need_free_url = 1;
 		} else
@@ -2069,7 +2069,6 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
 		strvec_push(&child->args, "--require-init");
 	strvec_pushl(&child->args, "--path", sub->path, NULL);
 	strvec_pushl(&child->args, "--name", sub->name, NULL);
-	strvec_pushl(&child->args, "--url", url, NULL);
 	if (suc->update_data->references.nr) {
 		struct string_list_item *item;
 
@@ -2082,6 +2081,12 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
 		strvec_push(&child->args, suc->update_data->single_branch ?
 					      "--single-branch" :
 					      "--no-single-branch");
+	/*
+	 * `url` might be NULL, so ensure that this argument is passed
+	 * last to avoid confusing the next argument as the value for
+	 * `--url`.
+	 */
+	strvec_pushl(&child->args, "--url", url, NULL);
 
 cleanup:
 	free(displaypath);
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index eae6a46ef3..c97c543dd8 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -1351,6 +1351,22 @@ test_expect_success 'clone active submodule without submodule url set' '
 	)
 '
 
+test_expect_success 'update submodules without url set in .gitconfig' '
+	test_when_finished "rm -rf multisuper_clone" &&
+	git clone file://"$pwd"/multisuper multisuper_clone &&
+
+	git -C multisuper_clone submodule init &&
+	for s in sub0 sub1 sub2 sub3
+	do
+		key=submodule.$s.url &&
+		git -C multisuper_clone config --local --unset $key &&
+		git -C multisuper_clone config --file .gitmodules --unset $key || return 1
+	done &&
+
+	test_must_fail git -C multisuper_clone submodule update 2>err &&
+	grep "option .url. requires a value" err
+'
+
 test_expect_success 'clone --recurse-submodules with a pathspec works' '
 	test_when_finished "rm -rf multisuper_clone" &&
 	cat >expected <<-\EOF &&
-- 
2.41.0.rc1.11.gf7a8de14fe
