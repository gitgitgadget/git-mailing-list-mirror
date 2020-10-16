Return-Path: <SRS0=w+PN=DX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_05,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B032C433DF
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 18:16:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0517208E4
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 18:16:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K1D0t9su"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391429AbgJPSQd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Oct 2020 14:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390946AbgJPSQd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Oct 2020 14:16:33 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C5BCC061755
        for <git@vger.kernel.org>; Fri, 16 Oct 2020 11:16:33 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id x16so3498173ljh.2
        for <git@vger.kernel.org>; Fri, 16 Oct 2020 11:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=KgFnDHwGPPEHZVMp4r4GHMzvmh5rNRpPf7DAcEEros8=;
        b=K1D0t9su++S2Xw2lBLvwbGxvDtbsedQgdldnIZHvuzK81SDjaRuZ/DdkmsCwK2I72c
         qvt4PXSbUbNaEztIWXZlIPli4jvKnrIGtZilaZD0Imqx4iqAn4veodmUpj7s24Yr4zLr
         8MtlSjwy7QIgNnHvFKyH7Ze467rpD4vWHGF80HKJxKV7YVm+Jw63/jXaXz7mWAAj06tD
         mZZmHq7PRsdG+mMcojml+VsjcD9QurWhh99SovO1HmBuFtyWJKxoe72eTPlXdO1L5XN8
         IMC6cNruNK0yZiZZMDrpbC7mbm0aYZipBfza0Lq7p4xOPZFf1SL64vuRpkW40YnDa/gj
         Cihg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=KgFnDHwGPPEHZVMp4r4GHMzvmh5rNRpPf7DAcEEros8=;
        b=YxPjvesrd/l7NOz1zlHZnR2/RWeHorCXoOdUAOjS83s7TETzkktY90jxeaFWC4Z1Sx
         qrv7aHwIMEbSNRtHZHThl5Z6TQgzjzEkFiulYBpG+TfxolYJi7Wp9eMlns66o5BCBnJw
         +cyvrpuGRBIetdTHbpkHd97Ra5yda2BxXbLcDS8m8HqC450ZXb74Rg0X93jXaHtiszO/
         1ksKzAxzbQSIckTZkXX8nPhYVWU3FywH1fYJMYAa3UCTYUSuyZfdoC5KbbKcCC8P49yG
         gnbiXqhRQATEdnFe1WHpJZjRqWPAoBFitKhJoG0EjwQGFsOTRW7Pp64MXa3esa2df7AV
         oJsg==
X-Gm-Message-State: AOAM533WvSzoWb3Ijc5PNO1b+wrFIeUojA68YHykKq2qa32CrLgJzw7G
        eD/f7kHSj8f3rhX/aU/6oDPqtPFGSCv4qb82k41IuyPHz6s=
X-Google-Smtp-Source: ABdhPJzpQDksKhMEa9BTM95MEnfryvorH5s37thtklihy3skSEZMELy0eF6i7T6pZgKKgZS8gqVxSxBcf7qV4Fz72Ls=
X-Received: by 2002:a2e:3112:: with SMTP id x18mr2226090ljx.149.1602872189424;
 Fri, 16 Oct 2020 11:16:29 -0700 (PDT)
MIME-Version: 1.0
From:   Caleb Tillman <caleb.tillman@gmail.com>
Date:   Fri, 16 Oct 2020 13:15:53 -0500
Message-ID: <CAES5DXRFu7yaM3TggA7p9Yot-E2O1SmpmT+B6ddZmHgRmCmuNw@mail.gmail.com>
Subject: [New, Outreachy] Introduction
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I am an Outreachy applicant interested in open source development. I
have started reading through docs for this project, and noticed that
many of the tests in t/ that are marked as expected to succeed are
failing.  Is this normal and to be expected, or is there I chance I
messed something up in the build phase.

Also, for my microproject I was considering replacing some of the
calls to 'test' in t/ with their debug-friendly helper functions.
There seem to still be a lot of files that would qualify. Is this
particular microproject still desired?

Thanks ahead of time for your help.

Caleb Tillman
