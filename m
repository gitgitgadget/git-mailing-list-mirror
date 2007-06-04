From: Raja R Harinath <rharinath@novell.com>
Subject: Re: How to use git-svn to clone from a mirror?
Date: Mon, 04 Jun 2007 20:41:29 +0530
Organization: Linux Private Site
Message-ID: <85myzfsqji.fsf@blr-RHarinath.blr.novell.com>
References: <86hcpq8qjz.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 04 17:08:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvEAF-0004we-CW
	for gcvg-git@gmane.org; Mon, 04 Jun 2007 17:08:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753792AbXFDPIH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Jun 2007 11:08:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750987AbXFDPIH
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jun 2007 11:08:07 -0400
Received: from main.gmane.org ([80.91.229.2]:38132 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750808AbXFDPIF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jun 2007 11:08:05 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HvEA7-000185-CP
	for git@vger.kernel.org; Mon, 04 Jun 2007 17:08:03 +0200
Received: from 125.16.129.16 ([125.16.129.16])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 04 Jun 2007 17:08:03 +0200
Received: from rharinath by 125.16.129.16 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 04 Jun 2007 17:08:03 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 125.16.129.16
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.3 (gnu/linux)
Cancel-Lock: sha1:rH55etPs6ndiEELhma2KbDKOqSM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49105>

Hi,

David Kastrup <dak@gnu.org> writes:

> Hi, I seem to be too stupid to get this right.
>
> I have used something like
>
> git-svn clone -T trunk -b branches -t tags file:///tmp/rsync-mirror
>
> to clone an rsync mirror of an SVN repository.  Now I want to have
> fetch revert to pulling from the upstream repository in future.
> However, if I change the respective line in .git/config to
> svn://the.svn.link/whatever, git-rebase will fetch the right updates,
> but then says that it can't work with the objects in the git
> repository.
>
> Changing the config back will make git-rebase -l work.
>
> So what would be the right procedure to shift the SVN source from an
> rsync mirror to the original, without git-svn breaking?

I think you'll have to

-------------8<------------
  # remove stored revision db, since we're going to change all the commit ids
  rm .git/svn/git-svn/.rev_db.*

  # rewrite git-svn-id: lines
  cg-admin-rewritehist \
	--msg-filter \
	'sed "s,file:///tmp/rsync-mirror,svn://the.svn.link/whatever,"'

  # recreate new revision db, and fetch updates, if any
  git-svn rebase
-------------8<------------

- Hari
