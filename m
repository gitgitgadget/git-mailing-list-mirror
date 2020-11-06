Return-Path: <SRS0=eTRQ=EM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ED35C2D0A3
	for <git@archiver.kernel.org>; Fri,  6 Nov 2020 22:42:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EED520720
	for <git@archiver.kernel.org>; Fri,  6 Nov 2020 22:42:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QKXalpc5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728833AbgKFWms (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Nov 2020 17:42:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728358AbgKFWmr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Nov 2020 17:42:47 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 728E1C0613CF
        for <git@vger.kernel.org>; Fri,  6 Nov 2020 14:42:47 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id n63so1965287qte.4
        for <git@vger.kernel.org>; Fri, 06 Nov 2020 14:42:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:content-transfer-encoding:subject:message-id:date:to
         :mime-version;
        bh=eiPjHqGGU7XWb5NN4RfuL929DntMJK2uoiGzdUt4+40=;
        b=QKXalpc5OaaRgqrqiZf33P407YthfO0dvGoOTlXHByyOiwNbsdstGL/IDZu1kFg09L
         2Rz2lH3B9J/HJBO0HFM8dftSzopo28WpjPmFBqHTNltdwyVnlVmk7Y9vu1HZ9vYO4q3/
         IoQqwmGcRJlktCmUeRwvo2IQPMGS3B93jgZIZ5D/2RKwJtk6FxPeXFKhDzsRBR/Bsk8U
         JItFI8uwGMxGF2BiZm1vG5P7kjfdiHfid3Ch20zuR7+UFs10ZYqQXirX2KNdoYSQQten
         gCBs+GEcMJVjcJhDzfkBJR8AOlfUGFzlm7c9uKampbFALnX0/r2ToWMMzqDFuV3uFfCs
         teOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:subject
         :message-id:date:to:mime-version;
        bh=eiPjHqGGU7XWb5NN4RfuL929DntMJK2uoiGzdUt4+40=;
        b=Od8pWOKGQcNx2rvKGLxO0L9xOJ2E7xZuVChQrSwlWPsgIVntHk3Sbn0JkhPtfm4O1O
         TlojQvI8+jOFVmlq2xLxi/yCcIu/4V1rIyIeowU/HVgpQUh8WSoR7xwW+s9LmB4bdZJT
         EUc/wRuqKWkIm9Hb8TZWbdYgta78lsuMaTi/DHfbiZQ/83pN64AFxzmMlm9kmbc4L9Km
         uYkPDRKdyJCrzK52K1or/5P3yV56esa8gICUXBVpa4rnZilJePI2GCzrbVu1Agqjb26o
         PK97MhI66/WkZP9l24QqKrLG5waSLxtjAU2lsMV/jBKZ3nDXEW269bGoHaKhSN4AMh65
         Byxw==
X-Gm-Message-State: AOAM532669T57NT4HAQvR4FiRm7h1kzR9xqL86MewFrklwHodFX90kTf
        uVMtujTKvHJrPwbgIFOMFEFHF5csEjE=
X-Google-Smtp-Source: ABdhPJyx90lPOnnfq6PbKXAWm2HW81nn10QaPwxFu+i3OBS9gCANB0CPqN2/Jx7PGwQv+EpwqbI4BQ==
X-Received: by 2002:ac8:615c:: with SMTP id d28mr3815152qtm.104.1604702565911;
        Fri, 06 Nov 2020 14:42:45 -0800 (PST)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id t60sm1433618qtd.65.2020.11.06.14.42.45
        for <git@vger.kernel.org>
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Fri, 06 Nov 2020 14:42:45 -0800 (PST)
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Subject: Completion for aliases that wrap aliases that wrap Git commands
Message-Id: <9717A684-9304-4A65-8566-19F946098455@gmail.com>
Date:   Fri, 6 Nov 2020 17:42:43 -0500
To:     Git mailing list <git@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
X-Mailer: Apple Mail (2.3124)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello all,

I've noticed the following: I have a Git alias that is simply a Git =
command=20
with some options, like

$ git config --get alias.logo
log --abbrev-commit --decorate --format=3Dformat:'%C(yellow =
bold)%h%C(reset) %C(normal)%s%C(reset) %C(dim white)%an%C(reset) %C(dim =
blue)(%ad)%C(reset) %C(auto)%d%C(reset)'

And another alias that is this previous alias with more options:

$ git config --get alias.lg
logo --first-parent

When typing 'git logo up[TAB][TAB]', the Bash completion script
suggests 'upstream' (like if I type 'git log up[TAB][TAB]'),
but typing 'git lg up[TAB][TAB]' does not suggest anything.

So I'm thinking there is some special logic in the completion script =
that makes it=20
work for simple aliases but not for recursive aliases.

I know nothing about Bash completions, but I'm wondering if that feature =
would
be possible at all ?

This is on Bash 4.4.19(1) (not that I think it matters very much...)

Cheers,

Philippe.=
