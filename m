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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 756E7C433FE
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 15:53:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49FD822B47
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 15:53:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731059AbgLIPxM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 10:53:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731121AbgLIPxJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Dec 2020 10:53:09 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2FFAC061793
        for <git@vger.kernel.org>; Wed,  9 Dec 2020 07:52:28 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id 91so2266386wrj.7
        for <git@vger.kernel.org>; Wed, 09 Dec 2020 07:52:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H4i9L0kmWoZZ/AgS0l9EwDfBeBCRHWLwMxoe/jUBloI=;
        b=tibIzE02qE10x6mmtyYI9QrwODAGx6JYFcpgYA4ZvCebeOWg/4MBK4FGi+/JdFvmgs
         TLyw26Zt41yMXKf4SHOG749jdrXD2cMkVRD7hztuAC10IkxsU92VWKU5KJTneQQLmTF1
         WVwNE22S/Dvd793Yl0FSfxzo2PIS9cmntHns/j+9SWPvhXgo1/fs1THtTrYUaGZ+n1mX
         P8gVg8Qv1INgAgjnsXMekxhXyFVPy1N78tYXEugqz5S/+XxFc78ChknGd43kuf/4B7yI
         rmFaXCmwFZOskni4yP71mDKMYIP8tBHl0qpCU2FRHBpnYqWe9bx7nO3iBkiEqIzGIlvq
         At3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H4i9L0kmWoZZ/AgS0l9EwDfBeBCRHWLwMxoe/jUBloI=;
        b=r2hfPmH6A5mxo9nxuKA2b7fcfwcbyc7HAGcV5gcSvShU5qt8Q7K11EPKC09UgbuOt1
         oFoJjyjXpkXSoPVbmfJSSUa9ekEFadhOWLF+KiIIQjS13CwzN0HC8/8zDFTxSGC9cOWB
         TSuGwHV6vSDcDY5dVJQFRS4YPge++GPDh1Uk3oUgrHM/sufpdfJ+oUQhtZgVCgO1bpvb
         t2QIMSzGjV/WYt20jAtY942QBehjecyx8Fihah6Ms4msHLVydsITA/qa83YBrkk8AjC0
         Rn6lL3JEsYy7UKSdu9rmA6kiM8sfgm2prWQICCzgmXv/fOknqVuX9uhTAjf05LECxVii
         0ziQ==
X-Gm-Message-State: AOAM531aANWDkB07t+SK7g1ABasSvvpbEuRRfk0f+50NUtxC3OawFUgJ
        5KoURxqBwq9FsP951ik5byDFWFu5nv8Mgg==
X-Google-Smtp-Source: ABdhPJxBSnbeGFepOSlyDhjzyFlnZpl2XUvUkid4zjCdRS+iWjFE657vGSvSOVr/0GdGK/vfVF4bcw==
X-Received: by 2002:a5d:69d1:: with SMTP id s17mr3470580wrw.104.1607529147412;
        Wed, 09 Dec 2020 07:52:27 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b7sm4424495wrv.47.2020.12.09.07.52.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 07:52:26 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Anders Waldenborg <anders@0x63.nu>, christian.couder@gmail.com,
        peff@peff.net, jonathantanmy@google.com,
        Hariom Verma <hariom18599@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 2/5] pretty format %(trailers) doc: avoid repetition
Date:   Wed,  9 Dec 2020 16:52:05 +0100
Message-Id: <20201209155208.17782-3-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20201206002449.31452-1-avarab@gmail.com>
References: <20201206002449.31452-1-avarab@gmail.com>
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
values.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/pretty-formats.txt | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index 84bbc7439a6..973b6c7d482 100644
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
+** 'only[=<BOOL>]': select whether non-trailer lines from the trailer
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
+** 'unfold[=<BOOL>]': make it behave as if interpret-trailer's `--unfold`
+   option was given. E.g.,
    `%(trailers:only,unfold=true)` unfolds and shows all trailer lines.
-** 'valueonly[=val]': skip over the key part of the trailer line and only
-   show the value part. Also this optionally allows explicit value.
+** 'valueonly[=<BOOL>]': skip over the key part of the trailer line and only
+   show the value part.
 
 NOTE: Some placeholders may depend on other options given to the
 revision traversal engine. For example, the `%g*` reflog options will
-- 
2.29.2.222.g5d2a92d10f8

