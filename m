Return-Path: <SRS0=AWh0=66=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AEF4C433DF
	for <git@archiver.kernel.org>; Sat, 16 May 2020 04:09:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FC55206D4
	for <git@archiver.kernel.org>; Sat, 16 May 2020 04:09:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=atlassian-com.20150623.gappssmtp.com header.i=@atlassian-com.20150623.gappssmtp.com header.b="2I3TM7JP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbgEPEJj (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 May 2020 00:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725275AbgEPEJj (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 16 May 2020 00:09:39 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAA0AC061A0C
        for <git@vger.kernel.org>; Fri, 15 May 2020 21:09:38 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id k6so4921241iob.3
        for <git@vger.kernel.org>; Fri, 15 May 2020 21:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=QYbqID7I+PGZlw6vGfwVCJO0k2KB30P4HYeHkmjNorM=;
        b=2I3TM7JP4uAm7TCzZSyHagWaM0gradOjf2I9iQfEsTQog+KkNit5Oe7Ji5kJ51VO4z
         0++cCzv9lYQZs24tYBgsc2MK6P3AbBqYVqwtcCEA5AX5SX31LCBquOfrCERC16/HpMtt
         TMjJ0Vd8nEJCV3nE743UJLE0XPSNyId2/HklhPBe29EWUgMsdovj3ZRpCD6EaFgmYrOU
         ePzjXbgKA9SogxD3IQCG27g8duTHlFgwzHXjyH61Jm1o2JY7PHTPcPSRbPkG23zuaE9e
         yEGYbLIiaSMGl/7QsZVul3qsR6txfuO3xWRTmS01xA3NGngDvcD/6OOjb5Zk8hFDid4j
         wDDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=QYbqID7I+PGZlw6vGfwVCJO0k2KB30P4HYeHkmjNorM=;
        b=TKNYgkcBXfr1zmDPUu+LtMtwbI6nEF15C2PqDZK8pYBjahNMDH+fwAOP8nbs7/AXJp
         eTmZBYm4LPhs2v/88e4xJtwgCQIKH90GgrVxxLT5pOF2I/OkPws4t7i+h5uYO28InWi2
         H8Q5UISseA34A8XLe1/zCf4jeFs36sMp6mO+x2SL2Bt3NuFLBNowMv6M0QxOitRzOUxr
         dq/YDD80CkgHlqD6pooxdxnDhd3nws/naaipKSDNChDiLoGCn9V82d1MihGH7jEepe1e
         CcxlhmsAA1lGzxB3a40nMx/koEL19mwMC3cohgqJPBgN0MmNJjLD1Z8IOv8DXGqcA68z
         6w2Q==
X-Gm-Message-State: AOAM531EUiIZBE/MgccR5eOpQaaj9TYA5i3jesGZ2ji5RDIRq1x9RBvl
        tgNrPLmfvT0nTj7cynEsxlBI2VQgKHT8CmZN6q/zCh0Q3yA=
X-Google-Smtp-Source: ABdhPJzywRzaFtaUXWe23v7n4GxOa1bpuYtJSlrsBw5xYPAYfIXEFJAmBfI2YLRm7fnNL5j3Ebs7W9VjWcxe8UcZ41Q=
X-Received: by 2002:a5e:8d17:: with SMTP id m23mr5762179ioj.11.1589602177841;
 Fri, 15 May 2020 21:09:37 -0700 (PDT)
MIME-Version: 1.0
From:   Bryan Turner <bturner@atlassian.com>
Date:   Fri, 15 May 2020 21:09:27 -0700
Message-ID: <CAGyf7-GQSPcdheKKiZPBpfGxAj_xu4oWdwRq_esSbuqLu5P08g@mail.gmail.com>
Subject: git push over HTTP; long delay with no progress, then hang?
To:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When running a huge "git push" via protocol v0/v1 over HTTP
(repository is ~10GB, with ~104,000 refs), I observe that:
* Git makes an initial connection for a ref advertisement. This
completes almost instantly because the repository is empty
* "git push" then sits in absolute silence for ~10 minutes

The process chain looks like:
git push <URL>
    git-remote-http <URL> <URL>
        git send-pack --stateless-rpc --helper-status --thin
--progress <URL> --stdin

The "git send-pack" process runs at 100% usage for a single CPU core
for this entire duration. Does anyone have any insight into what Git
might be doing during this long delay? Whatever it is, is it perhaps
something Git should actually print some sort of status for? (I've
reproduced this long silence with both Git 2.20.1 and the new Git
2.27.0-rc0.)

After the long delay, I see another HTTP request to the server and
then the "git push" process finally goes into "Enumerating objects",
"Counting objects", "Compressing objects" and finally "Writing
objects".

Another thing I've noticed is that, during this latter part, it
_appears_ Git opens a connection to the remote server and _then_
starts enumerating/counting/compressing, without having actually said
anything to the server. For this huge push, that actually results in
the server aborting the connection due to a read timeout. Why would
"git push" open a server connection and _then_ do all the work
necessary to create a pack to actually send? (Perhaps this is really
an HTTP keepalive issue, where the connection had been used for a
previous request?) As with the long silence, I reproduced this with
both Git 2.20.1 and 2.27.0-rc0.

Lastly, after the timeout, I observed that my "git push" hung forever
with this output displayed:
bturner$ /opt/git/2.27.0-rc0/bin/git push <URL> --all
Enumerating objects: 13135246, done.
Counting objects: 100% (13135246/13135246), done.
Delta compression using up to 20 threads
Compressing objects: 100% (3867748/3867748), done.
Writing objects: 0% (1/13135246)

An lsof on the "git-remote-http" process showed:
bturner$ lsof -p 64855
COMMAND     PID    USER   FD    TYPE             DEVICE  SIZE/OFF
          NODE NAME
git-remot 64855 bturner  cwd     DIR                1,4       352
     168415036 <CWD>
git-remot 64855 bturner  txt     REG                1,4   2305984
     170771507 /opt/git/2.27.0-rc0/libexec/git-core/git-remote-http
git-remot 64855 bturner  txt     REG                1,4     59156
     165457100 /usr/local/Cellar/gettext/0.20.2_1/lib/libintl.8.dylib
git-remot 64855 bturner  txt     REG                1,4     28420
     167195923 /Library/Preferences/Logging/.plist-cache.hR8QH5S4
git-remot 64855 bturner  txt     REG                1,4   1568368
1152921500312496125 /usr/lib/dyld
git-remot 64855 bturner    0    PIPE 0x9a358149ffa29591     65536
               ->0xa5ef9caffef8462c
git-remot 64855 bturner    1    PIPE 0x2dce7cc3b04ce8b8     16384
               ->0x3f62dce60d4a355
git-remot 64855 bturner    2u    CHR               16,8 0t1903241
          2841 /dev/ttys008
git-remot 64855 bturner    3u  systm 0xb078b23901649d47       0t0
               [ctl com.apple.netsrc id 7 unit 48]
git-remot 64855 bturner    4u   unix 0xb078b238edae81ff       0t0
               ->0xb078b238edae8777
git-remot 64855 bturner    5u   IPv6 0xb078b238f873ac47       0t0
           TCP localhost:58980-><host>:<port> (CLOSED)
git-remot 64855 bturner    7    PIPE 0x8e4a8565c7dd32eb     65536
               ->0xaec041bd7407b713
git-remot 64855 bturner    8    PIPE 0x6ed7631819b64580     65536
               ->0x52e7cf331dfd1de7

So at some level it was known that the remote host had closed the
socket, but "git-remote-http" was still sitting there.

I can readily reproduce all of this, but unfortunately can't readily
share the repository. I'm happy to do anything I can to contribute to
debugging, if anyone has any thoughts to share!

Best regards,
Bryan Turner
