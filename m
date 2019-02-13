Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C1031F453
	for <e@80x24.org>; Wed, 13 Feb 2019 21:49:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436953AbfBMVtV (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Feb 2019 16:49:21 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38898 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729596AbfBMVtV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Feb 2019 16:49:21 -0500
Received: by mail-wr1-f65.google.com with SMTP id v13so4250157wrw.5
        for <git@vger.kernel.org>; Wed, 13 Feb 2019 13:49:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oY3AoptyIkmDZI83nRW5nVWPM5C40Mt/DGxz8qH3LGA=;
        b=FlGqaP2fNcGxtVgzA3r9/G6H2lm6q+E1UGV13XsUqwvAj2m/octVW64HxNiRwIpKIc
         kEeP7YMKpGQjlPqHdsIhI5gKOwtYLRmQX9HsNk0TISy9TWu05jFHU2MTKZF9y4bKPIB0
         at46vALHgNpefl/+9EMrQZpyqCSZVjj25Mp6D2ITwcidH2zJyPA8k1ZOTU8+h/pK3Vbm
         rxzAmcHOl/i6M3TLYBVshbO92LoJSLatSQUV6jAcsfS8QUdaOX9tHhDG3xUxh7Jbu8Cb
         isfSQV9Gs6m7nUA9wM15h0kJ6MTsjnpTbBePF94D6W7s4Xj44usScUSN0PnIDrI0m0Xu
         RE8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oY3AoptyIkmDZI83nRW5nVWPM5C40Mt/DGxz8qH3LGA=;
        b=QPslRvCirkKjv5zvyGysfiE2EBPWWaTW79AjRs82kpLoIJRsDdMYUZnDPRmt5MIZ/l
         dyrW9zY/m0JSZJEBpBBVbhUofD+MUnVgc2A3+xKq+u3Goa4NZ6BbG8yajrIYHYJymbHR
         R+WGIce4YUA8JzocyrmoQvGnn7ck1NzqSL+oZQhexSj9CQDRmcJHi03vN1wviYxl9SJC
         JJ0pDknCUBBFV4e2Rlbc6yKFmtnFJbc82xKqKEEiOfz4hijXPT6qzYgJ6V93B6Yk493F
         ZoezfXUG6VBRYvbGDe+8sf++wC79oVXcrjAWcMPfS3sbuYWsIed2K6g71anW/kXFknWF
         zDkg==
X-Gm-Message-State: AHQUAuY43Jxo9F4cOa9UN52a2pyM/YOCf3gT6VGB/RcZSH5Ncvw0limd
        sYlasz4wWJmD/DcmLK5rlG/5EPX3aJs=
X-Google-Smtp-Source: AHgI3IbLpygcRP8PElTLB9AIriUImiN1uevsslEh+aRe/Ey87x/vXrp53d1+EexYAxcsVM8CJdzEbA==
X-Received: by 2002:a5d:6850:: with SMTP id o16mr176667wrw.123.1550094558514;
        Wed, 13 Feb 2019 13:49:18 -0800 (PST)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o7sm279129wmc.44.2019.02.13.13.49.17
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 13 Feb 2019 13:49:17 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] rebase: fix regression in rebase.useBuiltin=false test mode
Date:   Wed, 13 Feb 2019 22:49:08 +0100
Message-Id: <20190213214908.9459-1-avarab@gmail.com>
X-Mailer: git-send-email 2.20.1.611.gfbb209baf1
In-Reply-To: <xmqqva1nbeno.fsf@gitster-ct.c.googlers.com>
References: <xmqqva1nbeno.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a recently introduced regression in c762aada1a ("rebase -x: sanity
check command", 2019-01-29) triggered when running the tests with
GIT_TEST_REBASE_USE_BUILTIN=false. See 62c23938fa ("tests: add a
special setup where rebase.useBuiltin is off", 2018-11-14) for how
that test mode works.

As discussed on-list[1] it's not worth it to implement the sanity
check in the legacy rebase code, we plan to remove it after the 2.21
release. So let's do the bare minimum to make the tests pass under the
GIT_TEST_REBASE_USE_BUILTIN=false special setup.

1. https://public-inbox.org/git/xmqqva1nbeno.fsf@gitster-ct.c.googlers.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

On Wed, Feb 13 2019, Junio C Hamano wrote:
  
> [...]
> It would however be long enough to declare victory _immediately
> after_ the upcoming release and start the next cycle without the
> escape hatch.  At that point we'd be committed to maintain only the
> built-in version.
>
> The more important every-day features should still be covered by
> tests, if the scripted ones are to be kept as escape hatch.  So to
> me #1 looks like the only sensible choice at this point, if you want
> to see a test cycle with USE_BUILTIN=false to fully pass (i.e. by
> skipping the ones that are known not to pass).

Let's do this for 2.21 then and I'll re-submit the legacy removal
patch after we start 2.22.

 t/t3404-rebase-interactive.sh | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 52fa41c707..b60b11f9f2 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -149,10 +149,12 @@ test_expect_success 'rebase -i with the exec command checks tree cleanness' '
 
 test_expect_success 'rebase -x with empty command fails' '
 	test_when_finished "git rebase --abort ||:" &&
-	test_must_fail git rebase -x "" @ 2>actual &&
+	test_must_fail env GIT_TEST_REBASE_USE_BUILTIN=true \
+		git rebase -x "" @ 2>actual &&
 	test_write_lines "error: empty exec command" >expected &&
 	test_i18ncmp expected actual &&
-	test_must_fail git rebase -x " " @ 2>actual &&
+	test_must_fail env GIT_TEST_REBASE_USE_BUILTIN=true \
+		git rebase -x " " @ 2>actual &&
 	test_i18ncmp expected actual
 '
 
@@ -160,7 +162,8 @@ LF='
 '
 test_expect_success 'rebase -x with newline in command fails' '
 	test_when_finished "git rebase --abort ||:" &&
-	test_must_fail git rebase -x "a${LF}b" @ 2>actual &&
+	test_must_fail env GIT_TEST_REBASE_USE_BUILTIN=true \
+		git rebase -x "a${LF}b" @ 2>actual &&
 	test_write_lines "error: exec commands cannot contain newlines" \
 			 >expected &&
 	test_i18ncmp expected actual
-- 
2.20.1.611.gfbb209baf1

