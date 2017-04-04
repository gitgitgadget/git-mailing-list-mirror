Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B10F20966
	for <e@80x24.org>; Tue,  4 Apr 2017 10:21:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754200AbdDDKVy (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Apr 2017 06:21:54 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35711 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754037AbdDDKVw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Apr 2017 06:21:52 -0400
Received: by mail-pg0-f65.google.com with SMTP id g2so36191277pge.2
        for <git@vger.kernel.org>; Tue, 04 Apr 2017 03:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H658aHxTcg4f8tRZoUEYxLObQ64vTX7mRD8S0Jqx1/U=;
        b=dZ4Fp1YBqXyAAWfTgqfDlV8Qae5zyvtZJU/WV6yKYEhilDWwuUXwc2YVl2EWIfo24G
         c7KynWYUuoniwOOvGj+mjlFtGcaE0zssksCeTbRnsGz2KI7ZCrkMpmkOtdF1RcENQFKD
         puAloAj+23eTPUi0Nx4JYdbUiCKLqKBRzPu8Yn374wbS6jEW3Wi70ZsQg90n1ViDisYS
         LbCPxhKvgarGdgCFSS2l557yKiiw7lDtWBwfHdPjfVpw5+D/KOHohV3H7yCF/Zf5W9it
         fSRDyBv/GfQHi5WEbxU8bkvucG/Dhbrkts9ZwxsXApe8bil7yw5vl/yX9E2gEGNMBEjB
         S+bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H658aHxTcg4f8tRZoUEYxLObQ64vTX7mRD8S0Jqx1/U=;
        b=Ywqy5YD2f5W2NF5V3fg7cL+rfdH3TxNYASWKsF+LuAgxv5cgFCnhzyBIimQohTVEpk
         Z6p4eTUQ+xL2HG7MyGJxNBS5hNFRnIdchJJ4qYJZYsu3AxScuZe40HmbBUkng8VWxn0H
         VouWBG+E1gbhI+kkqwWwqD6auHzDmgNwc2Qm/FCwVdeggGp1kjQ+gxQlEnBFW3gl9I7S
         /K6VBmPFiEswwe8/EiXieJP5GNGhor3bs8UVCQs0GH3K96ZtfqtFwgBP5gMxZM8DVc9w
         liyuwXrYzdyC8c6Js1w/vk0bCzJ5ta47BleIMagJoSoM1Z4AV/FgKC6ia+EnAn8G96ig
         MLEg==
X-Gm-Message-State: AFeK/H31lLWhRG09zrArEvzbWDwx4n7Wsti9pO3ETTCHPokIvBpBpR1fTr/BcTrt1SplcA==
X-Received: by 10.98.49.129 with SMTP id x123mr1304979pfx.45.1491301312111;
        Tue, 04 Apr 2017 03:21:52 -0700 (PDT)
Received: from ash ([115.73.171.114])
        by smtp.gmail.com with ESMTPSA id s20sm30917932pfg.11.2017.04.04.03.21.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Apr 2017 03:21:51 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Tue, 04 Apr 2017 17:21:47 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v4 1/5] environment.c: fix potential segfault by get_git_common_dir()
Date:   Tue,  4 Apr 2017 17:21:19 +0700
Message-Id: <20170404102123.25315-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170404102123.25315-1-pclouds@gmail.com>
References: <20170318100206.5980-1-pclouds@gmail.com>
 <20170404102123.25315-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

setup_git_env() must be called before this function to initialize
git_common_dir so that it returns a non NULL string. And it must return
a non NULL string or segfault can happen because all callers expect so.

It does not do so explicitly though and depends on get_git_dir() being
called first (which will guarantee setup_git_env()). Avoid this
dependency and call setup_git_env() by itself.

test-ref-store.c will hit this problem because it's very lightweight,
just enough initialization to exercise refs code, and get_git_dir() will
never be called until get_worktrees() is, which uses get_git_common_dir
and hits a segfault.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 environment.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/environment.c b/environment.c
index 42dc3106d2..2986ee7200 100644
--- a/environment.c
+++ b/environment.c
@@ -214,6 +214,8 @@ const char *get_git_dir(void)
 
 const char *get_git_common_dir(void)
 {
+	if (!git_dir)
+		setup_git_env();
 	return git_common_dir;
 }
 
-- 
2.11.0.157.gd943d85

