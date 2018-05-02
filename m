Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D3B2521847
	for <e@80x24.org>; Wed,  2 May 2018 00:31:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753502AbeEBAbo (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 20:31:44 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35321 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753495AbeEBAbm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 May 2018 20:31:42 -0400
Received: by mail-pg0-f67.google.com with SMTP id j11-v6so9335720pgf.2
        for <git@vger.kernel.org>; Tue, 01 May 2018 17:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=vgDYEkrCZAeJ8GEllg+lCzLFwKf5tXpWB0r8lBEyWFE=;
        b=bqQIjmZtX6ELJTa8PYiQKRv+77H9/5JntCOivmmd19d17QF1rQB+610QlT2iOMr+NC
         CPKwGQvMtPM3IWxTcfoMU8u6AUKBt2vhqsWxXlClE8x3kg6OJDeRjemE/nd1BPysWeAk
         XdlcZ9vykeNoBVzqlnu8AIGKDozxGvOuy9xhpQleSuLCUIDUmkFRyWBLz8MFKVQtfpeh
         pLbFfI+6B0G04IG+zfCRuXXO2psoX7AOtL+7P8jL3Qu2dmDNzkQVEtnHAJwDumM4jL4g
         4SF1l2U+9Vugj5UOBMv2+CzEcbPOkPnYXDsX8T4ygmZL6LY0tPx/64ptLxjUTiKesTAd
         Wf+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=vgDYEkrCZAeJ8GEllg+lCzLFwKf5tXpWB0r8lBEyWFE=;
        b=W0fNooMrhzbdgWDWzhaZTSC1Z8YjIY5mAPh6PFPrI5UXLxyTIp9iid+jAzOUw53Knk
         rrTpVAMWq0AXWqB3R5Q0or33mcVVlRRkuocaUdS+uSx5+49AGWSSsmTY5ECy9XUkdsup
         oKK0OoIg00NZOxev5e1m5QLw/raB1i48/GLsQ0vMMcTW93i34idOzpbquDXZWH5zDlKH
         0SmHDe6Oz+PPHlhagiSNSmbulvOal1e+inn9aRZV++MIXSNGq25ANVFEOW7m38pGGZQl
         mH9JJq0EG1ZzTrNrC0FwglCzrQvwa7qNdfbpcNcZCuLRAxyIIgM9GW7QMbT7bA1RRlJ/
         VEuA==
X-Gm-Message-State: ALQs6tDFZB/4oXiLN0xk0ViKTmZLsH98omaqVmE5zTAsHtqF6ERSJcvL
        rld9YhYyUE+Xzxf+q5AKL5bZOncTt0U=
X-Google-Smtp-Source: AB8JxZoKT0ofTYMpGXslP/WkysBAaLLEkjFOzmapsMcndFvNxf3Ckm5OvFDETz4LuQliAx7gsMJEzA==
X-Received: by 2002:a17:902:4003:: with SMTP id b3-v6mr17636516pld.15.1525221101666;
        Tue, 01 May 2018 17:31:41 -0700 (PDT)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id s6-v6sm6306585pgq.19.2018.05.01.17.31.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 May 2018 17:31:40 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, bmwill@google.com
Subject: [PATCH v2 2/3] upload-pack: read config when serving protocol v2
Date:   Tue,  1 May 2018 17:31:30 -0700
Message-Id: <6e85aaa555f6789156626330327085207b2d2dff.1525220786.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
In-Reply-To: <cover.1525220786.git.jonathantanmy@google.com>
References: <cover.1525220786.git.jonathantanmy@google.com>
In-Reply-To: <cover.1525220786.git.jonathantanmy@google.com>
References: <cover.1525213052.git.jonathantanmy@google.com> <cover.1525220786.git.jonathantanmy@google.com>
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
index 56f7c3c32..0ead99993 100755
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
+	test ! -f server/.git/hookout &&
+	GIT_TRACE=/tmp/y git -c protocol.version=2 clone "file://$(pwd)/server" client &&
+	test -f server/.git/hookout
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

