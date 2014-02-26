From: Theodore Ts'o <tytso@mit.edu>
Subject: Re: `git stash pop` UX Problem
Date: Wed, 26 Feb 2014 10:17:46 -0500
Message-ID: <20140226151746.GA7422@thunk.org>
References: <530B0395.5030407@booking.com>
 <CANUGeEbPrPp8Sa-KEKSxNDWJShdkDBTkQyXv7tDJ6ReH6MXrHw@mail.gmail.com>
 <vpqlhx0a3cb.fsf@anie.imag.fr>
 <530C893D.7000108@ira.uka.de>
 <vpqzjlf5q2z.fsf@anie.imag.fr>
 <xmqqwqgj57n9.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Holger Hellmuth <hellmuth@ira.uka.de>,
	Brandon McCaig <bamccaig@gmail.com>,
	Omar Othman <omar.othman@booking.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 26 16:18:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WIgFF-00030M-RR
	for gcvg-git-2@plane.gmane.org; Wed, 26 Feb 2014 16:18:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752159AbaBZPR5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Feb 2014 10:17:57 -0500
Received: from imap.thunk.org ([74.207.234.97]:34341 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751439AbaBZPR4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Feb 2014 10:17:56 -0500
Received: from root (helo=closure.thunk.org)
	by imap.thunk.org with local-esmtp (Exim 4.80)
	(envelope-from <tytso@thunk.org>)
	id 1WIgF0-00014j-O4; Wed, 26 Feb 2014 15:17:46 +0000
Received: by closure.thunk.org (Postfix, from userid 15806)
	id 1AB165803C4; Wed, 26 Feb 2014 10:17:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=thunk.org; s=mail;
	t=1393427866; bh=Fu/9EMTGrxqwKIQCCYHS+wsbIwROCZ7kWvS6pIc/Lz0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SqPkppRAggi9ggmzRze4y1X03yUjXKOGVZLX4hLpMeZ6nDlqjxYTtfLpFbgK9Z3Ov
	 aJcD0VUKxEtXLG9OgAsQKH9aCSQMzqWPjTDnkO+LpIVqrpXGKcpBuMGUFp1cJ3hkrj
	 u/9yKrQJu7CrkhNOq6lB3cbU40/jMLCDgibYrMUc=
Content-Disposition: inline
In-Reply-To: <xmqqwqgj57n9.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242731>

On Tue, Feb 25, 2014 at 11:12:10AM -0800, Junio C Hamano wrote:
> So, I tend to agree with you, while I do understand where "I want to
> know about what is in stash" is coming from (and that is why we do
> have "git stash list" command).

One thing that would be nice is if there was built-in "git stash list"
option which only shows the stash items which match the current
branch.  The discussion on this thread inspired me to create the
following:

#!/bin/sh

b=$(git symbolic-ref HEAD | sed -e 's;refs/heads/;;')
git stash list --pretty="%gd %cr on: %s" | grep "WIP on $b" | \
    sed -e "s/ WIP on $b: [0-9a-f]*//"

This results in:

stash@{0} 4 weeks ago on: mke2fs: add make_hugefile feature
stash@{1} 5 weeks ago on: e2fsck, mke2fs: enable octal integers in the profile/config file
stash@{2} 5 weeks ago on: e2fsck, mke2fs: enable octal integers in the profile/config file
stash@{3} 5 weeks ago on: mke2fs: optimize fix_cluster_bg_counts()
stash@{4} 8 weeks ago on: e4defrag: choose the best available posix_fadvise variant
stash@{5} 9 weeks ago on: e2image: add -c option to optimize file system copying for flash devices
stash@{6} 9 weeks ago on: e2image: clean up gcc -Wall and sparse nits
stash@{7} 9 weeks ago on: e2fsck: fix printf conversion specs in ea_refcount.c

(Yes, I have a lot of junk on my git stash; showing the relative time
is going to help my GC what I have left on my git stash list.)

Cheers,

						- Ted
