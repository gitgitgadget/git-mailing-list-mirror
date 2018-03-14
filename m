Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 042D61F404
	for <e@80x24.org>; Wed, 14 Mar 2018 18:33:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752263AbeCNSdq (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Mar 2018 14:33:46 -0400
Received: from mail-qt0-f201.google.com ([209.85.216.201]:35481 "EHLO
        mail-qt0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752266AbeCNSdj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Mar 2018 14:33:39 -0400
Received: by mail-qt0-f201.google.com with SMTP id l32so2750811qtd.2
        for <git@vger.kernel.org>; Wed, 14 Mar 2018 11:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=Lt7L6e5s6ZQrhF/hyMvLHCcejf2qIXi5FwFiwkPsMV0=;
        b=MtR5AT+C9ea6ekJ2wpx46W2AG58y92/nkVU2riALh+AW4mQJLy4YcfAkMActHh/Pmo
         dR8McJ0nOXorJx8CU9PmCSyg0zSHjHHNQitZ18ITtCTIH5hgGzoedlH0ekrE2xkFN5B4
         zzT/4AhYzFnxLAqxKS/Bpq29YA3W5tnNK2UAnpMfIhxKoBvIDOe5kMfI+Qq49gVseBlZ
         hQK6T692JF0ifIQQwXS3O3y2Jao6/vQAaqnrUo1613GaYooaMvo8SzlQ2QPte6OjczOe
         qtM6Gfb3R5VF1HkSKyPWg1EiZJP7VBKRjvsjeZoxE4FtDiO+01If7ZvPWfDkQE9mvDXB
         j6jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=Lt7L6e5s6ZQrhF/hyMvLHCcejf2qIXi5FwFiwkPsMV0=;
        b=WPT/PzPkqZ/G1Ou+AvR8NLFr8KSOzFCfbrmfKxdpjpgiBbZJ9tfAX9AxXjF5xtm16X
         fm9oWL038pDBKDqc8tzyf/QXvz6Bdrotatgg7BcscAvwuy+5W4vFTkitU5SsRbZP/Ub+
         QnoOeyYO7SH9desfh/oY1yz3prltsK9Rk0Q9lLfHJG+UCDnH7doIQ1RDAGvck1pNWOyS
         ZqmLdKMfo5ClsbWUqbbRsqKdWSqKDEWmMMgyDS2IOvaWrPQEwVCcQ6xAEkgN1AQovXDw
         RK6Lhj1O3CSOiPavY3S+VyNr/bT44z4Msy0K2WUlIG2LsRhSz/hLOznaWN8ZxKGivQeI
         mLsQ==
X-Gm-Message-State: AElRT7GohlTkLOuro65tF8ckCdJFrM7qOcb1PDgeMiq2Ae/Ys3XRFJXq
        KNL8m4Hpg0nRfo65UPUiXb5vVqBZzoEjTogZWZh8YVXJNgSaHce9uxs6OKnwF4QjZRmEKyPqhwE
        WZK01qgF/RfSy2F39IYSiKhXjquHDk8oRJ9xAh85AvEoN18G0Cu8hKgu7HA==
X-Google-Smtp-Source: AG47ELvkmxyFZXb5JZS5jKrClYEe2d8cTZSXEM9Ag/dgVZagEpr24Qk7g4JYSjEZXBOm+zoasOPZ+QgcQzs=
MIME-Version: 1.0
X-Received: by 10.200.6.68 with SMTP id e4mr3849315qth.51.1521052418574; Wed,
 14 Mar 2018 11:33:38 -0700 (PDT)
Date:   Wed, 14 Mar 2018 11:32:12 -0700
In-Reply-To: <20180314183213.223440-1-bmwill@google.com>
Message-Id: <20180314183213.223440-36-bmwill@google.com>
References: <20180314183213.223440-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.2.804.g6dcf76e118-goog
Subject: [PATCH v5 35/35] remote-curl: don't request v2 when pushing
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     git@jeffhostetler.com, gitster@pobox.com, jrnieder@gmail.com,
        pclouds@gmail.com, peff@peff.net, sbeller@google.com,
        stolee@gmail.com, jonathantanmy@google.com,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In order to be able to ship protocol v2 with only supporting fetch, we
need clients to not issue a request to use protocol v2 when pushing
(since the client currently doesn't know how to push using protocol v2).
This allows a client to have protocol v2 configured in
`protocol.version` and take advantage of using v2 for fetch and falling
back to using v0 when pushing while v2 for push is being designed.

We could run into issues if we didn't fall back to protocol v2 when
pushing right now.  This is because currently a server will ignore a request to
use v2 when contacting the 'receive-pack' endpoint and fall back to
using v0, but when push v2 is rolled out to servers, the 'receive-pack'
endpoint will start responding using v2.  So we don't want to get into a
state where a client is requesting to push with v2 before they actually
know how to push using v2.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 remote-curl.c          | 11 ++++++++++-
 t/t5702-protocol-v2.sh | 24 ++++++++++++++++++++++++
 2 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/remote-curl.c b/remote-curl.c
index 87f5b77b29..595447b16e 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -322,6 +322,7 @@ static struct discovery *discover_refs(const char *service, int for_push)
 	struct discovery *last = last_discovery;
 	int http_ret, maybe_smart = 0;
 	struct http_get_options http_options;
+	enum protocol_version version = get_protocol_version_config();
 
 	if (last && !strcmp(service, last->service))
 		return last;
@@ -338,8 +339,16 @@ static struct discovery *discover_refs(const char *service, int for_push)
 		strbuf_addf(&refs_url, "service=%s", service);
 	}
 
+	/*
+	 * NEEDSWORK: If we are trying to use protocol v2 and we are planning
+	 * to perform a push, then fallback to v0 since the client doesn't know
+	 * how to push yet using v2.
+	 */
+	if (version == protocol_v2 && !strcmp("git-receive-pack", service))
+		version = protocol_v0;
+
 	/* Add the extra Git-Protocol header */
-	if (get_protocol_http_header(get_protocol_version_config(), &protocol_header))
+	if (get_protocol_http_header(version, &protocol_header))
 		string_list_append(&extra_headers, protocol_header.buf);
 
 	memset(&http_options, 0, sizeof(http_options));
diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index 124063c2c4..56f7c3c326 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -244,6 +244,30 @@ test_expect_success 'fetch with http:// using protocol v2' '
 	grep "git< version 2" log
 '
 
+test_expect_success 'push with http:// and a config of v2 does not request v2' '
+	test_when_finished "rm -f log" &&
+	# Till v2 for push is designed, make sure that if a client has
+	# protocol.version configured to use v2, that the client instead falls
+	# back and uses v0.
+
+	test_commit -C http_child three &&
+
+	# Push to another branch, as the target repository has the
+	# master branch checked out and we cannot push into it.
+	GIT_TRACE_PACKET="$(pwd)/log" git -C http_child -c protocol.version=2 \
+		push origin HEAD:client_branch &&
+
+	git -C http_child log -1 --format=%s >actual &&
+	git -C "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" log -1 --format=%s client_branch >expect &&
+	test_cmp expect actual &&
+
+	# Client didnt request to use protocol v2
+	! grep "Git-Protocol: version=2" log &&
+	# Server didnt respond using protocol v2
+	! grep "git< version 2" log
+'
+
+
 stop_httpd
 
 test_done
-- 
2.16.2.804.g6dcf76e118-goog

