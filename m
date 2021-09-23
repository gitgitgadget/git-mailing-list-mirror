Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C70E6C433EF
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 04:12:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E35E61040
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 04:12:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbhIWEO2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Sep 2021 00:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbhIWEO2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Sep 2021 00:14:28 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48821C061574
        for <git@vger.kernel.org>; Wed, 22 Sep 2021 21:12:57 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id z14-20020a17090a8b8e00b0019cc29ceef1so6047911pjn.1
        for <git@vger.kernel.org>; Wed, 22 Sep 2021 21:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gmPSL3aR1QbWSjY6v+BZUUnMwpqnOOZJCXIC9xe99DA=;
        b=khQzrSvmiIHDmFvvs0x+W1KnaghSyRmvkn0oy+Z2KAtugwNXitnR4VZ0Zeu1oSIuhc
         ibU36U2r59gpAurt468hNm8gPmAqTXMAv62fTYFCQ3F9INiBI+i+HIyp0VY5C1jLkGPZ
         CujkeIBM5qg8clSjInysYUx7OKsajkXnJT6vW7lbCVeP7L+VyMhA52GgP9VkbHX30/pE
         iwLI1ZKvs/Hf50Sm3pgtqSZwy0h9dOs/DARABBfa2daJ+AMNNr+CIv3ppP0cEX1wRdJa
         3PlX0f90uIwmjYQ2nNUM3zLOvMm0wNoDrLDMcpn0cRH/DlwAos/7U2ZxlD96CGMSIf4y
         hUwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gmPSL3aR1QbWSjY6v+BZUUnMwpqnOOZJCXIC9xe99DA=;
        b=GLHxvE5JKFJ/YVHQGmy1d7V0SWkgFgGjJjizmjNJI2/+WpBW7X7bAqmPCRUjJkKo+1
         xbSZYius+sdxwoG+ForE5A8NUb7PyFSfZMVeZC7PINcDhyDJp8BwJlHVax5L6c3t/WS2
         iVkARCtbqFDHX4/4IHm86zUHj9n5ZK4huJj1hWaKifmL5alVM1hUQ1/4CZweHybZkesF
         nac6jO+MI902Ybc7zsFWlBALSy6aaOF7gWcturRzuvmgQhdxS+ShsOEGyd/lvpDx0tu0
         5wJ+jGUXiDrySZlz1Xp4/T1nihskUuokcmKIOn/daccVeP22I5TBeeWuXXf4DxgOg/t/
         3J6w==
X-Gm-Message-State: AOAM530Gl1FVKVUelJ/Spv1e95Iqup6gN5aMyhnrKPFV9WAEaGlGfNs9
        o/CWRxih+xxE7K+A68WdLGE=
X-Google-Smtp-Source: ABdhPJwEkQSwzgoQNqhsDyvjMHV0UtnWYiE3RjXOhtmwnbKOb/U61isz7lWeu2n2PjXctTzoUJfY9g==
X-Received: by 2002:a17:90a:df0b:: with SMTP id gp11mr2919903pjb.96.1632370376609;
        Wed, 22 Sep 2021 21:12:56 -0700 (PDT)
Received: from sarawiggum.fas.fa.disney.com ([198.187.190.10])
        by smtp.gmail.com with ESMTPSA id u10sm3649870pjf.46.2021.09.22.21.12.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Sep 2021 21:12:56 -0700 (PDT)
From:   David Aguilar <davvid@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Alan Blotz <work@blotz.org>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>
Subject: [PATCH v5 0/3] difftool dir-diff symlink bug fix and cleanup patches
Date:   Wed, 22 Sep 2021 21:12:49 -0700
Message-Id: <20210923041252.52596-1-davvid@gmail.com>
X-Mailer: git-send-email 2.33.0.720.g59ef144b50
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a resend of previously submitted patches.

Links to previous discussions:
https://public-inbox.org/git/20210919203832.91207-1-davvid@gmail.com/
https://public-inbox.org/git/20210920220855.18637-1-davvid@gmail.com/
https://public-inbox.org/git/CAPig+cTBfP5_czsPiALcF3tODJmNfXvNkTjqVFRbHCS535d-ng@mail.gmail.com/

Patches 2/3 and 3/3 have been rebased against "next" to resolve
the clash with ab/retire-option-argument.

Patch 1/3 is maint-worthy and can be applied there without conflicts.
The commit message now uses the commit message ref format when referring to
other commits. Its test was adjusted to do "cd xyz" instead of "cd ./xyz".

Patch 2/3 has the strbuf leak avoidance brought up in the v4 round.

Patch 3/3 is trivial and unchanged.

David Aguilar (3):
  difftool: fix symlink-file writing in dir-diff mode
  difftool: create a tmpdir path without repeated slashes
  difftool: add a missing space to the run_dir_diff() comments

 builtin/difftool.c  | 52 +++++++++++++++----------------
 t/t7800-difftool.sh | 75 +++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 99 insertions(+), 28 deletions(-)

-- 
2.33.0.720.g59ef144b50

