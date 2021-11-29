Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D26E5C433F5
	for <git@archiver.kernel.org>; Mon, 29 Nov 2021 22:46:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234929AbhK2Wta (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 17:49:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235012AbhK2WtH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 17:49:07 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3EA5C08ED67
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 12:23:46 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id iq9-20020a17090afb4900b001a54412feb0so8560003pjb.1
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 12:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=vChRx/tEATUNypgTXOy+WtZvQsPytDGo9rWd/FMz9C0=;
        b=HyxOz0kRW+6XZnkPDpuhXgkJGR4+GQCk56oicojoO3pWPBg+y4byFamD77ar5tRKu7
         gFMwYTY4pcHqGX8PZRlcROxs5JxP32nM75FIFhk/0rgNHgNle0xAfcv2p6ImDFP/Y8cL
         Aa0/E/nQ1H7kRYfjBSIgweTU/I8gBpRbflpYHFJAaqV0GdKV+8xvK+W5QWnoD40wu8Gd
         3tGi2viVwfUZaog+LxgsNznHt2q3IHlDSI8SRQW3V36xVA+EeCHoTJnFSdA5IOt/HQ5n
         XXFIo8iLQpsJxNLRUDjOW33NQvMLCIDnRwZAex06F3ppghnF7n5gaxL3EEtcdokjMMx2
         OmLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=vChRx/tEATUNypgTXOy+WtZvQsPytDGo9rWd/FMz9C0=;
        b=a+D51xbTgislXRPrf+WpGAd/BB0HOPRJvOycJwAbZ/IVE27ta0AAfYkkJhr9UEL4VA
         4q0JqTh+3pwzM/EZHz5ANoyvQXzPgaZ7jynx6O0i5P4g0akq1ESkXJMfj7k2keUVzsg6
         fcZHygYVi/7JSWa9qNwD8WoK4DsGb3qoTjx0rMIoDZieNlLfrRX0XWiVfmsFZZKJCTYi
         PM/WT1/zwCgSK8iyDowxXaMRCMQKXRpPqbv1uLwKHCVhagKOINs6J9Is2ZHuXz0COxrM
         /2q8fKXbY7r1ERsSAVYJ3zXoRCv6Cbx2j3P0KLGPqkDxGmgcCzK+tqNTg5qlvdnpvsi1
         BdGA==
X-Gm-Message-State: AOAM5314YuVgcMMrGX+q08PVDjL4OqvQB85gI50MH5d/eYRPghJK/oiE
        djPBuaTmurwCCL5R5lemFnZXs3TcEaZztFclS0H8uvb0pgCtNNcTQnsMSwZZUzX+bDUgFBwSHj/
        LiE2YLA/mzK0NbY6alnHOgrwFe5Ctkbmt3rgC1fCenYu1m+5iv7XZaanNN3KCDcn9i8+Wi5ynQK
        k3
X-Google-Smtp-Source: ABdhPJy7koKHx/DVZebxJFkojDfgyIKT38giWMUtTiOSDhIzzweYl2Wu5pTwQIrQWtiIdA0m3yeac3do79fopIDjetGJ
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90a:df01:: with SMTP id
 gp1mr437505pjb.28.1638217425964; Mon, 29 Nov 2021 12:23:45 -0800 (PST)
Date:   Mon, 29 Nov 2021 12:23:40 -0800
In-Reply-To: <cover.1634077795.git.jonathantanmy@google.com>
Message-Id: <cover.1638217387.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1634077795.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [PATCH v4 0/2] Conditional config includes based on remote URL
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, chooglen@google.com,
        gitster@pobox.com, avarab@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks everyone for your comments. Here's an update.

Jonathan Tan (2):
  config: make git_config_include() static
  config: include file if remote URL matches a glob

 Documentation/config.txt |  12 ++++
 config.c                 | 133 ++++++++++++++++++++++++++++++++++++---
 config.h                 |  44 ++++---------
 t/t1300-config.sh        | 118 ++++++++++++++++++++++++++++++++++
 4 files changed, 265 insertions(+), 42 deletions(-)

Range-diff against v3:
1:  b2dcae03ed = 1:  b2dcae03ed config: make git_config_include() static
2:  1c1a07a0b6 ! 2:  3b3af0da98 config: include file if remote URL matches a glob
    @@ Documentation/config.txt: all branches that begin with `foo/`. This is useful if
     +	The data that follows the keyword `hasremoteurl:` is taken to
     +	be a pattern with standard globbing wildcards and two
     +	additional ones, `**/` and `/**`, that can match multiple
    -+	components. The rest of the config files will be scanned for
    -+	remote URLs, and then if there at least one remote URL that
    -+	matches this pattern, the include condition is met.
    ++	components. The first time this keyword is seen, the rest of
    ++	the config files will be scanned for remote URLs (without
    ++	applying any values). If there exists at least one remote URL
    ++	that matches this pattern, the include condition is met.
     ++
     +Files included by this option (directly or indirectly) are not allowed
     +to contain remote URLs.
    @@ t/t1300-config.sh: test_expect_success '--get and --get-all with --fixed-value'
     +	git -C hasremoteurlTest config --get user.ssm &&
     +	test_must_fail git -C hasremoteurlTest config --get user.no
     +'
    ++
    ++test_expect_success 'includeIf.hasremoteurl forbids remote url in such included files' '
    ++	git init hasremoteurlTest &&
    ++	test_when_finished "rm -rf hasremoteurlTest" &&
    ++
    ++	cat >"$(pwd)"/include-with-url <<-\EOF &&
    ++	[remote "bar"]
    ++		url = bar
    ++	EOF
    ++	cat >>hasremoteurlTest/.git/config <<-EOF &&
    ++	[includeIf "hasremoteurl:foo"]
    ++		path = "$(pwd)/include-with-url"
    ++	EOF
    ++
    ++	# test with any Git command
    ++	test_must_fail git -C hasremoteurlTest status 2>err &&
    ++	grep "fatal: remote URLs cannot be configured in file directly or indirectly included by includeIf.hasremoteurl" err
    ++'
     +
      test_done
-- 
2.34.0.rc2.393.gf8c9666880-goog

