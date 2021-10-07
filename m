Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54031C433F5
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 10:01:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 329EF6103C
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 10:01:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240592AbhJGKDk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Oct 2021 06:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232642AbhJGKDk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Oct 2021 06:03:40 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84F25C061746
        for <git@vger.kernel.org>; Thu,  7 Oct 2021 03:01:46 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id v17so17283996wrv.9
        for <git@vger.kernel.org>; Thu, 07 Oct 2021 03:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7p1B/3f/gE9bQgeipB6j+UxIO1DAmFdT6tBHYR/L6Hk=;
        b=WW72cWm7Fpizp3/KV5e0Y/GEt/FEzJxkVZ9ezatWEJaL3Ja+qLl3DWYVLKDloeNvYC
         xsIYwCnO9B1akMjleCqVaNthfnEuTZZokxv8URmPbh9+6rfPMWg4cNoJl6reu60jqwuO
         rlSncDVqABdnGU1n2crG6DfGNkLAyl8o0YgfIHDViUtLPNDEQTOIbtrthLW5Z4FJai9j
         8wQjmehAmL+7irb1DBTAH3Oda3Kd6uKo274WHxCOs5j4RO43FezIuMrHZZXjy8ECJrGc
         vkehpm0oMVDlFKuSLH0rMmJbPiHySbwjZDl2YdfN0lOczi+RjO1dlT65fh/JPOr6lA89
         X0+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7p1B/3f/gE9bQgeipB6j+UxIO1DAmFdT6tBHYR/L6Hk=;
        b=Ej5zupQJdOYTgfRTkSYGb2rA4ocIHDfEdaw60lvZlxcI2MXn4UZYHz/k0UR73psmgq
         nrWT+Gu1veQ+XzBRGrkZK5zOksnLZquI6c/RX0ozrfOB2wbT62PDlxqB9OgvJiT/yJ+q
         +HJ55aiFGiZS2R3Mr8SI96kGyJZugIXKroacXttwXEiBjDyIJtvzFKcYOLOeOP9/u5Rt
         YsS3JCa8K/zyZ/tdhUwRWR5NBsu2idKyMO7PaKx/JlYRNJ+6daQIQufxjh7bmXYEp2rf
         rF55vMYTDeiU8mQ5eZsDWuKPZecPdej/+MJipUshzwqSLryovRqqLM+kNJ0DRuaL4tHy
         R5DA==
X-Gm-Message-State: AOAM533RFIagLyA+WIImASG3FMdzQoNbA7H2zfamkVtfAM3kN/Ttleom
        VD/jrqqRLkWhEM2OI2C13ZQezaPZ894E1g==
X-Google-Smtp-Source: ABdhPJwAfxgTRrgK20qnziZP35diOobjGb/KrsdfiSRN7Jf38QGtxXA6cQoWEfmgaQeiTf3B2h49rg==
X-Received: by 2002:a5d:4ac4:: with SMTP id y4mr4130470wrs.190.1633600904882;
        Thu, 07 Oct 2021 03:01:44 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f16sm628559wrr.53.2021.10.07.03.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 03:01:44 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Andrzej Hunt <ajrhunt@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 0/7] leak tests: fix "test-tool" & other small leaks
Date:   Thu,  7 Oct 2021 12:01:30 +0200
Message-Id: <cover-v2-0.7-00000000000-20211007T100014Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1446.g6af949f83bd
In-Reply-To: <cover-0.7-00000000000-20211006T095426Z-avarab@gmail.com>
References: <cover-0.7-00000000000-20211006T095426Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Like my just-submitted series to mark existing tests as passing[1]
under the test mode added in ab/sanitize-leak-ci, this marks more
tests as passing, but here we need to fix some small memory
leaks. This goes on top of ab/sanitize-leak-ci.

See v1[1] for a more detailed summary, the only update here is to some
bad commit message grammar/phrasing in v1.

1. https://lore.kernel.org/git/cover-0.7-00000000000-20211006T095426Z-avarab@gmail.com/

Ævar Arnfjörð Bjarmason (7):
  tests: fix a memory leak in test-prio-queue.c
  tests: fix a memory leak in test-parse-options.c
  tests: fix a memory leak in test-oidtree.c
  tests: fix test-oid-array leak, test in SANITIZE=leak
  ls-files: fix a trivial dir_clear() leak
  ls-files: add missing string_list_clear()
  merge: add missing strbuf_release()

 builtin/ls-files.c                 | 14 ++++++--------
 builtin/merge.c                    |  2 ++
 t/helper/test-oid-array.c          |  4 ++++
 t/helper/test-oidtree.c            |  3 +++
 t/helper/test-parse-options.c      |  7 ++++++-
 t/helper/test-prio-queue.c         |  2 ++
 t/t0009-prio-queue.sh              |  2 ++
 t/t0040-parse-options.sh           |  1 +
 t/t0064-oid-array.sh               |  2 ++
 t/t0069-oidtree.sh                 |  1 +
 t/t3001-ls-files-others-exclude.sh |  5 +++--
 t/t3005-ls-files-relative.sh       |  1 +
 t/t3020-ls-files-error-unmatch.sh  |  2 ++
 t/t3700-add.sh                     |  1 +
 t/t7104-reset-hard.sh              |  1 +
 t/t7604-merge-custom-message.sh    |  1 +
 16 files changed, 38 insertions(+), 11 deletions(-)

Range-diff against v1:
1:  8806f9cb5e8 = 1:  37cdf0ee348 tests: fix a memory leak in test-prio-queue.c
2:  c24e115aa49 ! 2:  53b0da60804 tests: fix a memory leak in test-parse-options.c
    @@ Commit message
         tests: fix a memory leak in test-parse-options.c
     
         Fix a memory leak in t/helper/test-parse-options.c, we were not
    -    freeing the allocated "struct string_list" or its items. While I'm at
    -    it move the declaration of the "list" string_list the
    -    cmd__parse_options() function.
    +    freeing the allocated "struct string_list" or its items. Let's move
    +    the declaration of the "list" variable into the cmd__parse_options()
    +    and release it at the end.
     
         In c8ba1639165 (parse-options: add OPT_STRING_LIST helper, 2011-06-09)
         the "list" variable was added, and later on in
3:  a216297aba1 = 3:  33a4b9c7c68 tests: fix a memory leak in test-oidtree.c
4:  4aa2a70c67e = 4:  b8ce8d7e972 tests: fix test-oid-array leak, test in SANITIZE=leak
5:  58b5bc67435 = 5:  73cf1018953 ls-files: fix a trivial dir_clear() leak
6:  34749645f74 = 6:  fc10353c0c5 ls-files: add missing string_list_clear()
7:  d7c94fa2851 = 7:  9942c084244 merge: add missing strbuf_release()
-- 
2.33.0.1446.g6af949f83bd

