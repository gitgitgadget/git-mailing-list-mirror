Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8688C20248
	for <e@80x24.org>; Fri, 19 Apr 2019 18:26:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbfDSS0E (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Apr 2019 14:26:04 -0400
Received: from mail-lj1-f169.google.com ([209.85.208.169]:37674 "EHLO
        mail-lj1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727635AbfDSS0D (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Apr 2019 14:26:03 -0400
Received: by mail-lj1-f169.google.com with SMTP id v13so5329032ljk.4
        for <git@vger.kernel.org>; Fri, 19 Apr 2019 11:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=9QWfXYk5DswTVOpmv1vL9/goOBVswb54XHML52xpTKE=;
        b=B/1pBWljv9jrbKjtfsffzqdA+fX4L2fJLLEu7KUJsDdVS7J0Eyc+JYXbY4DEKtz/SN
         r3F1jZUdKYFbHQ3Va8oHLUVq78GeyNVmVi6EtHWsOywfWq4U2pdP5Bf+Qm2G+pYuInsL
         wHZls3Xo5D411k8QsEPSUfEqdS4LVK2MszQBA9P4ZAZidykxkgSSyPw769SNa6OmTU8B
         /EZ8xFM4ev8HBO+vfw0cfXMG9qja8zCUtMLhR9oNtYW1Wvd6ds/SO0Esf+4Tdg3wJcRV
         ZFxh1LsYWPIz3jDpHJ2h5njmpOzPTpAeW+om+VzsubXlNEzodFOkfpcJkjWsa08SxF3x
         qWjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=9QWfXYk5DswTVOpmv1vL9/goOBVswb54XHML52xpTKE=;
        b=n+JyHt1zfm561od4joEwd4yMChpRKACKAfWedVh/iJaYuQKsibUE8wsTChKPOUWQh+
         zYHPRTDzhHmA4rhbmG7l8y9bwPq8mEuEigPmpl4QDz05gDu6bM8lKIeJdLkCuCLEoUjL
         USH+oiqNrwcUiZu0VaOooMze45HpzANILPrLzqn9aoejGthBmenaGj5ot2E/RE6aaHY1
         FSUkW+kZu/vTiulEsELro0HuaabzvKttnqvK5mIRcRNq24OnB168eWLTqoXJpJrv1sST
         xmKKkbdIoQuT7yRNytEFQfaKjGfMdDlaCMAqZfh1O881vRd49idAVejdzOoZ+fPt2lF8
         2OOw==
X-Gm-Message-State: APjAAAW79o99cAojg0jsqDkiZkmkC2j+MOhZ02n13YS6EyYmxBnt4TUe
        95B0ReljOFLujVs0Kx7DAVCGGI4zSUpIxkAnCXs560Xh
X-Google-Smtp-Source: APXvYqz/Oh+6JqEdqvXBNoizI0CCUylwryJgK2/BJWWZPJBWlmDyzeZhrJvPvGPWvt9vTFHSPHcpkMwZDc4kZmtSans=
X-Received: by 2002:a2e:219:: with SMTP id 25mr3005695ljc.34.1555696665090;
 Fri, 19 Apr 2019 10:57:45 -0700 (PDT)
MIME-Version: 1.0
From:   Phil Hord <phil.hord@gmail.com>
Date:   Fri, 19 Apr 2019 10:57:33 -0700
Message-ID: <CABURp0p6RmwjW4BN4qPv5iBKC_kzZFGyKJxuWw=+pEpjZGtV_A@mail.gmail.com>
Subject: Exposing the states of sequencer, etc.
To:     Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Junio C Hamano via vger.kernel.org" writes:

> > When cherry-picking or reverting a sequence of commits and if the final
> > pick/revert has conflicts and the user uses `git commit` to commit the
> > conflict resolution and does not run `git cherry-pick --continue` then
> > the sequencer state is left behind. This can cause problems later.
> > ...
> I've certainly seen this myself.  Do you use command line prompt
> support to remind you of the operation in progress?  I do, and I
> have a suspicion that it did not help me in this situation by
> ceasing to tell me that I have leftover state files after a manual
> commit of the final step that conflicted and gave control back to
> me.

Is there some place today that we explain the many rules Git uses to
determine the operations in progress?  I once had a patch to do this
in code, but I think I let it die in committee.  It was something
like:

     $ git status --show-progress-state
     cherry-pick, conflicts, untracked

It would be helpful first to have an API for this, of course, though I
think that's where I got mired before.

I'm willing to take it on again, if there's not already some alternative.
