From: Brett Randall <javabrett@gmail.com>
Subject: A couple of rebase --autosquash proposals
Date: Mon, 9 Dec 2013 13:23:00 +1100
Message-ID: <CALeEUB4mTpd9tHJCC9Ffrfe6L=m0+gaDsXYSFGaO_tMcxCX_nA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 09 03:23:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VpqV0-00022P-Jm
	for gcvg-git-2@plane.gmane.org; Mon, 09 Dec 2013 03:23:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760264Ab3LICXB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Dec 2013 21:23:01 -0500
Received: from mail-ie0-f172.google.com ([209.85.223.172]:53150 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755336Ab3LICXA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Dec 2013 21:23:00 -0500
Received: by mail-ie0-f172.google.com with SMTP id qd12so5176431ieb.17
        for <git@vger.kernel.org>; Sun, 08 Dec 2013 18:23:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=IrJ45nEaekOa+ym4RtxuiRxFcDvWHIsUPAtrwmOly4c=;
        b=ozqWTGu80YxhA3viGh4wmUi7BJYlCgQ/HssMiCw4Kw/cRfYLEnSYVv7YkejdUDlPde
         qe5bP/9CcaM/g11srvmKrZQ48qzpoBC9YVz9KIPsdE69Xn74WHxFFVjcM5RMJqL3tdaX
         AndF/e/ot3PMT28BglXHdn30rkY7WuGbxApQWPMM7K5HzuROHCiHJM3rKhZ1OeXA1WkM
         wHVe8hFzK2J88QeUBOaVqNFFoTbhTS9mZ50UAxgWREKx4nJepaKoU+3DbGFtvOGDJOOB
         +ZoJvg5At1WHZfQGLlupn6AivedbZ2F0DENpCOd2Wp7AwaHbV5s/sKlLPaYWwIhA5a5O
         pkYg==
X-Received: by 10.50.66.195 with SMTP id h3mr13663730igt.41.1386555780442;
 Sun, 08 Dec 2013 18:23:00 -0800 (PST)
Received: by 10.64.126.169 with HTTP; Sun, 8 Dec 2013 18:23:00 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239058>

Hi,

I am using Git 1.8.4.3 compiled by me on OEL6.  I'd like to be able to
use rebase --autosquash like this:

======================
# git log

commit b94f970cd869dfbf5254b19867fa7200df732d4f
Author: Me <me@me.com>
Date:   Mon Dec 9 17:02:32 2013 -0800

    fixup!
    This is a second fixup.

commit 64e516c8b26b7e0531a1e8b2fc8dfa21de259b85
Author: Me <me@me.com>
Date:   Sun Dec 8 17:02:32 2013 -0800

    fixup!
    This is a meaningful commit-log message, on a new line, that will
be discarded later during rebase --autosquash.

commit f21cd48d5eeac92130dc0617252c6ee6989c0252
Author: Me <me@me.com>
Date:   Tue Dec 3 21:47:52 2013 -0800

    This is the commit that will be fixed-up.

commit 259c0eb41ef16ac94868ee3c9253ba938ed24c9f
Author: Me <me@me.com>
Date:   Mon Dec 2 21:47:52 2013 -0800

    This commit is origin/master.
======================

then

# git rebase -i --autosquash 259c0eb41ef16ac94868ee3c9253ba938ed24c9f

The differences here are:

* fixup! or squash! on it's own would default to fixing-up the
previous commit (or result of previous step of rebase if that was a
squash/fixup).  Interestingly using HEAD~1 or HEAD^1 works, but it
only works for a single fixup/squash.  Is there another treeish that
would work?
* Allow real commit-log text, perhaps only on lines other than the
first line (the one containing the fixup).

The motivations are:

* I can default a fixup to apply to the previous commit (a common
wish) without explicitly stating it's treeish or commit-message.
* I can easily apply multiple fixups.
* I can retain a meaningful WIP commit-log prior to the rebase - I can
still see what each commit does, without needing to forgo the future
autosquash capability - just put the !fixup or !squash on the first
line on its own, and put the real changes on line 2 and onwards.  In
the case of squash! instead of fixup!, this means I could retain some
valuable text to be squashed into the original commit.

Thoughts on these two ideas?

Thanks
Brett
