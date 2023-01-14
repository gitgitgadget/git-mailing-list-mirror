Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 596EEC677F1
	for <git@archiver.kernel.org>; Sat, 14 Jan 2023 08:30:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbjANIau (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 Jan 2023 03:30:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbjANIar (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Jan 2023 03:30:47 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B10E75B88
        for <git@vger.kernel.org>; Sat, 14 Jan 2023 00:30:44 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id u9so57348936ejo.0
        for <git@vger.kernel.org>; Sat, 14 Jan 2023 00:30:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JSnD3oj50yMKxc2IjMOHpDrQQSmCGlPi0WGyE394pEY=;
        b=JJOQdWx3JdaD45v+dnmwHYcsZdzyR1q5h6yeaIIT0LjYgpG1mtwgc5kE/A5p+kBnlh
         S1M89+b1vAETfxJgKv4TPydrd3DdTV7mtNhHv/pzn+ovMkx9VUcD6Rft6XJbzVF/Ngdu
         rURVmL+A0dRN+QvU0pIoDe86MhE51c9qWnPOchvAkSHk532gKLL6nUPElAB3YTUlPq0+
         iBwuW2n0WD8KBsWwPDjDu+15OLxhu16FwaeqS9Aj6qAajb6cBTsaCXCkCyGIlYzwVRxW
         6IFSlw0WMS/UpD1g5kNwWm/DuC3VPrkgkX6iselqz3yo2HJILNZ1Qzte7neR8jycGMER
         aGMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JSnD3oj50yMKxc2IjMOHpDrQQSmCGlPi0WGyE394pEY=;
        b=cqVbAQwhlqz1ZA9GcOj4d7JZvopc/6Cf6F2JjkDdk9GG1O4I2NFC1g3yppnKmb6nAn
         CsjaVEHoO4+44P6NfufoQPmuBmn2u+ooOo1wf3qxjGVc+GrAu0jBQso8OaWKy2RSoHEn
         jYYqn2WCrI4DIYXKXjiyarDQmKfhx7uQakSW7rJtsweP/G+Vdre8sdhD0rRMgjDPLWd+
         ic1BBJZD2zYjMX9n0dElRRnvkjoSrL7fp+rL+UEUGuTEqXrlJMZeZlZuz+g4SV31zl6V
         Per0ZY8wA0120s/aBnVesAJYNUio9NknYtA1YE42UwSDy8PDUwUtgFkS82wBp6/HhAQS
         wWow==
X-Gm-Message-State: AFqh2kqvFiZwe6Ts1VyinJJ7nGv59SeoxPhW8Dwwgx5b6rXxVdJ9B/BA
        HNc28MoE2/EWB5i/dL1rcFJZx970fyY=
X-Google-Smtp-Source: AMrXdXtgI7JPe4o86gfyXpHgRPUgOiJvumVRAgSrc4BcUyNTWWz8wiQas0q+MgbsueBxIcxIX4mDBg==
X-Received: by 2002:a17:907:2908:b0:85b:9540:4ca7 with SMTP id eq8-20020a170907290800b0085b95404ca7mr11343208ejc.30.1673685042979;
        Sat, 14 Jan 2023 00:30:42 -0800 (PST)
Received: from archlinux.fritz.box ([2a02:2454:574:5100:bfcd:791:c83b:983c])
        by smtp.gmail.com with ESMTPSA id e20-20020a170906249400b0084d4cb00f0csm6519089ejb.99.2023.01.14.00.30.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Jan 2023 00:30:42 -0800 (PST)
From:   Karthik Nayak <karthik.188@gmail.com>
To:     git@vger.kernel.org
Cc:     phillip.wood@dunelm.org.uk, sunshine@sunshineco.com,
        Karthik Nayak <karthik.188@gmail.com>, toon@iotcl.com
Subject: [PATCH v7 1/2] t0003: move setup for `--all` into new block
Date:   Sat, 14 Jan 2023 09:30:37 +0100
Message-Id: <622475417916cf48b8fb48e3587f6c87750d43ed.1673684790.git.karthik.188@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <cover.1673684790.git.karthik.188@gmail.com>
References: <https://lore.kernel.org/git/cover.1673521102.git.karthik.188@gmail.com/> <cover.1673684790.git.karthik.188@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There is some setup code which is used by multiple tests being setup in
`attribute test: --all option`. This means when we run "sh
./t0003-attributes.sh --run=setup,<num>" there is a chance of failing
since we missed this setup block.

So to ensure that setups are independent of test logic, move this to a
new setup block.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
Co-authored-by: toon@iotcl.com
---
 t/t0003-attributes.sh | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
index f7ee2f2ff0..b3aabb8aa3 100755
--- a/t/t0003-attributes.sh
+++ b/t/t0003-attributes.sh
@@ -203,9 +203,12 @@ test_expect_success 'attribute test: read paths from stdin' '
 	test_cmp expect actual
 '
 
-test_expect_success 'attribute test: --all option' '
+test_expect_success 'setup --all option' '
 	grep -v unspecified <expect-all | sort >specified-all &&
-	sed -e "s/:.*//" <expect-all | uniq >stdin-all &&
+	sed -e "s/:.*//" <expect-all | uniq >stdin-all
+'
+
+test_expect_success 'attribute test: --all option' '
 	git check-attr --stdin --all <stdin-all >tmp &&
 	sort tmp >actual &&
 	test_cmp specified-all actual
-- 
2.39.0

