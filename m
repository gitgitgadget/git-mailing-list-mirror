Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A755C433EF
	for <git@archiver.kernel.org>; Tue, 30 Nov 2021 13:25:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240089AbhK3N2T (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Nov 2021 08:28:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232336AbhK3N2O (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Nov 2021 08:28:14 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F44C061574
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 05:24:55 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id e3so86754805edu.4
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 05:24:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:user-agent:message-id:mime-version;
        bh=15hizer7m1uK+GwK66V8nLD5+qgBRWxnaPGEMNs88+8=;
        b=P/7YEum4+qf6gzLGyscbgTLiislbm2aK860f4NJ1+UQNVZCIwvQUVV0j368ik3XVcw
         LdIKa5t+fukkezeETfQVOkvlvphAtqkBwK/rlOIYLRnI+gm6G31+1d9bzyF3zFmgnlXh
         eMhXBgACX8cEV/3p6sqbX+N5qwUbqLusr1b6zy/d8WTvymSNO3pjzdjC896NF4Kdo+TH
         PjnV+HAp0TdL7JEzn9pBeJ5fCbnuPPolLZj8PeWbTJB4NzklXMG7aTMkMy/tlPIDoEtP
         sez2TdcxwR+zd+b3bfPns+8NI7hbzk2ZZkXKDnjiwQys5XwJ95OlyOO6V6YDg5PJZlsX
         N1kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:user-agent:message-id
         :mime-version;
        bh=15hizer7m1uK+GwK66V8nLD5+qgBRWxnaPGEMNs88+8=;
        b=CZIKtPVrmm9WUF4rUaPZZXxgdZTlDvJkeMC4iVSqzNozxienzG5FwePZ6Fv5JRry+s
         MpDd/mRP87Xy+6O5XhE/wS7hXaeMg1XTf4PKFwJpgeJQE+diDtYxSSrFWqkXBjde74bC
         Ihn7oBJK5FyvDXFB+9e75aIgJSF5Mm04+gKm3Zk5oO0WZSCzwq/WAuOBQsNN2VjPLWaw
         CQTY/UjwQQXwfznxBKDbIT1uLkW9VdKQdgqKJb9s+0JiJKIkVaMJnyU2QrUn751AUnG5
         YpP4tvQs9QUdZ+dzkstQL7Q+vPfhnujVxipfDO+qghyS8yB1EfJ3YyeKx35LQ+ZscVer
         dzbA==
X-Gm-Message-State: AOAM532SJ1yhuLz8sOUPMDcScxk0gtqavkodQ6zhPFYEYbtxtgKx+e3n
        kUc44YS1y3hm2v8MWqXCdZU=
X-Google-Smtp-Source: ABdhPJxnw4whtIns/fVBSuAqNv/Orf5WjiAyol+If5MnMccvuxPJLQWT7CCgKBEaGU/8f+8sr+8/gQ==
X-Received: by 2002:a17:907:3e1d:: with SMTP id hp29mr68003813ejc.70.1638278693583;
        Tue, 30 Nov 2021 05:24:53 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id b14sm11369781edw.6.2021.11.30.05.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 05:24:53 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1ms37s-000zye-K1;
        Tue, 30 Nov 2021 14:24:52 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     "Git ML" <git@vger.kernel.org>, Jeff King <peff@peff.net>
Subject: Will -fsyntax-only hide issues with -pedantic? I think not...
Date:   Tue, 30 Nov 2021 14:13:11 +0100
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
Message-ID: <211130.86ilw9epy3.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The answer to $subject is not at all urgent, but I noticed we can get
some (very modest) speed increases in the "pedantic" CI job when adding
-fsyntax-only to CFLAGS. This currently requires monkeypatching out the
"-o <target> -c" part hardcoded in the Makefile. See cebead1ebfb (ci:
run a pedantic build as part of the GitHub workflow, 2021-08-08) for the
pedantic job.

I.e. I'm aware of CFLAGS's -O<n> changing which warings we emit, but
does -fsyntax-only?

The gcc manpage suggests that it would, saying:

    Check the code for syntax errors, but don't do anything beyond that

Whereas clang's says:

    Run the preprocessor, parser and type checking stages. 

I think gcc's is a case of its docs drifting out of sync with the
implementation. Both will warn on e.g. this program under -pedantic,
which gcc wouldn't be doing if it only did syntax parsing (and didn't
run the warning machinery):
    
    int main(void)
    {
            int v[0];
            return 0;
    }

I don't have any practical use for this now. We could squeeze some
slight performance out of one CI jobs, but perhaps it'll be more
interesting in the future.
