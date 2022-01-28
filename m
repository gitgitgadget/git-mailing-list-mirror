Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DBE1C433FE
	for <git@archiver.kernel.org>; Fri, 28 Jan 2022 11:11:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347989AbiA1LLP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Jan 2022 06:11:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244239AbiA1LLO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jan 2022 06:11:14 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF40EC06173B
        for <git@vger.kernel.org>; Fri, 28 Jan 2022 03:11:13 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id s9so10174360wrb.6
        for <git@vger.kernel.org>; Fri, 28 Jan 2022 03:11:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7SBjioNmUmWson7KkH92JR1mFGggmtdxEhdaDHsBxEc=;
        b=cdpza2jx7SoyFt0bcu0/JXrkNYRnDOegOjc2pypkOuFbntEQ/6QEHA9FDFCzXrol2B
         cdJiVoliQ/+lRAdLOxHEtyaxd/DTEi5EEcwpgQWvxsUYo8hsrjm/MFzSq7fIDsmPmHyl
         ijIcBa6VNMZiClOMn6hntSpkLeqi5UtvE8/qIq1UyPCFtbQlmkXT5TWMN2TsqmYCUOGL
         EcJ2RI5gY/wxIDhh0Z/0KfbAtbeBkMVyL+jgkaDKx840hmQj+3YgyYJXEXcy6xrSykLD
         X/HaE0XSI4uok74mL5Ny7eZRkqVQ4p3RZYjn7mVeGyLQzIsYGhZr1N/ENP/n4sEFPiz6
         kurw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7SBjioNmUmWson7KkH92JR1mFGggmtdxEhdaDHsBxEc=;
        b=3byhScKK/eXanp8y7zqi/mU6aSlAMDIazunKN+8XYXUujmaGyKiGvOQ+szLC4ASnL2
         bLMNLJemlrccIPNUP4kHykzqSXCYC+3UlHL3CUAL+aPiTX078y3KO+8qlAvk2QPZscIR
         qCIffJXLFkO1BUzRZg8uM5Em0oRsgPGMfZg82Z2MgtXITamTkzyxBT8SBE7mpC6cxWd3
         JO90JVAsTBDz1qZrGtabNfktLRGlpEdkVffdQAf4FssmZhwkHOZbCzXfbgaI8Y8m9iNK
         e5oL0qDDfv1kvTEGsXyfxx7k8efIWlVqVxhg7DeoVMRaScW7fvqrX2poIkAAJwQFcA0N
         LEVQ==
X-Gm-Message-State: AOAM531QzWCLDe89mArP4T+UwAeaMVHKSDiVewa4X9mj07hrsjBfwIgR
        ovzLRMjQBh3pTLPcLTNXcW9nN9utY3l64Q==
X-Google-Smtp-Source: ABdhPJx0+eFFAXYEUaEXBVkG7HcvUx0XIe7PSVWY/D/2764LYqU2Z2DUreSnG4yrtNd3OinvBZ7tpA==
X-Received: by 2002:a5d:4581:: with SMTP id p1mr6590732wrq.531.1643368272350;
        Fri, 28 Jan 2022 03:11:12 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j15sm1988521wmq.19.2022.01.28.03.11.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 03:11:11 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 1/2] git-compat-util.h: clarify GCC v.s. C99-specific in comment
Date:   Fri, 28 Jan 2022 12:11:08 +0100
Message-Id: <patch-v2-1.2-31079a71ecb-20220128T110330Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.0.912.ga4a35ddedc3
In-Reply-To: <cover-v2-0.2-00000000000-20220128T110330Z-avarab@gmail.com>
References: <cover-0.2-00000000000-20210412T105422Z-avarab@gmail.com> <cover-v2-0.2-00000000000-20220128T110330Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change a comment added in e208f9cc757 (make error()'s constant return
value more visible, 2012-12-15). It's not correct that this is GCC-ism
anymore, it's code that uses standard C99 features.

The comment being changed here pre-dates the HAVE_VARIADIC_MACROS
define, which we got in e05bed960d3 (trace: add 'file:line' to all
trace output, 2014-07-12).

The original implementation of an error() macro) in e208f9cc757 used a
GCC-ism with the paste operator (see the commit message for mention of
it), but that was dropped later by 9798f7e5f9 (Use __VA_ARGS__ for all
of error's arguments, 2013-02-08), giving us the C99-portable version
we have now.

While we could remove the __GNUC__ define here, it might cause issues
for other compilers or static analysis systems, so let's not. See
87fe5df365 (inline constant return from error() function, 2014-05-06)
for one such issue.

See also e05bed960d3 (trace: add 'file:line' to all trace output,
2014-07-12) for another comment about GNUC's handling of __VA_ARGS__.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 git-compat-util.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 1229c8296b9..57f20439ef6 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -522,9 +522,7 @@ void warning_errno(const char *err, ...) __attribute__((format (printf, 1, 2)));
 /*
  * Let callers be aware of the constant return value; this can help
  * gcc with -Wuninitialized analysis. We restrict this trick to gcc, though,
- * because some compilers may not support variadic macros. Since we're only
- * trying to help gcc, anyway, it's OK; other compilers will fall back to
- * using the function as usual.
+ * because other compilers may be confused by this.
  */
 #if defined(__GNUC__)
 static inline int const_error(void)
-- 
2.35.0.912.ga4a35ddedc3

