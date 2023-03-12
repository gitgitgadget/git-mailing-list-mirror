Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FB79C6FD19
	for <git@archiver.kernel.org>; Sun, 12 Mar 2023 20:16:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbjCLUQ0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Mar 2023 16:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231171AbjCLUQK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Mar 2023 16:16:10 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E5652B609
        for <git@vger.kernel.org>; Sun, 12 Mar 2023 13:15:34 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id cy23so40722313edb.12
        for <git@vger.kernel.org>; Sun, 12 Mar 2023 13:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678652132;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G/Qr7JQKwY1aEHaHum0I31e8nLbOslObM7iZqQbIxUA=;
        b=mNnAHFa7mN9RBY85x5/94SJwJos0T478W8wwQqiu/o2qGIGxMnc/4pcsqF52Sy0RWJ
         LhyxLhHckq6dqO6fAg/7VHFsNqHe4ubnt3BBozDrIo4NcXEi65DdMAuEaa4IgHFjfI5P
         0rE3MJZsn423nO9evKPQQmnpw6otRfB2k+61lT6MQN0RCrbXk5jmthQLyrqeg15TBVCE
         tW5uh0R5rvYd+fb6POOlyksmbV6DSeX/xGvv43wC+Ib2P8+ZI9U+iu9/Zn5dVREJDIge
         qjErj3UxcM88hP/iX2XAzSk9a8uRLsTcXSjYkRUNXv0Rk3pouTh7cdXAag7xcmX86Sd7
         foxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678652132;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G/Qr7JQKwY1aEHaHum0I31e8nLbOslObM7iZqQbIxUA=;
        b=ZUoDMdpHZwXXU5mMRDNSMN7d6kQTWdPj0GAoh0BAG/uswIMXAwfY0x7gR3n5jTeqQ8
         lpux+KajN27stJnrxvW4hdNhmf/soRxm/lDvM3fgVAESHKsuX3RQS///MGqQALpp0Q3n
         4r44p2EXLWWpBHQlzF25ZReAv3E5ypAWIhSfMMQTkpMh12t08C/kiPAi39s5sIwpEBhF
         wLDk1pmxuzIsROmYtUtjk9KNjHQwipTCvOSfCj2paOirTq9vRMK3ks+hn0gX9WHsTFDU
         xt356lT/OL5CLuRcDNLI5lu6c1WSiOZbZRIdGttf8+meEELl4gB/pTSFB1yNu+iPEl9p
         BzbQ==
X-Gm-Message-State: AO0yUKWmUSgtBMChlWmMPf8mhSrGm10jqk7CtKTL+hEmbq/BP5/zxRYp
        OkTEQ88dRf66TphcwydKkohj3hiAlCYedg==
X-Google-Smtp-Source: AK7set/DUCAvQfolXLYNRL2xRmd7bdBDyIyeND3zzQ6NjAb+xSg0GTL7Qp8nt/Z9j4edcmXprmLFMA==
X-Received: by 2002:a17:907:8691:b0:8b1:3009:536b with SMTP id qa17-20020a170907869100b008b13009536bmr39996464ejc.29.1678652132771;
        Sun, 12 Mar 2023 13:15:32 -0700 (PDT)
Received: from titov.fritz.box ([216.24.216.227])
        by smtp.gmail.com with ESMTPSA id hz17-20020a1709072cf100b008dceec0fd4csm2570344ejc.73.2023.03.12.13.15.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 13:15:32 -0700 (PDT)
From:   Andrei Rybak <rybak.a.v@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Michael J Gruber <git@grubix.eu>,
        Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v1 5/7] t1400: assert output of update-ref
Date:   Sun, 12 Mar 2023 21:15:18 +0100
Message-Id: <20230312201520.370234-7-rybak.a.v@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230312201520.370234-1-rybak.a.v@gmail.com>
References: <20230312201520.370234-1-rybak.a.v@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In t1400-update-ref.sh test 'transaction can create and delete' creates
files "expect" and "actual", but doesn't compare them.  Similarly, test
'transaction cannot restart ongoing transaction' redirects output of
"git update-ref" to file "actual", but doesn't check its contents with
any assertions.

Assert output of "git update-ref" in tests to improve test coverage in
t1400-update-ref.sh.

Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>
---
 t/t1400-update-ref.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index cf58cf025c..4d66cd7f4a 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -1568,6 +1568,7 @@ test_expect_success 'transaction can create and delete' '
 	EOF
 	git update-ref --stdin <stdin >actual &&
 	printf "%s: ok\n" start commit start commit >expect &&
+	test_cmp expect actual &&
 	test_must_fail git show-ref --verify refs/heads/create-and-delete
 '
 
@@ -1595,6 +1596,8 @@ test_expect_success 'transaction cannot restart ongoing transaction' '
 	commit
 	EOF
 	test_must_fail git update-ref --stdin <stdin >actual &&
+	printf "%s: ok\n" start >expect &&
+	test_cmp expect actual &&
 	test_must_fail git show-ref --verify refs/heads/restart
 '
 
-- 
2.39.2

