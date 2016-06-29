Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9BD7D1FE4E
	for <e@80x24.org>; Wed, 29 Jun 2016 11:48:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752082AbcF2Lsf (ORCPT <rfc822;e@80x24.org>);
	Wed, 29 Jun 2016 07:48:35 -0400
Received: from mail-io0-f169.google.com ([209.85.223.169]:36328 "EHLO
	mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751993AbcF2Lsf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jun 2016 07:48:35 -0400
Received: by mail-io0-f169.google.com with SMTP id s63so43150111ioi.3
        for <git@vger.kernel.org>; Wed, 29 Jun 2016 04:48:34 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=archlinux-us.20150623.gappssmtp.com; s=20150623;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=ro9GMo6s/Hze6v23zvOs/W6a7rpiodYGqn2aBABfVJk=;
        b=cT1Nanm1qL0OXpwfrYQFGQiYZnHNlnIAs9Z6Jr7uAkYGKSMC3hraa6h4Q/H+JOuhWo
         nN6wjneFkNdbtzIZ3+IHnC+XPsxOmyZKCYGpiJGtPLeA6+HgLHL6bI0NJFBpnnAqPUKS
         HVru/34kZ/GaFbbbHVM8zYyIjMG2JYMCCLEf8wHw1U7gcpf2wPWPMRhsakxKS51H3Kxz
         tsJVQO85RUgawY7ao5XqcBNljlD8qX64fLe8BkHNUYSzWHrXt20dbEL4AgvmHPGkNmbt
         qKY8DA//LUfGvnRuhSPOhJ5Ako12cQ3lcjfaIGkwK4xlt1HCDbPCHzBv6c/ie27zoTM3
         YZDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=ro9GMo6s/Hze6v23zvOs/W6a7rpiodYGqn2aBABfVJk=;
        b=dUS7nmMiWIkAPHPjZ4nKDU1nLk6yKvLO3j/sNpTIKaOxD+w84iAyTW6moOsbhojKzR
         IGn5bxAuuFk30e/AWalfXjc4dDr8G1nRlNfaGjVFnEtz4hZn+AKtABTYhydOKNpRMd7S
         n2T7HOmDnS7XdzKXVnCXOTPUEod54xl0JAKE7SYPvVLHfNTaeP8hEfS5jUNDkM4p3ec8
         hPWiiVWadzT9V7XJuUWV/U8Jzppu6wni5EIKpbQeD3spMEUCPhzP4xpuiA6cxaZuLat/
         7/V9Mpbw5UyjcgfyVHiTjY/kgbUrOzf3ENjvaePlhIHwqEnQayyG4i3lzysxZtM7JDq0
         p2YA==
X-Gm-Message-State: ALyK8tKTn49dtIPXPZy2n3YnQMQvhyg6Rqant+yfEkgZlpvyIsxYJxs6lMSOKfkKT46jTLd1Fj1r63mE9lA+8A==
X-Received: by 10.107.8.26 with SMTP id 26mr8499466ioi.85.1467200914317; Wed,
 29 Jun 2016 04:48:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.137.14 with HTTP; Wed, 29 Jun 2016 04:48:33 -0700 (PDT)
From:	Laszlo Papp <lpapp@kde.org>
Date:	Wed, 29 Jun 2016 12:48:33 +0100
X-Google-Sender-Auth: J4yUq8HZ0I7FNeRUk9WGiF-2k3Y
Message-ID: <CAOMwXhNp9SwA_oQ8bE6-m72C+po+28maGtsP8wRFRfBLjSb5NA@mail.gmail.com>
Subject: git tag --contains for cherry-picks
To:	Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Dear List,

We have several release branches as well as a master branch where the
active development happens.

Old releases are maintained with important bug fixes or even new features
in our case. It sometimes means that we need to cherry-pick commits across
branches, like from master to a specific release branch.

Cherry-picking changes the hash of the commit, therefore, this may no
longer work for cherry-picks:

git tag --contains

I am thinking of having something like:

git tag --contains-follow

which would follow cherry-picks. I am not sure how easily and/or
efficiently this can be implemented, but my gut feeling is that in the vast
majority of the cases, the content check would bail out already at the
"subject line".

Again, just to recap: I would like to be able to list of releases (i.e.
tags) in which a commit occurs even if it is cherry-picked because what
matters for us in the end of the day is whether the feature or bugfix goes
into a release.

Best Regards,
Laszlo Papp
