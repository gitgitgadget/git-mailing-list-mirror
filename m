Return-Path: <SRS0=OyOp=6K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76B94C54FCB
	for <git@archiver.kernel.org>; Sun, 26 Apr 2020 23:52:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4234020706
	for <git@archiver.kernel.org>; Sun, 26 Apr 2020 23:52:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P5a0VzNU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbgDZXr5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Apr 2020 19:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726196AbgDZXr5 (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 26 Apr 2020 19:47:57 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDD55C061A0F
        for <git@vger.kernel.org>; Sun, 26 Apr 2020 16:47:55 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id j7so7817726pgj.13
        for <git@vger.kernel.org>; Sun, 26 Apr 2020 16:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wjcMORN15oJsJcDZJgzGKcQ4xrFZzA1rMzz4yTh8zmY=;
        b=P5a0VzNUJHZ52/0bbpQ9a0kn9qSd8b7gQICI+xt2/wN+r/LdmgFUbDDyQy4JPOIcXq
         XAq25gwrxw+iA1M7bhP4IrGU2e8x7CcmHLdKz02p4YqzzlWbtJI5Jq5sy7SJ9K8t6vDa
         ZXeOSO6sjpmtwrrxH9wQl35A/KGbd8TVS108f24WhMv3wUgjGY4stUkzRaUJNeQmdbui
         u7aI6UxH7DXLa+uOi1EUMz/YGWHVm21u/F+M8xFB+Q7A5IVPfv6Tc7Z/ZTesr5bkhULu
         hJ8VcDkanfWT03jiYFxT6njeCulWKtPIN7d0QKUaCSZtYUSSaPSCrHOt3LizXQ57kjQk
         LTrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wjcMORN15oJsJcDZJgzGKcQ4xrFZzA1rMzz4yTh8zmY=;
        b=YkmrQfCMddz5Vt1dKzLh87NzmXXVOziemfTuZkc152aG2Ar+p2smI/c++m43iMaBLU
         mxG8kFM27pcU/UxK3FLM0O9mMfGlzIgFhAMcnsgvc6ui4L06YHSm6PekskyW+CZf0Ee0
         RN6FnSfEfMumg4uT1vQd71BqltbmfBw/RiDtO6pSxsh5J8qYIt+HS4xJcou1dcxrxQRm
         88tx3BYUBXOWcsLBMoaJrlqXcR8FrhoSfY3IbKCFCE52k67+Ywc6uul3d3PXulLocuOR
         g0lXyv51iFfbsDN0GrqqC9AKDWspVeqlzcvWIh7GhMao8Wu3eSxZ1p2Z8huYWWn6KKv+
         W2KQ==
X-Gm-Message-State: AGi0PubDryUosGGm0DxUiT/xllmgvzAOJ+a/NTJs7X+rFEjlzmpaLKSV
        mP1EKmuj9JtuFdx3/WBj1e7b82Cy
X-Google-Smtp-Source: APiQypLt/K9A5m3wux/oYfQUabpUfE6RRv7NIDTamupHQ2K8tS32V8hNXvF651XYH6goIf2txeslcA==
X-Received: by 2002:a63:d30b:: with SMTP id b11mr6228147pgg.230.1587944873574;
        Sun, 26 Apr 2020 16:47:53 -0700 (PDT)
Received: from localhost.localdomain (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id a17sm10301280pfr.24.2020.04.26.16.47.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Apr 2020 16:47:53 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     jrnieder@gmail.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH] git-credential-store: skip empty lines and comments from store
Date:   Sun, 26 Apr 2020 16:47:50 -0700
Message-Id: <20200426234750.40418-1-carenas@gmail.com>
X-Mailer: git-send-email 2.26.2.569.g1d74ac4d14
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

with the added checks for invalid URLs in credentials, any locally
modified store files which might have empty lines or even comments
were reported as failing[1] to parse as valid credentials.

instead of passing every line to the matcher as read, trim them
from spaces and skip the ones that will be otherwise empty or
start with "#" (assumed to be comments)

[1] https://stackoverflow.com/a/61420852/5005936

Reported-by: Dirk <dirk@ed4u.de>
Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 credential-store.c          |  3 +++
 t/t0302-credential-store.sh | 17 +++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/credential-store.c b/credential-store.c
index c010497cb2..b2f160890d 100644
--- a/credential-store.c
+++ b/credential-store.c
@@ -24,6 +24,9 @@ static int parse_credential_file(const char *fn,
 	}
 
 	while (strbuf_getline_lf(&line, fh) != EOF) {
+		strbuf_trim(&line);
+		if (line.len == 0 || *line.buf == '#')
+			continue;
 		credential_from_url(&entry, line.buf);
 		if (entry.username && entry.password &&
 		    credential_match(c, &entry)) {
diff --git a/t/t0302-credential-store.sh b/t/t0302-credential-store.sh
index d6b54e8c65..7245d2f449 100755
--- a/t/t0302-credential-store.sh
+++ b/t/t0302-credential-store.sh
@@ -120,4 +120,21 @@ test_expect_success 'erase: erase matching credentials from both xdg and home fi
 	test_must_be_empty "$HOME/.config/git/credentials"
 '
 
+test_expect_success 'get: allow for empty lines or comments in store file' '
+	echo "#this is a comment" >"$HOME/.git-credentials" &&
+	echo "" >>"$HOME/.git-credentials" &&
+	echo "https://user:pass@example.com" >>"$HOME/.git-credentials" &&
+	echo "    " >>"$HOME/.git-credentials" &&
+	check fill store <<-\EOF
+	protocol=https
+	host=example.com
+	--
+	protocol=https
+	host=example.com
+	username=user
+	password=pass
+	--
+	EOF
+'
+
 test_done
-- 
2.26.2.569.g1d74ac4d14

