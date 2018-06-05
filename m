Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 134B21F403
	for <e@80x24.org>; Tue,  5 Jun 2018 21:16:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752364AbeFEVQu (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Jun 2018 17:16:50 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36436 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752154AbeFEVQq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jun 2018 17:16:46 -0400
Received: by mail-pg0-f68.google.com with SMTP id m5-v6so1842541pgd.3
        for <git@vger.kernel.org>; Tue, 05 Jun 2018 14:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kP0iq0dfcxKSDBDk3m20590TrxqXeLA2fBYE1ThubxI=;
        b=Pjf+Nu1g04Vm0dTZn2bPctJQOgraJhYILSqraC8dJm+7YeJA1E1pyL9nftPlz/NDPS
         SXn6IavNC8qWcMukYPgvMZJcz21AHK2bOAkeZJGe4kJvB6Ys3BA5Su2YRO56lPIv6Yr5
         7QjJYBg0ymdC9xZbxRJKOeLwnrM1xb2mxiKdhuQ8kUxTk15g5PWt2K5d9RGwhqr1UziZ
         7vFGUO9FAASYYY727REs2O53xsCK4EK9mUr/erzRs53o7+x0emG5V/TYxKj/bdDMU8zX
         Nu3/Lyv7F0bFHZxuo4kbviHpSOxmNYb8OKUvcOT0Vm7HNhKEV6ZEGlJxe7Bz+pFe1Wpv
         Ctmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kP0iq0dfcxKSDBDk3m20590TrxqXeLA2fBYE1ThubxI=;
        b=mJIXsC1uouGFFGh8gMMYDcpF0FsTbhuIIFL+rtj9EeuG2e8vAG+NfESc3b1AF8BBfX
         LjXyHKxtPAJePakaYOxyy7YfkinmHES+hchIdpcpVTzwEImw51tT4xF9jxidufuX8tRq
         w7t+JM5ebMQ3+zqRARkOyl8zBeVPT8FTOEUF1GiV9quWDPTGFdjpYZW1rbmC9SEFw+qZ
         qmiyoDfa9HGb1qEtLb6RoBHoFo48u480eAOFyyoSbp+llXWVixBtOfOGY/OTslt9dUWo
         8Rr5KhSqQ4reMamGuuDH9SPOF1h5Scj88NsHnOnbUR3F8Ct4E8xxFoC17TPOrnLE9B/s
         xn5A==
X-Gm-Message-State: APt69E3i10whVQsRhUlkZw3izKNeUg3So8+f+8GVLk8IvVOkRvGRYmYj
        3/d7Hvoir+U8seg+TQA0eHKI+QTiV8I=
X-Google-Smtp-Source: ADUXVKIV1FpaHvM7ylRwhaeJsKgOy82PpdzJDQrZLJvX9Qr8BEjS9MsGroGjaYXMAyMF7F1oSlvrTg==
X-Received: by 2002:a63:12:: with SMTP id 18-v6mr212213pga.121.1528233404814;
        Tue, 05 Jun 2018 14:16:44 -0700 (PDT)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id b15-v6sm76641614pfi.144.2018.06.05.14.16.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Jun 2018 14:16:43 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, bmwill@google.com
Subject: [PATCH 2/2] fetch: send "refs/tags/" prefix upon CLI refspecs
Date:   Tue,  5 Jun 2018 14:16:35 -0700
Message-Id: <4d69aa14dadbbc53defa6d7d6c9a62f2b02a0bfb.1528233146.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.17.0.768.g1526ddbba1.dirty
In-Reply-To: <cover.1528233146.git.jonathantanmy@google.com>
References: <cover.1528233146.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When performing tag following, in addition to using the server's
"include-tag" capability to send tag objects (and emulating it if the
server does not support that capability), "git fetch" relies upon the
presence of refs/tags/* entries in the initial ref advertisement to
locally create refs pointing to the aforementioned tag objects. When
using protocol v2, refs/tags/* entries in the initial ref advertisement
may be suppressed by a ref-prefix argument, leading to the tag object
being downloaded, but the ref not being created.

Commit dcc73cf7ff ("fetch: generate ref-prefixes when using a configured
refspec", 2018-05-18) ensured that "refs/tags/" is always sent as a ref
prefix when "git fetch" is invoked with no refspecs, but not when "git
fetch" is invoked with refspecs. Extend that functionality to make it
work in both situations.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 builtin/fetch.c        |  2 +-
 t/t5702-protocol-v2.sh | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index ea5b9669a..1f447f1e8 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -359,7 +359,7 @@ static struct ref *get_ref_map(struct transport *transport,
 		refspec_ref_prefixes(&transport->remote->fetch, &ref_prefixes);
 
 	if (ref_prefixes.argc &&
-	    (tags == TAGS_SET || (tags == TAGS_DEFAULT && !rs->nr))) {
+	    (tags == TAGS_SET || tags == TAGS_DEFAULT)) {
 		argv_array_push(&ref_prefixes, "refs/tags/");
 	}
 
diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index 261e82b0f..6733579c1 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -406,6 +406,24 @@ test_expect_success 'fetch supports various ways of have lines' '
 		$(git -C server rev-parse completely-unrelated)
 '
 
+test_expect_success 'fetch supports include-tag and tag following' '
+	rm -rf server client trace &&
+	git init server &&
+
+	test_commit -C server to_fetch &&
+	git -C server tag -a annotated_tag -m message &&
+
+	git init client &&
+	GIT_TRACE_PACKET="$(pwd)/trace" git -C client -c protocol.version=2 \
+		fetch "$(pwd)/server" to_fetch:to_fetch &&
+
+	grep "fetch> ref-prefix to_fetch" trace &&
+	grep "fetch> ref-prefix refs/tags/" trace &&
+	grep "fetch> include-tag" trace &&
+
+	git -C client cat-file -e $(git -C client rev-parse annotated_tag)
+'
+
 # Test protocol v2 with 'http://' transport
 #
 . "$TEST_DIRECTORY"/lib-httpd.sh
-- 
2.17.0.768.g1526ddbba1.dirty

