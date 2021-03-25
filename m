Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD046C433DB
	for <git@archiver.kernel.org>; Thu, 25 Mar 2021 16:10:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0F3961A0D
	for <git@archiver.kernel.org>; Thu, 25 Mar 2021 16:10:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbhCYQJ6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Mar 2021 12:09:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbhCYQJ1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Mar 2021 12:09:27 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF3F7C06174A
        for <git@vger.kernel.org>; Thu, 25 Mar 2021 09:09:26 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id j18so2870261wra.2
        for <git@vger.kernel.org>; Thu, 25 Mar 2021 09:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+vvcA4dyqsT1gGt5m92vOofakJ+dAgcLJ3EaZP8opzI=;
        b=B29UNgfwe7uGzA0Qq4JLKY/gTVtwj/A02l6gxyevtxF3u6FldC4XGID/BPRtRAdRy1
         kBDaaFgIL/jSUVJk9mZPF73updrD1G1ZuEEwdZSA4EZnZexTPGSzcd+vR++5NVweXW80
         GXrfvTCmZkjg19pu1YYJVJmMP+tL79BBYAd9RDa/PIXF0/xzMSpSGPNIl3LoCdetTXWp
         dD5yf0VN/Byvevn5EO1z0QfNyD23OasXs3aA0rDsrxCEuw4+ZRSvtcOTE7YjuK5M/ppG
         D2qpCkOwpZZC+GAxdsd+6I2cYL5XWtdSPlp9yNKSr+Lu3emvEAlTBV6sPWyjSwZEi526
         ckAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+vvcA4dyqsT1gGt5m92vOofakJ+dAgcLJ3EaZP8opzI=;
        b=H8eH7CvTf/6TG5QVyLabWlxNC42ETdXZ8B+TJnmsBfIUbVnjTptKVgYQP/nFM3T6um
         U2+l+s3mGrXf0qpw0BHZ7AsxvEsw93ZhT0p1afqbGLjSA/Tq3CgFswbp8lN3m2XjdLRj
         QfSZTIWFQ5FxX4ZyPMUXvDRT7gvUgSeu99ldTbM3hmO8U0kXWDquoUd5BS9uVKMcndov
         ZYEsEUWcelDKgYxLjSBcKSVyXtBFPpJtR8YkA0ZwaPmKySq3Dx2YxK9Ii0gvhFnMiguX
         oCgHMngHPVDZTWutuvaEK3sc4beiVa1CDEccMvjwZOIW/zIJa8+7l1b5C6UoC1wlzAT+
         2Fjg==
X-Gm-Message-State: AOAM531hQ73LOjD2Qkg5ER8MjZGNvLSWPGyiJLR7zfE3ag0aI8/D5hWO
        /XX0161IkPahtZ4s7bnGlIw=
X-Google-Smtp-Source: ABdhPJzjA2ZXktcx3EwGj489gWlbMQOc+udWCwX/ndu2e0UEli567ia44slKyNZ9Fe1zrP3I/1vJ4Q==
X-Received: by 2002:a5d:58e8:: with SMTP id f8mr9999259wrd.102.1616688565352;
        Thu, 25 Mar 2021 09:09:25 -0700 (PDT)
Received: from localhost.localdomain ([2a02:85f:2a0a:9300:501f:ca6d:3b18:1e72])
        by smtp.googlemail.com with ESMTPSA id f2sm7164052wmp.20.2021.03.25.09.09.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 09:09:24 -0700 (PDT)
From:   Stavros Ntentos <stdedos@gmail.com>
X-Google-Original-From: Stavros Ntentos <133706+stdedos@users.noreply.github.com>
To:     bagasdotme@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, pclouds@gmail.com,
        peff@peff.net, stdedos+git@gmail.com
Subject: [PATCH v1 1/1] pathspec: warn for a no-glob entry that contains `**`
Date:   Thu, 25 Mar 2021 18:09:21 +0200
Message-Id: <20210325160921.12187-1-133706+stdedos@users.noreply.github.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <af50b7e9-3594-ac46-ed1b-23f3143fe11e@gmail.com>
References: <af50b7e9-3594-ac46-ed1b-23f3143fe11e@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > +	if (strstr(entry, "**")) {
> > +		warning(_("Pathspec provided contains `**`, but no :(glob) magic.\n\tIt will not match 0 or more directories!"));
> > +	}
> Why an extra \t? Unnecessary indentation?

It brings out the warning label:

root@30f6bde171fe:/usr/src/git/t# ../git stash -- **/bar
warning: Pathspec provided contains `**`, but no :(glob) magic.
	It will not match 0 or more directories!
error: pathspec ':(,prefix:2)t/**/bar' did not match any file(s) known to git
Did you forget to 'git add'?

and "makes the user feel" that these two lines are in reality one
(but this is way over any sensible line limit to present as such).

I would've padded exactly, but:
* `\t` expansion is terminal-specific (usually set at 8, but not guaranteed)
* ` `-only would've been too long of a padding to an already long line

Ofc, if someone really wanted to solve this, someone
could rework the `void vreportf` split and auto-pad
prefix at newline, but sounds like a project on its own ...

> > +test_expect_success '** with    :(literal) does not warn of lacking glob magic' '
> Padding with without test above?

Yes; it somewhat aligns individual test output:

root@30f6bde171fe:/usr/src/git/t# ./t6130-pathspec-noglob.sh
...
ok 22 - ** without :(glob) warns of lacking glob magic
ok 23 - ** with    :(literal) does not warn of lacking glob magic
# passed all 23 test(s)

to emphasize they are a positive/negative test pair.

I don't know how well I feel about this anyway; I can undo it.
