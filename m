Return-Path: <SRS0=27Fn=A3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4260C433E3
	for <git@archiver.kernel.org>; Thu, 16 Jul 2020 17:32:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 706C42067D
	for <git@archiver.kernel.org>; Thu, 16 Jul 2020 17:32:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NFubsGLl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728638AbgGPRca (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jul 2020 13:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728385AbgGPRca (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jul 2020 13:32:30 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2BE9C061755
        for <git@vger.kernel.org>; Thu, 16 Jul 2020 10:32:29 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id s10so7879134wrw.12
        for <git@vger.kernel.org>; Thu, 16 Jul 2020 10:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=VAGeARp0SlN3DaJjtYMXPOwDR6BhLtokC4p828YXwFU=;
        b=NFubsGLl/NKzHduugnKYGURVXsDQfJjOjjiJSN47SQSdVe0qERpn12SuNBTth2ZR5m
         apHt7B4HZRHSi02qm5LfHDGZ9NkArkzAPeD0PopAMy2JJbdn0HqeA7ak8RYsdsarjVF/
         lNojr3gl9/y8rWJH9U59OkzdGEIiCdT72c/lfUZPUKpxgTCdRhND0AwVcvpvrqHNTwom
         zjdhw5v+20uehLB1A034T5vdhpJXeZqjgw6wx6n4CDZqPyDlCtGaoPQ5pn7Ru9oDBEb3
         otF5czq2806WibrgjrYfSbfcauTjSPTBpUy8iu9vnyVaO5+FcrF+UQVy0ch7QDXxBBRx
         kZ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=VAGeARp0SlN3DaJjtYMXPOwDR6BhLtokC4p828YXwFU=;
        b=mGyHTat/lZ222bDZNdjNr+HiSrn9KP6T8vK1R/S1t20ES1lnJAjSILVxAgzb8zJIrf
         kND7kxtk/lOVpAAhuEgJLg5nrljX7SbnAYvM7U7TtPqzzdwR0Bxhx+kQoPqLGf3s6mMA
         zAyUJNxiW1I4WoZSC4R1XzrMc4QAh7m20Db0vJa9xZ+wjb5kM1ClYJyKh/1x5a0qWXa+
         TZJPrl/8dZo06iU6O4EZsYpoTvyAzKbgJUeOS2bn7oqz0YDBe4qJhwaz9lFZ8njfdLoE
         Hhs+oZ6HboGW/c+B0HummQ+6mN+ogoHGNszyOaRxf/y/QKIHl2RH6zNH7UFRH/HzwNdx
         zlHg==
X-Gm-Message-State: AOAM532Y+BwnLM+3fee2cruDuUK3HuDl0yNCr6IRG/Psv66sS4N4ijvB
        QQQfJ5F1JXxv7RkrxV7VnNk=
X-Google-Smtp-Source: ABdhPJxPpWy7NHp8ewKl6haL+qOhxW8Ykguh7sWloXUWfxTLaqxEDGtQ1kT0qkUubbmpK00DhQ5MIg==
X-Received: by 2002:adf:ef89:: with SMTP id d9mr6459060wro.124.1594920748266;
        Thu, 16 Jul 2020 10:32:28 -0700 (PDT)
Received: from localhost.localdomain (130.20.198.146.dyn.plus.net. [146.198.20.130])
        by smtp.gmail.com with ESMTPSA id q1sm9890020wro.82.2020.07.16.10.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 10:32:26 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Alban Gruin <alban.gruin@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v7 0/5] cleanup ra/rebase-i-more-options
Date:   Thu, 16 Jul 2020 18:32:16 +0100
Message-Id: <20200716173221.103295-1-phillip.wood123@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200407141125.30872-1-phillip.wood123@gmail.com>
References: <20200407141125.30872-1-phillip.wood123@gmail.com>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Danh pointed out that the word "ident" gets misinterpreted by
translators as "indentation" leading to incorrect translations so I've
reworded an error message.

format-patch and am could do with having their similar messages
updated in the future

Phillip Wood (2):
  rebase -i: support --committer-date-is-author-date
  rebase -i: support --ignore-date

Rohit Ashiwal (3):
  rebase -i: add --ignore-whitespace flag
  sequencer: rename amend_author to author_to_free
  rebase: add --reset-author-date

 Documentation/git-rebase.txt           |  33 ++++-
 builtin/rebase.c                       |  47 +++++--
 sequencer.c                            | 112 ++++++++++++++-
 sequencer.h                            |   2 +
 t/t3422-rebase-incompatible-options.sh |   2 -
 t/t3436-rebase-more-options.sh         | 180 +++++++++++++++++++++++++
 6 files changed, 353 insertions(+), 23 deletions(-)
 create mode 100755 t/t3436-rebase-more-options.sh

Range-diff against v6:
1:  0fc90eaff1 ! 1:  3865fdf461 rebase -i: support --ignore-date
    @@ sequencer.c: static const char *author_date_from_env_array(const struct argv_arr
     +	struct strbuf new_author = STRBUF_INIT;
     +
     +	if (split_ident_line(&ident, author, strlen(author)) < 0) {
    -+		error(_("malformed ident line '%s'"), author);
    ++		error(_("invalid author identity: %s"), author);
     +		return NULL;
     +	}
     +
2:  21cf5e5512 = 2:  0b6b19cb68 rebase: add --reset-author-date
-- 
2.27.0

