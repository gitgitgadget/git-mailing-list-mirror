Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D100F200B9
	for <e@80x24.org>; Thu,  3 May 2018 23:47:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751139AbeECXrR (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 May 2018 19:47:17 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34096 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751126AbeECXrQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 May 2018 19:47:16 -0400
Received: by mail-pg0-f65.google.com with SMTP id g20-v6so7538363pgv.1
        for <git@vger.kernel.org>; Thu, 03 May 2018 16:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=/MXcHdrzNYYgBIz8btJu4HgWc0XXFvNnsBJR1/641G0=;
        b=OpkYJxxobHqwEw6GgYU62+g30AhdjCXnifHNEhZr93ErS8SeQYc+0mB4Im/on0b8aP
         ySw90mY+wEOlDyCUGL6jnuIZKqgzxB7ZcOtKW7TRn4kP2HVCMyc1MAVfVAes3zvflg6y
         RZqbseRl81er/XGzMSPKQmB7Hel8GtmBgBEspDZOrtdghKoFgQxwivffYNIWndFRHamS
         +VLNT3S4z6GpLuUEcv7lthbwmFdDEHWd51QNYg2dydpFzRgOYx/rVbUeiO4luhYbrBIP
         9pXFzLvviL31yybgZXx5Jaaeb7RwPT5JAmetfFaM630X6knER5QCu7K4OpfURN5Bop6w
         0tJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=/MXcHdrzNYYgBIz8btJu4HgWc0XXFvNnsBJR1/641G0=;
        b=KfOVq5YViOqlXzyvX09cf1HX1oK9j2pkY4/WKJb6ATn3kKXxNdekv/LnOpYHntQdDJ
         4DYLPSHIKbQUsB8y4QBKup9/sOXwuNU1wgUnWevmv2Fr+BY9FqMZbu9d/6luq7Y8kqzh
         cOCP/KfLpfpB1AqqMOTYArPPazwRSSTdqU2YGwrQ4Wkp9z8+dNaHZ1iemFzz+e64/7ZC
         0s2VbM+AG2CnEjcwkzsU9agPsQa81vze3C2S+loLFkGngSVMoUkMiArVkm/+eQ5492fV
         t8Biupj3RX0HuvVOIHOoLalxZU6gw3apSXHvv0bBZCxCmo77KqxrrWyXI2XgKfC62tyc
         2IFw==
X-Gm-Message-State: ALQs6tDll4kVpSpFZk96DZqXaXzhFtXl+NKjk86aYk3ARjWVK91kdhFm
        Ker1138TUxASod3RRjXXuAaYUDZt9VM=
X-Google-Smtp-Source: AB8JxZrMrRdfDA6XYT6yr80pgPWY1eVy6nkE9xd3nOLFL4jDf/zGM0Ab9HuHguhDxTdCqtEXjErxAw==
X-Received: by 2002:a17:902:1c7:: with SMTP id b65-v6mr25607020plb.298.1525391235088;
        Thu, 03 May 2018 16:47:15 -0700 (PDT)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id a67-v6sm7924669pgc.23.2018.05.03.16.47.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 May 2018 16:47:14 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, sbeller@google.com
Subject: [PATCH v3 2/3] upload-pack: read config when serving protocol v2
Date:   Thu,  3 May 2018 16:46:55 -0700
Message-Id: <73642e0e75dc7543e1057116d57670dc7a6e34c0.1525391172.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
In-Reply-To: <cover.1525391172.git.jonathantanmy@google.com>
References: <cover.1525391172.git.jonathantanmy@google.com>
In-Reply-To: <cover.1525391172.git.jonathantanmy@google.com>
References: <cover.1525213052.git.jonathantanmy@google.com> <cover.1525391172.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The upload-pack code paths never call git_config() with
upload_pack_config() when protocol v2 is used, causing options like
uploadpack.packobjectshook to not take effect. Ensure that this function
is called.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 t/t5702-protocol-v2.sh | 14 ++++++++++++++
 upload-pack.c          |  2 ++
 2 files changed, 16 insertions(+)

diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index 56f7c3c32..abb15cd6d 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -201,6 +201,20 @@ test_expect_success 'ref advertisment is filtered during fetch using protocol v2
 	! grep "refs/tags/three" log
 '
 
+test_expect_success 'upload-pack respects config using protocol v2' '
+	git init server &&
+	write_script server/.git/hook <<-\EOF &&
+		touch hookout
+		"$@"
+	EOF
+	test_commit -C server one &&
+
+	test_config_global uploadpack.packobjectshook ./hook &&
+	test_path_is_missing server/.git/hookout &&
+	git -c protocol.version=2 clone "file://$(pwd)/server" client &&
+	test_path_is_file server/.git/hookout
+'
+
 # Test protocol v2 with 'http://' transport
 #
 . "$TEST_DIRECTORY"/lib-httpd.sh
diff --git a/upload-pack.c b/upload-pack.c
index c4456bb88..113edd32d 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -1376,6 +1376,8 @@ int upload_pack_v2(struct repository *r, struct argv_array *keys,
 	enum fetch_state state = FETCH_PROCESS_ARGS;
 	struct upload_pack_data data;
 
+	git_config(upload_pack_config, NULL);
+
 	upload_pack_data_init(&data);
 	use_sideband = LARGE_PACKET_MAX;
 
-- 
2.17.0.441.gb46fe60e1d-goog

