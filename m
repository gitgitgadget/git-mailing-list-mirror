Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF38FC433EF
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 19:07:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C25AE60F4F
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 19:07:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240715AbhJHTJt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Oct 2021 15:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231424AbhJHTJq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Oct 2021 15:09:46 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C58BC061755
        for <git@vger.kernel.org>; Fri,  8 Oct 2021 12:07:50 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id r7so32601827wrc.10
        for <git@vger.kernel.org>; Fri, 08 Oct 2021 12:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j7bkEYgOMppw8HItc10x77itZQSux80FIcTo1H7rIWs=;
        b=HjZ1FcpFQsv9lmGuLNhO62Sh1pminzWL2OTXZ1ZwbPYOWv5jF7Y0dcMIKBlfEIb2+e
         JQZ695hhvToBRpCDiGHmbfAPeqUR4TvzlG9G9zwIecEWAEdKD6EaP1iEnzgrfIwxfDii
         GIhwAKCK7JMnzX7dhAogk/QJvI56oiyCKWVOoih8H/6mg20W+/fnpNMZ4+Nn5SML4C9w
         qM5Kn0VtxyWUcxVu62/UnVZfwflMyzc4EFP1+Rf+y9ktlKv50m6pbURtDl9K8Adzwb+W
         5J5N4BZ2bDhhe8KaQFRIbGx3uord+97HSLX8oT041NpDy/O6XKE696uTP8j1ExdHEgUX
         YwUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j7bkEYgOMppw8HItc10x77itZQSux80FIcTo1H7rIWs=;
        b=J6vrMJWHp6g8U8Xztzm6CLPECahctCQaQGw6sABatyzll4kDmDoWFRZ5EH18xwGMPK
         oF8NNoARSvKZZYlOvvd9DOVhqV1Ict1RZ1OSW+UAaPKUGZ4HNHwYE5fG+u3fNlBpvTpB
         vFW+nCopWhNPplstcWKt7nE8ptfDAs0tGpIo+GeTW+n5OuJsFndwWG6pF4hDXxHWVKbA
         rjP38LSrFLrIaJuJns+a8NfthVWyHkrgBu6Jwajpigsr1lpG/MqIU2CNuldti1dD6/XV
         V9jO90ykK8RUckgCmntIeX8W8wevlA3jcEIZThodlAQpmNaaJizyPzwdKDZq1tPCYH/c
         5BGA==
X-Gm-Message-State: AOAM533zBNCvjRNLpGmhDvIDyYnsco/1QTfEosOiLLCeGLojS/Lh0ZWs
        8XSe5SMW2TN9d09M1ymvjiowcE/aduo=
X-Google-Smtp-Source: ABdhPJxN4HLROw16psTrTgxd9Xc8ajY7c6ZIBnYHrvjXkHiGSuKAEwcHDihAeJO/ZE3dQTS5oiepMg==
X-Received: by 2002:adf:a443:: with SMTP id e3mr6328338wra.115.1633720068931;
        Fri, 08 Oct 2021 12:07:48 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x17sm169882wrc.51.2021.10.08.12.07.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 12:07:48 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Thomas Rast <tr@thomasrast.ch>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 01/10] parse-options.h: move PARSE_OPT_SHELL_EVAL between enums
Date:   Fri,  8 Oct 2021 21:07:37 +0200
Message-Id: <patch-v3-01.10-59195845497-20211008T190536Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1446.g6af949f83bd
In-Reply-To: <cover-v3-00.10-00000000000-20211008T190536Z-avarab@gmail.com>
References: <cover-v2-00.11-00000000000-20211001T142631Z-avarab@gmail.com> <cover-v3-00.10-00000000000-20211008T190536Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a bad landmine of a bug which has been with us ever since
PARSE_OPT_SHELL_EVAL was added in 47e9cd28f8a (parseopt: wrap
rev-parse --parseopt usage for eval consumption, 2010-06-12).

It's an argument to parse_options() and should therefore be in "enum
parse_opt_flags", but it was added to the per-option "enum
parse_opt_option_flags" by mistake.

Therefore as soon as we'd have an enum member in the former that
reached its value of "1 << 8" we'd run into a seemingly bizarre bug
where that new option would turn on the unrelated PARSE_OPT_SHELL_EVAL
in "git rev-parse --parseopt" by proxy.

I manually checked that no other enum members suffered from such
overlap, by setting the values to non-overlapping values, and making
the relevant codepaths BUG() out if the given value was above/below
the expected (excluding flags=0 in the case of "enum
parse_opt_flags").

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 parse-options.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/parse-options.h b/parse-options.h
index 39d90882548..3a3176ae65c 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -33,6 +33,7 @@ enum parse_opt_flags {
 	PARSE_OPT_KEEP_UNKNOWN = 1 << 3,
 	PARSE_OPT_NO_INTERNAL_HELP = 1 << 4,
 	PARSE_OPT_ONE_SHOT = 1 << 5,
+	PARSE_OPT_SHELL_EVAL = 1 << 6,
 };
 
 enum parse_opt_option_flags {
@@ -44,7 +45,6 @@ enum parse_opt_option_flags {
 	PARSE_OPT_NODASH = 1 << 5,
 	PARSE_OPT_LITERAL_ARGHELP = 1 << 6,
 	PARSE_OPT_FROM_ALIAS = 1 << 7,
-	PARSE_OPT_SHELL_EVAL = 1 << 8,
 	PARSE_OPT_NOCOMPLETE = 1 << 9,
 	PARSE_OPT_COMP_ARG = 1 << 10,
 	PARSE_OPT_CMDMODE = 1 << 11,
-- 
2.33.0.1446.g6af949f83bd

