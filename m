Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 155F3C433E0
	for <git@archiver.kernel.org>; Sun, 24 Jan 2021 02:13:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8C7022B51
	for <git@archiver.kernel.org>; Sun, 24 Jan 2021 02:13:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbhAXCNt (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Jan 2021 21:13:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726375AbhAXCNe (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Jan 2021 21:13:34 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B32EC061786
        for <git@vger.kernel.org>; Sat, 23 Jan 2021 18:12:53 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id c12so8781856wrc.7
        for <git@vger.kernel.org>; Sat, 23 Jan 2021 18:12:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NB7mhvFvUjEowPusLa+YA1W3DcEB1yfVBnq/lJzfrok=;
        b=kuJOpcN7oAF4urwSPspZ1XOh3SxMUDkmM3iQdk9jyu7L0p5KvEoWq4n6DLr4Cy3BwR
         OAyGSYp0YbXbLpVHYXfFs30HXjo1Fr7VY2QcX/VzaZYeMvK5UM5/whNPJjLyMlsXWoLu
         XOMMQ+S5Rc+1+ydr2hYMLJri+lOUGx260h0Nq83OQfuC5wQyVhuxMaobRtRmaqkp0nS0
         mwuFqrF7YzI1n7bCgWKyWGy/8t8FTg4IlIHiiy9/sOSAoTiY1ok5HYv/t7DsXqbLu2KQ
         H7OUyKu/Bk8dYFJI8VbhsYCJTOVQZsNTRiet1FeAORv4a0XUQQASyR1RxGHcU9u6DbN7
         chXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NB7mhvFvUjEowPusLa+YA1W3DcEB1yfVBnq/lJzfrok=;
        b=NoC/aPWgU4Z9r6cLkKbca3/CLfnfWbltruTH93phnT8sUD1S5DMeoWXDEzOemPwNM5
         ivJjAo/7V4ZUg9IoVsZsJ8XtFS3WrkdtfTz20L7Zdy/tfp+nz+LSZrcv6xwVvlitwRlv
         rO+cWF7BCWJ7OLcGs8O0ljIGbF9juraec03i2KleLM7dnTYl+uRPbLTYIxBKD8Zbzvnx
         moqxZCZlio6S5p5UcD2Yj+Mh32hHY8ScmIuueXP3ONHnCHkEz75JoZ4MMHtJNI6m8RpM
         aS13u/uQtQPSG5WkUP43j/5ZvjzkvOafm3607SfSxyxSdOSJpC71IQflPECQoXkNfhb7
         cu1A==
X-Gm-Message-State: AOAM530/TaJv2F8mOH6OVVMVaFAep5dQyl0UjTLTJaAGYHmpBC+fbqOH
        SLt7p+uFkit+ExpvYN6uvvXdmjA0Mn9nUg==
X-Google-Smtp-Source: ABdhPJzbFqQgTp9f2jjAPlJBfk0AwtPICvGgULJqOFe6EKVKjUQ5Uxw5GFsndPVcspZmVHjHTCrpIA==
X-Received: by 2002:adf:f9d0:: with SMTP id w16mr11004913wrr.137.1611454371935;
        Sat, 23 Jan 2021 18:12:51 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z184sm17380129wmg.7.2021.01.23.18.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jan 2021 18:12:51 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Todd Zullinger <tmz@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 1/4] grep/pcre2 tests: don't rely on invalid UTF-8 data test
Date:   Sun, 24 Jan 2021 03:12:26 +0100
Message-Id: <20210124021229.25987-2-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20190726150818.6373-9-avarab@gmail.com>
References: <20190726150818.6373-9-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As noted in [1] when I originally added this test in [2] the test was
completely broken as it lacked a redirect[3]. I now think this whole
thing is overly fragile. Let's only test if we have a segfault here.

Before this the first test's "test_cmp" was pretty meaningless. We
were only testing if PCREv2 was so broken that it would spew out
something completely unrelated on stdout, which isn't very plausible.

In the second test we're relying on PCREv2 forever holding to the
current behavior of the PCRE_UTF8 flag, as opposed to learning some
optimistic graceful fallback to PCRE2_MATCH_INVALID_UTF in the
future. If that happens having this test broken under bisecting would
suck.

A follow-up commit will actually test this case in a meaningful way
under the PCRE2_MATCH_INVALID_UTF flag. Let's run this one
unconditionally, and just make sure we don't segfault.

1. e714b898c6 (t7812: expect failure for grep -i with invalid UTF-8
   data, 2019-11-29)
2. 8a5999838e (grep: stess test PCRE v2 on invalid UTF-8 data,
   2019-07-26)
3. c74b3cbb83 (t7812: add missing redirects, 2019-11-26)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t7812-grep-icase-non-ascii.sh | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/t/t7812-grep-icase-non-ascii.sh b/t/t7812-grep-icase-non-ascii.sh
index 03dba6685a..38457c2e4f 100755
--- a/t/t7812-grep-icase-non-ascii.sh
+++ b/t/t7812-grep-icase-non-ascii.sh
@@ -76,12 +76,7 @@ test_expect_success GETTEXT_LOCALE,LIBPCRE2 'PCRE v2: grep non-ASCII from invali
 
 test_expect_success GETTEXT_LOCALE,LIBPCRE2 'PCRE v2: grep non-ASCII from invalid UTF-8 data with -i' '
 	test_might_fail git grep -hi "Æ" invalid-0x80 >actual &&
-	if test -s actual
-	then
-	    test_cmp expected actual
-	fi &&
-	test_must_fail git grep -hi "(*NO_JIT)Æ" invalid-0x80 >actual &&
-	! test_cmp expected actual
+	test_might_fail git grep -hi "(*NO_JIT)Æ" invalid-0x80 >actual
 '
 
 test_done
-- 
2.29.2.222.g5d2a92d10f8

