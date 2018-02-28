Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 645EB1F404
	for <e@80x24.org>; Wed, 28 Feb 2018 23:30:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965033AbeB1Xab (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Feb 2018 18:30:31 -0500
Received: from mail-yb0-f174.google.com ([209.85.213.174]:46579 "EHLO
        mail-yb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964903AbeB1Xa2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Feb 2018 18:30:28 -0500
Received: by mail-yb0-f174.google.com with SMTP id e142-v6so1497710ybc.13
        for <git@vger.kernel.org>; Wed, 28 Feb 2018 15:30:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=+poClxX04enNDj8wW2RMFPl17URZHSatldIg49K6LAk=;
        b=tydWFAY+Afj2+WP2QG8DJzCbzTaiBm5ijBjugrh8Iv9nrz98VctDTD07y2NACD26+Q
         pq4rGlppu0UOT5nfTHGMvaeusR0U9p+hVnF3yV9vJ7HDLlLcMd9GjM3HZAGjIy1YGR/k
         Tw2QN2pMgnv0gQvKSwFpDDl4hBS75Eh8+azoksINUgHOdoV3F3ZQsYnRPJLsUzwbGqTt
         2Zkd84HeW7+WODzIKkUaD0/0ruhKuR806ctc35hs1B3iwFxgRQdPop3Ozmij3gSPieHL
         rVwGhER2352qWH2y01i06zVpH6CnR/wbvlkC8+aspsjuQ3otNMjdCe8AbVmRmXsTU24A
         DgUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=+poClxX04enNDj8wW2RMFPl17URZHSatldIg49K6LAk=;
        b=q18YUenTDCgzHlFO4csp0QjsJLexoMn63EVbLxoSdzYmaujvgCMPE3NHKSQWQuaxke
         CQ1Uapah8uN/AfNCFlIt08qn1ZSRkQCVA8guLtWfLhC7CpePW8+eTXIKL1JXILUuWDJi
         wbykBpDroY6F6lk+uCBYDYhtGngJquDpgJhwmTI18/vU4NChcmfHB7anDj9U5ym/uApF
         s9LMSsnbxJkwjt//j4mnXmVg80EYTB8VcBeWCYC2AORXadRT//L+JkICZdxzR8cyfqDK
         f+AxQgwDXHXJGB68tD20lJIs7V95IalHe2UlIv8H5gSsWMgBBnngzttb/T1iiS0jaTtL
         L/6g==
X-Gm-Message-State: APf1xPCv+8O2niOa0fgAC8SwfjAuDhYwxKx0z9b5vsCrcqlTOL+XBYiF
        S/cDGJPC/rDVLqtIZwCmU58tbttZL8jP/CrPfRJMDz6wM/A=
X-Google-Smtp-Source: AG47ELueTHjTzrv10NF8hu7C7nJL/DyGlOvgccpmnKOZ4eDQnWkyVknMjrGwe/raisdoLkzpHdFt67gztyHzcIoLTm4=
X-Received: by 2002:a25:7d42:: with SMTP id y63-v6mr13669994ybc.307.1519860627674;
 Wed, 28 Feb 2018 15:30:27 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a25:cfcb:0:0:0:0:0 with HTTP; Wed, 28 Feb 2018 15:30:27
 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 28 Feb 2018 15:30:27 -0800
Message-ID: <CAGZ79ka6PXgs+JDicaQYWYSKgEthj0A-2bBaRcdp_0T2H+sREA@mail.gmail.com>
Subject: The case for two trees in a commit ("How to make rebase less modal")
To:     git <git@vger.kernel.org>
Cc:     Sergey Organov <sorganov@gmail.com>, igor.d.djordjevic@gmail.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

$ git hash-object --stdin -w -t commit <<EOF
tree c70b4a33a0089f15eb3b38092832388d75293e86
parent 105d5b91138ced892765a84e771a061ede8d63b8
author Stefan Beller <sbeller@google.com> 1519859216 -0800
committer Stefan Beller <sbeller@google.com> 1519859216 -0800
tree 5495266479afc9a4bd9560e9feac465ed43fa63a
test commit
EOF
19abfc3bf1c5d782045acf23abdf7eed81e16669
$ git fsck |grep 19abfc3bf1c5d782045acf23abdf7eed81e16669
$

So it is technically possible to create a commit with two tree entries
and fsck is not complaining.

But why would I want to do that?

There are multiple abstraction levels in Git, I think of them as follows:
* data structures / object model
* plumbing
* porcelain commands to manipulate the repo "at small scale", e.g.
create a commit/tag
* porcelain to modify the repo "at larger scale", such as rebase,
cherrypicking, reverting
  involving more than 1 commit.

These large scale operations involving multiple commits however
are all modal in its nature. Before doing anything else, you have to
finish or abort the rebase or you need expert knowledge how to
go otherwise.

During the rebase there might be a hard to resolve conflict, which
you may not want to resolve right now, but defer to later.  Deferring a
conflict is currently impossible, because precisely one tree is recorded.

If we had multiple trees possible in a commit, then all these large scale
operations would stop being modal and you could just record the unresolved
merge conflict instead; to come back later and fix it up later.

I'd be advocating for having multiple trees in a commit
possible locally; it might be a bad idea to publish such trees.

Opinions or other use cases?

Thanks,
Stefan
