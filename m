Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4082A1FA14
	for <e@80x24.org>; Tue, 11 Apr 2017 08:57:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754057AbdDKI5D (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Apr 2017 04:57:03 -0400
Received: from mail-oi0-f53.google.com ([209.85.218.53]:36252 "EHLO
        mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751047AbdDKI5C (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2017 04:57:02 -0400
Received: by mail-oi0-f53.google.com with SMTP id r203so175781045oib.3
        for <git@vger.kernel.org>; Tue, 11 Apr 2017 01:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=picussecurity.com; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=y+gzTMWQCaKOcTQseX95m3vK9GNfNKAwmPB/gOhkahY=;
        b=jSCLxzRl0YS5kzv/VV/st7AjZC4JHekSO3ISX0FA79J83YV8Uwdfi0kA0iGYmzckXC
         8Sl9d5o1Hvwn3osEFELFf+L3CYZKtrVr05qZ9QDovXwybyvW1HrrE3OAWITK0INYvbMD
         /tQrFJnXSXqqdsVVASOO7FxmGdkP+sfjgC0BM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=y+gzTMWQCaKOcTQseX95m3vK9GNfNKAwmPB/gOhkahY=;
        b=VwT5ZbjwgLRNsOVrofoqDwfGknAyeHr91w8CUD9b6+pgBc+ghZ55dDwmuA3FL4cA3v
         WxHzLxCIot4cN2FB0lEJzRmqQ3U+RaBXyVwBiBuTyuOat5RDz8Vlli288NUQZxx0JrfE
         9j/Su58lTifujH4zB64Z2fSnJwlHU5i2YdLDD6dE/P4PC31lfpXBPbhJq/HTqovcJDC/
         QWHMuxTJDaQABWhs5ZsLqbec//0wEXkIgRQrYOAy8mgSuT9C2wOpTegGBF2B2tEdyuig
         39zclPpuF6aIqp1XUl7mKssG7W2cACObmsR0IvLDZrCO7JINyFmRc4NehgJgT5WCecAG
         Zd9w==
X-Gm-Message-State: AFeK/H0LJRiNvzfX3g+E3FAQQhJlTMQ5kdf67+kC7Ktdy4IRRTLk2X84xim6KtDTYUZtwkc7AjbmyntR35xl9g==
X-Received: by 10.202.173.85 with SMTP id w82mr32040878oie.100.1491901021206;
 Tue, 11 Apr 2017 01:57:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.145.1 with HTTP; Tue, 11 Apr 2017 01:57:00 -0700 (PDT)
From:   =?UTF-8?Q?Enis_Bayramo=C4=9Flu?= <enis@picussecurity.com>
Date:   Tue, 11 Apr 2017 11:57:00 +0300
Message-ID: <CAMLReHYBVmuu5H015N1ShCD0iLNau9oLOabJhQ7xc=58rXQi+Q@mail.gmail.com>
Subject: `git status` output is very misleading after a merge on a "detached HEAD"
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I've encountered a very misleading output from `git status`. Here's a
sequence of events that demonstrates the issue:

$ git --version
git version 2.12.0

$ git checkout origin/master

$ git status
HEAD detached from origin/master
nothing to commit, working directory clean

$ git merge --ff f3515b749be861b57fc70c2341c1234eeb0d5b87

$ git status
HEAD detached from origin/master
nothing to commit, working directory clean

$ git rev-parse origin/master
e1dc1baaadee0f1aef2d5c45d068306025d11f67

$ git rev-parse HEAD
786cb6dd09897e0950a2bdc971f0665a059efd33

I think it's extremely misleading that `git status` simply reports
"HEAD detached from origin/master" while this simply happens to be a
mildly relevant fact about some past state.

Thanks and regards
