Return-Path: <SRS0=4tT/=EF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA039C4363A
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 10:36:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F14B720704
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 10:36:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="Itm9g5Jy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725948AbgJ3Kg4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Oct 2020 06:36:56 -0400
Received: from forward500j.mail.yandex.net ([5.45.198.250]:37674 "EHLO
        forward500j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725790AbgJ3Kgz (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 30 Oct 2020 06:36:55 -0400
X-Greylist: delayed 383 seconds by postgrey-1.27 at vger.kernel.org; Fri, 30 Oct 2020 06:36:54 EDT
Received: from mxback11q.mail.yandex.net (mxback11q.mail.yandex.net [IPv6:2a02:6b8:c0e:1b4:0:640:1f0c:10f2])
        by forward500j.mail.yandex.net (Yandex) with ESMTP id 2BBF411C18B0;
        Fri, 30 Oct 2020 13:30:29 +0300 (MSK)
Received: from localhost (localhost [::1])
        by mxback11q.mail.yandex.net (mxback/Yandex) with ESMTP id ocBvfREThE-USrWIp7V;
        Fri, 30 Oct 2020 13:30:28 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1604053828;
        bh=EKQmI/mgoS2tiAeeiJdqhe32xY2D7VOlFwP/z7YagjM=;
        h=References:Date:Message-Id:Subject:In-Reply-To:To:From;
        b=Itm9g5Jy+oKGF+eaCgIG2Ypcli71ukZiTbQjHsxmwowzdQS9bYoWKBfCbsRBiARpi
         RcOcQAgq87KQGOONdxTFVJBOLJKLZDbz2rMB+lwB7z7q4KNyz1g1nSyNzLz5mmp8Og
         97KGR4r7bNGY0dVcexiwH4wjscf/FGBLZwcmyFs0=
Authentication-Results: mxback11q.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by vla5-f98fea902492.qloud-c.yandex.net with HTTP;
        Fri, 30 Oct 2020 13:30:28 +0300
From:   Konstantin Tokarev <annulen@yandex.ru>
To:     Birger Skogeng Pedersen <birger.sp@gmail.com>,
        Git List <git@vger.kernel.org>
In-Reply-To: <CAGr--=KpNaPFjMOzXzF382cv1p58nMoOPXAm0MCdA8WZMBznVA@mail.gmail.com>
References: <CAGr--=KpNaPFjMOzXzF382cv1p58nMoOPXAm0MCdA8WZMBznVA@mail.gmail.com>
Subject: Re: git-gui: How to configure for use in gigantic projects?
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Fri, 30 Oct 2020 13:30:28 +0300
Message-Id: <445251604053314@mail.yandex.ru>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



30.10.2020, 13:16, "Birger Skogeng Pedersen" <birger.sp@gmail.com>:
> Hi,
>
> I would like to use git gui for a project. The problem is that the
> repository directory is really gigantic. Doing a scan (F5) takes a
> couple of minutes to finish.
>
> I would like the scan to only focus on files that are specifically
> added to the index. In git I do this:
>
> git config status.showUntrackedFiles no
>
> git status will then only show status of files that I have
> specifically added. So git status completion is instant.
>
> But this configuration appears to have no effect on git-gui. The scan
> is just as slow as before.
>
> Anything I can do to make git-gui only scan files that are
> specifically added, and not look through the whole directory?

FWIW, there are better ways to improve performance of git status without
hiding untracked files (which are useful to see when new files are added):

* Add all uninteresting files and directories to .gitignore
* Use fast storage for git repository, e.g. NVME-based
* If your OS can handle filesystem cache efficiently (e.g., Linux) make sure 
there is enough of free RAM for caches and all repeated operations on
same files and directories will speed up dramatically
* If your OS cannot handle filesystem cache efficiently (e.g. Windows) consider
using different OS for development
* If overall performance is still not sufficient, consider using fsmonitor hook [1]

[1] https://github.blog/2018-04-05-git-217-released/#speeding-up-status-with-watchman



-- 
Regards,
Konstantin
