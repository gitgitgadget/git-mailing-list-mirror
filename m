Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97CE61F463
	for <e@80x24.org>; Thu, 19 Sep 2019 21:47:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403799AbfISVrV (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Sep 2019 17:47:21 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54691 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393079AbfISVrV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Sep 2019 17:47:21 -0400
Received: by mail-wm1-f66.google.com with SMTP id p7so44516wmp.4
        for <git@vger.kernel.org>; Thu, 19 Sep 2019 14:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jVW+3/NusNpkHNjpyUYCq7dkeZZKicdNKaX4zQmObfo=;
        b=eTr8SoxY65XxNpUygBySvrHR/blC45ndRKvGzLlIWHmdodju1QX+dLVLyAoElyusyd
         LXcJkLaZIIhnjVkaiEaFwMfoMd3Sm8mdZ/5G3cogACKkwhyg1sM5ZPdwBpR5KUG3b0+X
         N1bRhWmgma7CYFR3EQ0DgbPjGmKIZNfacHQCuZZC7cEhNY5xlTyoMi3HAs31uG9oybd0
         rkW/uDmEiZ4G2nTVGF8NZgNG9wBNwBb4tIvMAQcFYXK/n6N8Eqk5ITHN90aQ6GK8jkc+
         l8H9tLw3qaRCyVT1zcu3ViOb0TrFJ3JqGyL0aQp8ZG2xbIGZjLWOVvDLQbi8hkbP77PS
         iRBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jVW+3/NusNpkHNjpyUYCq7dkeZZKicdNKaX4zQmObfo=;
        b=h2WqXL8e3qIAFbQmD1kSUncVeKNoYAkYhBKQi5gPpGWLtTC6x4xXXU7TygqotO+kGh
         LfWE+H2wOukQlw5Zdu6PdBsNzGvS1ewP8Tio1GAG0Q/j8r0k49ltXpF0CcWPXAARue8W
         Y1IgnSoRY6k9FoTqF7VjnahdIHNHO2Q4kOwfP3N0ZAmjF+24ATOHNXSnGtQEEQOCSSNa
         2nnAXPH/D3Eongjt22pn1OyVUlUb81b4jc2Oy2ye/JCOQ2aAjIfGlfL8JWm8vawb2uNi
         +ag6eieyJxzoUYhH11D0Rh9jYJQbN5SR12yqS+gvhs9nKqk7ZXbT06y11JyPM934CK32
         28Sw==
X-Gm-Message-State: APjAAAU8GWouVDUim9Rf0WuJA+FkHY/s9a1zLZNRcAo0sDFF9exOj7js
        bgXGsbCs59ZXFniPQhuvqZI=
X-Google-Smtp-Source: APXvYqxj/+AJmligpBOXqZTxE4zMn1gKEZ/6qF17SjgiFg7npjNP9RKwssxJRyLRIXoYExv+4erSOQ==
X-Received: by 2002:a1c:cfc9:: with SMTP id f192mr18699wmg.85.1568929639184;
        Thu, 19 Sep 2019 14:47:19 -0700 (PDT)
Received: from localhost.localdomain (x4db63806.dyn.telefonica.de. [77.182.56.6])
        by smtp.gmail.com with ESMTPSA id b12sm12280wrt.21.2019.09.19.14.47.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 Sep 2019 14:47:18 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 00/15] name-rev: eliminate recursion
Date:   Thu, 19 Sep 2019 23:46:55 +0200
Message-Id: <20190919214712.7348-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.23.0.331.g4e51dcdf11
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

'git name-rev' is implemented using a recursive algorithm, and,
consequently, it can segfault in deep histories (e.g. WebKit), and
thanks to a test case demonstrating this limitation every test run
results in a dmesg entry logging the segfaulting git process.

This patch series eliminates the recursion.

Patches 1-5 and 14-15 are while-at-it cleanups I noticed on the way,
and patch 6 improves test coverage.

Patches 7-11 are preparatory refactorings that are supposed to make
this series easier to follow, and make patch 12, the one finally
eliminating the recursion, somewhat shorter, and even much shorter
when viewed with '--ignore-all-space'.  Patch 13 cleans up after those
preparatory steps.

SZEDER Gábor (15):
  t6120-describe: correct test repo history graph in comment
  t6120-describe: modernize the 'check_describe' helper
  name-rev: use strip_suffix() in get_rev_name()
  name-rev: avoid unnecessary cast in name_ref()
  name-rev: use sizeof(*ptr) instead of sizeof(type) in allocation
  t6120: add a test to cover inner conditions in 'git name-rev's
    name_rev()
  name-rev: extract creating/updating a 'struct name_rev' into a helper
  name-rev: pull out deref handling from the recursion
  name-rev: restructure parsing commits and applying date cutoff
  name-rev: restructure creating/updating 'struct rev_name' instances
  name-rev: drop name_rev()'s 'generation' and 'distance' parameters
  name-rev: eliminate recursion in name_rev()
  name-rev: cleanup name_ref()
  name-rev: plug a memory leak in name_rev()
  name-rev: plug a memory leak in name_rev() in the deref case

 builtin/name-rev.c  | 140 ++++++++++++++++++++++++++++----------------
 t/t6120-describe.sh |  72 ++++++++++++++++++-----
 2 files changed, 147 insertions(+), 65 deletions(-)

-- 
2.23.0.331.g4e51dcdf11

