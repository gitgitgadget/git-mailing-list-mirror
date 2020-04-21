Return-Path: <SRS0=ToNR=6F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C921C55181
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 10:50:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED6DF2071C
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 10:50:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LS0cr7XB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728637AbgDUKuw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Apr 2020 06:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728616AbgDUKuw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Apr 2020 06:50:52 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9264C061A0F
        for <git@vger.kernel.org>; Tue, 21 Apr 2020 03:50:51 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id w2so9885332edx.4
        for <git@vger.kernel.org>; Tue, 21 Apr 2020 03:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=StF0ltsS+VqsJ9/5/24jK8E1iYdOFRZ3mZS/Fv+q9Bk=;
        b=LS0cr7XBLf9QkKq5DvFFTh6oG6Ezjw4wMh9LbmVC+adsu80/l/k+X3CfvDa+ahKjdf
         EjELu9urtkMx2UbJLBnCVf4tjWclt0fVAmU2UUYyGqKiNNCJsY54t6LnPD6n+kQCgW0D
         FxsTROapdcVu5Nj87SIv92VssTzu7CLFZbq9nDqzR43h+M9fhs53aphhdyy3CvLxaPBM
         9t6rUzrnCNuZpICiERZZHS6SrIvUPksNinHyMjaSxHt5C/IQ8Ut7w/5aLCLJVquEPPpe
         YGFmdWpEqc+fIDOZq8K3Pxow1259mtoXMdi4UgEV+ZnZbhiQdshu09cdMdzAAbIb3VsV
         e08g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=StF0ltsS+VqsJ9/5/24jK8E1iYdOFRZ3mZS/Fv+q9Bk=;
        b=ckzPxwnPLahO64YxtWv6LOkO/8hoCqKcsbKhEMfdIjvXB7K2RS9DlrLhWjHjkn1Ndg
         OgqKrNMjHEGU7wHHC8pBHWVA1921cWL17kss6QZ6fACu8h7LjnlzjAnaWT6vIUJXClnM
         Q+G+l9vngod9WCimmVcZWEsdXVzqHMfGkJmrpFUdTMCD3pda556Yh9FQframEmSZuE16
         GLOQ/arbe04Ag6I6qmS+mqUjuTuuL0u2DhHxu/dxwVAvlvWYYUnu1NgAMynxCvKnMN2s
         kR9mFaOQGb5K/y1kFh6XRjOGp6IC6Q2NA/AN+eHqo93ZxmmBmuLc3m7t0CCG8YRyFUmm
         LcVQ==
X-Gm-Message-State: AGi0PubIVUG0GT2Id9BRZ5xCuxloQjTcAFMuH27033FkZ4LBAQ0CwSfX
        QoXpGuZF3uFsZuwSycn/Cw+205zB7zgX8phogy92JCOy/94=
X-Google-Smtp-Source: APiQypKUJVtpWMg2hKwpL53Xz1qyDE5QW3dxF4A5Eghl3Jb2olGkGYZZP1WgWBL2LS6dsQAlztth5X/iqEjeD3eZbtw=
X-Received: by 2002:aa7:cc88:: with SMTP id p8mr18174671edt.387.1587466250179;
 Tue, 21 Apr 2020 03:50:50 -0700 (PDT)
MIME-Version: 1.0
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 21 Apr 2020 12:50:39 +0200
Message-ID: <CAP8UFD2iR2TOoU-HJvOiQvZhJ+ebxX6zs+KfM-CCFKHSYuwNSg@mail.gmail.com>
Subject: Draft of Git Rev News edition 62
To:     git <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Raymond <esr@thyrsus.com>,
        Edward Thomson <ethomson@edwardthomson.com>,
        =?UTF-8?Q?Jean=2DNo=C3=ABl_AVILA?= <jn.avila@free.fr>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone!

A draft of a new Git Rev News edition is available here:

  https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-62.md

Everyone is welcome to contribute in any section either by editing the
above page on GitHub and sending a pull request, or by commenting on
this GitHub issue:

  https://github.com/git/git.github.io/issues/427

You can also reply to this email.

In general all kinds of contribution, for example proofreading,
suggestions for articles or links, help on the issues in GitHub, and
so on, are very much appreciated.

I tried to cc everyone who appears in this edition, but maybe I missed
some people, sorry about that.

Jakub, Markus, Kaartic and me plan to publish this edition on Thursday
April 23rd in the evening.

Thanks,
Christian.
