Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5896A1F403
	for <e@80x24.org>; Tue,  5 Jun 2018 21:16:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751619AbeFEVQq (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Jun 2018 17:16:46 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:42720 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752075AbeFEVQo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jun 2018 17:16:44 -0400
Received: by mail-pg0-f65.google.com with SMTP id p9-v6so1834811pgc.9
        for <git@vger.kernel.org>; Tue, 05 Jun 2018 14:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LUFcF7PxWywM2w46Url7ye1IjlmCkKZaV+DGZvpBbOI=;
        b=RIT/tb3Qa9P9w8Exf89JAUcdIF89mvtfr968yPSEvYjkmc8AltDmsDRHKxfTpd/xST
         ptZp4zqkmMmpw4WdsZMBk+K3rNzuD1KQ6IQrraGEgs3/TTbvnwQ7uvFg3d1iqo0qFQ/+
         YFy3jFvESQml66KgJWexEYzroWvYaxFemiCftbR0tzgpTsspFBEbsS3IAZ2hOyMO2YKL
         kV/X8UVw3eQsDn1zNqvPgcRVXhIM0ZEsyaHBFNqNTbwbvYFJVr55FU47pKXfTIG5spND
         AEtmpebVEa46Pgb27Otuczl+9pydLBoFx5oqg4qeTeIY7LpadVpg43WC8PrjPCrZEfn1
         olXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LUFcF7PxWywM2w46Url7ye1IjlmCkKZaV+DGZvpBbOI=;
        b=keilhKPAQO7YChgb1MwesWFIu11DmsrlbwUuvoONIVIM/k2ARUTnYQv6UrCqdJwdtR
         Ya7N62mLj8GZL+25gH8hy48k+eAMW0BBR4fE/ff5LjhldC6JL7j5USSAJp15kOWGNFEe
         unEgiXHs4ERcVA3VhVdrRWZVCEIO8R2mmIcGqOxtPgMiGE0WjdYMg968w5yGg8rljn8A
         Ods9KkajLVAHT0+NHp2il4NOAeit7TL+FEcGctpztGLOYHeNHCSWPM4By5832Ms2F7Wd
         xk9c9HTliEoQjOWsDoiOCoTk4I/9Mii+qZBCzdhzJcmHjw8OznYndGR0wbzzmdUf9AAp
         5lCA==
X-Gm-Message-State: APt69E02ethwRQFhcSmJ+7muqttDfbAzI7TOsIArA1yVeIJoxfWYx6YB
        YLqqZn5IqOMoJGACaXTGXbJZNuYMTI8=
X-Google-Smtp-Source: ADUXVKJEqr3oN3TjiriPR533ptFM91IA9n9mULG7sj1uSzOseJfrqJQZvBRxwBriZhW3qLJo1x1Scw==
X-Received: by 2002:a65:57c6:: with SMTP id q6-v6mr226756pgr.160.1528233402876;
        Tue, 05 Jun 2018 14:16:42 -0700 (PDT)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id b15-v6sm76641614pfi.144.2018.06.05.14.16.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Jun 2018 14:16:41 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, bmwill@google.com
Subject: [PATCH 1/2] t5702: test fetch with multiple refspecs at a time
Date:   Tue,  5 Jun 2018 14:16:34 -0700
Message-Id: <2bc7df55a6451afbd35638b31a1551c648129b22.1528233146.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.17.0.768.g1526ddbba1.dirty
In-Reply-To: <cover.1528233146.git.jonathantanmy@google.com>
References: <cover.1528233146.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Extend the protocol v2 tests to also test fetches with multiple refspecs
specified. This also covers the previously uncovered cases of fetching
with prefix matching and fetching by SHA-1.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 t/t5702-protocol-v2.sh | 47 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index a4fe6508b..261e82b0f 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -359,6 +359,53 @@ test_expect_success 'default refspec is used to filter ref when fetchcing' '
 	grep "ref-prefix refs/tags/" log
 '
 
+test_expect_success 'fetch supports various ways of have lines' '
+	rm -rf server client trace &&
+	git init server &&
+	test_commit -C server dwim &&
+	TREE=$(git -C server rev-parse HEAD^{tree}) &&
+	git -C server tag exact \
+		$(git -C server commit-tree -m a "$TREE") &&
+	git -C server tag dwim-unwanted \
+		$(git -C server commit-tree -m b "$TREE") &&
+	git -C server tag exact-unwanted \
+		$(git -C server commit-tree -m c "$TREE") &&
+	git -C server tag prefix1 \
+		$(git -C server commit-tree -m d "$TREE") &&
+	git -C server tag prefix2 \
+		$(git -C server commit-tree -m e "$TREE") &&
+	git -C server tag fetch-by-sha1 \
+		$(git -C server commit-tree -m f "$TREE") &&
+	git -C server tag completely-unrelated \
+		$(git -C server commit-tree -m g "$TREE") &&
+	
+	git init client &&
+	GIT_TRACE_PACKET="$(pwd)/trace" git -C client -c protocol.version=2 \
+		fetch "file://$(pwd)/server" \
+		dwim \
+		refs/tags/exact \
+		refs/tags/prefix*:refs/tags/prefix* \
+		"$(git -C server rev-parse fetch-by-sha1)" &&
+
+	# Ensure that the appropriate prefixes are sent (using a sample)
+	grep "fetch> ref-prefix dwim" trace &&
+	grep "fetch> ref-prefix refs/heads/dwim" trace &&
+	grep "fetch> ref-prefix refs/tags/prefix" trace &&
+
+	# Ensure that the correct objects are returned
+	git -C client cat-file -e $(git -C server rev-parse dwim) &&
+	git -C client cat-file -e $(git -C server rev-parse exact) &&
+	git -C client cat-file -e $(git -C server rev-parse prefix1) &&
+	git -C client cat-file -e $(git -C server rev-parse prefix2) &&
+	git -C client cat-file -e $(git -C server rev-parse fetch-by-sha1) &&
+	test_must_fail git -C client cat-file -e \
+		$(git -C server rev-parse dwim-unwanted) &&
+	test_must_fail git -C client cat-file -e \
+		$(git -C server rev-parse exact-unwanted) &&
+	test_must_fail git -C client cat-file -e \
+		$(git -C server rev-parse completely-unrelated)
+'
+
 # Test protocol v2 with 'http://' transport
 #
 . "$TEST_DIRECTORY"/lib-httpd.sh
-- 
2.17.0.768.g1526ddbba1.dirty

