From: Duy Nguyen <pclouds@gmail.com>
Subject: inotify support, nearly there
Date: Wed, 29 Jan 2014 13:47:30 +0700
Message-ID: <CACsJy8CG5QUqYOM46mOHOWDKB-A45B2-fj1uS9OtgniV+P8Ktg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Thomas Rast <tr@thomasrast.ch>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jan 29 07:48:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W8OwS-0007d4-9w
	for gcvg-git-2@plane.gmane.org; Wed, 29 Jan 2014 07:48:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751241AbaA2GsD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jan 2014 01:48:03 -0500
Received: from mail-qc0-f178.google.com ([209.85.216.178]:56117 "EHLO
	mail-qc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750838AbaA2GsB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jan 2014 01:48:01 -0500
Received: by mail-qc0-f178.google.com with SMTP id m20so2124646qcx.23
        for <git@vger.kernel.org>; Tue, 28 Jan 2014 22:48:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        bh=O53RO/wLYqaUGlskwQSLqrFpLh+Kog2+UKdvgnmQVLs=;
        b=IWPM5zCsOWxqHbbrerCZAxXV+7RqzmEuHwx6Sxp1mWmy219ia/lCwxqweYP0Ikhy3K
         LelfZNAB+unQOglD7Zqg2QnFuwcMvDh2arEUHbeet2ewnEiBSHwDSh5CGoZ9/1rruGzi
         zj+WWvz7inubik5YNIpwUmzBRWVsRzEXsZM5Tf2Zj1MX7STON4PnVgJVOZSQsbnlJQ6w
         i5HPgjRrggJsdahRvTY4AdTq++h8DOYzdmLodgzwVXHIFDWbju95vEuDhlLPx/sw62Wc
         tMSwT2YYyRUE0dscCPLitnvDtzrvW4l2iURKogH/izMx8BbJzW+7bp4jLz6xe0ajxCQL
         wOTA==
X-Received: by 10.140.84.19 with SMTP id k19mr8750472qgd.98.1390978080894;
 Tue, 28 Jan 2014 22:48:00 -0800 (PST)
Received: by 10.96.136.98 with HTTP; Tue, 28 Jan 2014 22:47:30 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241200>

Just a quick update for the enthusiasts. My branch file-watcher [1]
has got working per-user inotify support. It's a 20 patch series so
I'll refrain from spamming git@vger for a while, even though it hurts
your eyes a lot less than what I have posted so far. The test suite
ran fine with it so it's not that buggy. It has new tests too, even
though real inotify is not tested in the new tests. Documentation is
there, either in .txt or comments. Using it is simple:

$ mkdir ~/.watcher
$ git file-watcher --detach ~/.watcher
$ git config --global filewatcher.path $HOME/.watcher

There's still some polishing work to do. But I think the core logic is
done. I have some ideas what to be polished, but I'd appreciate
feedback if anyone uses it. We may need to make lookup code faster
later.

MacOS, FreeBSD and Windows contributors. If you have time and are
interested, have a look at the protocol, which is basically documented
in file-watcher.c:handle_command(), and see if something is
incompatible with your file notification mechanism. MacOS and FreeBSD
may reuse code from file-watcher.c, at least the unix socket part. I'm
not so sure about Windows. It probably needs a brand new daemon
because little could be shared, I don't know. I deliberately design
the daemon dumb so writing a completely new one won't be so hard. My
plan is focus on inotify and get it merged first, then new OS support
can come later (with refactoring if needed, but should not change the
protocol drastically).

[1] git clone https://github.com/pclouds/git.git file-watcher
--
Duy
