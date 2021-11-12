Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D961FC433EF
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 21:49:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7DF260F36
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 21:49:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235943AbhKLVwN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Nov 2021 16:52:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235838AbhKLVwD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Nov 2021 16:52:03 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8EFBC0613F5
        for <git@vger.kernel.org>; Fri, 12 Nov 2021 13:49:11 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id b12so17921671wrh.4
        for <git@vger.kernel.org>; Fri, 12 Nov 2021 13:49:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L1Z4EP7S+E5heMuoL696RAtbxmLDk7Ny+JKU1d3yQTw=;
        b=Y7fMD3zpvbLN4XRg1zmG3WR/MrZLgRPjGbhESCrfCi9D5ElTLUIM5CZF9ZCeqtNWFk
         IpDys9YUBcGPh1/d0QNj6egJED7oy677dnZrNDqzFt0vd2f97h27m8On1wLlztEo39hC
         0Hr5kNkCxW1zRmcEnMn/pRQz1L0utQF9q4++u6/mwbWQk3BTVhg0FjmyD7T+3PqAvnPq
         phcrWtj1Rwutui6oArLJtWhzTDzfGiMgBi/gwdtsxVXWpAarQzlz/VnCc3okRwgJctX0
         rlshYYadWDO/aq+3AGbiXXrwbWeQueDROa0wk+A871hHokv8Xl5XEMJAU4CmEHsCuj3U
         FWjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L1Z4EP7S+E5heMuoL696RAtbxmLDk7Ny+JKU1d3yQTw=;
        b=fh8sm+pDJ8jDCzapxNjRgEAgtMt7ZYpUKB23kE6J7wHB/b+ieWuUD3ISFO7fvRQV5J
         0TnrTgX9Bno2CeVAjCIi23x5gkuqXR3p8kN2nPSFF1+829uecB0UjyBt8uewa3WDc5Io
         kuI7MVO/vtvZtH8YY2HVRHroqpzxUzjGo4CLOJ57CBsTJ8ZVxH22gTlgKnhOb3U7XkZT
         IgWJ5Sj5vG8i3Fjrux7Y+gg/DIRqqr/gTcFvkZxkV/Gx1kYGahKQYF6G77ZhcjYte84u
         dMtVmYy9vKuccFQgerqOgZWDjklLSp1Q1YXcPDVuNbothWq1Cpm0ntaBfJOPY45yd0eu
         pdaw==
X-Gm-Message-State: AOAM532X7Twg6qHINF/HChw7yFVhfPTurCaLNp+bucZCThhDmwl5cXSi
        J7rxMKy1e5Yz+Otk3T8dotbF9QyRKJMbhA==
X-Google-Smtp-Source: ABdhPJyyXqc/vTCYcHG1roEVdGL7nyfZ5pymMBmpMrYjzI7Ck+UX+5EP3otFeomk+mJwVJAdjbu9Ww==
X-Received: by 2002:a05:6000:184e:: with SMTP id c14mr22281308wri.241.1636753750058;
        Fri, 12 Nov 2021 13:49:10 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h27sm14117189wmc.43.2021.11.12.13.49.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 13:49:09 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>, Dan Jacques <dnj@google.com>,
        Eric Wong <e@80x24.org>, Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 04/18] Makefile: clean perl/build/ even with NO_PERL=Y
Date:   Fri, 12 Nov 2021 22:48:48 +0100
Message-Id: <patch-v2-04.18-a5ce2dce164-20211112T214150Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.rc2.795.g926201d1cc8
In-Reply-To: <cover-v2-00.18-00000000000-20211112T214150Z-avarab@gmail.com>
References: <cover-00.16-00000000000-20211106T205717Z-avarab@gmail.com> <cover-v2-00.18-00000000000-20211112T214150Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a regression in 499c29394ce (Makefile: allow building without
perl, 2009-04-03) where we'd stop cleaning the perl/* directory
because NO_PERL was defined, thus leaving behind litter if the flag at
"clean" time didn't match that of build time.

In 499c29394ce this was done to avoid relying on the perl/Makefile.PL,
but since my 20d2a30f8ff (Makefile: replace perl/Makefile.PL with
simple make rules, 2017-12-10) we can clean things in that directory
unconditionally.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 6b77702e102..a71fba15e30 100644
--- a/Makefile
+++ b/Makefile
@@ -3234,6 +3234,7 @@ clean: profile-clean coverage-clean cocciclean
 	$(RM) $(HCC)
 	$(RM) -r bin-wrappers $(dep_dirs) $(compdb_dir) compile_commands.json
 	$(RM) -r po/build/
+	$(RM) -r perl/build/
 	$(RM) *.pyc *.pyo */*.pyc */*.pyo $(GENERATED_H) $(ETAGS_TARGET) tags cscope*
 	$(RM) -r .dist-tmp-dir .doc-tmp-dir
 	$(RM) $(GIT_TARNAME).tar.gz
@@ -3242,7 +3243,6 @@ clean: profile-clean coverage-clean cocciclean
 	$(RM) Documentation/GIT-EXCLUDED-PROGRAMS
 ifndef NO_PERL
 	$(MAKE) -C gitweb clean
-	$(RM) -r perl/build/
 endif
 	$(MAKE) -C templates/ clean
 	$(MAKE) -C t/ clean
-- 
2.34.0.rc2.795.g926201d1cc8

