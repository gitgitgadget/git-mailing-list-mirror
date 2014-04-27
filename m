From: Johan Herland <johan@herland.net>
Subject: Re: Recording the current branch on each commit?
Date: Sun, 27 Apr 2014 11:09:28 +0200
Message-ID: <CALKQrgfmBByMwMhxu3HkJqJGWy2Rwvij6Hi1_4npjfsxcSgpaQ@mail.gmail.com>
References: <535C47BF.2070805@game-point.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git mailing list <git@vger.kernel.org>
To: Jeremy Morton <admin@game-point.net>
X-From: git-owner@vger.kernel.org Sun Apr 27 11:09:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WeL5j-0006Dl-PK
	for gcvg-git-2@plane.gmane.org; Sun, 27 Apr 2014 11:09:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753178AbaD0JJg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Apr 2014 05:09:36 -0400
Received: from mail12.copyleft.no ([188.94.218.224]:34925 "EHLO
	mail12.copyleft.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753157AbaD0JJf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Apr 2014 05:09:35 -0400
Received: from locusts.copyleft.no ([188.94.218.116] helo=mail.mailgateway.no)
	by mail12.copyleft.no with esmtp (Exim 4.76)
	(envelope-from <johan@herland.net>)
	id 1WeL5Z-0003ZP-0h
	for git@vger.kernel.org; Sun, 27 Apr 2014 11:09:33 +0200
Received: from mail-pa0-f51.google.com ([209.85.220.51])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1WeL5Y-00090d-Ka
	for git@vger.kernel.org; Sun, 27 Apr 2014 11:09:32 +0200
Received: by mail-pa0-f51.google.com with SMTP id fb1so4058038pad.10
        for <git@vger.kernel.org>; Sun, 27 Apr 2014 02:09:28 -0700 (PDT)
X-Received: by 10.66.102.72 with SMTP id fm8mr18491201pab.86.1398589768698;
 Sun, 27 Apr 2014 02:09:28 -0700 (PDT)
Received: by 10.70.48.232 with HTTP; Sun, 27 Apr 2014 02:09:28 -0700 (PDT)
In-Reply-To: <535C47BF.2070805@game-point.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247197>

On Sun, Apr 27, 2014 at 1:56 AM, Jeremy Morton <admin@game-point.net> wrote:
> Currently, git records a checksum, author, commit date/time, and commit
> message with every commit (as get be seen from 'git log').  I think it would
> be useful if, along with the Author and Date, git recorded the name of the
> current branch on each commit.

This has been discussed multiple times in the past. One example here:
http://thread.gmane.org/gmane.comp.version-control.git/229422

I believe the current conclusion (if any) is that encoding such
information as a _structural_ part of the commit object is not useful.
See the old thread(s) for the actual pro/con arguments.

That said, you are of course free to add this information to your own
commit messages, by appending something like "Made-on-branch: frotz".
In a company setting, you can even create a commit message template or
(prepare-)commit-msg hook to have this line created automatically for
you and your co-workers. You could even append such information
retroactively to existing commits with "git notes". There is also the
current interpret-trailers effort by Christian Couder [1] that should
be useful in creating and managing such lines.

[1]: http://thread.gmane.org/gmane.comp.version-control.git/245874

> The branch name can provide useful
> contextual information.  For instance, let's say I'm developing a suite of
> games.  If the commit message says "Added basic options dialog", it might be
> useful to see that the branch name is "pacman-minigame" indicating that the
> commit pertains to the options dialog in the Pacman minigame.

In that partcular case, ISTM that the context ("pacman-minigame")
would actually be better preserved elsewhere. E.g. the commits touch
files in a particular "minigames/pacman" subdir, or you prefix the
context in the commit message ("pacman-minigame: Added basic options
dialog"). Also, such a "topic" branch is often tied to a specific
issue in some bug/issue tracker, and it would in any case be natural
to mention the bug/issue ID in the commit message, at which point the
tracker can provide more context and discussion.

> Basically,
> I'm saying that well-named branches can and do carry useful contextual
> information that oughtn't to be thrown away.  Currently, when you delete
> that branch, you lose the branch name altogether.

Some would argue that branches are not always well-named... But
anyway, if the branch ends up getting merged to the mainline, the
merge commit defaults to a message like "Merge branch
'pacman-minigame'".

> So what do you think?  Would it be good to have a patch to add this feature?

One is free to try, of course, but I wouldn't get my hopes up for a
patch that changes the fundamental format of the commit object to
include something that many users/workflows would consider to be pure
cruft.

If you still believe that this is useful enough to warrant a change to
the commit object format, it is probably better to start off putting
the information in the commit message (as described above), and
provide some tools that demonstrate the added value of this
information. If that is successful and gains momentum, the git
community can certainly reconsider whether it makes sense to fold it
into a more formalized part of the commit object.

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
