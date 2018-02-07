Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C30DB1F404
	for <e@80x24.org>; Wed,  7 Feb 2018 01:14:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932285AbeBGBOn (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Feb 2018 20:14:43 -0500
Received: from mail-yw0-f201.google.com ([209.85.161.201]:51942 "EHLO
        mail-yw0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932281AbeBGBOi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Feb 2018 20:14:38 -0500
Received: by mail-yw0-f201.google.com with SMTP id u133so4382760ywg.18
        for <git@vger.kernel.org>; Tue, 06 Feb 2018 17:14:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=c4G4xB9tdNYs0zp1zEFBE3O0xvD+8PUYLW/INlZm9zg=;
        b=cSTljPEEJ+48/40EMkBpT7Za9nqNslHWbOIandhjqFy/t4pdHxsV8OoZah9P80qIoH
         gZF8vT+caB7lPEX43oeHvhywnje8DsouTsAImNK5kWO9GSoIvWyn0tMcLsZtxTSHoP/2
         ykbxgWHrClhms3mqSXqdmuw7zS3a6z6DOJMGbAlHyAJ+wYx8BOxApAfEMi9nQ0HhmMYD
         5D3xQZnd7eJ7Yt9uH1AcD1r2KUBFPSFiqv1Nb2Lr3qaG5QSxicGa1KlnpZg+8TXgzdxG
         GAezMSaG1w63fJ4J+EpuwAds6/aoMzDlpFdCQgEqXm/LNuT/ioyyMbVT+7K0L+/AT2V5
         8iPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=c4G4xB9tdNYs0zp1zEFBE3O0xvD+8PUYLW/INlZm9zg=;
        b=qKtLmRSE4fnvWgzasdkEo2UoRRXkCilYMP6uRAlKpP26ctQ+jBikBvLVmmZLNZtxy0
         gD6nXd7/0KLolia6CmcvhQeId4oXsaazDnPOd9pqRnBAksjTvlmHU9AjVxOBlbJFmoTV
         iNcaxgPL4HVdGfoFWHH18KxzHAC7fLw758pqjvFnQ6fhPlt4H5TeoCJWQgDZxm9BX/ze
         o5bKbt3ZE5DnPizxIav1JNAq9cB5JIG6St4v1ZyKweKuWAmESKfNFf8h+nhN9UCz1gXm
         U5LP+yHmOGk6KUw37fq3X7ZUJnQ4tfCrWMUI5W9YawpPT1I3csrqK2/j/MQpRtU18902
         rKww==
X-Gm-Message-State: APf1xPDHFab6enCWtb1NG7wTwtJ14caLWTuprkV+6/OkwSvMMr0Ii6KM
        VYq1cnx0wjIe5eqHNsr1NLqyREoTid9XkYSjS7gPbgEnKLwpai8x7McCxkSlloDkTQWGAxuZjau
        1VT08YBAy1CpnRC5O5TE5Z0LutfUPjSGsGev7XWAmd0nQZxUQDk97yD7Spw==
X-Google-Smtp-Source: AH8x224baXv0XcnKFlsYhHANmvnbjrFlTLKQxt8bwSrVMD+JJi/xudmPws7BrkZ84rdDlgG/ZYRCNhTIdWs=
MIME-Version: 1.0
X-Received: by 10.37.120.2 with SMTP id t2mr2379134ybc.2.1517966077788; Tue,
 06 Feb 2018 17:14:37 -0800 (PST)
Date:   Tue,  6 Feb 2018 17:13:12 -0800
In-Reply-To: <20180207011312.189834-1-bmwill@google.com>
Message-Id: <20180207011312.189834-36-bmwill@google.com>
References: <20180125235838.138135-1-bmwill@google.com> <20180207011312.189834-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.0.rc1.238.g530d649a79-goog
Subject: [PATCH v3 35/35] remote-curl: don't request v2 when pushing
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, peff@peff.net, gitster@pobox.com,
        jrnieder@gmail.com, stolee@gmail.com, git@jeffhostetler.com,
        pclouds@gmail.com, Brandon Williams <bmwill@google.com>
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
 t/t5702-protocol-v2.sh | 23 +++++++++++++++++++++++
 2 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/remote-curl.c b/remote-curl.c
index af431b658..c39b6ece6 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -320,6 +320,7 @@ static struct discovery *discover_refs(const char *service, int for_push)
 	struct discovery *last = last_discovery;
 	int http_ret, maybe_smart = 0;
 	struct http_get_options http_options;
+	enum protocol_version version = get_protocol_version_config();
 
 	if (last && !strcmp(service, last->service))
 		return last;
@@ -336,8 +337,16 @@ static struct discovery *discover_refs(const char *service, int for_push)
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
index c2c39fe0c..14d589a7f 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -211,6 +211,29 @@ test_expect_success 'fetch with http:// using protocol v2' '
 	grep "git< version 2" log
 '
 
+test_expect_success 'push with http:// and a config of v2 does not request v2' '
+	# Till v2 for push is designed, make sure that if a client has
+	# protocol.version configured to use v2, that the client instead falls
+	# back and uses v0.
+
+	test_commit -C http_child three &&
+
+	# Push to another branch, as the target repository has the
+	# master branch checked out and we cannot push into it.
+	GIT_TRACE_PACKET=1 git -C http_child -c protocol.version=1 \
+		push origin HEAD:client_branch && 2>log &&
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
2.16.0.rc1.238.g530d649a79-goog

