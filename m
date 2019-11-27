Return-Path: <SRS0=iCZD=ZT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF0C2C432C0
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 02:09:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B22E120684
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 02:09:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MruWP6k0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbfK0CJN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Nov 2019 21:09:13 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41775 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbfK0CJM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Nov 2019 21:09:12 -0500
Received: by mail-pg1-f193.google.com with SMTP id 207so9974094pge.8
        for <git@vger.kernel.org>; Tue, 26 Nov 2019 18:09:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oOoX5+F+n/p862LXarg/cm3p2Xl9lmVgk4POwx5Fcno=;
        b=MruWP6k0wxx7Z3nUDGGuei7KAyutisKM8VhsRYqC8dTG+gmH8sysd8QGjg+pIz7jgh
         j5v6oWp7r+4tuAVmH8zSDE5Do8x5kF1XKeqZfn14mu1W4eew3nJng7N4V5SuKA4bsFkK
         6ZDV8rTzvsrq6IYCpmVglmVtoI1cUOkjSE8BXlrimPoomBEnDUB7cP3BqbxUAiUeXlr2
         EaxOU1JYUfla0MnpDwo+f6XFFiPfbvXd2B02/D7ts5lIHhFSLo4HnFZ6FBPMnGzyiZlR
         dD3VIAJXfjO1raRVai/EAXIZZP7kJ/gW0ZlnuxASXeieSQx/W/GBsbj/0xxG2LQ07na8
         yR0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oOoX5+F+n/p862LXarg/cm3p2Xl9lmVgk4POwx5Fcno=;
        b=PCJyEWL9KOC7xEQRPtt+YXbvVOQGm0kl8K6FpZZ161XRA6x/h6gpj72DI/QhTPwpY0
         XNwy/6PHSWqqwEteOyD+v0Q4FpyPnoNVWguUt/84m92E4v//uHvh7UQ9okCak+/+UIUP
         P8vMvs7nHwHHkgfLVYbebK+e5Z60Zvgx3EV4JpOFDcxVyLjBufVAnToGgQXG+dSySHIA
         KMOOvApVghtKvsPDJifsuseBj8lJhST94g0s/nApuBAYeF89CNUKClVQJyOPBxEskAEM
         9dILDXYTFIbk1TLxgfczxi8i7Rh/qQE915jRHQYAWM1HNrjQvj842A62TgOstBlJsRll
         iKtw==
X-Gm-Message-State: APjAAAVmAD2RtfjIz8pdTzmjeo/G6zHzf8jo3uNkwcegyd0NmRUM/tWV
        BBC4AxmGzW0deuHttJOkyyyveS6g
X-Google-Smtp-Source: APXvYqxUe59CVfv+RTR92+9+HQaaJos+cl64X+w3KdI/NCPS3Xgm0X+HuDDNUNhzWUjTTgdL1EgbwQ==
X-Received: by 2002:a65:62cc:: with SMTP id m12mr1797644pgv.397.1574820551604;
        Tue, 26 Nov 2019 18:09:11 -0800 (PST)
Received: from generichostname ([204.14.239.138])
        by smtp.gmail.com with ESMTPSA id h9sm1404034pfo.139.2019.11.26.18.09.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2019 18:09:10 -0800 (PST)
Date:   Tue, 26 Nov 2019 18:09:07 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Christian Biesinger <cbiesinger@google.com>
Subject: [PATCH 0/5] rebase: fix breakage with `format.useAutoBase`
Message-ID: <cover.1574820308.git.liu.denton@gmail.com>
References: <CAPTJ0XEcMJEwPBEL4akncJ_A5XwyQyKL95fpf2tC0rNXJK65Og@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPTJ0XEcMJEwPBEL4akncJ_A5XwyQyKL95fpf2tC0rNXJK65Og@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for reporting the breakage, Christian.

Apparently, this use case has been broken for a long time... Since
bb52995f3e (format-patch: introduce format.useAutoBase configuration,
2016-04-26). I'm surprised it's only been reported now.

This patchset fixes the breakage by teaching
`git format-patch --no-base` and making rebase use it.

Denton Liu (5):
  t3400: demonstrate failure with format.useAutoBase
  format-patch: fix indentation
  t4014: use `test_config`
  format-patch: teach --no-base
  rebase: fix `format.useAutoBase` breakage

 Documentation/git-format-patch.txt |  5 +++--
 builtin/log.c                      | 26 ++++++++++++++++++++++----
 builtin/rebase.c                   |  3 ++-
 t/t3400-rebase.sh                  |  6 ++++++
 t/t4014-format-patch.sh            | 14 +++++++++-----
 5 files changed, 42 insertions(+), 12 deletions(-)

-- 
2.24.0.504.g3cd56eb17d

