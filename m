Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 761A71F6DC
	for <e@80x24.org>; Wed, 25 Jan 2017 22:16:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752520AbdAYWQm (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jan 2017 17:16:42 -0500
Received: from mail-lf0-f46.google.com ([209.85.215.46]:35911 "EHLO
        mail-lf0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751822AbdAYWQl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2017 17:16:41 -0500
Received: by mail-lf0-f46.google.com with SMTP id z134so136539334lff.3
        for <git@vger.kernel.org>; Wed, 25 Jan 2017 14:16:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=h7a9/vtvY0F4ab1AxV3VBPNwTvxWnIiTIjGOdUhHOZA=;
        b=VYfPDqxQ/TSyx4uf94kkfUhFciSOY/0Br61SyTtkmkfSLXkO2wOMgygibi9x4wN9dR
         SYMJiNWJ1B9Z7neCU5INY0/1Nwxi478Ok92s1ts8Lxjk04m8TlbMb2zaJpal3DsWZYDf
         gQLQin8RptXYeTYDMNveY7ogpO9254MypPP6QLDs6XIX5vHjSp4+cCHNKpOgX6A+A4Km
         J5huX3QjfWpYeBDWocGwQKPre7zLmehHpg71vRRgqhdHiS8SyKgurMVwreIl9fgKuZ4c
         7hENsfUdEM9ufrwPU61Q9w6h6mTY91f9XrE0bWgl6c2QwwVYIzJbYTbdERDWoBC3Y4n5
         nGkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=h7a9/vtvY0F4ab1AxV3VBPNwTvxWnIiTIjGOdUhHOZA=;
        b=i6NqFXpGwhbVTY9r28wjO9jB0xzN2UDR2t0kmxyhTf/HiWs3KKOU1xcqLkeod1GWiX
         Z1rldlyPMYVRqiRgE/EJ9JumHIYleJVu7/WcW4stiDo1VZ2peSs+2JRpxL7IeIs+M1VN
         ls1H9g9EhpKXz02+GdFPZMRjUhsMJX3WGpgBmD/ZVshx5qLh52uyt4sZHPJNW0D7ENid
         8Zok8iGCZRJ2OycPix4AQLu7pU14n8caqSL57O4VkRmkplkOlsBKRa1t09SvHSzFg+uB
         CE3o2cSKt/AuaZLZ+bgFxM9ppoGpcWWq5vaSJ+0OKUDRqrvwt0H8LQo81CoGNSdQ7i4a
         R7Qg==
X-Gm-Message-State: AIkVDXJoAUehZ1fBdbF7iSB5qnCdxv9Xa5Nz6En/83qvkGvPxfg8hcN4E9ju9uVihzw8+pR/wCBsq34di/Bp5Q==
X-Received: by 10.25.16.158 with SMTP id 30mr13594419lfq.119.1485382585096;
 Wed, 25 Jan 2017 14:16:25 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.20.193 with HTTP; Wed, 25 Jan 2017 14:16:04 -0800 (PST)
From:   Hilco Wijbenga <hilco.wijbenga@gmail.com>
Date:   Wed, 25 Jan 2017 14:16:04 -0800
Message-ID: <CAE1pOi2YZayEfKxxh3gsTds1mQ9L1E9AW=wPnmW=Dg=-EMj=tw@mail.gmail.com>
Subject: Force Confirmation for Dropping Changed Lines
To:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

Most of the time, when a later commit changes a line in an identical
fashion during, say, a rebase, you want Git to silently continue by
dropping the duplicate change from the later commit. I have a common
(for me) scenario where I want Git to specifically ask me to resolve
this "conflict" myself instead of simply assuming that the change has
already been applied.

Let's say I have a file my-code.x that starts with a line indicating
its version:

===== my-code.x =====
VERSION=1.2
line 1
line 2
line 3
=====

In my branch my-branch off of master, I make a change:

===== my-code.x =====
VERSION=1.3
line 1
line 2
line 2a
line 3
=====

Now someone else makes a different change on master and pushes it ([1]):

===== my-code.x =====
VERSION=1.3
line 1
line 2
line 3
line 4
=====

When I rebase my-branch onto origin/master, I get no conflicts and
everything seems fine ([2]):

===== my-code.x =====
VERSION=1.3
line 1
line 2
line 2a
line 3
line 4
=====

Except that I should have used VERSION=1.4, not VERSION=1.3 because I
made a change to my-code.x. Obviously, for a single file this is easy
to remember/check but when it's hidden among lots of files and commits
it becomes very hard to find these types of errors.

How can I force Git to not assume my change to the first line is "redundant"?

Cheers,
Hilco

[1] Note that this someone is (correctly) using the same, new version of 1.3.
[2] If my example is actually incorrect, then please just pretend
there are no conflicts.
