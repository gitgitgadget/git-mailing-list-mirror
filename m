Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C681FC04FF3
	for <git@archiver.kernel.org>; Fri, 21 May 2021 22:45:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A448B613AF
	for <git@archiver.kernel.org>; Fri, 21 May 2021 22:45:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbhEUWqX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 May 2021 18:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbhEUWqU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 May 2021 18:46:20 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B2B9C061574
        for <git@vger.kernel.org>; Fri, 21 May 2021 15:44:57 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id w127so17288821oig.12
        for <git@vger.kernel.org>; Fri, 21 May 2021 15:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6hrFgomY39D/QRHWLKBpxQmIEKj3msuoBymtjF5aGA0=;
        b=V75V2QIcr6B7Jo9RrlnbMgv1sNVfDHvnlvy6/5O48+cXD8mnlQ1Ju70NJLF/vYMJGE
         qUbvtRAYRIYZjckaA8OCjSfQiftPjSHmUmAo2e9JsGAppgbq3Rc7r+Ns2wbgH05sEOeC
         +bUm1OKoFJryTdeQDwGjc5TgB5OhWdixN2570znrGtrrGq8aOA3HXtQjPBh8yJE2CL7s
         MXXtbAPdriDa0AeIOlynIU1lVmwaOLLfFlCkp+Q4NKyDqv+grr/GnQ6UIkzc03fxDgAA
         MvET/Y7ugrZ/xoxomQ8hfo5xEmA0DzBMfQesvLEfyum0QdrNQKkwZVeEjds56LuFTDVH
         lVGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6hrFgomY39D/QRHWLKBpxQmIEKj3msuoBymtjF5aGA0=;
        b=qlUIrxHDWw/7c8hcB5fnqankt6qnjsmRZvLK0mTrZn0el6Vc7SaT6RiihL+6uZ3ktt
         iCc1dTinmKngMQ0TxV3J6pgwTA6bBPPoxMz4wioE6MY13TgF+RKshqgjwMme/RF1jGiL
         LuYFeWfRPnrHXrQiHopQH8ALgCBGHVqpG9g8RElt2JnUoz7HZkC53ocvxy6vErxWnDFA
         kd+T00l/sM8wlcKALq7B98wsEkf3TFL4SctytNYWKbvFOW56nrRuZnIjgOPcs9P2QWOe
         Hh085/v9jUFMUhT11FhTsI34CSYbsjYc3KR8UEuAeqKOsizt85uxQ/CUO5QV6TDX8X7S
         Ksiw==
X-Gm-Message-State: AOAM532xkK8dsyya0VIQckAA4WK15aZgxevvHZDH4S4MIPaDAMpY3bSL
        r2yRnWtCVh49SfNDCPqP77SDbbLVdOFm6w==
X-Google-Smtp-Source: ABdhPJy4FSeLGoCRrd3+CkSg4A42NmujMO7GJvT2So2S5pKiaQnApnAxYrYm59vAqnsmKZyUsk6i/A==
X-Received: by 2002:a05:6808:d48:: with SMTP id w8mr3625208oik.141.1621637096383;
        Fri, 21 May 2021 15:44:56 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id i9sm1463449oog.17.2021.05.21.15.44.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 15:44:55 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 01/11] doc: doc-diff: set docdate manually
Date:   Fri, 21 May 2021 17:44:42 -0500
Message-Id: <20210521224452.530852-2-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0
In-Reply-To: <20210521224452.530852-1-felipe.contreras@gmail.com>
References: <20210521224452.530852-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In order to minimize the differences in the footer.

Asciidoc automatically generates a date with format '%Y-%m-%d', while
asciidoctor '%F'.

I personally prefer the latter, so only modify it for diff purposes.

Fixes tons of these:

-Git omitted                       01/01/1970                        GIT-ADD(1)
+Git omitted                       1970-01-01                        GIT-ADD(1)

Note that we have to add quotes when passing around $makemanflags, as it
now may contain whitespace due to multiple arguments (but the
dereference inside render_tree must remain unquoted, because it wants to perform
whitespace splitting to get the individual arguments back).

Comments-by: Jeff King <peff@peff.net>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/Makefile | 2 +-
 Documentation/doc-diff | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 47053c78f8..b68ab57239 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -136,7 +136,7 @@ ASCIIDOC_EXTRA =
 ASCIIDOC_HTML = xhtml11
 ASCIIDOC_DOCBOOK = docbook
 ASCIIDOC_CONF = -f asciidoc.conf
-ASCIIDOC_COMMON = $(ASCIIDOC) $(ASCIIDOC_EXTRA) $(ASCIIDOC_CONF) \
+ASCIIDOC_COMMON = $(ASCIIDOC) $(ASCIIDOC_EXTRA) $(ASCIIDOC_FLAGS) $(ASCIIDOC_CONF) \
 		-amanmanual='Git Manual' -amansource='Git $(GIT_VERSION)'
 ASCIIDOC_DEPS = asciidoc.conf GIT-ASCIIDOCFLAGS
 TXT_TO_HTML = $(ASCIIDOC_COMMON) -b $(ASCIIDOC_HTML)
diff --git a/Documentation/doc-diff b/Documentation/doc-diff
index 1694300e50..c11b90a6ef 100755
--- a/Documentation/doc-diff
+++ b/Documentation/doc-diff
@@ -111,7 +111,7 @@ construct_makemanflags () {
 		echo USE_ASCIIDOCTOR=
 	elif test "$1" = "-asciidoctor"
 	then
-		echo USE_ASCIIDOCTOR=YesPlease
+		echo USE_ASCIIDOCTOR=YesPlease ASCIIDOC_FLAGS='-adocdate="01/01/1970"'
 	fi
 }
 
@@ -181,6 +181,6 @@ render_tree () {
 	fi
 }
 
-render_tree $from_oid $from_dir $from_makemanflags &&
-render_tree $to_oid $to_dir $to_makemanflags &&
+render_tree $from_oid $from_dir "$from_makemanflags" &&
+render_tree $to_oid $to_dir "$to_makemanflags" &&
 git -C $tmp/rendered diff --no-index "$@" $from_dir $to_dir
-- 
2.32.0.rc0

