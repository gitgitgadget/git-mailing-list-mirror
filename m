Return-Path: <SRS0=VPsx=4V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A083C3F2D1
	for <git@archiver.kernel.org>; Wed,  4 Mar 2020 15:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07ACB2166E
	for <git@archiver.kernel.org>; Wed,  4 Mar 2020 15:53:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YZP/qT4m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387609AbgCDPxQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Mar 2020 10:53:16 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43791 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbgCDPxP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Mar 2020 10:53:15 -0500
Received: by mail-ed1-f65.google.com with SMTP id dc19so2854692edb.10
        for <git@vger.kernel.org>; Wed, 04 Mar 2020 07:53:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=9jCPgKpugcvqQd1Dtw122cOqy4ArE+jkMaU27oVK0es=;
        b=YZP/qT4mIgcQFZE8aSwKIhFA2v+nZRoqV27zoSOSXxTEZVC1OrJjoIj5zBTvBdD7hy
         LbUo2mSr+JJ1CPsndYAYz7RJUT65UPtcwNNaRV9q/hvodVonpnOXs8uKrCQ7xW/lnbhp
         yAEnMXJvqyZr2ALtc4bWTMgT++eoRUegCIN9VP807aeJ3fc6ct7IkeJz6i57+b/jhNNF
         jvmL1mF55nUQ9yghytOqUTYDFiYTZZ5nMVRBtvS9z5GRuEEIgyFwP1l20G2dV6wSr8hD
         6HeBm+9jOVKF4GlyqEjn3/g0GWtmWpKCqnEPYqxvK1tX50d+V9WCk9m7KDM7Wq8zXrBH
         mGNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=9jCPgKpugcvqQd1Dtw122cOqy4ArE+jkMaU27oVK0es=;
        b=H8b66LEE5rwHjCpwBtbSsiP0ABgM4DlYu1Qxmc1KDTj+kY+CznvTDgp8c3IohYOlRW
         emDL9cKPHRS/QoDuHfRlmjnNymka3LqvxiUw7vUOSVAToZfXCOaTOVop2SFMGbTnpxB4
         M2GtlGlSCHpM8hVz2ZjkqTpehVjItGCwGYc1JoswhUayYfz/yB5V1DMIghEoob8uY4a4
         eMJscTX5+tJ8xNQ3Vn7TdEGk+WwatBJRKV929n+mWjJOgMo0UvhH1Kc6NAirZZd9jPIe
         oQjYktRAGXPk3xS2I4hz8m+wr9+LZ2nQqyxOx6Oqk6YIk7a2vAdz7pjUm6Jm58K0LqW6
         +1DA==
X-Gm-Message-State: ANhLgQ2aStPw6Vd/VqSgh+VUdZ9ysiBDsBTzq0ia0qtslIzxl0DM3DS7
        aA1SgnD6i/wSEAFsiKXxJdbvmB55
X-Google-Smtp-Source: ADFU+vtwUgA5pI401o3xAQ1vfXJo2IoKY1LWv1leI3vOJffYWfa5SgMtQ54TySSIb2i8Z60uKgrM7w==
X-Received: by 2002:a05:6402:206c:: with SMTP id bd12mr3284002edb.212.1583337194065;
        Wed, 04 Mar 2020 07:53:14 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f20sm404787edm.38.2020.03.04.07.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 07:53:13 -0800 (PST)
Message-Id: <pull.717.v2.git.git.1583337192946.gitgitgadget@gmail.com>
In-Reply-To: <pull.717.git.git.1582834951742.gitgitgadget@gmail.com>
References: <pull.717.git.git.1582834951742.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 04 Mar 2020 15:53:12 +0000
Subject: [PATCH v2] t5537: adjust test_oid label
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

We recently switched to using Perl instead of `sed` in the httpd-based
tests. Let's reflect that in the label we give the corresponding commit
hashes.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    Follow-up for "ci: upgrade to the latest Azure Pipelines agent pools"
    
    This is a companion patch for https://github.com/git/git/pull/714,
    adding a patch that would not apply to maint but applies to master. It
    is intended to be applied on top of the merge that pulls in the agent
    pool upgrade (which in turn is intended to be applied on top of maint).
    
    Changes since v1:
    
     * Rebased onto master, as it now has all the building blocks needed for
       this.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-717%2Fdscho%2Fazure-pipelines-latest-pools-test_oid-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-717/dscho/azure-pipelines-latest-pools-test_oid-v2
Pull-Request: https://github.com/git/git/pull/717

Range-diff vs v1:

 1:  79ad5eaa75b ! 1:  a6e4e9cc6ad t5537: adjust test_oid label
     @@ -30,4 +30,4 @@
      +	printf "$(test_oid perl)" \
       	       "$(git -C "$REPO" rev-parse HEAD)" \
       	       "$(git -C "$REPO" rev-parse HEAD^)" \
     - 	       >"$HTTPD_ROOT_PATH/one-time-perl" &&
     + 	       >"$HTTPD_ROOT_PATH/one-time-sed" &&


 t/t5537-fetch-shallow.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t5537-fetch-shallow.sh b/t/t5537-fetch-shallow.sh
index 9e16512fe31..287d2c336be 100755
--- a/t/t5537-fetch-shallow.sh
+++ b/t/t5537-fetch-shallow.sh
@@ -17,8 +17,8 @@ test_expect_success 'setup' '
 	commit 4 &&
 	git config --global transfer.fsckObjects true &&
 	test_oid_cache <<-EOF
-	sed sha1:s/0034shallow %s/0036unshallow %s/
-	sed sha256:s/004cshallow %s/004eunshallow %s/
+	perl sha1:s/0034shallow %s/0036unshallow %s/
+	perl sha256:s/004cshallow %s/004eunshallow %s/
 	EOF
 '
 
@@ -243,7 +243,7 @@ test_expect_success 'shallow fetches check connectivity before writing shallow f
 	# with an empty packfile. This is done by refetching with a shorter
 	# depth (to ensure that the packfile is empty), and overwriting the
 	# shallow line in the response with the unshallow line we want.
-	printf "$(test_oid sed)" \
+	printf "$(test_oid perl)" \
 	       "$(git -C "$REPO" rev-parse HEAD)" \
 	       "$(git -C "$REPO" rev-parse HEAD^)" \
 	       >"$HTTPD_ROOT_PATH/one-time-sed" &&

base-commit: 2f268890c2cd2f115424936bbee27f8269080e5e
-- 
gitgitgadget
