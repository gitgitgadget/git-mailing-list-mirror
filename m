Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F2C8E1FC96
	for <e@80x24.org>; Tue, 29 Nov 2016 19:40:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756103AbcK2TkM (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Nov 2016 14:40:12 -0500
Received: from mail-yw0-f177.google.com ([209.85.161.177]:35451 "EHLO
        mail-yw0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752526AbcK2TkL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Nov 2016 14:40:11 -0500
Received: by mail-yw0-f177.google.com with SMTP id i145so144499418ywg.2
        for <git@vger.kernel.org>; Tue, 29 Nov 2016 11:40:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=barzilay-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=1oNfgcIjL3K7Lc4rPib4Rg5DBJaQCoZT7KsGYg9EHYY=;
        b=J2ryO6WCMyYo4Na3tRH0K1di+dAjuFdXTsiMUo4PR3JX6+8Yn0zKkt8u7dq5L1gPhR
         DajwDtwBa5hkYwjV5mgyTNOH5fY1v4+4CzpmsmanCe1oEGbye9s18+p1HxwfjqfqQ2Q7
         prOGxfSjB03WYKLfCCdiZzVi37tsFkauJXRfrBJYQwn+Xmb/GxZXJjX2O859blGg6dyg
         udexm7NBm6WqRFfNPbL63eIckqwyraNUB82MeQaA6bRSPzoDq3z/JbOszUHlDZlNpdTD
         qjlzAUcxAQSwFtEZ1qJONJ0YU6KETRl0cSOBTc78RkHdJuZ9cTeeZKERLkOSqKv7xcxI
         KRNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=1oNfgcIjL3K7Lc4rPib4Rg5DBJaQCoZT7KsGYg9EHYY=;
        b=OurX9Tjwth2qH4mU6CrDXqg/QSUpiQv8ttOrxPWAukNvuHKtiLDRsY4kDeZNrRdA+r
         JMCQMWbeAEgpoYF4+oNR5ypIdiLTAvuDDsEHPxnuczmkygCQCxkJidyavsZw6KTI8HSA
         5Ib4GnzcU4C3olKIHjZnD9ldk6fFRLitHfSpI/RIiiO2McIQBft+w2D5sQzqN2A6u+V4
         jxviqEdCbHujk7dlaB9fPOomombB+RgStWJEMlWv1d/ZxaNOpyfmLStjwCDlP30AnWHV
         cY4johRCRMo8QmMBhC3+PaaGXfLK8XTiUMfOzoWmdz7xjywEO3B6tBpVTvYl1GMU22NR
         uYtw==
X-Gm-Message-State: AKaTC03LoXBhvBqBySGToMuWSFs8JLul+p+xuTl45SI9Vglib0c+4XsezCcOuemnp4YA/Q8KBCx9SlD6MHQzQQ==
X-Received: by 10.129.113.84 with SMTP id m81mr36394618ywc.223.1480448410033;
 Tue, 29 Nov 2016 11:40:10 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.98.77 with HTTP; Tue, 29 Nov 2016 11:40:09 -0800 (PST)
From:   Eli Barzilay <eli@barzilay.org>
Date:   Tue, 29 Nov 2016 14:40:09 -0500
Message-ID: <CALO-gutW80d6RLdXAtYA2m2GWOchAjNNPy3YCsr31_fCss512g@mail.gmail.com>
Subject: gitconfig includes
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I just noticed something weird: if I have this in my ~/.gitconfig:

    [x]
      x = global
    [include]
      path = .gitconfig.more

and .gitconfig.more has

    [x]
      x = more

then I get:

1. git config x.x                      =>  more
2. git config --global x.x             =>  global
3. git config --global --includes x.x  =>  more

The first works as I expected.  The second surprised me, since I took
"--global" to mean "the global file and stuff it includes" (that's my
understanding of the description of `include`).  The third is fine, but
it made me even more surprised at the second, especially since the man
blurb on --includes says "Defaults to on."...

So this is at least a documentation issue, though I hope that #2 is a
bug and that it *should* return "more"...?

-- 
                   ((x=>x(x))(x=>x(x)))                  Eli Barzilay:
                   http://barzilay.org/                  Maze is Life!
