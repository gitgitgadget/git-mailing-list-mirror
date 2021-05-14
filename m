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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AFADC433B4
	for <git@archiver.kernel.org>; Fri, 14 May 2021 11:56:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 445D761406
	for <git@archiver.kernel.org>; Fri, 14 May 2021 11:56:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232658AbhENL5v (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 May 2021 07:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232428AbhENL5u (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 May 2021 07:57:50 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1544DC06174A
        for <git@vger.kernel.org>; Fri, 14 May 2021 04:56:39 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id q7-20020a9d57870000b02902a5c2bd8c17so26244803oth.5
        for <git@vger.kernel.org>; Fri, 14 May 2021 04:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eELljfT6wicp9sMuiJj+IVC8he2MZfvlcRihzftFcsE=;
        b=fsEv/2qTiwodQCZlC+waPW/2ZRkiAhKukZK7hsi1MTz4ryeUbuh6J8Zy5i4Q1+sBF9
         cYocDQ67t2+DZprOBNm5gwHyIq5+JywtIdLUle9Xv2dKqwASCuN2xddLFDR/Yaniz3kY
         hIEiiO/ZRS5HXa0jdOl1SGBhLxvOGqouDSFfWcPSEzX0m2cj1i+IctQNcRWeRlgZyB8z
         Oanq+a6uxvK8Ann7lj2XpnqlyYo9m+VF6AX62p7wZ1BGT8OgI08hXCjHP9MbhLQQ5ypX
         BhyMUcLtPna25ooMfqmo3ami2P96skLQLyaMa/xbAUhp0oEz/1MrkTAQ6SntBN5coP/8
         AHxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eELljfT6wicp9sMuiJj+IVC8he2MZfvlcRihzftFcsE=;
        b=QrBQQqRIbsuVV4bW6j/fpoWd5svWMZNre1g/vNzywpZpm/jtbVyWfMH5O5RRMKVDDT
         SDPTDusUq4iR0OF2GgmXfAJAVgWo5CXdSSwVBSW1DZFGd5P4srJm4b3LLJw5yjKlv/80
         GnONcONkCv4ZK9RA/sxDREZh8AClBctqO9l+ANVfTOjyxiK2uqXRzTNdjxQ5wLsqUdA3
         7O7+wMVxl9cc+RJfgzyxF/g/e5A1J6Xs5HpHzQ83vwtZuCWBTyujWJMNddcCbxZ4odk3
         ndE9yGF6/ksEYfI8PkBBXQ8Ll5hEBy955+ekhRuJu7klAwtxO9QHb1ctf8IZOJGh862s
         eKtA==
X-Gm-Message-State: AOAM531V68XV0krAw1IzX5Qulx/R4catnrg5nO6fvqxe0c94/6vEM58F
        MRe7kmaVY47+UZny8oIh3KeOK3JMV5iZeQ==
X-Google-Smtp-Source: ABdhPJxqhr5OWbz7h84wVO8FW3HkbPNrVrqACjDgBQiz2zGi8/iDaniN9EOJm7nQT/g9Algn5GlLFg==
X-Received: by 2002:a9d:7d8d:: with SMTP id j13mr18830353otn.208.1620993398315;
        Fri, 14 May 2021 04:56:38 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id s6sm1262669otk.71.2021.05.14.04.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 04:56:37 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 3/5] doc: remove unnecessary rm instances
Date:   Fri, 14 May 2021 06:56:29 -0500
Message-Id: <20210514115631.503276-4-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210514115631.503276-1-felipe.contreras@gmail.com>
References: <20210514115631.503276-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commits 50cff52f1a (When generating manpages, delete outdated targets
first., 2007-08-02) and f9286765b2 (Documentation/Makefile: remove
cmd-list.made before redirecting to it., 2007-08-06) created these rm
instances for a very rare corner-case: building as root by mistake.

It's odd to have workarounds here, but nowhere else in the Makefile--
which already fails in this stuation, starting from
Documentation/technical/.

We gain nothing but complexity, so let's remove them.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/Makefile | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 0f59cc0853..aae8803e4c 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -318,8 +318,7 @@ cmds_txt = cmds-ancillaryinterrogators.txt \
 $(cmds_txt): cmd-list.made
 
 cmd-list.made: cmd-list.perl ../command-list.txt $(MAN1_TXT)
-	$(QUIET_GEN)$(RM) $@ && \
-	$(PERL_PATH) ./cmd-list.perl ../command-list.txt $(cmds_txt) $(QUIET_STDERR) && \
+	$(QUIET_GEN)$(PERL_PATH) ./cmd-list.perl ../command-list.txt $(cmds_txt) $(QUIET_STDERR) && \
 	date >$@
 
 mergetools_txt = mergetools-diff.txt mergetools-merge.txt
@@ -327,7 +326,7 @@ mergetools_txt = mergetools-diff.txt mergetools-merge.txt
 $(mergetools_txt): mergetools-list.made
 
 mergetools-list.made: ../git-mergetool--lib.sh $(wildcard ../mergetools/*)
-	$(QUIET_GEN)$(RM) $@ && \
+	$(QUIET_GEN) \
 	$(SHELL_PATH) -c 'MERGE_TOOLS_DIR=../mergetools && \
 		. ../git-mergetool--lib.sh && \
 		show_tool_names can_diff "* " || :' >mergetools-diff.txt && \
@@ -370,8 +369,7 @@ manpage-base-url.xsl: manpage-base-url.xsl.in
 	$(QUIET_GEN)sed "s|@@MAN_BASE_URL@@|$(MAN_BASE_URL)|" $< > $@
 
 %.1 %.5 %.7 : %.xml manpage-base-url.xsl $(wildcard manpage*.xsl)
-	$(QUIET_XMLTO)$(RM) $@ && \
-	$(XMLTO) -m $(MANPAGE_XSL) $(XMLTO_EXTRA) man $<
+	$(QUIET_XMLTO)$(XMLTO) -m $(MANPAGE_XSL) $(XMLTO_EXTRA) man $<
 
 %.xml : %.txt $(ASCIIDOC_DEPS)
 	$(QUIET_ASCIIDOC)$(RM) $@+ $@ && \
-- 
2.31.1

