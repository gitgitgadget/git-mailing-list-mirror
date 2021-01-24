Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F5E4C433E0
	for <git@archiver.kernel.org>; Sun, 24 Jan 2021 17:29:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA74822CA2
	for <git@archiver.kernel.org>; Sun, 24 Jan 2021 17:29:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725768AbhAXR3T (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Jan 2021 12:29:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbhAXR3J (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Jan 2021 12:29:09 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18499C061574
        for <git@vger.kernel.org>; Sun, 24 Jan 2021 09:28:29 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id u14so8738818wmq.4
        for <git@vger.kernel.org>; Sun, 24 Jan 2021 09:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H7QPHD/BZvuwjZXl1GEdk9NQaIhWhJE60o7eNQllC6c=;
        b=O73aa9RHCyQ9QdTlerKrNCjIrrbFxt46Frx2Nw3Fi44Pr3OKvwfrF3n1wRH4W4DB7L
         mLGeE2jv/2NWzA6slReEBxmVx+aMBGhfG0MNipZhE5wkqoaobSY8CQ2bJvjIZ96+Zaze
         lfhTuvcBpNa+vpHARZ9fwDzYVKv6QJf1pL0XsJdZfHYx8SVVll2j1n/q6dsjticXOqPX
         1UJfB27u+UyNkJn0xa9b1wM9nbBShu2eYZeSCy5gCVsJIKa3vTJmYQPITH+6gMLgUuQX
         8zMWS0bRhybiIYCrljQSh6h4MLsbQWISPT60D87OmpwrrriL1npzS0/nuI8px1436sX6
         IX3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H7QPHD/BZvuwjZXl1GEdk9NQaIhWhJE60o7eNQllC6c=;
        b=gRm1TLEkD9UyVTXy0CRQXXOcu+dVYS7KipMcCz9YckqLtTIEo5pilJdp+CACBmy1ub
         j2BLA/yz7Wg3cxxnXlDof10vvgU2bHgwGOTxo4FTDJTTwdmszdjniBjvS3wUXpxoLvgV
         OSqIdtrSniciQD57sQ/3KOPWt0K8RCyuGccXwhhODQ6eEuaQtNQ3uzoIl9PL5NFWecnQ
         8veXIEQvdH90J9ALenaWcRs4Fc65NXBjIQsifeEHpCxnozZ8ob/awYYwCEo245US1jKz
         uxoH9Ap7T0chbNP8hXCh22S5TE1nmX452vdBdjLsR3ot+1YqFXFYyfPDSaT3nNHHL7IY
         GLIg==
X-Gm-Message-State: AOAM533mBcQVNEvUZ8c6eizpUpjjyFt91/473xreU4hVZ3M2xI4ozfx8
        dVl+5834We9EiPdYOGZIP7WSlA8olt10iQ==
X-Google-Smtp-Source: ABdhPJxBtHpTCNL7FzHVCWDH/lFXZbSG9hvLGDCcBmJDTQfof5UQThXXAoYkv/ayQNqyiLPmaivXfA==
X-Received: by 2002:a1c:7c03:: with SMTP id x3mr3422691wmc.103.1611509307541;
        Sun, 24 Jan 2021 09:28:27 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z185sm4127332wmb.0.2021.01.24.09.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Jan 2021 09:28:26 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Todd Zullinger <tmz@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 0/2] grep: better support invalid UTF-8 haystacks 
Date:   Sun, 24 Jan 2021 18:28:11 +0100
Message-Id: <20210124172813.9547-1-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20210124114855.13036-1-avarab@gmail.com>
References: <20210124114855.13036-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fixes a version comparison typo/thinko, pointed out by Ramsay Jones.

Ævar Arnfjörð Bjarmason (2):
  grep/pcre2 tests: don't rely on invalid UTF-8 data test
  grep/pcre2: better support invalid UTF-8 haystacks

 Makefile                        |  1 +
 grep.c                          | 18 ++++++++++-
 grep.h                          |  4 +++
 t/helper/test-pcre2-config.c    | 12 ++++++++
 t/helper/test-tool.c            |  1 +
 t/helper/test-tool.h            |  1 +
 t/t7812-grep-icase-non-ascii.sh | 53 ++++++++++++++++++++++++++++-----
 7 files changed, 82 insertions(+), 8 deletions(-)
 create mode 100644 t/helper/test-pcre2-config.c

Range-diff:
1:  699bb6b324 = 1:  699bb6b324 grep/pcre2 tests: don't rely on invalid UTF-8 data test
2:  e4807d6879 ! 2:  04c87c04d7 grep/pcre2: better support invalid UTF-8 haystacks
    @@ grep.c: static void compile_pcre2_pattern(struct grep_pat *p, const struct grep_
     -		options |= PCRE2_UTF;
     +		options |= (PCRE2_UTF | PCRE2_MATCH_INVALID_UTF);
     +
    -+	if (PCRE2_MATCH_INVALID_UTF &&
    -+	    options & (PCRE2_UTF | PCRE2_CASELESS) &&
    -+	    !(PCRE2_MAJOR >= 10 && PCRE2_MAJOR >= 36))
    -+		/* Work around https://bugs.exim.org/show_bug.cgi?id=2642 fixed in 10.36 */
    -+		options |= PCRE2_NO_START_OPTIMIZE;
    ++	/* Work around https://bugs.exim.org/show_bug.cgi?id=2642 fixed in 10.36 */
    ++	if (PCRE2_MATCH_INVALID_UTF && options & (PCRE2_UTF | PCRE2_CASELESS)) {
    ++		struct strbuf buf;
    ++		int len;
    ++		int err;
    ++
    ++		if ((len = pcre2_config(PCRE2_CONFIG_VERSION, NULL)) < 0)
    ++			BUG("pcre2_config(..., NULL) failed: %d", len);
    ++		strbuf_init(&buf, len + 1);
    ++		if ((err = pcre2_config(PCRE2_CONFIG_VERSION, buf.buf)) < 0)
    ++			BUG("pcre2_config(..., buf.buf) failed: %d", err);
    ++		if (versioncmp(buf.buf, "10.36") < 0)
    ++			options |= PCRE2_NO_START_OPTIMIZE;
    ++		strbuf_release(&buf);
    ++	}
      
      	p->pcre2_pattern = pcre2_compile((PCRE2_SPTR)p->pattern,
      					 p->patternlen, options, &error, &erroffset,
-- 
2.29.2.222.g5d2a92d10f8

