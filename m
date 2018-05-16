Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4DF981F406
	for <e@80x24.org>; Wed, 16 May 2018 23:48:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751907AbeEPXse (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 May 2018 19:48:34 -0400
Received: from mail-yw0-f202.google.com ([209.85.161.202]:52472 "EHLO
        mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751395AbeEPXsc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 May 2018 19:48:32 -0400
Received: by mail-yw0-f202.google.com with SMTP id j14-v6so1139123ywg.19
        for <git@vger.kernel.org>; Wed, 16 May 2018 16:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=niGeYWFK9cAZsoNWvgA9C6h0139Dkk+s0vQbV7ieSek=;
        b=LGGYxYL+9GQbwmiCSUphrfVhM8ckz0Pw2ObzdmbtxTCdXyKdj7GyLV5Dp3Mox5AONN
         7mo3GoHyyppO4TH5DubZwipEdaXKjdbXDde51hxHTmzpqvEkslFlhSKqfwrmeY6gJDmK
         uUvWm00wc3TsUS/azC2jB1pBMvWxt9huMRPPqI/5e78V1ztXTIuOxLLAHF4IUq+xFs3u
         y5Tsg03fEF5KyMCoBfQFKg6oRnfMFji7IsfyBJBoMTjd/RJKdqU9xv48r0x+lM9OmaM0
         cJ2Hf7eM0yZTpYQzpunWPS7gbW9SYN7HTG75/aJcEZN+S1XXJdSanRRx6AS3D4aPN2jx
         sBKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=niGeYWFK9cAZsoNWvgA9C6h0139Dkk+s0vQbV7ieSek=;
        b=nlGj4hmYuB1qg3dEwnHmi6GSjagod6rJBWc3ubLQnIdJzWD9YNhBD9uzCT92JWKMHl
         bhGljqcisUI7fNwCSGq1B/jkjURFTcmkh/Ci5VCAVwny0FPGa46//6oZfjw7q7dmCFUM
         v5VlciMQLhMMAdXbVUUnOw458VCj1d7jKwj6h1buyHAzqrnlH214OPMCu4HgeC6zmIEo
         ciJKbx1pZCQnDKrq+jyetxENeCRUaJLyoF/k6GeyYFzuYRHpm8cI27PSHq9CdFUlXniA
         +Rvtc1objMC55ZQrq3YqFV4G/N0ASTM1hPfKm6tjk2PIg2DVFadkkn7LSAw8fQ6OoqBC
         ptpg==
X-Gm-Message-State: ALKqPwcboW6iPGErN6pJe4g2BU669HPK1YM0Fai9i9oLHzvr2R66wg4K
        yDciIXWUB1qEPJjzIeoTSjqTY+tEOsPR5fDowWWZryttn+9ildGdLc3ZNXfot2Pf+mFVt0zLPAm
        m4x+CH2sLhZzImEybGS6r5wwvMHLiyNwS84qcjvoMTS5VAuvtmOsq62ITZg==
X-Google-Smtp-Source: AB8JxZoMd076gYO4v0xo/xLxmyS59JWWlO4hmfpQrPjcslQLo4n1wOMOm98cS5WnfH1+MveipXdIIJOU+ps=
MIME-Version: 1.0
X-Received: by 2002:a81:8706:: with SMTP id x6-v6mr1027510ywf.224.1526514511411;
 Wed, 16 May 2018 16:48:31 -0700 (PDT)
Date:   Wed, 16 May 2018 16:48:22 -0700
In-Reply-To: <20180516234822.182663-1-bmwill@google.com>
Message-Id: <20180516234822.182663-3-bmwill@google.com>
References: <20180516225823.235426-1-bmwill@google.com> <20180516234822.182663-1-bmwill@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
Subject: [PATCH 2/2] fetch: generate ref-prefixes when using a configured refspec
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org, bmwill@google.com
Cc:     Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach fetch to generate ref-prefixes, to be used for server-side
filtering of the ref-advertisement, based on the configured fetch
refspec ('remote.<name>.fetch') when no user provided refspec exists.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/fetch.c        | 10 +++++++++-
 t/t5702-protocol-v2.sh | 14 ++++++++++++++
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 80bb14370..7cc7a52de 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -351,7 +351,15 @@ static struct ref *get_ref_map(struct transport *transport,
 
 	const struct ref *remote_refs;
 
-	refspec_ref_prefixes(rs, &ref_prefixes);
+	if (rs->nr)
+		refspec_ref_prefixes(rs, &ref_prefixes);
+	else if (transport->remote && transport->remote->fetch.nr)
+		refspec_ref_prefixes(&transport->remote->fetch, &ref_prefixes);
+
+	if (ref_prefixes.argc &&
+	    (tags == TAGS_SET || (tags == TAGS_DEFAULT && !rs->nr))) {
+		argv_array_push(&ref_prefixes, "refs/tags/");
+	}
 
 	remote_refs = transport_get_remote_refs(transport, &ref_prefixes);
 
diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index 56f7c3c32..b6c72ab51 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -201,6 +201,20 @@ test_expect_success 'ref advertisment is filtered during fetch using protocol v2
 	! grep "refs/tags/three" log
 '
 
+test_expect_success 'default refspec is used to filter ref when fetchcing' '
+	test_when_finished "rm -f log" &&
+
+	GIT_TRACE_PACKET="$(pwd)/log" git -C file_child -c protocol.version=2 \
+		fetch origin &&
+
+	git -C file_child log -1 --format=%s three >actual &&
+	git -C file_parent log -1 --format=%s three >expect &&
+	test_cmp expect actual &&
+
+	grep "ref-prefix refs/heads/" log &&
+	grep "ref-prefix refs/tags/" log
+'
+
 # Test protocol v2 with 'http://' transport
 #
 . "$TEST_DIRECTORY"/lib-httpd.sh
-- 
2.17.0.441.gb46fe60e1d-goog

