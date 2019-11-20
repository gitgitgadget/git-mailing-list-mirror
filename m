Return-Path: <SRS0=iiTG=ZM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3C77C43215
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 09:52:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C40021939
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 09:52:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GTvFP0Kt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728329AbfKTJwq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Nov 2019 04:52:46 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41892 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728145AbfKTJwp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Nov 2019 04:52:45 -0500
Received: by mail-wr1-f66.google.com with SMTP id b18so25908250wrj.8
        for <git@vger.kernel.org>; Wed, 20 Nov 2019 01:52:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ykslHckbqC2bSRpr2Rz4YATbGC5cfMaMF5A2Ua5+UMY=;
        b=GTvFP0Kt55Q+eR7PnUwdguq/wYOO+FQ16Z1Mno8nvsHc3ZJqke0FlHNsAJELk1jnJK
         Wg2N9WXrubXM0/6gWjPrgPA5NGTfeE1nsWoyFL0y+fNAPVo3/iCxIwaACQye23bwnUt/
         c8AZZ1aPMgN7+xYtkJaAk8o2bK8+7YsXDjDOYBoHLlVuWNcFfhbhb6SqSSQgfoylNsvB
         GioLoh4RU4nufsEnNtyQEuan0jxHwYWboVbq/CYByqR+cCN/kOuxOAWgiEFS/a3GFiUU
         6teR3/bVpshXQoa+kOx8n0VudL1imKwFQjcFS21sdqaQ71eAT/xeE46gUIyoc7NlVD2O
         N2bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ykslHckbqC2bSRpr2Rz4YATbGC5cfMaMF5A2Ua5+UMY=;
        b=P9SfBygPkkuBotqCqeU6QDhu8jgffT4SijNB+sZKC7VdyrZYou/i3HkJUYKGebP8dY
         0Ux7PjS9dpTdaB6yYbOLEB4GSjxb4F5QqpmICMVys6VobiSkui+1jbELuJuy/c9cKV4Y
         YV6wOY+Q+Jvpa+1oIEWtMX4ZVT4WrQIZ13+kC2YjcGGtTTuJR/FrYmqFsj/CTJdEAh0t
         LEyik3Yzw5LlD8N9hLsrpdAIVTwzDFRyxAQzGmog5+KDfYj/nDg2+8NPFzjbYEmXvUby
         PYsNLZGzPEWKktcyCVynP7XS8n0err+mULy8BvfTmDOjBw9Sbkgbv1Rv3o3G2w2mnj5W
         YNcg==
X-Gm-Message-State: APjAAAUn6b/V1o426TFE9GVlaBfsCDwstjYwtw/geCYts/lwB+iuWIOC
        y10J8hG00ILZ7bCzQoOhS6h/9H49gP8=
X-Google-Smtp-Source: APXvYqyFPoprAWLlJRZnWtKj0vvZ2NjdZDWBTAhI2MwTPqZv28IJgsyr6txzzRTAjwqoD3T+rkJOeg==
X-Received: by 2002:adf:dd12:: with SMTP id a18mr2112216wrm.123.1574243561799;
        Wed, 20 Nov 2019 01:52:41 -0800 (PST)
Received: from rybak.office.devexperts.com ([185.79.217.61])
        by smtp.googlemail.com with ESMTPSA id p25sm5992516wma.20.2019.11.20.01.52.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Nov 2019 01:52:40 -0800 (PST)
From:   Andrei Rybak <rybak.a.v@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, phillip.wood@dunelm.org.uk,
        predatoramigo@gmail.com
Subject: [RFC PATCH v2 0/4] rebase --edit-todo --exec
Date:   Wed, 20 Nov 2019 10:52:34 +0100
Message-Id: <20191120095238.4349-1-rybak.a.v@gmail.com>
X-Mailer: git-send-email 2.24.0.windows.2
In-Reply-To: <20191114163549.7648-1-rybak.a.v@gmail.com>
References: <20191114163549.7648-1-rybak.a.v@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Differences from v1:
  - Added missing RFC marker.
  - Fixed CC list.
  - Addressed Junio's comment about masked variable in a for loop: another
    preparatory patch is added.
  - Cleaned up copy-pasted unused code in the new test.

----

Original cover letter:
I've wanted this feature for a long time, and now with rebase working without
forking rebase--interactive (thanks to Phillip Wood for working on that), I
finally got around to implementing it.

It still needs validation for arguments. Right now, I have two ideas:

  1. iterate over original argv and make sure its just '--exec's with its
     arguments.
  2. check all other vars in options[].

Andrei Rybak (4):
  builtin/rebase.c: reuse loop variable
  rebase: prepare cmd before choosing action
  rebase: extract add_exec()
  rebase -i: allow --edit-todo with --exec

 Documentation/git-rebase.txt  |  3 +-
 builtin/rebase.c              | 63 +++++++++++++++++++++--------------
 t/t3404-rebase-interactive.sh | 32 ++++++++++++++++++
 3 files changed, 72 insertions(+), 26 deletions(-)

-- 
2.24.0.windows.2

