Return-Path: <SRS0=cZ0k=DR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3880DC2D0A1
	for <git@archiver.kernel.org>; Sat, 10 Oct 2020 23:10:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0605A2075E
	for <git@archiver.kernel.org>; Sat, 10 Oct 2020 23:10:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BrjaLqy5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731517AbgJJW4Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Oct 2020 18:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731312AbgJJTJY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Oct 2020 15:09:24 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BE66C08E81A
        for <git@vger.kernel.org>; Sat, 10 Oct 2020 09:43:16 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id b69so13865702qkg.8
        for <git@vger.kernel.org>; Sat, 10 Oct 2020 09:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:content-transfer-encoding:subject:message-id:date:to
         :mime-version;
        bh=jVvA3o/wEimEwsZo8Xd9L7IbN1Aq7XOJB7bZJM2bdmE=;
        b=BrjaLqy5TKV95nf/muLVsa0WOw9ZuOi0exCx7q5ABVpkwVgHcLfPCYEwXbMdmkNNfW
         RugAzcp2AK9WZsRUckN5QeNQDp6lhnjAK1DPL+mdL+bt0V/NpO3QKqscrtQFJtCEcojX
         vqr+t7XX6S6mgYQaKMJB3nLLu7JtUHM67owbU3yG3HcKchDJSE4QQl+lJuulCurQl0af
         zE6KITrX3JTmoSNOKfgsSBsmVi0XmYr8gOi3ba7z7IgFMHhfONJ+mCsovJ/x2aiPrJsM
         eD96Uk/1hlMgm55bT/G+EEWUmSsCEAnUW7kQ5NtavsH5VD3KtHe+zkeWarZv+PflOdnA
         X/kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:subject
         :message-id:date:to:mime-version;
        bh=jVvA3o/wEimEwsZo8Xd9L7IbN1Aq7XOJB7bZJM2bdmE=;
        b=KqfvyfGcNYfuEOjtx0Anoo8VFGsArSiZS0FXSH3KWbXk7NRn7TZGdOePsLZ4HxBtKQ
         4hC9VyY2CV3iBVVcBM3qnhen+GhZyaF4PDpOCvjthGn9hTyYYlL7t2Wqbj98iJhly0Dm
         q6RkoXbirHVTy20ELWfynMnSGRIsmbTNl8fgYjCxyZGyIs+FEQCdoWDO+O2/WVWdZIQD
         +2Zi2ztZedT+06ViXqDsKVvfI8VB/OGCmGtpf15NUUP1P0+aIR9f1n8/37A2cjAskd1z
         3BI38oj7f++ALpapAax5o8sRIRa4IWIdlh9L+9x70yz5t2ovGZ0WHnJxjWEaKFWYYz5Q
         qJbw==
X-Gm-Message-State: AOAM530bUBpewVqnScWLC5mG9kmU19Py9yTjsPVP2r8cCLbZvz0+B2/h
        rAI72bKO+bOpR+c2yfLy/toSZ9+xs+Q=
X-Google-Smtp-Source: ABdhPJxZCeq+KAOcEUPbYrHisWxnhZ9cTfHh8RhGgDTW8PJ5z+bAETMerQvGdhw7xAyIleknYYF5rg==
X-Received: by 2002:a37:7f85:: with SMTP id a127mr3074381qkd.257.1602348194976;
        Sat, 10 Oct 2020 09:43:14 -0700 (PDT)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id x91sm3971173qte.69.2020.10.10.09.43.13
        for <git@vger.kernel.org>
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Sat, 10 Oct 2020 09:43:13 -0700 (PDT)
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Subject: [BUG?] After 'git checkout',  files deleted upstream are left in the working directory as untracked
Message-Id: <3D3C5F5D-830E-4EC7-A527-DC595D983BB2@gmail.com>
Date:   Sat, 10 Oct 2020 12:43:10 -0400
To:     Git mailing list <git@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
X-Mailer: Apple Mail (2.3124)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello all,

I've noticed a weird behaviour of 'git checkout' and I don't know if =
it's a bug.

I went back to an old clone which had an old feature branch =
('stale-branch')=20
checkout out, and its working directory and index matching HEAD=20
('git status' is clean).
Then I did `git checkout other-branch`, where 'other branch' is a more=20=

recent feature branch, based on a more recent commit on 'master'.
After the checkout, `git status` reports untracked files. These are =
files that were=20
deleted on 'master' between the commit on which 'stale-branch' was based =
(d9f6f3b619)
and the commit on which 'other-branch' is based (d4a392452e).

The thing is, I can't reproduce it on a fresh clone. If I could, this =
would be a reproducer:

```
$ git clone git@github.com:phil-blain/git.git && cd git
$ git checkout stale-branch
$ git checkout other-branch
$ git status # the following is what is shown in my old clone
On branch other-branch
Untracked files:
  (use "git add <file>..." to include in what will be committed)

	git-legacy-stash
	git-remote-testsvn
	t/helper/test-line-buffer
	t/helper/test-svn-fe

nothing added to commit but untracked files present (use "git add" to =
track)
```

I did not modify or delete any of these 4 files myself, neither in the =
commits=20
on 'stale-branch' or in the commits on 'other-branch'. They were deleted =
by
other feature branches that were merged to 'master' between d9f6f3b619 =
and
d4a392452e.

This is not the first time that I've seen this happen, and I'd like to =
understand
if this is a bug, and why I can't reproduce it on a fresh clone (I'm =
guessing maybe
the index is at play here, but I'm not sure how to diagnose it)...

Thanks and cheers,

Philippe.

