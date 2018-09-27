Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A01851F453
	for <e@80x24.org>; Thu, 27 Sep 2018 19:24:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728680AbeI1BoZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Sep 2018 21:44:25 -0400
Received: from mail-io1-f73.google.com ([209.85.166.73]:39832 "EHLO
        mail-io1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728101AbeI1BoZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Sep 2018 21:44:25 -0400
Received: by mail-io1-f73.google.com with SMTP id x5-v6so4069231ioa.6
        for <git@vger.kernel.org>; Thu, 27 Sep 2018 12:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=VIcC7tx9B4oUDsvz6GmX4ErQ3TOv3BnJOy8jvlzqb14=;
        b=brPbUatG9pYoLS/qNOiRpkexsxqyxrNyvki+E4RAfzM8Ocr+317dZZV0qDTPKZJdOF
         yiK1o09sH0FbTu+Ye5csJ6GeRpLGRsubo+TDEyMTUEPcV7suseY1Tv7NXvVg0b/7DUOh
         iEh8pM8j89g2rBZQAL8AB3HEIbPw75HfBDJn1vd/7ZpSiWxmAOkPCP+haprkybPWIoox
         DMBtpV2piy/UF0n1t8aXjrM/ogxtEf0ga/6n6emqnBWUaSpoZwAiEV42AbuUGdeRdocg
         gijKtzzaRl8ivfjn8KtY9I9TpaDL6Iipo/Cu2hJtu1sMhu5bE4JSXGKC++LY5wZ8wMby
         AXGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=VIcC7tx9B4oUDsvz6GmX4ErQ3TOv3BnJOy8jvlzqb14=;
        b=WqKjL8yo+QBtsbZ5l32mP80n2dbXz7/Cc5b5lEXeu8f0Fmztfa4TSQ8m6SbbK3/LJo
         qzIzUJLdnxx0kw0eBprcla+YZ+GKvZfVOOzPfbDFEZ0HKPUdamLwByKjWCoKe+zcWBO2
         y3zzqKMVn7vwGnFue2tq7mYBlsusosuvPNAvZwp3SeixQOtHjOKD3pLArzLzj2w8jSb0
         KzhjpGjgPCn3Fk39Vix7uDosthtBp9X5ERqXAsVVnfmR0TaTTcXIORcgwJK0K0uM05UE
         AfsrPx3XcRsJNdoo7d+pnjN5aIh9vT1srzp5b5gHZAlYSH7WB4g0WaCVoKo8eOo2IUKP
         CUKw==
X-Gm-Message-State: ABuFfohIWrJKnpV4EkasxBDUtRYH5PPFYMsb7QwVroMOPydfYEeObIb7
        SDPrJiaf1MwGZP4MFdtalFumIX7MRD/KsvX57xUKEo2RVX+u8EhaWPl+n5XB0n8dEWwYDlFc28X
        vnt3JfTt6aDmEaIXiJXoXwArh2HPY5JWSrrIAdvJVHLBVwh/ruyW05VmVYB98QsL+4xvjSXP/nj
        HF
X-Google-Smtp-Source: ACcGV6087iMtpkHyRQk71EqPY3CHj599q7ShpdMvBPb98/K0zqeU2cObGEruWOsoCW/0OZxcHfkAipfynxRzcfhljgcK
X-Received: by 2002:a24:f585:: with SMTP id k127-v6mr7773148ith.1.1538076276901;
 Thu, 27 Sep 2018 12:24:36 -0700 (PDT)
Date:   Thu, 27 Sep 2018 12:24:07 -0700
In-Reply-To: <cover.1538075680.git.jonathantanmy@google.com>
Message-Id: <1ae00ea1fdd1118b92ac90d67f27a988750b60f2.1538075680.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <20180925225355.74237-1-jonathantanmy@google.com> <cover.1538075680.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
Subject: [RFC PATCH v2 4/4] fetch: do not list refs if fetching only hashes
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If only hash literals are given on a "git fetch" command-line, tag
following is not requested, and the fetch is done using protocol v2, a
list of refs is not required from the remote. Therefore, optimize by
invoking transport_get_remote_refs() only if we need the refs.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 builtin/fetch.c             | 32 ++++++++++++++++++++++++++------
 t/t5551-http-fetch-smart.sh | 15 +++++++++++++++
 t/t5702-protocol-v2.sh      | 13 +++++++++++++
 3 files changed, 54 insertions(+), 6 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 0696abfc2a..4c4f8fa194 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1175,6 +1175,7 @@ static int do_fetch(struct transport *transport,
 	int retcode = 0;
 	const struct ref *remote_refs;
 	struct argv_array ref_prefixes = ARGV_ARRAY_INIT;
+	int must_list_refs = 1;
 
 	if (tags == TAGS_DEFAULT) {
 		if (transport->remote->fetch_tags == 2)
@@ -1190,17 +1191,36 @@ static int do_fetch(struct transport *transport,
 			goto cleanup;
 	}
 
-	if (rs->nr)
+	if (rs->nr) {
+		int i;
+
 		refspec_ref_prefixes(rs, &ref_prefixes);
-	else if (transport->remote && transport->remote->fetch.nr)
+
+		/*
+		 * We can avoid listing refs if all of them are exact
+		 * OIDs
+		 */
+		must_list_refs = 0;
+		for (i = 0; i < rs->nr; i++) {
+			if (!rs->items[i].exact_sha1) {
+				must_list_refs = 1;
+				break;
+			}
+		}
+	} else if (transport->remote && transport->remote->fetch.nr)
 		refspec_ref_prefixes(&transport->remote->fetch, &ref_prefixes);
 
-	if (ref_prefixes.argc &&
-	    (tags == TAGS_SET || (tags == TAGS_DEFAULT))) {
-		argv_array_push(&ref_prefixes, "refs/tags/");
+	if (tags == TAGS_SET || tags == TAGS_DEFAULT) {
+		must_list_refs = 1;
+		if (ref_prefixes.argc)
+			argv_array_push(&ref_prefixes, "refs/tags/");
 	}
 
-	remote_refs = transport_get_remote_refs(transport, &ref_prefixes);
+	if (must_list_refs)
+		remote_refs = transport_get_remote_refs(transport, &ref_prefixes);
+	else
+		remote_refs = NULL;
+
 	argv_array_clear(&ref_prefixes);
 
 	ref_map = get_ref_map(transport->remote, remote_refs, rs,
diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
index 771f36f9ff..12b339d239 100755
--- a/t/t5551-http-fetch-smart.sh
+++ b/t/t5551-http-fetch-smart.sh
@@ -381,6 +381,21 @@ test_expect_success 'using fetch command in remote-curl updates refs' '
 	test_cmp expect actual
 '
 
+test_expect_success 'fetch by SHA-1 without tag following' '
+	SERVER="$HTTPD_DOCUMENT_ROOT_PATH/server" &&
+	rm -rf "$SERVER" client &&
+
+	git init "$SERVER" &&
+	test_commit -C "$SERVER" foo &&
+
+	git clone $HTTPD_URL/smart/server client &&
+
+	test_commit -C "$SERVER" bar &&
+	git -C "$SERVER" rev-parse bar >bar_hash &&
+	git -C client -c protocol.version=0 fetch \
+		--no-tags origin $(cat bar_hash)
+'
+
 test_expect_success 'GIT_REDACT_COOKIES redacts cookies' '
 	rm -rf clone &&
 	echo "Set-Cookie: Foo=1" >cookies &&
diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index a316bb9bf4..1a97331648 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -79,6 +79,19 @@ test_expect_success 'fetch with git:// using protocol v2' '
 	grep "fetch< version 2" log
 '
 
+test_expect_success 'fetch by hash without tag following with protocol v2 does not list refs' '
+	test_when_finished "rm -f log" &&
+
+	test_commit -C "$daemon_parent" two_a &&
+	git -C "$daemon_parent" rev-parse two_a >two_a_hash &&
+
+	GIT_TRACE_PACKET="$(pwd)/log" git -C daemon_child -c protocol.version=2 \
+		fetch --no-tags origin $(cat two_a_hash) &&
+
+	grep "fetch< version 2" log &&
+	! grep "fetch> command=ls-refs" log
+'
+
 test_expect_success 'pull with git:// using protocol v2' '
 	test_when_finished "rm -f log" &&
 
-- 
2.19.0.605.g01d371f741-goog

