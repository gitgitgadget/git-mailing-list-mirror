Return-Path: <SRS0=NngS=CY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1CF3C43461
	for <git@archiver.kernel.org>; Tue, 15 Sep 2020 09:58:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 560F52080C
	for <git@archiver.kernel.org>; Tue, 15 Sep 2020 09:58:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c35QBtw7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbgIOJ6f (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Sep 2020 05:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726169AbgIOJ6e (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Sep 2020 05:58:34 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E616C06174A
        for <git@vger.kernel.org>; Tue, 15 Sep 2020 02:58:34 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id r19so1074478pls.1
        for <git@vger.kernel.org>; Tue, 15 Sep 2020 02:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7IoT8GOmscal161OYichbAoqU3UPkvQAY6LdkJudSZ8=;
        b=c35QBtw7KJ0ztnc4GJvGJIxTS8JnIUFtWvobcMGWuRABvbWuJ9Qt1Y5PxFAabDl9MZ
         70ia/Rp7GoEcglpC7yCOKLx1Cf840565HRs36rRa4edyFMwf05ySBIDHMttaGcj++0BF
         g7GW2nMNGVo4u8zswYVeiGclIIyRqd4SEFuZSl4yag3y4PgK7Are9tZ5HZ6Dd+nE+Fv9
         Jqy4ICOYl0eVLmPewXkMfyQbC2RpNntv6nVpDzE3W/Sx3iA8MFAs2KTlRDh2cMCTXGjk
         GD/x2mGEZczFeqZniJ0wZyUP1r+NBjwhv4g6Y5fUfbldU9+wB2d+Zg5V+30Rp0LgeeV+
         uyKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7IoT8GOmscal161OYichbAoqU3UPkvQAY6LdkJudSZ8=;
        b=C5W5uWz8Uf0ufuK3reGsN5Nm6NL9+ygnKgq1mg/71pYAO5BeT0Q5Q+pr4V0npH3uqR
         I3xe4FRKEkFgZIIuQf4a0MgMs05SQ8U2H5VtoxAPfD3UZkeJq+KM16pPRUTGOwt74ZXg
         j+HdnuoG2Mbuiz3+wLSD6ulLFYsf0eqFUr3gFYmSOmMooCEgdJSix1wvUIyQlcZQl0HL
         eaTZmPrmkjFYx2eNXBt8ZuZfB3jVIbh5P6iFN1OFTqwmMFaH50u7KAs/EFWZkP5WQlmx
         NtReOlNmrNfENiUbU/8jHvsp6/jaZiruy/WrMEQ0eS+wiDHi67ZuYqZywf+MMYPhRzRW
         +I2A==
X-Gm-Message-State: AOAM5306J/vijbto8s/VlA75loBDSdFa0lMiPQIJvjbOfNXEYbdxzrAt
        dCs871GmGunq714TfHvci1M=
X-Google-Smtp-Source: ABdhPJxJORJ5hrB3G4iJiyxgq/uAFru4+4nfcVJhtpqIlZoL7IldNMPIibuf94Xrr39eFOdzrtHJ1g==
X-Received: by 2002:a17:90a:d702:: with SMTP id y2mr3469043pju.216.1600163913736;
        Tue, 15 Sep 2020 02:58:33 -0700 (PDT)
Received: from localhost.localdomain ([205.204.117.14])
        by smtp.gmail.com with ESMTPSA id i62sm12839400pfe.140.2020.09.15.02.58.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Sep 2020 02:58:33 -0700 (PDT)
From:   Han Xin <chiyutianyi@gmail.com>
X-Google-Original-From: Han Xin <hanxin.hx@alibaba-inc.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Cc:     Han Xin <hanxin.hx@alibaba-inc.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH 1/2] t5534: new test case for atomic signed push
Date:   Tue, 15 Sep 2020 17:58:26 +0800
Message-Id: <20200915095827.52047-1-hanxin.hx@alibaba-inc.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In order to test signed atomic push, add a new test case.

Reviewed-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
Signed-off-by: Han Xin <hanxin.hx@alibaba-inc.com>
---
 t/t5534-push-signed.sh | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/t/t5534-push-signed.sh b/t/t5534-push-signed.sh
index 030331f1c5..d0fcdc900e 100755
--- a/t/t5534-push-signed.sh
+++ b/t/t5534-push-signed.sh
@@ -273,4 +273,21 @@ test_expect_success GPGSM 'fail without key and heed user.signingkey x509' '
 	test_cmp expect dst/push-cert-status
 '
 
+test_expect_failure GPG 'check atomic push before running GPG' '
+	prepare_dst &&
+	git -C dst config receive.certnonceseed sekrit &&
+	write_script gpg <<-EOF &&
+	echo >&2 "Fake gpg is called."
+	exit 1
+	EOF
+	test_must_fail env PATH="$TRASH_DIRECTORY:$PATH" git push --signed --atomic \
+			dst noop ff noff >out 2>&1 &&
+	grep "^error:" out >actual &&
+	cat >expect <<-EOF &&
+	error: atomic push failed for ref refs/heads/noff. status: 2
+	error: failed to push some refs to '"'"'dst'"'"'
+	EOF
+	test_i18ncmp expect actual
+'
+
 test_done
-- 
2.28.0

