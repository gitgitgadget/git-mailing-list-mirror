Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81B5B1F462
	for <e@80x24.org>; Sat, 27 Jul 2019 23:41:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbfG0Xlq (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Jul 2019 19:41:46 -0400
Received: from mail-io1-f41.google.com ([209.85.166.41]:34584 "EHLO
        mail-io1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbfG0Xlq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Jul 2019 19:41:46 -0400
Received: by mail-io1-f41.google.com with SMTP id k8so112360159iot.1
        for <git@vger.kernel.org>; Sat, 27 Jul 2019 16:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=VKmGYrE2UIjM2pOG1eh/Ux/HhiW+++u1LC1XAUmdf70=;
        b=l1zdhG3LOImGEkRDsn9Mu3adO5vq++4A4VWd/YJiLogthjlbVap0Raiqn2SpX4GZiu
         8Q26yRaY+fetcKew6hguPjeMYZvio0sWAjsZIRrhSFnuvIj44JLTwa4hRTbww0sWc6sQ
         ig9z6Zpuq1HaPcFGjWXHvpMmFi+HbWwoQ1pk+saHmrRPx+42Q16G9XJkFrIiRyLKs8k9
         b2g0E6DRnn2CuF1cQuESjV0tvlsn7LqIQb2FPQREx20sdsrMOoiU4dRxav8BIkCjy5gA
         QtJtRw41w8yNTqcpaNT48pgLm4UmyqA26x9Z1LicSehbJ5HldTbwwe8ugMYeFUktxtlZ
         JqgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=VKmGYrE2UIjM2pOG1eh/Ux/HhiW+++u1LC1XAUmdf70=;
        b=XMW/ck/TzpLGOdlraEyfL/cYMAzZemkFxh7jI6aTNp0ozU+DxsrkvcD+KcYCNjxLnj
         jHR2/1zyVoiKrXn84Y9cp5rHwoQgKDwaWNn8cFt927hs63cnlsJb97qtNMqbmFoGfCwD
         3H1uVC36fbAEZxz2PfV2I0xVzui7CB1BYIFurPDxBKsDunVF9IQCaP4027MGCbDgtaSp
         lY2n/WO1+KsGXYmnMBM3Hy/36ySY2mWWT6u8/XgO5YG9886+HbQRrAR3+Ywoea6iNNCt
         QaJx1H1jyztwxe2uiR4cfvEurwCxG4yZmiaviBHFMW9vInvjLFAmmpF/1Bb+tHgbXe2N
         xzgg==
X-Gm-Message-State: APjAAAUaG4Og0p7Do7MJHeDlIlfRBquz9dw5GdRJIx/d0UUgtVRE0Cjy
        6LyoNRw3aDaSn/5/qDKKQBk0E1pyeJ9cNNxfStu5zVmB
X-Google-Smtp-Source: APXvYqz2xOeLQFpb6jAcq6LFMAsmOZFK2Im4ScAG2sjvatqntpVZqcA8s5rqCLTFJrPEu++E2V1EIJTdjbuFzM6bmAE=
X-Received: by 2002:a6b:c90c:: with SMTP id z12mr89700863iof.11.1564270905046;
 Sat, 27 Jul 2019 16:41:45 -0700 (PDT)
MIME-Version: 1.0
From:   ardi <ardillasdelmonte@gmail.com>
Date:   Sun, 28 Jul 2019 01:41:34 +0200
Message-ID: <CA+fZqCXBjA5jsYg7L7X1VhJZXrp9NP+dR1SQWK9fAf9b1jgpCg@mail.gmail.com>
Subject: Settings for minimizing repacking (and keeping 'rsync' happy)
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi!

Some of my Git repositories have mirrors, maintained with 'rsync'. I
want to have some level of repacking, so that the repositories are
efficient, but I also want it to minimize it, so that 'rsync' never
has to perform a big transfer for the repositories.

For example, I think it would be fine if files are repacked just once
in their lifetimes, and then that resulting pack file is never
repacked again. I did read the gc.bigPackThreshold and
gc.autoPackLimit settings, but I don't think they would accomplish
that.

Basically, what I'm describing is the behaviour of not packing files
until the resulting pack would be a given size (say 10MB for example),
and then never repack such ~10MB packs again, ever.

Can this be done with some Git settings? And do you foresee any kind
of serious drawback or potential problem with this kind of behaviour?

Thanks!!

ardi
