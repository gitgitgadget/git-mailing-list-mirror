Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10F7CC433EF
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 12:10:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE70961AA7
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 12:10:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234785AbhKSMNG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Nov 2021 07:13:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbhKSMNG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Nov 2021 07:13:06 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB62C061574
        for <git@vger.kernel.org>; Fri, 19 Nov 2021 04:10:05 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id b11so7956245pld.12
        for <git@vger.kernel.org>; Fri, 19 Nov 2021 04:10:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X6iCF8GSTDTi1QKrDay0Cx8vo9VZzNDFsMfIawxC5ZI=;
        b=gdLQ9v+A8/RA1ONbXeZm1+NUtgLBnsOgCa/edVkHGjIKxza40sBkpED9VkW3tUny/z
         aWj20Dx5B6g3sFKsH3Y6/XrTg1DIjZ2omYoXqPnWeA/samm3qoZhWc5XFg0g7m1J85jG
         uUgDPr8+tmGmBH1cG09YHXylaXlzoxjgpRdVS3U9irDNqNXiZkK+ssqFfQsZP3/Qcusn
         DMF4dMbEC320EfnTTzc1oEBa2d6f4R/xZYoR0HRfzIn4dlhtaonLkncipunv7Gn2UHF3
         g/+SzqZOn3NLs0loT2cByDvk5AMN9zSM7h78L4BDFERFaEZ62Ew/qb0aQjAuAxiu4vCI
         MkjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X6iCF8GSTDTi1QKrDay0Cx8vo9VZzNDFsMfIawxC5ZI=;
        b=tD8wkOt4jr6vXRuTYW/qRjE4WTttbVUfHHL2rrVSuzaY2aJgtuDp/5ng05zRLy61s6
         jCdijayQp9HOikeUsljwZVS0VURehAOHoJpwD9gAQFoj/N8iFgoYHfU+LBW9fgRt7R/7
         k2VeCV7vIBCJ2jIaMKTg4pEQjfPh78n58HYs28uiTXV6AwarwCqnUodcPI04lTOkMQ/Z
         5I0Zwe/youmsTZEGrTVTZjjLmndGH+a3cg3LsenzXYGvWWn6HkjrGRBkYNpheo8LA0J8
         nP0fsImsje5r200sr1bt9Yrz8n0WxOMZwkYYtAI6ax/uQ/PrxemxyG+VPYM97GgltwyQ
         4DXA==
X-Gm-Message-State: AOAM5321SgZQk8EJhNgqcvKgCVRSM5/AGUh2Wr2CEqMKhE8vlhLQSwCC
        PDM5A1MxOYh80/P285YrgRA4DBdGuEmIzhTy
X-Google-Smtp-Source: ABdhPJz/3RpZmSSZUEsPuWlmqNmxT06ORLwA2rFHJb9ydgyxg24dcNpWO7zL9q8bcpD1YAxdevnfKw==
X-Received: by 2002:a17:902:8214:b0:142:61cf:7be with SMTP id x20-20020a170902821400b0014261cf07bemr76672255pln.0.1637323804359;
        Fri, 19 Nov 2021 04:10:04 -0800 (PST)
Received: from localhost.localdomain ([205.204.117.98])
        by smtp.gmail.com with ESMTPSA id oj11sm11875381pjb.46.2021.11.19.04.10.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Nov 2021 04:10:03 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, avarab@gmail.com,
        congdanhqx@gmail.com, Teng Long <dyroneteng@gmail.com>
Subject: [PATCH v2 0/1] support `--oid-only` in `ls-tree`
Date:   Fri, 19 Nov 2021 20:09:26 +0800
Message-Id: <cover.1637321601.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.33.1.10.g8b68568d6c
In-Reply-To: <20211115115153.48307-1-dyroneteng@gmail.com>
References: <20211115115153.48307-1-dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


This patch series supports for only outputing the "objects" (OID)
with a new option names `--oid-only`.

Changes with the first patch are :

        1. Three commits are squashed to 1 commit (Peff's advice)
        2. The tests issues (Đoàn Trần Công Danh's advice)
        3. Use `OPT_CMDMODE()` for mutually exclusive control
           (Ævar Arnfjörð Bjarmason's advice)

Some discussions are not included in Patch 2 :

        1. `git ls-tree --long --name-only` and
           `git ls-tree --long --oid-only` which is arguably a bug
           (Peff's advice)
        2. Support `--format` for `git-ls-tree`
           (Ævar Arnfjörð Bjarmason's advice)

The reason why these 2 discussions not included is I'm not sure whether
I should continue on the current patchset or start a new one. And for the
second, I think current implementation is clear and simple to use, meeting
the needs of the moment. Maybe I will to support `--format` option, but
before that, I'm appreciate if there are more suggestions appear.

Thanks.

Teng Long (1):
  ls-tree.c: support `--oid-only` option for "git-ls-tree"

 Documentation/git-ls-tree.txt |  8 +++++--
 builtin/ls-tree.c             | 27 ++++++++++++++++-------
 t/t3104-ls-tree-oid.sh        | 40 +++++++++++++++++++++++++++++++++++
 3 files changed, 65 insertions(+), 10 deletions(-)
 create mode 100755 t/t3104-ls-tree-oid.sh

Range-diff against v1:
1:  c4479178d7 < -:  ---------- ls-tree.c: support `--oid-only` option for "git-ls-tree"
2:  853ebbcf88 < -:  ---------- t3104: add related tests for `--oid-only` option
3:  33c68c1f11 < -:  ---------- git-ls-tree.txt: description of the 'oid-only' option
-:  ---------- > 1:  8b68568d6c ls-tree.c: support `--oid-only` option for "git-ls-tree"
-- 
2.33.1.10.g1f74a882e4

