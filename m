Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F479C433EF
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 19:08:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EF6760F6E
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 19:08:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240735AbhJHTKd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Oct 2021 15:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240642AbhJHTJw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Oct 2021 15:09:52 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E6BC061570
        for <git@vger.kernel.org>; Fri,  8 Oct 2021 12:07:56 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id t2so32629734wrb.8
        for <git@vger.kernel.org>; Fri, 08 Oct 2021 12:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ntfxB4Y6zeB26EdcuWtHUHfTeFxP6IXFBOvZCPRLoNs=;
        b=mONjeavJJUxQ9UYI8nF4WYXFfbxGMjy2/sR2tssrST4pcXzp0MAxbQjUw9N8oQWQ4z
         hmibyl1bOAJaGR0EA7ixwJL6XeC7Trp4zmF7KvqkN8TlwGgPIE7Vee5psLofKwpQpkt3
         Rd2fSIspIz8a+N6JMX3ifO4CqioFkuc3pC9FVsVDqSLrK+5mOZxAoL/yISy/rKmP1dEK
         Sq0qHAOIHE1xJZ4F+TwAp4mvOwjApraR9RZIQDyPffhf5pFi9Y8+hho+fYkJ6Pv4D132
         bPhNogeo7bd/7ATaS/3/dWK7Qd8kLRByKxAdfNnGEqZvMu9pXR7DYl95M+qV8ny+Ir81
         QLng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ntfxB4Y6zeB26EdcuWtHUHfTeFxP6IXFBOvZCPRLoNs=;
        b=gNcOXLqcO6hxBud3RpLAF2O2szfQn22Qy1Xufu97Rj6nfOJI0r1mTXdfjYfVDASD6v
         WnDVTRfxJy3WlbGEnT8Dk0CMLMoAGpmrnr/m/MsaKVTB0tIMKQkWmwDks98CF34FlHZJ
         1mMSt//plUbk48ThEUH2sDPTgZ3tAR78xR1RoUvGeaaTgSbRAjk+72zAfDM5XJG24VwA
         Q5oLfJNKg2LMhTHwkVUk2TNaeXDYGSIwtMYxfpnRUyCKhMb6FKyz1rapDNpdNNT3W57T
         4hipox00R2enK+vq54Xv1yuPsu0blDCOQGIxVXwOa2Y8g3ztpv9PwbqX0xgr6gaCyD14
         CfIQ==
X-Gm-Message-State: AOAM531kU93qriFVoX3T8jY1GHSeQRDLfQD/rtfVD8WdXSKasrbzUUJI
        P2VlXnObYltSvYuUYz10lIgiL7oYm4R4dA==
X-Google-Smtp-Source: ABdhPJwHrJGnT2NcYYyxKQXuTL/WZmDjFD+CBSM9uSlmB9+n77/z4so/SI7JVul2TQ5HJrEpOtK9xg==
X-Received: by 2002:adf:a30b:: with SMTP id c11mr6268763wrb.289.1633720075236;
        Fri, 08 Oct 2021 12:07:55 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x17sm169882wrc.51.2021.10.08.12.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 12:07:54 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Thomas Rast <tr@thomasrast.ch>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 08/10] parse-options.[ch]: make opt{bug,name}() "static"
Date:   Fri,  8 Oct 2021 21:07:44 +0200
Message-Id: <patch-v3-08.10-520cc5a8dc0-20211008T190536Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1446.g6af949f83bd
In-Reply-To: <cover-v3-00.10-00000000000-20211008T190536Z-avarab@gmail.com>
References: <cover-v2-00.11-00000000000-20211001T142631Z-avarab@gmail.com> <cover-v3-00.10-00000000000-20211008T190536Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change these two functions to "static", the last user of "optname()"
outside of parse-options.c itself went away in the preceding commit,
for the reasons noted in 9440b831ad5 (parse-options: replace
opterror() with optname(), 2018-11-10) we shouldn't be adding any more
users of it.

The "optbug()" function was never used outside of parse-options.c, but
was made non-static in 1f275b7c4ca (parse-options: export opterr,
optbug, 2011-08-11). I think the only external user of optname() was
the commit-graph.c caller added in 09e0327f57 (builtin/commit-graph.c:
introduce '--max-new-filters=<n>', 2020-09-18).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 parse-options.c | 4 ++--
 parse-options.h | 3 ---
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index 9e2da8383d7..64bd4c32854 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -11,7 +11,7 @@ static int disallow_abbreviated_options;
 #define OPT_SHORT 1
 #define OPT_UNSET 2
 
-int optbug(const struct option *opt, const char *reason)
+static int optbug(const struct option *opt, const char *reason)
 {
 	if (opt->long_name) {
 		if (opt->short_name)
@@ -22,7 +22,7 @@ int optbug(const struct option *opt, const char *reason)
 	return error("BUG: switch '%c' %s", opt->short_name, reason);
 }
 
-const char *optname(const struct option *opt, int flags)
+static const char *optname(const struct option *opt, int flags)
 {
 	static struct strbuf sb = STRBUF_INIT;
 
diff --git a/parse-options.h b/parse-options.h
index 74b66ba6e93..dd79c9c566f 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -224,9 +224,6 @@ NORETURN void usage_msg_opt(const char *msg,
 			    const char * const *usagestr,
 			    const struct option *options);
 
-int optbug(const struct option *opt, const char *reason);
-const char *optname(const struct option *opt, int flags);
-
 /*
  * Use these assertions for callbacks that expect to be called with NONEG and
  * NOARG respectively, and do not otherwise handle the "unset" and "arg"
-- 
2.33.0.1446.g6af949f83bd

