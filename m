Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67BE5C433F5
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 23:16:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53C0E615E3
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 23:16:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345903AbhKOXTI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Nov 2021 18:19:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347688AbhKOXQd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Nov 2021 18:16:33 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94CEEC03E02E
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 14:18:36 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id p18so5884983wmq.5
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 14:18:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VzBdLYv4l1D8tIFJh4GgcflhNVxrmEx/MNapMwYa5OY=;
        b=lACDHn0z5JmmU1+rSq6giZbdV6RyrKpcD7zg1IXCDz27tssCbeV+/4YxhCF9VmJOMq
         H7YPZekhhduO1n/TMtltChAydJ6+Mq8/B+iM9WmhOzcUbjOP3Af3BDthhbkc+3EUlSL9
         x8gflyFN+MXLTKnKjC+H/t0AzpFuj1k2jY881bi2BP5sly1JcUgf5LAnPgh0Zn1MvEHx
         3juBd+wNO36lbtdTiYISw/rcVkIuNCtNJYWu/+fNp3RBK1k61BfHdJFZ3VIRj5iJ1Dv4
         YgmmYGqNDiij8KQnjxE3XuthegDJe0kcmDMMHCE0rgqz73w/STn0xm6WjYZMJZMZqrwN
         ZVrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VzBdLYv4l1D8tIFJh4GgcflhNVxrmEx/MNapMwYa5OY=;
        b=jCj8QqiEtUZnEFeKewAGNhlDhM4U9H4Wl3YAnRaMVhVlRAVh7xGFWc7HIoyhT3BsFc
         jkaeve4NcdXrn+0eV3LPqdHdAjk/KNxKCG30YS8O6oEyoWkjEMHKsxj/8D7cfRtjAAU9
         a+6V3d5AI9LyGCpeoEtrucm7pL8kA4hpBJRG4GF0mFTVUI7of3lXtvg8swS0os/F/SmY
         kH9kl9tSWqrHGi0neoYKypoO0XFcXaFie92obNAbFfoi698znoYF2skLF73RC/5W3zQW
         wzZdSL5VxSl+9Le8QKtTiaRiBpjuIQn2qaCn+HuFldAcQDerxBK/U0wr52/dyhgqr+gY
         Q02A==
X-Gm-Message-State: AOAM531TzyhjrjXBAEKtqHxXE5HKs8Zma9870xt/75Tiyardr8cTnSdB
        YaqLBwgpivtWI/FmcFarNQHwUKwYUdQ0zQ==
X-Google-Smtp-Source: ABdhPJzu9xWzkYXBz1Zmvd1PELov0uiCQGP5N4hdYsEbVzurAeNFAIkSbMfr4jj6C1XX3Tmjh6D84Q==
X-Received: by 2002:a1c:4c13:: with SMTP id z19mr63948737wmf.143.1637014715013;
        Mon, 15 Nov 2021 14:18:35 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n184sm526812wme.2.2021.11.15.14.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 14:18:34 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Elijah Newren <newren@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 01/21] git-compat-util.h: clarify GCC v.s. C99-specific in comment
Date:   Mon, 15 Nov 2021 23:18:11 +0100
Message-Id: <RFC-patch-01.21-e49ac938399-20211115T220831Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.rc2.809.g11e21d44b24
In-Reply-To: <RFC-cover-00.21-00000000000-20211115T220831Z-avarab@gmail.com>
References: <RFC-cover-00.21-00000000000-20211115T220831Z-avarab@gmail.com>
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
index d70ce142861..e86df9769ba 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -489,9 +489,7 @@ void warning_errno(const char *err, ...) __attribute__((format (printf, 1, 2)));
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
2.34.0.rc2.809.g11e21d44b24

