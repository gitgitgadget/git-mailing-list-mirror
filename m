Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D124C7EE24
	for <git@archiver.kernel.org>; Wed, 10 May 2023 21:37:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235995AbjEJVhq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 May 2023 17:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235984AbjEJVhp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 May 2023 17:37:45 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCAF43A85
        for <git@vger.kernel.org>; Wed, 10 May 2023 14:37:42 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id 5614622812f47-38eb2984c82so2482305b6e.0
        for <git@vger.kernel.org>; Wed, 10 May 2023 14:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683754662; x=1686346662;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H2mypDID86Kunng8ttVxBtlQfgst4TSeerm2KjpuNcg=;
        b=T4hvptE5k9p6KnoaXewFD5pUXmLtyVrMal1TnAxX9lNBUsSM5ktnE0VSxy6U9UsDTX
         /ZzRVhzmfOc8xSQ0JOwY+MrloRNxQ8ufT7oswbeaNBZ4TDXn4lxM3sZPKz6GBj8VerEP
         Limo5WitfSA3V6Pq42agIqPtqRhBQZh52/X58Om3b6A2BppYtd7doFa3w0qD5VIMGxH1
         6oWHCYMqCY4fh0eZKArpE/tXh36r/dXhWjlL/fl7jvqS6ZMpF+JWsQysd89lFdfj5Jmg
         nV/v8P5zhwERkI2kBCBktAAfpR9DLQSTj7iitu7YGpDUQKGgwCYJnGd+qnSMolf//+tC
         Y8hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683754662; x=1686346662;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H2mypDID86Kunng8ttVxBtlQfgst4TSeerm2KjpuNcg=;
        b=Bo0ecHYCYua/n9KY0Hruk9OCdcJJHk6VMTNGunZZbhnURpF0ggyqzEfFeO94PeWQfV
         BV0/+uvZr0r+KgfxtrRV7eO6KspPCV68Kwlw8XKTRrmQrQZZoR7OJG8hsz7DdEBOH6Ez
         dQRLpulLMAY50HcM9G0OnOQ7YU7R6cdVW1cayAayjlP3GiPKQRuxxrG7Bw2KQlrLLlwo
         HDRzmzC5au2DmHddN6oTziIsoE1pT80nEdgbt3fXcsCUk18TdIoLJK7eFI5OlLzVIirn
         rIylHMoNrVd1o4T/l6kfAKAnnBRblAOdfVBV+vo7G46ljpqkVQr8xcxOrAriT4dQljK2
         Gx9w==
X-Gm-Message-State: AC+VfDz4xMmUUnj+Ov+DDmX8vc4v0buLy75BIdTHab3757SOkSJwcKdR
        VWG0yw7h+65f1/croIr6Osrk7IiVHGY=
X-Google-Smtp-Source: ACHHUZ4UjJHtguLkcRuSYlZcwXqQhZ45KJ67oIBendqxphcScuo360z9fFcnVV7m4az+67K0RMzRZw==
X-Received: by 2002:a05:6808:903:b0:38e:909e:86cf with SMTP id w3-20020a056808090300b0038e909e86cfmr3800699oih.32.1683754661835;
        Wed, 10 May 2023 14:37:41 -0700 (PDT)
Received: from localhost ([2806:2f0:4000:e8a3:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id q66-20020acac045000000b0038c0cf168afsm2739056oif.7.2023.05.10.14.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 14:37:41 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 1/4] test: add merge style config test
Date:   Wed, 10 May 2023 15:37:35 -0600
Message-Id: <20230510213738.505241-2-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.40.0+fc1
In-Reply-To: <20230510213738.505241-1-felipe.contreras@gmail.com>
References: <20230510213738.505241-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We want to test different combinations of merge.conflictstyle, and a new
file is the best place to do that.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t6440-config-conflict-markers.sh | 37 ++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100755 t/t6440-config-conflict-markers.sh

diff --git a/t/t6440-config-conflict-markers.sh b/t/t6440-config-conflict-markers.sh
new file mode 100755
index 0000000000..813d7dda9a
--- /dev/null
+++ b/t/t6440-config-conflict-markers.sh
@@ -0,0 +1,37 @@
+#!/bin/sh
+
+test_description='merge style conflict markers configurations'
+
+. ./test-lib.sh
+
+test_expect_success 'merge' '
+	test_create_repo merge &&
+	(
+		cd merge &&
+
+		test_write_lines 1 2 3 >content &&
+		git add content &&
+		git commit -m base &&
+
+		git checkout -b r &&
+		echo six >>content &&
+		git commit -a -m right &&
+
+		git checkout master &&
+		echo 7 >>content &&
+		git commit -a -m left &&
+
+		test_must_fail git merge r &&
+		! grep "^|||||||" content &&
+
+		git reset --hard &&
+		test_must_fail git -c merge.conflictstyle=diff3 merge r &&
+		grep "^|||||||" content &&
+
+		git reset --hard &&
+		test_must_fail git -c merge.conflictstyle=merge merge r &&
+		! grep "^|||||||" content
+	)
+'
+
+test_done
-- 
2.40.0+fc1

