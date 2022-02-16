Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C9C1C433F5
	for <git@archiver.kernel.org>; Wed, 16 Feb 2022 14:15:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233931AbiBPOP3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Feb 2022 09:15:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbiBPOP1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Feb 2022 09:15:27 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E02392604DB
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 06:15:14 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id f3so3549376wrh.7
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 06:15:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=yousician.com; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=vQ1Su7C31Nf1Q09metxkYI4JOC3GnwmpeRRhf29lWP8=;
        b=DAKIHSG91WsnYEoDMUk430ZTmCEV+GSz8mMbuzxzD206pCsoi5AiyZqPDAQinKmVBP
         4kV5v7Ztf1j/eCZCWVYxNoxZZcdYcKOogFh9KfyiQyu8GbYndbgr4n1RS2r9YulwRf5A
         Y+pdgcd05RZWwqwz/w0uoYaMWzUCRLXY57gx8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=vQ1Su7C31Nf1Q09metxkYI4JOC3GnwmpeRRhf29lWP8=;
        b=mpjSyLjsZpl3j/jmRoH/EFQ+c9CVpy8EMtZHffH4C6j98hJ1KsV6OmYix8vn7d6MV9
         VZjX5bO6f3Yw1KjJfbIS68mehR8QrY8V4OBjlP4haUY0qGJW9/qs67avNTBMTuMYR4y1
         c6NlT1WiKtkgsIaJ1WMkbeghmyfd/w/AbWjcchLpSXk580eCFw6uu5cdncyhu/vnCohR
         l929+JIb5t0usLl2pXtGUEYp4oU/ihIPlaJ77nUOGF06zqAwuJN+bIm0vi/StPe4mtUo
         RJ5HVCN182VIhFrjUq4+8RuJhzMEjvq8ys86S6R1RXRvFFSUG6CxT4eV+r6kHrj/xX5G
         wRVg==
X-Gm-Message-State: AOAM533EJG3Fmk1YJhWqbw6XHGPlM7rx2neZRo75AI9B+k0JjcDKMNaF
        9dQGyc4GKN0bw+I9lcMNATJizFlqptEq6cFI4MIGeLLMnkurX9S428SuNQ9aKjKgE2buJXR+dvf
        9WQh3c5HN4IcLXK2BV9pbFuuoFrPmS1fI
X-Google-Smtp-Source: ABdhPJzJxWtdSeihussVpzNSZq3DDhrWsoF2G2oTN68AOZnZWGuShX/+RRDkYC+JZgMwjufK4229HjL8G3WQXY3YOsM=
X-Received: by 2002:a5d:44d1:0:b0:1e4:9a8b:741e with SMTP id
 z17-20020a5d44d1000000b001e49a8b741emr2564611wrr.133.1645020913179; Wed, 16
 Feb 2022 06:15:13 -0800 (PST)
MIME-Version: 1.0
From:   Adam Kapos <adam@yousician.com>
Date:   Wed, 16 Feb 2022 16:15:04 +0200
Message-ID: <CAMwvdPQLMK2-CPyLqSKBWZjEi+6o2iaj_=C2VnJA=sV5GUV47Q@mail.gmail.com>
Subject: Leading slash exclusion does not with git clean on Windows
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I came across an issue where the leading slash exclusion pattern does
not work with git clean on Windows.

What did you do before the bug happened? (Steps to reproduce your issue)

Run the following commands:
1. mkdir foo
2. mkdir -p bar/foo
3. git clean -fdx --exclude /foo

What did you expect to happen? (Expected behavior)
The root-level directory is not removed because it's excluded

Removing bar/

What happened instead? (Actual behavior)
The root level directory is removed:

Removing bar/
Removing foo/


What's different between what you expected and what actually happened?
The root-level exclusion doesn't work

Anything else you want to add:

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.35.1.windows.2, 2.31.1.windows.1
cpu: x86_64
built from commit: c5f0be26a7e3846e3b6268d1c6c4800d838c6bbb
sizeof-long: 4
sizeof-size_t: 8
shell-path: /bin/sh
feature: fsmonitor--daemon
uname: Windows 10.0 22000
compiler info: gnuc: 10.2
libc info: no libc information available
$SHELL (typically, interactive shell): C:\Program Files\Git\usr\bin\bash.exe


[Enabled Hooks]
post-commit
post-checkout
post-merge
pre-push

-- 




**Confidentiality**
The
 information contained in this e-mail is 
confidential, may be privileged
 and is intended solely for the use of the 
named addressee. Access to 
this e-mail by any other person is not 
authorised. If you are not the 
intended recipient, you should not 
disclose, copy, distribute, take any 
action or rely on it and you should 
please notify the sender by reply. 
Any opinions expressed are not 
necessarily those of the company.

We
 may monitor all incoming and 
outgoing emails in line with current 
legislation. We have taken steps to 
ensure that this email and 
attachments are free from any virus, but it 
remains your responsibility 
to ensure that viruses do not adversely affect 
you.


