Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9DDAF20D2F
	for <e@80x24.org>; Fri, 27 Jan 2017 20:47:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751214AbdA0UrR (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jan 2017 15:47:17 -0500
Received: from mail-ua0-f173.google.com ([209.85.217.173]:33081 "EHLO
        mail-ua0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751193AbdA0UrG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jan 2017 15:47:06 -0500
Received: by mail-ua0-f173.google.com with SMTP id i68so213347730uad.0
        for <git@vger.kernel.org>; Fri, 27 Jan 2017 12:47:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=3VaBuK6myc6aAVXW+t43QSUJwYlPwC5M4VLf5HTeUt8=;
        b=oABacVgzz/tfa6f0TZpR8JMXme6celJO2x9swHzYJ1iV9rlRpRhWVVZvfDqkT0YeEu
         tYW2rHlj80QCztZbe+ryJd1kFUtJmwjQQY0IBEhxEvY9lC4tmYWN8/Ov0HXLkrQdgKPj
         gIoCXcjlF44jexkMuDbAshUD0+Zh9VaGSF4xGcylsShDQ9IPHgZ+Q560UNtlA2cwux8k
         NDs0p9qjnFVcmiSnqmIH5HlL341ZnXyeWuQsBxF7A19LtZp35+mQEY4bh8GrJItMHYwa
         9sX1hf/Yc6HgNfcCBqJtbClyPwrVKBuEaoEOFXKV3TmJdMNhj5PfdVviJZnUgeG5E+sA
         lkMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=3VaBuK6myc6aAVXW+t43QSUJwYlPwC5M4VLf5HTeUt8=;
        b=E6u66MYhf430yPGa8PCoRnMRmCh8UfIU3Gw/uWe80R6aWcUqwm23ui3FfZJYVEd5Wy
         duVV9LTu1Xqm8hMZBzEnlNG4x3/klFkKVzJXSa94RlPbAGVmQf5Zx1mybhEc4tRzhB9G
         4A/VK02vJsy/bWqcd0cwnFn7+E1Bl/j72xvM4I6uZwrP9tZLVkXFK2KvslXNuOrmtg3H
         S0K/W5iqJMLv/CHPO2LVDHlVXTfa/UHhXYUx/2jgaK/GTFeDdRwikeyByAxl/GedNVXO
         25e4ayw+1sidpCdbM3d+yK8euC4g0FSjzRrGflP/VJoAtY+OwGqCGzJO+0EY1UBMNy8/
         0sFg==
X-Gm-Message-State: AIkVDXKz0Gd8O50QcPDmgSGFKToItHTd0yodfZJ52VpsslWkGXVBWzskzzoV39UQpT6joBXsYYTkL6Z0UK+g+w==
X-Received: by 10.176.6.106 with SMTP id f97mr5556221uaf.118.1485550025548;
 Fri, 27 Jan 2017 12:47:05 -0800 (PST)
MIME-Version: 1.0
Received: by 10.159.34.48 with HTTP; Fri, 27 Jan 2017 12:46:25 -0800 (PST)
From:   Samuel Lijin <sxlijin@gmail.com>
Date:   Fri, 27 Jan 2017 14:46:25 -0600
Message-ID: <CAJZjrdWdRGZ5DC1XV_YiNt-1sKiNgAtiS-eS9L6H2GJ+_8n08w@mail.gmail.com>
Subject: octopus merge --no-ff claims to fast-forward even though it doesn't
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I was doing an octopus merge earlier and noticed that it claims to
fast-forward when you specify --no-ff, even though it does actually
abide by --no-ff.

I can consistently reproduce as follows:

$ git clone https://github.com/sxlijin/merge-octopus-experiment
$ cd merge-octopus-experiment
$ git merge --no-ff origin/A origin/B --no-edit
Fast-forwarding to: origin/A
Trying simple merge with origin/B
Merge made by the 'octopus' strategy.
 anotherA | 0
 anotherB | 0
 otherA   | 0
 otherB   | 0
 4 files changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 anotherA
 create mode 100644 anotherB
 create mode 100644 otherA
 create mode 100644 otherB

$ git log --graph --pretty=oneline --decorate

I've reproduced the issue with 2.11.0 on both a Windows box (MSYS) and
Linux (Arch).

The issue seems to live in git-merge-octopus.sh, specifically in that
--no-ff does not affect the initial value of NON_FF_MERGE. I'm happy
to submit a patch if someone can point me in the right direction.

Sam
