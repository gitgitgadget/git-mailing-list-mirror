Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A2F4C433EF
	for <git@archiver.kernel.org>; Fri, 28 Jan 2022 01:56:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345191AbiA1B4N (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jan 2022 20:56:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345178AbiA1B4M (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jan 2022 20:56:12 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB0A4C061714
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 17:56:11 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id e2so8046248wra.2
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 17:56:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=JsUXzdCzS5uRTLB8u3OhMqsFDcH1Q4tcFkhtcvu8TxM=;
        b=EGxJ0pMwO/BBH/HrlkNo4wrAmnpIl1USuaFDn1JIy9r4cyVSnRH2tFtw5G1113I88W
         iUckBoYefIPewRCZSsVO5dlgF7FVRD2laZ07awXJl/iLLxInO0WkxfErtGLXF6FCrFMn
         a2ea76i10B6yi9Er5FC7YsBgmTlpPe4QKQ6oI0GUgy/xIJR4b1+qbY+SuBxx0f/dwEb2
         UQ9WtJMXQalUNvad1j8+L6FSZ2P+cnzR84DpYNsg83HAdA5iPFPknNMMY0YAfUdOXT/o
         sAODkcXElOzSS17vITo3rFPbSX9pDwuiiTtKM5WW++4UIX/gYR9nrtP9gTrQBonsii+C
         r4rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=JsUXzdCzS5uRTLB8u3OhMqsFDcH1Q4tcFkhtcvu8TxM=;
        b=OY5cTHtqzoV/aphK/zXYbXf9WUmqw/8kIaQZ0eUxpAY3+TaDMqqbc4hMa7ZA3rVEUn
         41pLfb9rrlruraqMPvP2/SeZMX6NsOo5SiMYQBtZ86l0d4HPT4So6N/nHhJRx19Xqg5u
         5rV1JBBQ3R2IDWvhvOSbF28KrFW1yewOPFhydv1PhGZnXEGERVy8icpWOelSp9ynazMw
         G/pH4re3ncOwG8wwG8VIg2RE/V1lRxj3f201rE+nCgcqJp3mSOsqzyWdf0P79DiKq3Mm
         bDlu7NzvWBbQI7Rfyq48PGPdG1wlqOox0YUMAILJBJ9m/5wkpFxcJ1qhVK3Z5+84nFAk
         xQXw==
X-Gm-Message-State: AOAM531PiCYDUGmsGMMKSfZ22FdSWzMMQpCZgGQCmQKFUx3IAWUyaeXt
        7jowe6u4XSzrCpirJjBjmxpccdiOLL8=
X-Google-Smtp-Source: ABdhPJx3j4mDszjWT46ORis7EBR60Q7miWA9uaVKKi+J4n0x/le1I9nV42otkYhC3dMfxjihWJ24Ow==
X-Received: by 2002:a5d:47cf:: with SMTP id o15mr5097329wrc.577.1643334970190;
        Thu, 27 Jan 2022 17:56:10 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u19sm689348wmm.39.2022.01.27.17.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 17:56:09 -0800 (PST)
Message-Id: <pull.1131.git.1643334969216.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 28 Jan 2022 01:56:09 +0000
Subject: [PATCH] repo-settings: fix checking for
 fetch.negotiationAlgorithm=default
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

In commit 3050b6dfc75d (repo-settings.c: simplify the setup,
2021-09-21), the branch for handling fetch.negotiationAlgorithm=default
was deleted.  Since this value is documented in
Documentation/config/fetch.txt, restore the check for this value.

Note that this change caused an observable bug: if someone sets
feature.experimental=true in config, and then passes "-c
fetch.negotiationAlgorithm=default" on the command line in an attempt to
override the config, then the override is ignored.  Fix the bug by not
ignoring the value of "default".

Technically, before commit 3050b6dfc75d, repo-settings would treat any
fetch.negotiationAlgorithm value other than "skipping" or "noop" as a
request for "default", but I think it probably makes more sense to
ignore such broken requests and leave fetch.negotiationAlgorithm with
the default value rather than the value of "default".  (If that sounds
confusing, note that "default" is usually the default value, but when
feature.experimental=true, "skipping" is the default value.)

Signed-off-by: Elijah Newren <newren@gmail.com>
---
    repo-settings: fix checking for fetch.negotiationAlgorithm=default
    
    This regression is not new in v2.35; it first appeared in v2.34. So, not
    urgent.
    
    A long sidenote about naming things "default":
    
    Many years ago, in the Gnome community, there was a huge fight that
    erupted, in part due to confusion over "default". There was a journalist
    who had been a designer in a past life, who had a little friction with
    the rest of the community, but intended well and generally improved
    things. At some point, they suggested some changes to improve the
    "default" theme (and they were a nice improvement), but not being a
    developer the changes weren't communicated in the form of a patch. And
    the changes accidentally got applied to the wrong theme: the default one
    (yes, there was a theme named "default" which was not the default
    theme). Now, basically no one used the default theme because it was so
    hideously ugly. I think we suffered from a case of not being able to
    change the default (again?) because no one could get an agreement on
    what the default should be. Who did actually use the default theme,
    though? The person writing the release notes (though they only used it
    for taking screenshots to include in the release notes, and otherwise
    used some other theme). So, with people under pressure for an imminent
    release, there were screenshots that looked like garbage, and
    investigation eventually uncovered that it was due to changes that were
    meant for the "default" theme having accidentally been applied to the
    default theme. It could have just been an amusing story if not for the
    other unfortunate factors happening around the same time and the heated
    and protracted flamewars that erupted.
    
    Don't name settings/themes/things "default" if it describes something
    specific, since someone may come along and decide that something else
    should be the default, and then you're stuck with a non-default
    "default". Sadly, the name was already picked and documented so for
    backward compatibility we need to support it...

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1131%2Fnewren%2Ffix-fetch-negotiation-algorithm-equals-default-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1131/newren/fix-fetch-negotiation-algorithm-equals-default-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1131

 repo-settings.c       |  2 ++
 t/t5500-fetch-pack.sh | 40 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/repo-settings.c b/repo-settings.c
index 00ca5571a1a..38c10f9977b 100644
--- a/repo-settings.c
+++ b/repo-settings.c
@@ -85,6 +85,8 @@ void prepare_repo_settings(struct repository *r)
 			r->settings.fetch_negotiation_algorithm = FETCH_NEGOTIATION_SKIPPING;
 		else if (!strcasecmp(strval, "noop"))
 			r->settings.fetch_negotiation_algorithm = FETCH_NEGOTIATION_NOOP;
+		else if (!strcasecmp(strval, "default"))
+			r->settings.fetch_negotiation_algorithm = FETCH_NEGOTIATION_DEFAULT;
 	}
 
 	/*
diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index f0dc4e69686..37958a376ca 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -928,6 +928,7 @@ test_expect_success 'fetching deepen' '
 '
 
 test_expect_success 'use ref advertisement to prune "have" lines sent' '
+	test_when_finished rm -rf clientv0 clientv2 &&
 	rm -rf server client &&
 	git init server &&
 	test_commit -C server both_have_1 &&
@@ -960,6 +961,45 @@ test_expect_success 'use ref advertisement to prune "have" lines sent' '
 	! grep "have $(git -C client rev-parse both_have_2^)" trace
 '
 
+test_expect_success 'same as last but with config overrides' '
+	test_when_finished rm -rf clientv0 clientv2 &&
+	rm -rf server client &&
+	git init server &&
+	test_commit -C server both_have_1 &&
+	git -C server tag -d both_have_1 &&
+	test_commit -C server both_have_2 &&
+
+	git clone server client &&
+	test_commit -C server server_has &&
+	test_commit -C client client_has &&
+
+	# In both protocol v0 and v2, ensure that the parent of both_have_2 is
+	# not sent as a "have" line. The client should know that the server has
+	# both_have_2, so it only needs to inform the server that it has
+	# both_have_2, and the server can infer the rest.
+
+	rm -f trace &&
+	rm -rf clientv0 &&
+	cp -r client clientv0 &&
+	GIT_TRACE_PACKET="$(pwd)/trace" git -C clientv0 \
+		-c feature.experimental=true \
+		-c fetch.negotiationAlgorithm=default \
+		fetch origin server_has both_have_2 &&
+	grep "have $(git -C client rev-parse client_has)" trace &&
+	grep "have $(git -C client rev-parse both_have_2)" trace &&
+	! grep "have $(git -C client rev-parse both_have_2^)" trace &&
+
+	rm -f trace &&
+	cp -r client clientv2 &&
+	GIT_TRACE_PACKET="$(pwd)/trace" git -C clientv2 -c protocol.version=2 \
+		-c feature.experimental=true \
+		-c fetch.negotiationAlgorithm=default \
+		fetch origin server_has both_have_2 &&
+	grep "have $(git -C client rev-parse client_has)" trace &&
+	grep "have $(git -C client rev-parse both_have_2)" trace &&
+	! grep "have $(git -C client rev-parse both_have_2^)" trace
+'
+
 test_expect_success 'filtering by size' '
 	rm -rf server client &&
 	test_create_repo server &&

base-commit: 89bece5c8c96f0b962cfc89e63f82d603fd60bed
-- 
gitgitgadget
