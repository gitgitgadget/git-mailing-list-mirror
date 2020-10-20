Return-Path: <SRS0=RnkD=D3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9675EC433E7
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 01:27:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 395FF22253
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 01:27:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mforney-org.20150623.gappssmtp.com header.i=@mforney-org.20150623.gappssmtp.com header.b="JdpAHHNK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728339AbgJTB1P (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Oct 2020 21:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728247AbgJTB1P (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Oct 2020 21:27:15 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FC87C0613CE
        for <git@vger.kernel.org>; Mon, 19 Oct 2020 18:27:15 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id b69so266930qkg.8
        for <git@vger.kernel.org>; Mon, 19 Oct 2020 18:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mforney-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=1g2CjVSB953GeywOBZC6cGApovfR7c5776KQ3hHNWdw=;
        b=JdpAHHNKVrTWUf2X/DtXfozqJF209kUoBph2E37aTrCFTEgFobdihvqRiqTYtPut/V
         qXn071WDb9FOMgno0jsz4ndiTMJJ0tntvxhGdx73cu8jskyIdDHQl9mmnnIT6PVcZsvQ
         vCvgZUsRyDC+W/61reJTXILM1NVD7ep3PP2KUabVHOghSgPeoiu9uMeum2bEwtrUzjmk
         sts8k/++2e+GAb78LiEGRyCYd9XQDFooJVCxytmd7UKZubyEp8K6nu4On3RAmG+Sf3Ts
         +i9J2otTGW7sfOXiY3fu2gXo9muYuZbAFBB89OjC+kAUwNEBKxcI3AMkoMSacmBccilH
         J/wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=1g2CjVSB953GeywOBZC6cGApovfR7c5776KQ3hHNWdw=;
        b=p7kfx1R+p7pamA2y2h6Yfn9ydgqFiJSZEsnDL+J5ZilpHAievq4TpFVTZ7TbVHqih6
         RwFjxkVdCk4K+6Qa8Ixlc/OVssTnX0U+2gSuwRabUGt1bRAJKjEK05xrQKVlILVKnrHN
         Gu/2/xEZlPszQmWCL2Htyn3goNJoqIRaF0i8pa5IZpY44vUC/0r2b8sJet5pi9Mq1jDo
         zfbZSI2brJvMx2bxJJLmOv0h540qyQsrQgVJabk64UpF/8P26aqAxzd5A5u6q+07J+Ny
         AokDlBJiZeh9jhVhwvBSPtpbA0gPcaS14EfiHuKmLDR5ZiVxmdz2D1qfeoqSPsSOdFBV
         4BFw==
X-Gm-Message-State: AOAM532yRL0c/qnKg8KWvrJcqr2CxuJRtUv4PAgGzuJKUpIDd5SvK/CS
        73YJ0aDBUcQejSbvC13Q5WhEpoR3Dc7a1zM/8HiIhEORwEdDcw==
X-Google-Smtp-Source: ABdhPJxlHSKeOkFtCtaN53WEbc6o2UyuT69c9ABUTO+t9aRT4Vc3ssbkpnVYsnmIZsEHwNzsF72FyJ1kDdKykpM5VEU=
X-Received: by 2002:a05:620a:677:: with SMTP id a23mr495209qkh.428.1603157233973;
 Mon, 19 Oct 2020 18:27:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:5bc1:0:0:0:0:0 with HTTP; Mon, 19 Oct 2020 18:27:13
 -0700 (PDT)
X-Originating-IP: [73.70.188.119]
From:   Michael Forney <mforney@mforney.org>
Date:   Mon, 19 Oct 2020 18:27:13 -0700
Message-ID: <CAGw6cBsEjOnh-ZqXCPfFha=NYEdy7JDddha=UzAau0Z1tBrWKg@mail.gmail.com>
Subject: SKIP_DASHED_BUILT_INS does not install git-*-pack
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I saw that git 2.29.0 introduced a new make variable
SKIP_DASHED_BUILT_INS. However, after testing it out I noticed that it
skips installation of bin/git-receive-pack bin/git-upload-archive and
bin/git-upload-pack as well.

There is a comment that says these commands are special and expected
to be in the bin/ directory in dashed form, so unless I'm missing
something, I believe this is unintended.

This seems to be the offending hunk:
https://github.com/git/git/commit/94de88c986712e79c20813ba54e797c4ca83137b#diff-76ed074a9305c04054cdebb9e9aad2d818052b07091de1f20cad0bbac34ffb52L2979-R2993

Reverting that hunk restores git-receive-pack, git-upload-archive, and
git-upload-pack (and only those).
