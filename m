Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE851C433FE
	for <git@archiver.kernel.org>; Fri,  7 Oct 2022 09:30:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbiJGJat (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Oct 2022 05:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbiJGJaq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Oct 2022 05:30:46 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D79D57E9
        for <git@vger.kernel.org>; Fri,  7 Oct 2022 02:30:43 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id bv10so2821372wrb.4
        for <git@vger.kernel.org>; Fri, 07 Oct 2022 02:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1OBWqNhgnPEHTpjKB6QRdb9j9B3rt64J0IqiiBl3Ogk=;
        b=eNt5sA+G7kiXb/SDPjIwIue98sFZLHHp0fwPh0KmF36CPzf/BopyWlPAktB4TftBOc
         ieUo6d8qUeAtvU7G2HmTKyCtKKRfGgc7E+NVWk39IB2SN6gJplB7sqTsQLmym/Q0P6HC
         deVoR47nda72JNf9+KnyEv5iAd5zjaIYjSMMfEeU94vi3J+H+yyg5ZcA5qcjVnJfixnr
         JA18LcV6FC1PrCWM+aG8nsj2ykzGWPxWoLuWh63sFg6w7lHOvzjImn9AZ2Qes/JU0ROA
         qXwqTGjapA71CZxk32qwlOUq6eqjOenkBMUhGC+ZjkpKHl9QB0msXillK8HBmHzxslIz
         LjwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1OBWqNhgnPEHTpjKB6QRdb9j9B3rt64J0IqiiBl3Ogk=;
        b=NDr47qj1XOMVynq8vd5/I9/OYu+SntzSqHkAHhZ2g71E+yXo9enFUuNFXUp8Z5rZbQ
         JoNY2uRphrFFzZ554FMMhLICG7bgdRr8E0jGgCXBrOWLmg7FdzyO3p7+c6wc2mHmzL4X
         KfMUBahTVDTlnb6PCwji9rfaAWUrmVpKCB71V3w38jrOOz5dgxL3ANR95rjKqRPaYr3/
         tOWdRY9y9JxCdTcCdBADHQqsKGQ0zXdLpUL+SKltvBJ3hDUSQs5wQ8JuOYM/bRYbU1Nt
         iImig8Mq4m80Auj23b7V7sujqKMg9ZIdWFujLgoI0/RC1iBokmiOk8BjW2M8OsprM94R
         0WjQ==
X-Gm-Message-State: ACrzQf37NHdnpmm7asuXd0J2tFd0uTfhGJb5raWFBficcxHXqgBazc9N
        vac5QprGrRnwEM19mf96V/e/knGwR+6feg==
X-Google-Smtp-Source: AMsMyM5FdOQutmjJhYMXs2SLgp0evFEGDNWciP0ycX0pu0IibK5179h8pSEqkkj150k1mZhMRFLayw==
X-Received: by 2002:a05:6000:1568:b0:22e:6691:57aa with SMTP id 8-20020a056000156800b0022e669157aamr2476509wrz.708.1665135041453;
        Fri, 07 Oct 2022 02:30:41 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o18-20020a1c7512000000b003b492753826sm1634945wmc.43.2022.10.07.02.30.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 02:30:40 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/5] CodingGuidelines: update for C99
Date:   Fri,  7 Oct 2022 11:30:30 +0200
Message-Id: <patch-1.5-5ea53989486-20221007T092505Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.971.ge79ff6d20e7
In-Reply-To: <cover-0.5-00000000000-20221007T092505Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20221007T092505Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since 7bc341e21b5 (git-compat-util: add a test balloon for C99
support, 2021-12-01) we've had a hard dependency on C99, but the prose
in CodingGuidelines was written under the assumption that we were
using C89 with a few C99 features.

As the updated prose notes we'd still like to hold off on novel C99
features, but let's make it clear that we target that C version, and
then enumerate new C99 features that are safe to use.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/CodingGuidelines | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index 9fca21cc5f9..386ca0a0d22 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -204,10 +204,14 @@ For C programs:
    by e.g. "echo DEVELOPER=1 >>config.mak".
 
  - We try to support a wide range of C compilers to compile Git with,
-   including old ones.  You should not use features from newer C
+   including old ones.  As of Git v2.35.0 Git requires C99 (we check
+   "__STDC_VERSION__"). You should not use features from a newer C
    standard, even if your compiler groks them.
 
-   There are a few exceptions to this guideline:
+   New C99 features have been phased in gradually, if something's new
+   in C99 but not used yet don't assume that it's safe to use, some
+   compilers we target have only partial support for it. These are
+   considered safe to use:
 
    . since early 2012 with e1327023ea, we have been using an enum
      definition whose last element is followed by a comma.  This, like
-- 
2.38.0.971.ge79ff6d20e7

