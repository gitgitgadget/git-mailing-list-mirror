From: Jay Soffian <jaysoffian@gmail.com>
Subject: gc --aggressive
Date: Tue, 17 Apr 2012 12:16:15 -0400
Message-ID: <CAG+J_DzO=UZ56PjnSCRaTdj8pBSYc5PFofw1QHy42c5pHMK_HQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Shawn Pearce <spearce@spearce.org>
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 17 18:16:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKB4n-0007I2-Fw
	for gcvg-git-2@plane.gmane.org; Tue, 17 Apr 2012 18:16:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932071Ab2DQQQR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Apr 2012 12:16:17 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:62054 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755293Ab2DQQQQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2012 12:16:16 -0400
Received: by yhmm54 with SMTP id m54so3157358yhm.19
        for <git@vger.kernel.org>; Tue, 17 Apr 2012 09:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=TOKHIlKDJHosvKtVF8PcIkRxEJDF6oWAywMzrmjpOwQ=;
        b=pJgODnt8UrLm1B5couh/WkjhSeX4zwFtRfdLcdbLzibZfBk2hI7UVZqnZvPqqvuDAl
         Ug5GUBu08YGaTAn4DFHV9O2QX4+oCyTS9yTBxc6GZ3htc91SLRhdlQ+joIpcdrBUawEd
         cfqn07r8adNE96BrgHQIb1gIFjfFuQo9639r4Q3WjYsE2UZ4qjjHvfPlhZayHUzKWkaS
         F3VvpYhTsaGC8vH2pyqXbgtMJvI8Ob8bUgRbizOwdmaSlJYwLpnETquqvJ2Gz9C/R0XP
         Ydv5TxO0p2tkdARl03qOLS27BzxJYP08pei1LmB/Yxt6HwW3qnhFI6+kyrSUr+KcQnP+
         odBw==
Received: by 10.236.79.234 with SMTP id i70mr15815184yhe.88.1334679375786;
 Tue, 17 Apr 2012 09:16:15 -0700 (PDT)
Received: by 10.147.47.19 with HTTP; Tue, 17 Apr 2012 09:16:15 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195770>

For a couple years now I've had a maintenance script which repacks all
the repos at @dayjob thusly:

  git config repack.usedeltabaseoffset true
  git config pack.compression 9
  git config pack.indexversion 2
  git config gc.autopacklimit 4
  git config gc.packrefs true
  git config gc.reflogexpire never
  git config gc.reflogexpireunreachable never
  git gc --auto --aggressive --prune

This has worked fine on repos large and small. However, starting a
couple days ago git started running out of memory on a relatively
modest repo[*] while repacking on a Linux box with 12GB memory (+ 12GB
swap). I am able to gc the repo by either removing --aggressive or
.keep'ing the oldest pack.

[*] Stats:

  du -hs objects
  141M	objects

  git count-objects -v
  count: 0
  size: 0
  in-pack: 57656
  packs: 37
  size-pack: 143811
  prune-packable: 0
  garbage: 0

  git version 1.7.10

I've since found a message from Shawn recommending against using --aggressive:

  http://groups.google.com/group/repo-discuss/msg/d2462eed67813571

> Junio Hamano and I looked at things a few weeks ago; it turns out the
> --aggressive flag doesn't generally provide a benefit like we thought
> it would. It would be safe to remove from your GC script, and will
> speed things up considerably.

A couple questions:

1) If --aggressive does not generally provide a benefit, should it be
made a no-op?

2) Is it expected that gc --aggressive would run out of memory on this repo?

I've posted the repo in case anyone wants to take a look:

  http://dl.dropbox.com/u/2138120/WebKit-trimmed.git.zip

j.
