From: Jan Hudec <bulb@ucw.cz>
Subject: Re: Moving .git around
Date: Sun, 3 Aug 2008 20:51:29 +0200
Message-ID: <20080803185129.GB3482@efreet.light.src>
References: <93c3eada0807231832o6b7689c4j2913253d7ced62ba@mail.gmail.com> <fcaeb9bf0807231912t6f20d508va1381f324a8981aa@mail.gmail.com> <93c3eada0807231936ib103824u9204f1109119e1c2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org
To: Geoff Russell <geoffrey.russell@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 03 20:52:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPih3-0003SL-7D
	for gcvg-git-2@gmane.org; Sun, 03 Aug 2008 20:52:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752734AbYHCSvf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Aug 2008 14:51:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752719AbYHCSvf
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Aug 2008 14:51:35 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:41951 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752639AbYHCSve (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Aug 2008 14:51:34 -0400
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id C48B05735C;
	Sun,  3 Aug 2008 20:51:33 +0200 (CEST)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id bA54Aoo9wV3l; Sun,  3 Aug 2008 20:51:31 +0200 (CEST)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id 7AE52572B3;
	Sun,  3 Aug 2008 20:51:30 +0200 (CEST)
Received: from bulb by efreet.light.src with local (Exim 4.69)
	(envelope-from <bulb@ucw.cz>)
	id 1KPifx-0001U2-QJ; Sun, 03 Aug 2008 20:51:29 +0200
Content-Disposition: inline
In-Reply-To: <93c3eada0807231936ib103824u9204f1109119e1c2@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91259>

On Thu, Jul 24, 2008 at 12:06:28 +0930, Geoff Russell wrote:
> On Thu, Jul 24, 2008 at 11:42 AM, Nguyen Thai Ngoc Duy
> <pclouds@gmail.com> wrote:
> > On 7/24/08, Geoff Russell <geoffrey.russell@gmail.com> wrote:
> >> For reasons which would take a while to explain, I'm building a repository
> >>  in a directory  using "--git-dir=xxxx/.git --work-tree=." and
> >>  then doing an "mv  xxxx/.git ./.git"  and then trying to work with
> >>  that repository  --- but can't
> >>
> >>  Below is a sample script. The last line (git add) fails with
> >>
> >>  fatal: unable to create
> >>  '/usr/local/AusTop/AuPrograms/AuServer/testgit/aaa/bbb/.git/index.lock':
> >>  No such file or directory
> >>
> >>  git doesn't seem to realise that there is a .git back up the tree.
> >
> > It's because when you did git --work-tree=. init, worktree is stored
> > in .git/config. The code that chdir() in setup_git_directory()
> > probably forgot to chdir() back to toplevel worktree. Workaround could
> > be just remove core.worktree in .git/config.
> 
> Many thanks, the work-around works. I'm not sure if this is a bug or
> a feature, but I'm happy either way.

That depends on what the value of core.worktree is:
 - If it is '.', than I think it should be considered a bug in git init,
   because that value is just plain nonsense.
 - If it is '..', than it's a user error and the right thing is to just
   remove it when you relocate the .git directory.
 - If it was '/usr/local/AusTop/AuPrograms/AuServer/testgit/' than it would
   have worked, so it's not that.

Best regards,
Jan

-- 
						 Jan 'Bulb' Hudec <bulb@ucw.cz>
