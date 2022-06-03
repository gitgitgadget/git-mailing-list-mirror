Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 537B4C43334
	for <git@archiver.kernel.org>; Fri,  3 Jun 2022 18:39:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347426AbiFCSj0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Jun 2022 14:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237867AbiFCSjB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Jun 2022 14:39:01 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2421513CF7
        for <git@vger.kernel.org>; Fri,  3 Jun 2022 11:38:06 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id f23-20020a7bcc17000000b003972dda143eso6785343wmh.3
        for <git@vger.kernel.org>; Fri, 03 Jun 2022 11:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cOjzncUXNGtW9lgx42kgxYpyu4kURDQz/nl+++pJmq4=;
        b=J/Sj5e6KJC/5eqT+H0ZTnvMPUEzXr/Xvy1Bj0OAAX9McUE9ig+FsnR2c3elL+T0kDL
         kZWpy94YyIOzriE3AQVygm0izzQXCF8HNVG4hcWHokaC6M8GUvQoXHeaet1ccFTWx+Ng
         U4nc9O098pO4WwZU8d6auWNTknByc8wwJK1DIFEkis8XGluu0HWpMTpuo2Tay7zWbAmX
         wez8osqK2jC3US/gyMeEBU3LH9eeuLbw338KiYXaL1QCn85DvnxUXzMH3dQlXDWUhKKm
         +EaepNkNFLabilA8ZzWZjn9ujjjExivvlt7hPfjn7VBPpnTbQ7SXFgKog4UkQjd1XN+s
         e0LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cOjzncUXNGtW9lgx42kgxYpyu4kURDQz/nl+++pJmq4=;
        b=CSZdBTmDOHTHPGl4jj7FlAZt+zkGM6TacoehuoHnJEBZ7TTGDw8JeuIiNufV7Nt4AV
         HvY/FjHZax3+XOdXBtZi7eGUa929f9pMsjSuuAEP+UfBZrOkVBAJFY/BSRHoGmkLyI6a
         1xqoAArTHFBdSd7EMtH1U0kp36mQK+PALAege72RzNFamzJNVDzDfmXiK/BFEKx4+59/
         x5OuAGeyMKbyOldHevDk53eqSdhN55yMLidz6bjJCuhlwXKsNiHRtGDlM/aICWXOajeC
         IPavHAQPGexmw/PW9qV8ZRSF4r3o1gz8ZLFf6IgHPdTwQU0H6r0jpVTAJvgnfUE26gUT
         JZ8g==
X-Gm-Message-State: AOAM530r06gb2/CHc4U3oCZKB+6aaKrvUl038oWk5EW38XYePrGyDvu8
        Qj7odZ/v8+p7l1ClqGSeo7IMqUF9DYZijA==
X-Google-Smtp-Source: ABdhPJxWNfBBgLs45Iin1OX9c8QbCcEo/aQP5goO4NWEO1BJLcYvm8vmOpOvnopkv6a9UTAlIMo8RA==
X-Received: by 2002:a05:600c:3ac9:b0:397:70f8:bd65 with SMTP id d9-20020a05600c3ac900b0039770f8bd65mr39155484wms.194.1654281484277;
        Fri, 03 Jun 2022 11:38:04 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y5-20020adff6c5000000b0020c5253d926sm8232636wrp.114.2022.06.03.11.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 11:38:03 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Jinoh Kang <luke1337@theori.io>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Glen Choo <chooglen@google.com>, Paul Tan <pyokagan@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        Jeff Smith <whydoubt@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 04/15] diff-lib.c: don't dereference NULL in oneway_diff()
Date:   Fri,  3 Jun 2022 20:37:41 +0200
Message-Id: <RFC-patch-04.15-3a287c19d7e-20220603T183608Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1124.g577fa9c2ebd
In-Reply-To: <RFC-cover-00.15-00000000000-20220603T183608Z-avarab@gmail.com>
References: <RFC-cover-00.15-00000000000-20220603T183608Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a control flow issue dating back to d1f2d7e8ca6 (Make
run_diff_index() use unpack_trees(), not read_tree(), 2008-01-19)
where we'd assume "tree" must be non-NULL if idx was NULL. As
-fanalyzer shows we'd end up dereferencing "tree" in that case in
ce_path_match():

dir.h:541:41: warning: dereference of NULL ‘ce’ [CWE-476] [-Wanalyzer-null-dereference]
  541 |                               S_ISDIR(ce->ce_mode) || S_ISGITLINK(ce->ce_mode));
      |                                         ^
  ‘oneway_diff’: events 1-2
    |
    |diff-lib.c:493:12:
    |  493 | static int oneway_diff(const struct cache_entry * const *src,
    |      |            ^~~~~~~~~~~
    |      |            |
    |      |            (1) entry to ‘oneway_diff’
    |......
    |  506 |         if (tree == o->df_conflict_entry)
    |      |            ~
    |      |            |
    |      |            (2) following ‘true’ branch...
    |
  ‘oneway_diff’: event 3
    |
    |  507 |                 tree = NULL;
    |      |                      ^
    |      |                      |
    |      |                      (3) ...to here
    |
  ‘oneway_diff’: events 4-8
    |
    |  507 |                 tree = NULL;
    |      |                      ^
    |      |                      |
    |      |                      (4) ‘tree’ is NULL
    |  508 |
    |  509 |         if (ce_path_match(revs->diffopt.repo->index,
    |      |             ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    |      |             |
    |      |             (5) following ‘false’ branch (when ‘idx’ is NULL)...
    |      |             (6) ...to here
    |      |             (7) ‘tree’ is NULL
    |      |             (8) calling ‘ce_path_match’ from ‘oneway_diff’
    |  510 |                           idx ? idx : tree,
    |      |                           ~~~~~~~~~~~~~~~~~
    |  511 |                           &revs->prune_data, NULL)) {
    |      |                           ~~~~~~~~~~~~~~~~~~~~~~~~
    |
    +--> ‘ce_path_match’: event 9
           |
           |dir.h:535:19:
           |  535 | static inline int ce_path_match(struct index_state *istate,
           |      |                   ^~~~~~~~~~~~~
           |      |                   |
           |      |                   (9) entry to ‘ce_path_match’
           |
         ‘ce_path_match’: event 10
           |
           |  541 |                               S_ISDIR(ce->ce_mode) || S_ISGITLINK(ce->ce_mode));
           |      |                                         ^
           |      |                                         |
           |      |                                         (10) dereference of NULL ‘ce

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 diff-lib.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/diff-lib.c b/diff-lib.c
index ca085a03efc..8373ad7e3ea 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -506,6 +506,9 @@ static int oneway_diff(const struct cache_entry * const *src,
 	if (tree == o->df_conflict_entry)
 		tree = NULL;
 
+	if (!idx && !tree)
+		return 0;
+
 	if (ce_path_match(revs->diffopt.repo->index,
 			  idx ? idx : tree,
 			  &revs->prune_data, NULL)) {
-- 
2.36.1.1124.g577fa9c2ebd

