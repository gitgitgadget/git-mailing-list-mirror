Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECB1EC433F5
	for <git@archiver.kernel.org>; Mon, 11 Oct 2021 21:36:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C594560238
	for <git@archiver.kernel.org>; Mon, 11 Oct 2021 21:36:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235332AbhJKVi0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Oct 2021 17:38:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235301AbhJKViZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Oct 2021 17:38:25 -0400
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26C29C061570
        for <git@vger.kernel.org>; Mon, 11 Oct 2021 14:36:25 -0700 (PDT)
Received: by mail-ua1-x929.google.com with SMTP id e7so15370008ual.11
        for <git@vger.kernel.org>; Mon, 11 Oct 2021 14:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nianticlabs.com; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=dvmMH0ijtAnXgiicFySex++1nnV8npzYQEDv5lYjr+g=;
        b=U2x0NxKcH+usx+ga5oyxFSlSJk+GlcvvfqF8Wi9wLJ3zHsoCj2ZqRppDu8arUERqeH
         sACQgd/GMESZue7OF7kKKByab8aOkj8Tmuck7L0QLLrUhgHCoLepa1CVwM7H4Y9n3rmc
         zFpcB2BETWhf4Om+0R7VXXGx0eMBr8gNBYfQg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=dvmMH0ijtAnXgiicFySex++1nnV8npzYQEDv5lYjr+g=;
        b=R0Rpq/Tx6fjv/TSbJ/ngEoify13s/5ppzcR8KUmzMWgfgJ9XD+xrBZ23nrgSwHUzhj
         7ImOui2Vx26keaTdymBos/4o6H3Opv67pNmhjW5Bja9e0SzN7AmxnUGrS0Eces+J1Ojj
         EKyWQRoow18FUev1CLIZMdQV4fvulnN2wDQTBmpuxVG8MItTU7obZabk8cK0evqIB0/4
         CvM1WErnEoEgdBr71O4BMWO9AGZFPKA6nTf7OdQrx1OIqoi7Z+b7+c5fE7DnZt/PHMgD
         nYbI+rLg6zSXADLA/w03fUz4KfjT3QWMImm7MqYPWjy8Kt//sogT8aTNM3NzmXz40APE
         vasA==
X-Gm-Message-State: AOAM531sbP0wWLRaUPTZ0IFBe3SFL/E7Xxg3AdcOUcnwg3cjiJ5ZQtV+
        anFdPuKNnIN8UOEvWBDr07SizcvP+N8ktAJjWNZNRozCBNNS8g==
X-Google-Smtp-Source: ABdhPJw43yfoGUNygxih61ryyxEpEOlP88rp5dGxtgth+lVINr7EA9DJG220tjKnJooCAkub2OberTm7K/K8J74V3dc=
X-Received: by 2002:a67:a247:: with SMTP id t7mr9079689vsh.46.1633988184006;
 Mon, 11 Oct 2021 14:36:24 -0700 (PDT)
MIME-Version: 1.0
From:   Chris Chow <cchow@nianticlabs.com>
Date:   Mon, 11 Oct 2021 14:36:13 -0700
Message-ID: <CAH4DS54U-qN+NY2A50bBawbL1cwD74fdaZdQKdhXyZSzFS-Y+g@mail.gmail.com>
Subject: Inconsistency in git credential helper docs
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

There appears to be a small inconsistency / bug in the documentation
located at https://git-scm.com/docs/gitcredentials.

Under the "Custom Helpers" subhead, there's a line that reads
> Generally speaking, rule (3) above is the simplest for users to specify. =
Authors of credential helpers should make an effort to assist their users b=
y naming their program "git-credential-$NAME", and putting it in the $PATH =
or $GIT_EXEC_PATH during installation, which will allow a user to enable it=
 with git config credential.helper $NAME.

Earlier in the document, under "Configuration Options > helper", there
is a line that reads
> The name of an external credential helper, and any associated options. If=
 the helper name is not an absolute path, then the string git credential- i=
s prepended

I think the latter text is correct. The maintainers of the google
cloud SDK followed the advice in the first part, naming their cred
helper `git-credential-gcloud.sh`, which is not accessible if you set
the custom credential helper to `gcloud.sh`. I had to make a symlink
at `credential-gcloud.sh`, following the instructions in the latter
block, to make it work. One could of course just specify the full path
in .gitconfig, but I figured it might be good to have these parts be
consistent anyways.

Best,
Chris
