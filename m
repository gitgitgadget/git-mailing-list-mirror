Return-Path: <SRS0=prLJ=4M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 859C4C35641
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 03:59:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AB9E20675
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 03:59:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=webssup.com header.i=@webssup.com header.b="hA/8rLqz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727227AbgBXD72 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 23 Feb 2020 22:59:28 -0500
Received: from mail-pj1-f41.google.com ([209.85.216.41]:34035 "EHLO
        mail-pj1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727221AbgBXD72 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Feb 2020 22:59:28 -0500
Received: by mail-pj1-f41.google.com with SMTP id f2so3578135pjq.1
        for <git@vger.kernel.org>; Sun, 23 Feb 2020 19:59:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=webssup.com; s=google;
        h=from:mime-version:subject:date:references:to:in-reply-to:message-id
         :content-transfer-encoding;
        bh=nhFZcq5jaCdeTI9cvaeUuj65MI6YnSLBaR57bvLS4vg=;
        b=hA/8rLqzwjyGRVVr5fTr/FEa53fhOe8ZDyB4VGRnCdIib8OiDz+zSL2nRqRGMN4Tfh
         iJzOlAcF+C7wlDIycwer8oO8NXpHAJAgPaoOhMQNjpBRhVOQckE+BrlbZP8nr/yiWiti
         UR3KImU3vs7oRbiSw0xjayR0tE8HMk1lmg7Xk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:mime-version:subject:date:references:to
         :in-reply-to:message-id:content-transfer-encoding;
        bh=nhFZcq5jaCdeTI9cvaeUuj65MI6YnSLBaR57bvLS4vg=;
        b=gpwJPHp0+3LlhDrYS+EqYL9Gt2jlIrA/9dPefd48haiyAHhJl4kmbU4i6GN4qgZWm/
         LDz79U7bxFRXRVLaRMxPUn8N5GmmM67SsJBgoqPMvx5cNK6LAlsE4u3AEbY7mt/iF+tG
         +92zQHwrXv1h9Hj7HXQ/fAO7J863SrRnaAIaQ9UsSZ8NOsGdzZvQ6MekTYboFDJt46lW
         92HaSdFR49ruRY3UldcBhrWUSc9vncy11SEc42nxHYLi1fzduvIBsUMmLCOZLya1DZLY
         Oaum3mnGRaRmd8mT8Ebo2J3WRCqhJbAVgFN70RE4XWgK47YRuvKO8tabniDbPjTrovVy
         hbKg==
X-Gm-Message-State: APjAAAVRT9qobc4LaabRtP2IiLRsS8bJdLQf3aSaeCj6vn4KeH9TzdLW
        VAhhHDEIelBtTAwG4qgk2pWzelARYePPHSz9UwhPTkOfVJtVB97hZ3DDepMc0JjJAiYTEL91GdS
        xgrjl+0OtTA==
X-Google-Smtp-Source: APXvYqxpYJG1gm3BZRuGFTGn95nhmOZOKRjVPUdaAndVKIDypbMkYfY2oZqnsLg8ZDmpyBZCfoiDzw==
X-Received: by 2002:a17:90a:1b42:: with SMTP id q60mr17256824pjq.108.1582516767422;
        Sun, 23 Feb 2020 19:59:27 -0800 (PST)
Received: from [10.102.0.108] (061244206222.ctinets.com. [61.244.206.222])
        by smtp.gmail.com with ESMTPSA id iq22sm10496892pjb.9.2020.02.23.19.59.26
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Feb 2020 19:59:26 -0800 (PST)
From:   On Luk <on.luk@webssup.com>
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Dropbox do not sync particular files after using git push
Date:   Mon, 24 Feb 2020 11:59:25 +0800
References: <EC87F304-78E6-40C4-840C-45F118902079@webssup.com>
 <16B44F67-E85E-4D87-A8EC-18ED1B35DB41@webssup.com>
 <9A165840-280C-43C4-B92B-3349E07AC0B1@webssup.com>
 <C8290530-F064-47CD-8FA0-F42CFBF777D9@webssup.com>
To:     git@vger.kernel.org
In-Reply-To: <C8290530-F064-47CD-8FA0-F42CFBF777D9@webssup.com>
Message-Id: <A07B2628-8AEB-4520-8C60-16BE607B3022@webssup.com>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Sir/Madam,

I tried to report this issue to dropbox technical team, but they replied th=
at the issue was not caused by Dropbox, so I try to report to your team as =
a bug report below:

Everytime I used git to push commit to my remote repo located in my dropbox=
, some files stuck in syncing status and can=E2=80=99t be able to sync to d=
ropbox. To get those files be synced, I need to do one of the follow steps =
everytime by manually:

1.	Drag and drop back the file to dropbox using the finder.
OR
2.	Click Pause and resume syncing in dropbox desktop manager.
OR
3.	Restart Dropbox.

To make it clear, I prepared a screen recording to show the issue that I am=
 facing.

www.dropbox.com/s/ivn7qytk0u67v6n/Screen%20Recording%202020-01-03%20at%2012=
.21.21%20PM.mov?dl=3D0

This issue only appear after I switch to use my new computer running as mac=
OS 10.15, everything works fine in my old computer running as macOS 10.13.6=
.

p.s: git version 2.24.1

BRs,

On
--=20










The information in this electronic mail ("e-mail") message is for=20
the use of the named recipient(s) only and may be confidential.=C2=A0The=20
information may be protected by privilege, work product immunity or other=
=20
applicable law. If you are not the intended=C2=A0recipient(s), the retentio=
n,=20
dissemination, distribution or copying of this e-mail message is strictly=
=20
prohibited. If you receive this=C2=A0e-mail message in error, please notify=
 me=20
immediately by replying to the message and thereafter, delete all copies on=
=20
your=C2=A0system and destroy any hard copies.=C2=A0
