Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5F84C4361B
	for <git@archiver.kernel.org>; Sun,  6 Dec 2020 00:26:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F68E23108
	for <git@archiver.kernel.org>; Sun,  6 Dec 2020 00:26:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbgLFAZs (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Dec 2020 19:25:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbgLFAZs (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Dec 2020 19:25:48 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB5FFC0613D4
        for <git@vger.kernel.org>; Sat,  5 Dec 2020 16:25:07 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id c198so8472101wmd.0
        for <git@vger.kernel.org>; Sat, 05 Dec 2020 16:25:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J2yZx6KjPdhFK98zKb0H1YK1K5NNadMnSnDIfNqMxpc=;
        b=Wrrz+fE+vDZopvZXIsfT6p2c1DnmdooCFE9A1VGejKb0fuAH/CFBfEexdSJq8DZsWr
         tI/3du2XIebk72+JnYIpDAQczXyFytcof12FkN1Y/stiL7/bpNZqaT857WmLQhJmLm/e
         GqeqBwVuH0mNaqBfTLrDE9eKfXMGOU8kDZjzNoyZj4faZT5wk/4wedyWHIiW16Qk9TxC
         bbatcKUbWd+ZgbSAGuUD4/G0qn14nUUSwMyYfMdsxN0xUxxPaHusjsBVleeItSuqqcif
         7P5VcsOur6rV7f+3rLaLAgBFk6bXYHepl11J9dnfBO6o/aMOyB7MxCSoaUlLeJNI7rUy
         PCwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J2yZx6KjPdhFK98zKb0H1YK1K5NNadMnSnDIfNqMxpc=;
        b=rW/8awTxDMB36SNay2NIexipjPkJZtG2h3UT6IHkQjHWb+7QEmA4tYjqEOYfC2oo85
         JWDjfH4n8D8ELv1PaJSSwNtWuwzC4/YwUHNF4406eUj58z+1fdv9yzJ1O6ifhejP+pjE
         YbT8/vPQ4sPS42LbZS/wPU5dmtVMJeTxcCs7fQgYm4Naq/wnytFzNdnhYwtwlya14cko
         +nTWwIgkoHbiuIsk/EWqGQyaRb+GOcX/lvMx6VhGr3lc+lAv+hLaCGHq/gl/KGAgnY/5
         /BgDRICiJ950nsjDix5M2miU+yetCHJ4Rwj8Z6S3w4perFyk5npygLgnQnIp/umrZW9F
         86KA==
X-Gm-Message-State: AOAM533Bl+PqJKpBKbuuk8ELmXOG+HdceJasR1oSK9E+EU0EdDKx9F0n
        uAnggVKlL+g6bAJwfQq0NAmMBXtvi+X70Q==
X-Google-Smtp-Source: ABdhPJx+/BsjCg+a7XxQe34NBE+Zs1tqbc9OShAWwwONzvCOmYZX6kWXJNTnOAtPq0sopx8t0uYW4w==
X-Received: by 2002:a1c:5ad6:: with SMTP id o205mr11151881wmb.161.1607214306287;
        Sat, 05 Dec 2020 16:25:06 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 34sm9144338wrh.78.2020.12.05.16.25.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Dec 2020 16:25:05 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Anders Waldenborg <anders@0x63.nu>, christian.couder@gmail.com,
        peff@peff.net, jonathantanmy@google.com,
        Hariom Verma <hariom18599@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 2/5] pretty format %(trailers) doc: avoid repetition
Date:   Sun,  6 Dec 2020 01:24:46 +0100
Message-Id: <20201206002449.31452-3-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20201205013918.18981-1-avarab@gmail.com>
References: <20201205013918.18981-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the documentation for the various %(trailers) options so it
isn't repeating part of the documentation for "only" about how boolean
values are handled. Instead, let's split the description of that into
general documentation at the top.

It then suffices to refer to it by listing the options as
"opt[=<BOOL>]". I'm also changing it to upper-case "[=<BOOL>]" from
"[=val]" for consistency with "<SEP>"

It took me a couple of readings to realize that these options were
referring back to the "only" option's treatment of boolean
values. Let's try to make this more explicit, and upper-case "BOOL"
for consistency with the existing "<SEP>" and "<K>".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/pretty-formats.txt | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index 84bbc7439a6..66dfa122361 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -252,7 +252,15 @@ endif::git-rev-list[]
 			  interpreted by
 			  linkgit:git-interpret-trailers[1]. The
 			  `trailers` string may be followed by a colon
-			  and zero or more comma-separated options:
+			  and zero or more comma-separated options.
+			  If any option is provided multiple times the
+			  last occurance wins.
++
+The boolean options accept an optional value `[=<BOOL>]`. The values
+`true`, `false`, `on`, `off` etc. are all accepted. See the "boolean"
+sub-section in "EXAMPLES" in linkgit:git-config[1]. If a boolean
+option is given with no value, it's enabled.
++
 ** 'key=<K>': only show trailers with specified key. Matching is done
    case-insensitively and trailing colon is optional. If option is
    given multiple times trailer lines matching any of the keys are
@@ -261,27 +269,21 @@ endif::git-rev-list[]
    desired it can be disabled with `only=false`.  E.g.,
    `%(trailers:key=Reviewed-by)` shows trailer lines with key
    `Reviewed-by`.
-** 'only[=val]': select whether non-trailer lines from the trailer
-   block should be included. The `only` keyword may optionally be
-   followed by an equal sign and one of `true`, `on`, `yes` to omit or
-   `false`, `off`, `no` to show the non-trailer lines. If option is
-   given without value it is enabled. If given multiple times the last
-   value is used.
+** 'only[=BOOL]': select whether non-trailer lines from the trailer
+   block should be included.
 ** 'separator=<SEP>': specify a separator inserted between trailer
    lines. When this option is not given each trailer line is
    terminated with a line feed character. The string SEP may contain
    the literal formatting codes described above. To use comma as
    separator one must use `%x2C` as it would otherwise be parsed as
-   next option. If separator option is given multiple times only the
-   last one is used. E.g., `%(trailers:key=Ticket,separator=%x2C )`
+   next option. E.g., `%(trailers:key=Ticket,separator=%x2C )`
    shows all trailer lines whose key is "Ticket" separated by a comma
    and a space.
-** 'unfold[=val]': make it behave as if interpret-trailer's `--unfold`
-   option was given. In same way as to for `only` it can be followed
-   by an equal sign and explicit value. E.g.,
+** 'unfold[=BOOL]': make it behave as if interpret-trailer's `--unfold`
+   option was given. E.g.,
    `%(trailers:only,unfold=true)` unfolds and shows all trailer lines.
-** 'valueonly[=val]': skip over the key part of the trailer line and only
-   show the value part. Also this optionally allows explicit value.
+** 'valueonly[=BOOL]': skip over the key part of the trailer line and only
+   show the value part.
 
 NOTE: Some placeholders may depend on other options given to the
 revision traversal engine. For example, the `%g*` reflog options will
-- 
2.29.2.222.g5d2a92d10f8

