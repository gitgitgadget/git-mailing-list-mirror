Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 030AE20286
	for <e@80x24.org>; Sun, 10 Sep 2017 14:44:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751803AbdIJOog (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Sep 2017 10:44:36 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35180 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751613AbdIJOoe (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Sep 2017 10:44:34 -0400
Received: by mail-wm0-f68.google.com with SMTP id e64so4986928wmi.2
        for <git@vger.kernel.org>; Sun, 10 Sep 2017 07:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VncqiVxQwXK0cCAPszyYXnL4bNubI/6xxLYPWxzpjh8=;
        b=l5hlpr1zRTXLnguF0L9+sFv/TTN0NG/lP5nW5mdxlGF9eZi63wu/n7aKrRsLodMWx7
         LrILEvU/vJm0KzwkKzFHRTIXnRXMKYBVvrC0WjJavPh24JjB/92u1l3mNiZxdMvL+MoE
         4GA6AH/dNE17kypyo48s0K+K3AvGAEXkZL0+I34ol+u1ROxYKS5l8Z5x4H0W5vPf81so
         e/cBLCkvC8QPCPBhyz/3SnIbaXzbMf4uwuQmnRm27+XgsthGc4f1xu1bS0CNpm/6CLFz
         qqPnqHFAZiiZd+0BWYw1fNvx8SMFotyh+fE2fyjxFKvml0Pq0Jq3AUD1CZ+w3c9kIKAi
         Y36Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VncqiVxQwXK0cCAPszyYXnL4bNubI/6xxLYPWxzpjh8=;
        b=NLH246oGQNl3xFlCo6VNDI8FcN/VJvu9K9WnDUqIY2cRI/+YBIszFD6Qo6gUce+Peb
         s0eUH1GWKoqEJ3wEaoYOa8NPIThyfCWpFTOT6Ggsra4HbiMiCWJMvcDsotvww4ipxuAa
         ErbIK3HQBRFKqcF6KMwjcjD9BdWGvCnuXl8Tmsek0vXAAgeHkyyv88raXcZ5gFw67iN6
         DoCMYK/HY6CVLAX5G2fp+iRT5/jHO4XtvJqfoRyXTqP2tgy6On9VWYRu0rnjWadeFnz7
         uELlB1b05JeFU4t/Y59ViKHpFOi1UVjM4CdFP/d7Hmne1XFaO/3zpXt4V/oSad5lN+2D
         tSvg==
X-Gm-Message-State: AHPjjUh0irHWfsaZ1uYqGyyeEVP+eoKaFO4vJHBs42SFxGT44I++J0yZ
        pRYMBIogRDD4h4hDVnHrF1hsKw==
X-Google-Smtp-Source: AOwi7QCtdpFvRMY9gmf6hdwuwywDG7e9ekC/dDaSu+WmFlAnNy3XXonMG79HXDki1qT14d8AdzTaLA==
X-Received: by 10.28.0.207 with SMTP id 198mr5340656wma.92.1505054673459;
        Sun, 10 Sep 2017 07:44:33 -0700 (PDT)
Received: from slxBook4.fritz.box (p5DDB7AFE.dip0.t-ipconnect.de. [93.219.122.254])
        by smtp.gmail.com with ESMTPSA id 4sm6961223wmg.20.2017.09.10.07.44.32
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 10 Sep 2017 07:44:32 -0700 (PDT)
From:   larsxschneider@gmail.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v1 2/2] travis-ci: skip a branch build if equal tag is present
Date:   Sun, 10 Sep 2017 16:44:29 +0200
Message-Id: <20170910144429.47346-3-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20170910144429.47346-1-larsxschneider@gmail.com>
References: <20170910144429.47346-1-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

If we push a branch and a tag pointing to the HEAD of this branch,
then Travis CI would run the build twice. This wastes resources and
slows the testing.

Add a function to detect this situation and skip the build the branch
if appropriate. Invoke this function on every build.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 ci/lib-travisci.sh | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/ci/lib-travisci.sh b/ci/lib-travisci.sh
index 44d6ba2dd2..9c4ae9bdd0 100755
--- a/ci/lib-travisci.sh
+++ b/ci/lib-travisci.sh
@@ -1,5 +1,28 @@
 # Library of functions shared by all CI scripts
 
+skip_branch_tip_with_tag () {
+	# Sometimes, a branch is pushed at the same time the tag that points
+	# at the same commit as the tip of the branch is pushed, and building
+	# both at the same time is a waste.
+	#
+	# Travis gives a tagname e.g. v2.14.0 in $TRAVIS_BRANCH when
+	# the build is triggered by a push to a tag.  Let's see if
+	# $TRAVIS_BRANCH is exactly at a tag, and if so, if it is
+	# different from $TRAVIS_BRANCH.  That way, we can tell if
+	# we are building the tip of a branch that is tagged and
+	# we can skip the build because we won't be skipping a build
+	# of a tag.
+
+	if TAG=$(git describe --exact-match "$TRAVIS_BRANCH" 2>/dev/null) &&
+		$TAG != $TRAVIS_BRANCH
+	then
+		echo "Tip of $TRAVIS_BRANCH is exactly at $TAG"
+		exit 0
+	fi
+}
+
 # Set 'exit on error' for all CI scripts to let the caller know that
 # something went wrong
 set -e
+
+skip_branch_tip_with_tag
-- 
2.14.1

