Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE503C433F5
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 07:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C207F610C8
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 07:46:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350683AbhIHHrT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 03:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233210AbhIHHrR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 03:47:17 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 737FAC061575
        for <git@vger.kernel.org>; Wed,  8 Sep 2021 00:46:10 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id y144so1576169qkb.6
        for <git@vger.kernel.org>; Wed, 08 Sep 2021 00:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XhojOkRBpzGe5VAPCzWzuFSXnkpbnekQwttxTYa/sfA=;
        b=R6FcmXeEiGdktY9RJVp/SalFc28VniK1YCOuK6Yrse89cWIhEyHZkMTNDKpTl3Yzl7
         5MV3iEOsAMPoymbBAKcRyqAPXIiD/hI1FnFwrjZMVoeCW6SB5nPfu5HoQC+uHPaHxAjy
         3U6Dj7u+YJBF0CKiLx4rnxhCb6+AEsHu/owqYF2pOfUlY54+dtJF8YMO+1tR2EpKg9sb
         zWELPJrSCJDVqj7YFoUh7RLtyWzswhFLhTjbNTLA6W+OodR68FG3wYYFczYb3aUE2HfH
         NsG2GxJE8lOQ83hrn0XvHKnUVlUACTS9jI69X0zF6TlJJbJ4kUHlAj6VD5u1qMebT2QZ
         cpLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XhojOkRBpzGe5VAPCzWzuFSXnkpbnekQwttxTYa/sfA=;
        b=I4q//dwnzQAXXN+DzRf3Ak8Uof529znYgVkbi1SfI1gEQdlDdrOoEaXPNKnJQWn6/s
         TEat9WvecDlBueAcI8jMFOHNVFG1z9Hm/whAyaS7D/Y59qo7X2n9zYXDGeEs+NoTQpc3
         XNxXsHMtwWwr2Wu1gYN/DM+ha9NLTIM+ZPrWYhfcAHD7WW2VeRgG8AJNYb8Ldm5hxzhO
         o01zbm19itPMv2tOhc0OmQGdJ0oazLOI0MIYeofGF5KlVZWiHpDgrqQeDnx9HvNcnRib
         dtEHJWT5C6B2za4+kAAwv5Ajw2Yowf6hdOodjOXr/ltSZ0pQnhQLqYTV/HSO4xPtS5FQ
         Rh5A==
X-Gm-Message-State: AOAM530JFF4eFxgJoOc70FyCElMcg6eqEP2IT2qp1Hm6lNPSjncr8wpE
        LrxMA2t2Tk7dKt2hjbqXgUygzUbYjFw=
X-Google-Smtp-Source: ABdhPJwp5yZBZ46eLxQvAUfEXQUv7kbVoGzs+Z8UNK+Bh4lmAav299UmrMEV1bBrfqzClTFl3rX5kg==
X-Received: by 2002:a05:620a:2914:: with SMTP id m20mr2188953qkp.497.1631087169374;
        Wed, 08 Sep 2021 00:46:09 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id v14sm1122935qkb.88.2021.09.08.00.46.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Sep 2021 00:46:08 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     hanwen@google.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH 0/4] fixup for hn/reftable
Date:   Wed,  8 Sep 2021 00:45:53 -0700
Message-Id: <20210908074557.38141-1-carenas@gmail.com>
X-Mailer: git-send-email 2.33.0.481.g26d3bed244
In-Reply-To: <pull.1081.git.git.1630335476.gitgitgadget@gmail.com>
References: <pull.1081.git.git.1630335476.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

DEVELOPER=1 wasn't working well in OpenBSD until cb/makefile-apple-clang
(which just hit next), so I missed it in my previous run.

hopefully it is not too late to fix this, otherwise.

As usual they should apply to the patch they refer to and are based on the
last reroll in seen (tip 1427aef0bd as of e881a4ab6c (Merge branch
'hn/reftable' into seen, 2021-09-07)

Except from the last patch (and two other minor refactors I couldn't avoid)
they could all be one single change to move the declaration for the zlib
compat function to some place where it could be visible from the two files
that will use it, but it was spread on multiple files to easy autosquashing

Carlo Marcelo Arenas Belón (4):
  fixup! reftable: reading/writing blocks
  fixup! reftable: utility functions
  fixup! Provide zlib's uncompress2 from compat/zlib-compat.c
  fixup! reftable: utility functions

 compat/zlib-uncompress2.c |  3 +++
 reftable/basics.h         |  1 -
 reftable/block.c          |  9 ---------
 reftable/system.h         | 10 +++++++++-
 4 files changed, 12 insertions(+), 11 deletions(-)

-- 
2.33.0.481.g26d3bed244

