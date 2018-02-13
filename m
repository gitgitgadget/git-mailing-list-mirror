Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB6631F404
	for <e@80x24.org>; Tue, 13 Feb 2018 22:27:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965949AbeBMW1g (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Feb 2018 17:27:36 -0500
Received: from mail-qk0-f180.google.com ([209.85.220.180]:46512 "EHLO
        mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965900AbeBMW1f (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Feb 2018 17:27:35 -0500
Received: by mail-qk0-f180.google.com with SMTP id g129so9845760qkb.13
        for <git@vger.kernel.org>; Tue, 13 Feb 2018 14:27:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gnustavo-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=c1b0V+gsOheO3KXOXNiEW6c6T5Wv1zMQAQkQPc8O2BI=;
        b=fuoK2POmchBHqlV8bJNCW92LGP9D3fOE2ERVGWE2mxdA/WXrUeqLivX8N+Tvd51cSi
         FkaoQp7gzUh4CgLQhLPV1jCVtY6Wtisorzmnfejhivm4JzQJiR5yd0+KFqUTwWAr1q5v
         GO55uOBsOJgqsWf5FWEGDsBLEZHmHAZatxR/qJvXpMfBh6L/glhhIXLKL+k+xNjFJe6Q
         kK2pmXE9db1m43Bk4Ok0IlPjYztC/sAf2zCA7DDvKA/7UW1IliI/xJr1CPAdphAkq74K
         obX4cWB6hNOCjz85NP3Gaae8C68BX5VyyiixQKJAitZE1qvmUdVyF2IDUaDFRa/9pafq
         YcKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=c1b0V+gsOheO3KXOXNiEW6c6T5Wv1zMQAQkQPc8O2BI=;
        b=Jhqy7vK3W9cZhgON+z9LqAPdM1H0cnAq8KDSbwY4UK1dfgVWTDx++AbPCvg1yCE1oc
         vnyoRm1Nq8X0WUi2iSidtbGbKl5K/Hi2uc4a0F+BkFjbIJUd23LwIUkk8nsQS6/wvrf/
         Ajnk4RkL6JJRC32SK9eKbAKhpAqiRBfBQ6EvMjmXUd6YiS7xZaPyKWAM3sB5cakxll4E
         DgeWfP2MGgMvMfZAtAcn2HfifRMsnelzBFUpfCixT38i1nqkVpmcNiQJh4OIi5W+ecAN
         /isbow11inu10P1L0ob0mt2q7vVevGoxhSV5fBPOp3WRaFKjG38E5t7hoauZrJB7MX98
         8+6Q==
X-Gm-Message-State: APf1xPAlSariwmH8AGYIdPPM6A0U5lHkmkRY8RQwLcqDdrFapTOsv78/
        JIkYCE68def8YIjQeaL6p21AFsCjDJ7jXzYQFoOx9kuuaEI=
X-Google-Smtp-Source: AH8x225FItFdNnh02ClizRVUDovC4strigtvpQZUlAB9Aspy7l1lcQYAJ3kuviHtlF/qTcXoM6XoSq4a8Sz6G45Io5Y=
X-Received: by 10.55.24.34 with SMTP id j34mr4165266qkh.294.1518560854267;
 Tue, 13 Feb 2018 14:27:34 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.107.230 with HTTP; Tue, 13 Feb 2018 14:27:13 -0800 (PST)
From:   Gustavo Chaves <gustavo@gnustavo.com>
Date:   Tue, 13 Feb 2018 20:27:13 -0200
Message-ID: <CAPx58qqv84+i0JbdsVzFqWB=bRDecWHxss8frD4=nWOsFj-NPg@mail.gmail.com>
Subject: Why git-revert doesn't invoke the pre-commit and the commit-msg hooks?
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Using strace I noticed that git-revert invokes only two hooks:
- prepare-commit-msg
- post-commit

But git-commit invoke these four:
- pre-commit
- prepare-commit-msg
- commit-msg
- post-commit

Since git-revert produces a commit, why doesn't it invoke the same
hooks as git-commit?

I couldn't find any discussing about this in the list or elsewhere. So
I'm asking here.

I ended up researching this when I was implementing a hook to detect
and deny commits which revert merge-commits, since they are
troublesome (https://www.kernel.org/pub/software/scm/git/docs/howto/revert-a-faulty-merge.html).
I tried to implement it as a commit-msg hook to search for the string
"This reverts commit SHA-1" in the commit message. But git-revert
doesn't invoke the commit-msg hook.

So, for now I implemented my check as a pre-receive hook. But I find
it useful to have all pre-receive checks implemented also as a
pre-commit or a commit-msg hook so that I can detect problems at
commit time instead of only at push time.

-- 
Gustavo Chaves
