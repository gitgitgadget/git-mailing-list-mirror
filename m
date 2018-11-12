Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-12.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 277A21F87F
	for <e@80x24.org>; Mon, 12 Nov 2018 22:03:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730407AbeKMH6E (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Nov 2018 02:58:04 -0500
Received: from mail-it1-f202.google.com ([209.85.166.202]:33025 "EHLO
        mail-it1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbeKMH6E (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Nov 2018 02:58:04 -0500
Received: by mail-it1-f202.google.com with SMTP id w68so1032824ith.0
        for <git@vger.kernel.org>; Mon, 12 Nov 2018 14:02:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to;
        bh=J59Vw3uvDEtkwee5U2ftOaBfc+g4ZUV9h7d/WwVrssU=;
        b=kuQ3DD7VyJ6Q0hqy2vS+zMJoHZN8llO9zWmvhM1WO5dZRbqaX1A43dKI5vbLzXfBK2
         axxyaGf/eUGZNwTNUg+I0EBNkaJ7SyIpvlKJ7z4ka99RgOdrjXNr43d3wAaDHJQgGVsB
         1aqGN8Jpe+O53CQgCG0YIzZm3B5z2bGKSkEAM1tuv54uIvyRrzt41ul7TlIybqY7aSHY
         HvdmX9zVnHUZ3SrrYd4KRhMXX+pvGLtv1wKpyyH/Xuznj3Nb0p2+fJVPh8Q95/NgF6R4
         Bos51a5b7TRIO0Y1FPBjkh4FjJOXtCtsjWF5KsUAWZgEeH6MICGZMbuasRMu62zRkgmG
         ebuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to;
        bh=J59Vw3uvDEtkwee5U2ftOaBfc+g4ZUV9h7d/WwVrssU=;
        b=erRXDeIQvqM4/OxgUOjuGXNWuU9xpS3jmXnSugVvKOMs4M+FEVEXUsX1bARHAsAS8Q
         scJ9cNRDy0hOZW3UTBwJ0vI4CiRSI30iT5yWHfTv1iFZs3KDnIA/x1hCE5hMbKryZyQa
         epYCLcMcZPDiNgwQ+2ERvB7YTE4CDt2EpUWm/qVEBomNUygbQ4QwrTGbIot/2zM6Xzzu
         uoL19XJCcxCp1Vzuzi/GnG1vp3chRYNdM8/cuXE4++YT0t2bA8QE2xcAQIxf/pjiph4j
         8SvIOL3GRBWdPiOUJvbmDGb/oHEYDdj+pBNL18Ej3ZlpQ1XjRLAF1paj1ELzRPnuqOGq
         6Iuw==
X-Gm-Message-State: AGRZ1gJ288cUcGj0mI+la3+XYMG4QHReY50X+718cqwmHy0JtC5Pqqct
        eVdHS/OCvE+5bZVll1ZaijhxkABzGdK1MTnVLY7Vpofj9o72Ns5cLO2Uqnkv7giqjOPZivUCV02
        blv1hBX+f+/iFvP3OUkMefuXiP5NhACaWPs7rixSNcJCKYyOZbctuTht5Quq7fic=
X-Google-Smtp-Source: AJdET5cUcUCca5XtkAvNpbgY9scU+p89M8ifQpqP5cJ+s/+qB9EfnADTep4+0G38K0Sf79B4PONO/F6OFC9lcQ==
X-Received: by 2002:a24:d255:: with SMTP id z82-v6mr1073398itf.31.1542060178337;
 Mon, 12 Nov 2018 14:02:58 -0800 (PST)
Date:   Mon, 12 Nov 2018 14:02:56 -0800
Message-Id: <1630a93f8270ca090459be8cc7213221cc6250cf.1542060094.git.steadmon@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.19.1.930.g4563a0d9d0-goog
Subject: [PATCH] Makefile: use CXXFLAGS for linking fuzzers
From:   steadmon@google.com
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

OSS-Fuzz requires C++-specific flags to link fuzzers. Passing these in
CFLAGS causes lots of build warnings. Using separate CXXFLAGS avoids
this.

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 Makefile | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index bbfbb4292d..5462bc4b6b 100644
--- a/Makefile
+++ b/Makefile
@@ -497,6 +497,7 @@ GIT-VERSION-FILE: FORCE
 # CFLAGS and LDFLAGS are for the users to override from the command line.
 
 CFLAGS = -g -O2 -Wall
+CXXFLAGS ?= $(CFLAGS)
 LDFLAGS =
 ALL_CFLAGS = $(CPPFLAGS) $(CFLAGS)
 ALL_LDFLAGS = $(LDFLAGS)
@@ -3098,14 +3099,14 @@ cover_db_html: cover_db
 # An example command to build against libFuzzer from LLVM 4.0.0:
 #
 # make CC=clang CXX=clang++ \
-#      CFLAGS="-fsanitize-coverage=trace-pc-guard -fsanitize=address" \
+#      CXXFLAGS="-fsanitize-coverage=trace-pc-guard -fsanitize=address" \
 #      LIB_FUZZING_ENGINE=/usr/lib/llvm-4.0/lib/libFuzzer.a \
 #      fuzz-all
 #
 .PHONY: fuzz-all
 
 $(FUZZ_PROGRAMS): all
-	$(QUIET_LINK)$(CXX) $(CFLAGS) $(LIB_OBJS) $(BUILTIN_OBJS) \
+	$(QUIET_LINK)$(CXX) $(CXXFLAGS) $(LIB_OBJS) $(BUILTIN_OBJS) \
 		$(XDIFF_OBJS) $(EXTLIBS) git.o $@.o $(LIB_FUZZING_ENGINE) -o $@
 
 fuzz-all: $(FUZZ_PROGRAMS)
-- 
2.19.1.930.g4563a0d9d0-goog

