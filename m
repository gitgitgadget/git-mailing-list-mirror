Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 13F5520373
	for <e@80x24.org>; Mon, 13 Mar 2017 21:43:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753587AbdCMVnx (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Mar 2017 17:43:53 -0400
Received: from mail-pg0-f46.google.com ([74.125.83.46]:34018 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753410AbdCMVnu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2017 17:43:50 -0400
Received: by mail-pg0-f46.google.com with SMTP id 77so70560636pgc.1
        for <git@vger.kernel.org>; Mon, 13 Mar 2017 14:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eW+1JXnUXltW3o4kBU8sW1TFI+sTjQJFucZd6w0XPzM=;
        b=NdAVPg0SqlT1tLRtcEVoj1RKA5u7K920kCv+SyHawONVo+uC39fG9ntgshO+Qq2Ps8
         +3KWpGzJ1rYQJlqAnsiIp1GB5Wb8Cv5wAALS9wnpVvfoW7x8QCj9oxjKXlVaqJNCXFjD
         vWhDjO9woAd23Y0gE+4vDqZmoFIy5HwDySYGKjhnomRqFcUeGOlWYuwCKLJ3KinpyqjM
         fsX5TwW2CaQnS5vQPLlHX3zuRhIlz+OxxAcCVxqfh4YHDukB7kcoedRw2rVl8S2fEYhr
         ToYh1hKaV/ZXvce7KAetpFx1UURnvdvRt1weHV3IBqLYmf+C+Eyn0sGmZ3Jsyp/XgaNZ
         IZxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eW+1JXnUXltW3o4kBU8sW1TFI+sTjQJFucZd6w0XPzM=;
        b=lJGZwBC14UPpsi+ffGJhQqfPy/OwnqBSxNEmS0wewekB4vV8EiI6RRU/zStRlut1L1
         VhF2U5mQaK87lCspJpZhnUKDl8JMIsCcjbC2kKGxoop9KgKlbHeFwAG4NWAEAa1dhJJx
         tyDEMeOjlT4MIQkrvT8HSO4eyEUkbINwFhtGb4JjhqdiqjzDqW5f08wJnZRT032pp2do
         Vd02GRIeMkd0Ro4ko1+KEO3x1kT9ATwsFphPHcOFX9t2ySfUf3BAe00leTps1opeoBP7
         htKzYN3D1S436mv+reySdubMigoPckffdRxtTl0d4tUjfV0o9qS0rR804Lh8rq5SDWQU
         Ai4w==
X-Gm-Message-State: AMke39ltkWOFeRuEHhShjsWEY8lCSkMeUHWCQtgerct1ueIW0oQ/MZW3vjl5e2N4BVqHnFLS
X-Received: by 10.98.18.216 with SMTP id 85mr40155095pfs.131.1489441428447;
        Mon, 13 Mar 2017 14:43:48 -0700 (PDT)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id 129sm34525937pgj.59.2017.03.13.14.43.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 13 Mar 2017 14:43:47 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        gitster@pobox.com
Subject: [PATCH v3 02/10] submodule status: use submodule--helper is-active
Date:   Mon, 13 Mar 2017 14:43:33 -0700
Message-Id: <20170313214341.172676-3-bmwill@google.com>
X-Mailer: git-send-email 2.12.0.246.ga2ecc84866-goog
In-Reply-To: <20170313214341.172676-1-bmwill@google.com>
References: <20170309012345.180702-1-bmwill@google.com>
 <20170313214341.172676-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 git-submodule.sh | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 136e26a2c..ab233712d 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -1010,14 +1010,13 @@ cmd_status()
 	do
 		die_if_unmatched "$mode" "$sha1"
 		name=$(git submodule--helper name "$sm_path") || exit
-		url=$(git config submodule."$name".url)
 		displaypath=$(git submodule--helper relative-path "$prefix$sm_path" "$wt_prefix")
 		if test "$stage" = U
 		then
 			say "U$sha1 $displaypath"
 			continue
 		fi
-		if test -z "$url" ||
+		if ! git submodule--helper is-active "$sm_path" ||
 		{
 			! test -d "$sm_path"/.git &&
 			! test -f "$sm_path"/.git
-- 
2.12.0.246.ga2ecc84866-goog

