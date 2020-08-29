Return-Path: <SRS0=eCeC=CH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4269C433E2
	for <git@archiver.kernel.org>; Sat, 29 Aug 2020 01:36:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BE97208CA
	for <git@archiver.kernel.org>; Sat, 29 Aug 2020 01:36:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hzCNdF/Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbgH2BgZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Aug 2020 21:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726321AbgH2BgX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Aug 2020 21:36:23 -0400
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79657C061264
        for <git@vger.kernel.org>; Fri, 28 Aug 2020 18:36:23 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id x2so560367vsp.13
        for <git@vger.kernel.org>; Fri, 28 Aug 2020 18:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=kGfu+0cHzfog05BSNBaP1S6ftG+PY809jeBH46YYZwA=;
        b=hzCNdF/YnQ56NDFGD3W2HtximZyW3sId3zWVHyX93Rb/QRB35i//f2xFqqBsvDm2Ub
         VYn3MRyqqBLSQ58tKdaQUm0F5mUR7xLGClcXjb9V5Pee3+LioH3C+abKF9kMC4jIUBdz
         WQIngRF1ds+2eQi7xnN0+eWCeTnhewRBi4YPTSXEX0ql2M4+CnMxWgYjGeEAzLOdxdi3
         zW8qeWpReMHZ0LoElTjyT8F8YoDsVIRvLqe52CEQWvHaO3zKZZLyB0JBqr6sCCi17SmX
         MtnJOyCN90VejEK4K8N588512sttHKpofY5cCyR9aycD2g2+eKfCXk4okeWHtbp6NtuU
         lQ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=kGfu+0cHzfog05BSNBaP1S6ftG+PY809jeBH46YYZwA=;
        b=XkiDqAEo6gqK7gdmQprKePxTvOduIc6jx8BfnMGv+7Bvts1eRuqrBuwyxCJAxArwA5
         YPh4esYlMdlp0ZD43t/DRN5udBqck7klYmY7pppV+YvpZeN2B4ku34pZPTCqvysGwDLq
         R62xDRlFo5n7QE1Lywl0fLh7gCIZa8PoYgjLylzmJ1XjKMoLFgyJ2iiT7k4ww7JQXtj2
         7o8s8bmpwQpSXaYop2pvpWEnmEsa9gt4ircJ8cRerKmUd8aFBYV26vRHo5Pa/DX6EQpg
         D5KOJEAW+cvmHF6Rb8W5m9kwNx8gN8m11vfzVMknj0HpSc0HDNATGUbNDuPDyO1g5VNG
         oXBw==
X-Gm-Message-State: AOAM532vcArpL0+ItsAQO9nuuuHHAd+IbGq8UvUXcrsGmaddA77tenoo
        o4oAFyfbm+S+gfXrEnQocs0pkJxHX/cPNgMiwZgIymb/LtQ=
X-Google-Smtp-Source: ABdhPJzAudRZ0mIvdrrO+S0+XB7xrlmGLQK9bHprME+mcHOAx8Zwal72IgZBD1cCNvo+wlOKNxzsaHQ/WGtpg0RSKIQ=
X-Received: by 2002:a67:f247:: with SMTP id y7mr1015821vsm.95.1598664981729;
 Fri, 28 Aug 2020 18:36:21 -0700 (PDT)
MIME-Version: 1.0
From:   Ivan Baldo <ibaldo@gmail.com>
Date:   Fri, 28 Aug 2020 22:36:10 -0300
Message-ID: <CAEbcw=3mOoYuJo2mQgqB2aJgn-D2i_7ZRmhfPvYNVHD1Kp8wuA@mail.gmail.com>
Subject: Fastest way to set files date and time to latest commit time of each one
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  Hello.
  I know this is not standard usage of git, but I need a way to have
more stable dates and times in the files in order to avoid rsync
checksumming.
  So I found this
https://stackoverflow.com/questions/2179722/checking-out-old-file-with-original-create-modified-timestamps/2179876#2179876
and modified it a bit to run in CentOS 7:

IFS="
"
for FILE in $(git ls-files -z | tr '\0' '\n')
do
    TIME=$(git log --pretty=format:%cd -n 1 --date=iso -- "$FILE")
    touch -c -m -d "$TIME" "$FILE"
done

  Unfortunately it takes ages for a 84k files repo.
  I see the CPU usage is dominated by the git log command.
  I know a way I could use to split the work for all the CPU threads
but anyway, I would like to know if you guys and girls know of a
faster way to do this.
  Also I know of other utilities that store the metadata in Git, but I
am trying to avoid that for the moment.
  Thanks a lot in advance!
  Have a nice day.
P.s.: please Cc replies to me.

-- 
Ivan Baldo - ibaldo@gmail.com - http://ibaldo.codigolibre.net/
Freelance C++/PHP programmer and GNU/Linux systems administrator.
The sky isn't the limit!
