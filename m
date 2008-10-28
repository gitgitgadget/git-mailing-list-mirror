From: Hannu Koivisto <azure@iki.fi>
Subject: Re: Gitk/Cygwin bug: phony local changes
Date: Tue, 28 Oct 2008 17:12:19 +0200
Organization: NOYB
Message-ID: <837i7s3ga4.fsf@kalahari.s2.org>
References: <83bpx62hbn.fsf@kalahari.s2.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 28 16:14:13 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KuqGm-0006NV-BU
	for gcvg-git-2@gmane.org; Tue, 28 Oct 2008 16:14:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752965AbYJ1PMi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Oct 2008 11:12:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752928AbYJ1PMi
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Oct 2008 11:12:38 -0400
Received: from main.gmane.org ([80.91.229.2]:35406 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752965AbYJ1PMh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Oct 2008 11:12:37 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KuqFC-0007Tc-5V
	for git@vger.kernel.org; Tue, 28 Oct 2008 15:12:30 +0000
Received: from s2.org ([195.197.64.39])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 28 Oct 2008 15:12:30 +0000
Received: from azure by s2.org with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 28 Oct 2008 15:12:30 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: s2.org
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/22.2 (gnu/linux)
Cancel-Lock: sha1:3eyHOsrD9anWRdSDjJOnAJbw+0E=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99295>

Hannu Koivisto <azure@iki.fi> writes:

> Greetings,
>
> git clone git://git.kernel.org/pub/scm/git/git.git
> cd git
> gitk
>
> with Cygwin build of git version 1.6.0.3.523.g304d0 in Windows XP
> SP2 with Cygwin dll version 1.5.24 results to gitk showing "Local
> uncommitted changes, not checked in to index" entry in the history
> tree and if I select that entry, it seems to indicate that all
> files have changed but without any actual content changes.
>
> git status doesn't show any changes.
>
> If I run git diff (which displays no changes) or git reset and then
> run gitk again, there is no longer that "Local uncommitted
> changes..." entry.
>
> Since it was suggested on #irc, I tried "git config --global
> core.trustctime false" but that didn't help, which I suppose was
> expected since the documentation talks about differences between
> the index and the working copy and I haven't added anything to the
> index.
>
> I can reproduce this problem with another (private) repository as
> well.

I used bisect to find which commit introduced this bug and the
result is:

7faee6b8de836904227ee98dc3d2c4c75b0ef3a1 is first bad commit
commit 7faee6b8de836904227ee98dc3d2c4c75b0ef3a1
Author: Mark Levedahl <mlevedahl@gmail.com>
Date:   Mon Oct 13 00:33:31 2008 -0400

    compat/cygwin.c - Use cygwin's stat if core.filemode == true

    Cygwin's POSIX emulation allows use of core.filemode true, unlike native
    Window's implementation of stat / lstat, and Cygwin/git users who have
    configured core.filemode true in various repositories will be very
    unpleasantly surprised to find that git is no longer honoring that option.
    So, this patch forces use of Cygwin's stat functions if core.filemode is
    set true, regardless of any other considerations.
   
    Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

:040000 040000 8cbed462649839a444f63c54ddc5b1a0fb5eed8e 4dab6846ae35f2c5d2971d5810c30b39278c7060 M      Documentation
:040000 040000 f64d96b06609aadc586fa4312a57900c911779df cbf9743456a38bb3584e48e27d4659e8ec3b0be4 M      compat

-- 
Hannu
