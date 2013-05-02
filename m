From: Johan Herland <johan@herland.net>
Subject: Re: removing a bad commit
Date: Thu, 2 May 2013 12:33:00 +0200
Message-ID: <CALKQrgdomY_JTzkAaVYsShtLRmc342xEprhkbiiNPitAcWJi+A@mail.gmail.com>
References: <CAH_OBifxVOaFMXCthm+r30GNaqrsLRoBE-wvzkeKVxw7R2gGFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: shawn wilson <ag4ve.us@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 02 12:33:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXqp7-0001y1-BF
	for gcvg-git-2@plane.gmane.org; Thu, 02 May 2013 12:33:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756978Ab3EBKdI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 May 2013 06:33:08 -0400
Received: from mail10.copyleft.no ([188.94.218.231]:49917 "EHLO
	mail10.copyleft.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756468Ab3EBKdH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 May 2013 06:33:07 -0400
Received: from locusts.copyleft.no ([188.94.218.116] helo=mail.mailgateway.no)
	by mail10.copyleft.no with esmtp (Exim 4.66 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1UXqoz-0008nk-Hh
	for git@vger.kernel.org; Thu, 02 May 2013 12:33:05 +0200
Received: from mail-oa0-f42.google.com ([209.85.219.42])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1UXqoz-000Pec-BL
	for git@vger.kernel.org; Thu, 02 May 2013 12:33:05 +0200
Received: by mail-oa0-f42.google.com with SMTP id i18so341782oag.29
        for <git@vger.kernel.org>; Thu, 02 May 2013 03:33:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=Wx43KbV/StGq2L0Gqy6U5YyS/EwxAAacUNmuYV9EZ2U=;
        b=eFWzPHJGfU8gR/dxAcZ6EGULUyfwLUlxsn8KNe7NDZMh1oZPdLOnkJt9TqmsP8pabB
         HtePfNsUkpk6FMR4zM53QC1rD3z7LO86NaQMjwPdFgLkO2Tjh57Wa40zwYDmvC+sp8r/
         hgXLjh2CrEczXsgjSipkQKgyX4xYs95lw/LdzGMwf6566WyyuH/wUvOU/P8GqBJMHyZ8
         q9jpDBNj8xZJC6ecEccKnQhcUNquIap/RgRSUkXqzDM9nvOZbBeGJmMz6iQ0ZxlsQuSA
         4OLi1DAAoSbUUZeAIjxgIo5KglgVgN6n7n4RHAZjSY62C/O3k1rrPIEbz2GXNuw9mZPn
         g7NA==
X-Received: by 10.60.63.50 with SMTP id d18mr1637875oes.65.1367490781054; Thu,
 02 May 2013 03:33:01 -0700 (PDT)
Received: by 10.182.142.132 with HTTP; Thu, 2 May 2013 03:33:00 -0700 (PDT)
In-Reply-To: <CAH_OBifxVOaFMXCthm+r30GNaqrsLRoBE-wvzkeKVxw7R2gGFA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223191>

On Thu, May 2, 2013 at 12:15 PM, shawn wilson <ag4ve.us@gmail.com> wrote:
> I've got a commit that was done about a week ago that I want to remove
> (preferably remove and rewrite history as it's in a branch and it
> doesn't need to be in this branch until the branch is working) but if
> a reverse patch is the only way, i'll go with it.

Whether or not you should rewrite history depends on whether the bad
commit has been shared with anybody else. If others have started
working on top of your history, they will not enjoy it if you rewrite
that history and force them to rebase their work accordingly. In that
case, your best bet is a reverse patch: "git revert $bad_commit_sha1"

Otherwise, if the bad commit exists nowhere else but your own repo,
then you can do an interactive rebase to remove the bad commit: On the
branch with the bad commit: "git rebase -i $bad_commit_sha1^" (the
trailing caret ^ is important). This will launch a text editor listing
your last commits starting with your bad commit. Delete the first line
containing your bad commit, and save/exit the editor. Git will now
replay all your last commits except for the bad commit. If any of the
later commits touch the same stuff as the bad commit did, Git might
stop the rebase because of conflicts when it replays those patches. In
this case, fix the conflicts, add the file, and "git rebase
--continue". Repeat until all commits have been replayed and the
rebase is finished.

Hope this helps,

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
