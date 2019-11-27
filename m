Return-Path: <SRS0=iCZD=ZT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E7B9C432C0
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 02:09:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D94D42071A
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 02:09:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oJsuHaLa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbfK0CJV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Nov 2019 21:09:21 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45866 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726968AbfK0CJU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Nov 2019 21:09:20 -0500
Received: by mail-pl1-f195.google.com with SMTP id w7so9003699plz.12
        for <git@vger.kernel.org>; Tue, 26 Nov 2019 18:09:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vHGDzFR1Hxyn1LZWp+Ad9rvJ8yhBkTUT8f7WuFicfaU=;
        b=oJsuHaLaHvBj2fj4g8Fn1qwpWo1HgAcT5/oscIzBrLUN7CjMt2doLXGsHdw2kvSgC/
         dF0UruGrXZzs0LDY6RjY1IBrwr1RNqGiD0biiFn6/mJSXUVeKwAvXvRQ9hbH3KcAdBe+
         pmCRxMuXNCIUCcMtl2BmiZFbdgb8hR+2nIpcDaDRWOxi3T/6Mm0EQHBUIJF3MdspjJCW
         lQgyE+e2aYEroKp1QtSsec10kYwOrUj/9lrP0sKz24yL3HG6XV401KnYRzOnAu864HzU
         OfzHs7gyi7N9jHpVZNuOPVdSGJAsTi3+SyhYbAjqdMWHzeGYlcPMzUXhfdGT3GFciT0K
         G2bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vHGDzFR1Hxyn1LZWp+Ad9rvJ8yhBkTUT8f7WuFicfaU=;
        b=jTAUoRoQYrOlaln6tqLSSsxZFLySkDurVhxwfyOv0FGMhHgftEqcZLOepvyeV/Q/9G
         rv3Ceq3ckEshjH67MW1976xJLa7SK5khmfDWmGduBNKJDh/Wx/IqQvv2Ld1sG4tR5OIC
         pJwzNYe7tCGYOw23VhfvsrqXFyX1SfI04dyvsJS5S0qNHM3a3ehnwNZHLpQuzIhPw5c5
         8zbqcGSe/z7bhq+TC0vNmTuHkw3CSJdu8P8Bo8rUisqrioROHQ/hb1tdROvX8iMTChkN
         1v5b6DO+kzifvgP6Py4V+IaA0viTba9LjxpWZCtseTsDWcl1/P4fEqY0nHVUG3FTtgv9
         9IXg==
X-Gm-Message-State: APjAAAWO6RDYEjNXTrj4qijA3zOs3YS1ayiEs0bafddgI6D8BeV8S+lV
        ZeDI7F/7vPgdMxSwmeWCxDDgLIBw
X-Google-Smtp-Source: APXvYqwe959Sh29fDsHMWe8C9+T5dcZawa2jglOGv7SZwP3cp5ASE/wbfvhDcjPyxR50HsKpjmEDoQ==
X-Received: by 2002:a17:90a:ba89:: with SMTP id t9mr2803050pjr.138.1574820559563;
        Tue, 26 Nov 2019 18:09:19 -0800 (PST)
Received: from generichostname ([204.14.239.138])
        by smtp.gmail.com with ESMTPSA id u3sm13751576pgp.51.2019.11.26.18.09.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2019 18:09:19 -0800 (PST)
Date:   Tue, 26 Nov 2019 18:09:17 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Christian Biesinger <cbiesinger@google.com>
Subject: [PATCH 3/5] t4014: use `test_config`
Message-ID: <22b1fb14f9ac841e93b6177cec216530a6756d7c.1574820308.git.liu.denton@gmail.com>
References: <CAPTJ0XEcMJEwPBEL4akncJ_A5XwyQyKL95fpf2tC0rNXJK65Og@mail.gmail.com>
 <cover.1574820308.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1574820308.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of manually unsetting the config after the test case is done,
use `test_config` to do it automatically. While we're at it, fix a typo
in a test case name.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t4014-format-patch.sh | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 69267b16f0..c7cc643adf 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -1939,10 +1939,9 @@ test_expect_success 'format-patch errors out when history involves criss-cross'
 	test_must_fail 	git format-patch --base=auto -1
 '
 
-test_expect_success 'format-patch format.useAutoBaseoption' '
-	test_when_finished "git config --unset format.useAutoBase" &&
+test_expect_success 'format-patch format.useAutoBase option' '
 	git checkout local &&
-	git config format.useAutoBase true &&
+	test_config format.useAutoBase true &&
 	git format-patch --stdout -1 >patch &&
 	grep "^base-commit:" patch >actual &&
 	git rev-parse upstream >commit-id-base &&
@@ -1951,8 +1950,7 @@ test_expect_success 'format-patch format.useAutoBaseoption' '
 '
 
 test_expect_success 'format-patch --base overrides format.useAutoBase' '
-	test_when_finished "git config --unset format.useAutoBase" &&
-	git config format.useAutoBase true &&
+	test_config format.useAutoBase true &&
 	git format-patch --stdout --base=HEAD~1 -1 >patch &&
 	grep "^base-commit:" patch >actual &&
 	git rev-parse HEAD~1 >commit-id-base &&
-- 
2.24.0.504.g3cd56eb17d

