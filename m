From: Jacob Helwig <jacob.helwig@gmail.com>
Subject: Re: Fatal error running status in new repo
Date: Mon, 15 Feb 2010 22:24:22 -0800
Message-ID: <20100216062422.GC10296@vfb-9.home>
References: <20100216041945.GB10296@vfb-9.home>
 <20100216060528.GB2169@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 16 07:24:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhGrI-0001Ry-Cx
	for gcvg-git-2@lo.gmane.org; Tue, 16 Feb 2010 07:24:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753295Ab0BPGY1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2010 01:24:27 -0500
Received: from mail-px0-f191.google.com ([209.85.216.191]:58878 "EHLO
	mail-px0-f191.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753079Ab0BPGY0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2010 01:24:26 -0500
Received: by pxi29 with SMTP id 29so1575727pxi.1
        for <git@vger.kernel.org>; Mon, 15 Feb 2010 22:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=SZzPXkQUUox2RRklPsQ6NjyLVVMSr0+v3P1wSR52NtY=;
        b=b4GwZp8t9qha525Q4yAzME+fUiUGv2mxzt2DJZ2FnRBH6ttmiHovg3B/S3MwHrcmhW
         zFkb2y7913qfaTehfor0PXyjaqkrmMEfzEts+mSmEUgYuY4YrF92oboeX+wzpWNPo3c/
         wY5SZL4Rp6ZLoUoDrpKSEa9Yl99In6ai758Yc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=hkEXPMGFngNS6xCkOLhPiueNN7je8ztVk4rfTEF5APFz18JrpCT6IK6QviRH2ewhVT
         OaZq8DKAW+K2rSHpwx4OcwkCJIt+kqS7oqo88p47gkgbZWlaiIeWSM8ShN/tUYuEJJb+
         FHEVpWvlXZVKEGjEvfcUJUrqxc2RaQipGy62Q=
Received: by 10.143.154.37 with SMTP id g37mr1229765wfo.316.1266301465668;
        Mon, 15 Feb 2010 22:24:25 -0800 (PST)
Received: from vfb-9.home ([96.225.220.117])
        by mx.google.com with ESMTPS id 23sm1205450pzk.12.2010.02.15.22.24.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 15 Feb 2010 22:24:24 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20100216060528.GB2169@coredump.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140070>

On 01:05 Tue 16 Feb     , Jeff King wrote:
> On Mon, Feb 15, 2010 at 08:19:45PM -0800, Jacob Helwig wrote:
> 
> > I just noticed this when creating a new repo for a project.
> > 
> > $ mkdir tmp
> > $ cd tmp
> > $ git init
> > Initialized empty shared Git repository in /home/jhe/projects/tmp/.git/
> > $ git status
> > # On branch master
> > #
> > # Initial commit
> > #
> > warning: ignoring dangling symref HEAD.
> > fatal: bad revision 'HEAD'
> > nothing to commit (create/copy files and use "git add" to track)
> > $ echo $?
> > 0
> > $ git --version
> > git version 1.7.0
> 
> I can't reproduce it here:
> 
>   $ mkdir tmp && cd tmp && git init && git status
>   Initialized empty Git repository in /home/peff/tmp/.git/
>   # On branch master
>   #
>   # Initial commit
>   #
>   nothing to commit (create/copy files and use "git add" to track)
> 
> Furthermore, the "ignoring dangling symref" message can only come from
> one place (sha1_name.c:285), and is specifically protected by a
> conditional making sure that the refname is not "HEAD". Which is just
> plain weird.
> 
> Do you have anything strange in your ~/.gitconfig? Can you try running
> with GIT_TRACE=1 to make sure we are not invoking some sub-command or
> something? Did you build git yourself? Can you double-check with a "make
> clean && make" that a newly built version exhibits the problem?
> 
> > Seems a bit silly that "git status" should be issuing warnings, and
> > fatal errors (especially when the exit code is still 0), when run before
> > the first commit has been created in a brand new repository.
> > 
> > The warnings make sense if you know what's going on behind the scenes,
> > but seem like the kind of thing that could scare someone new to git when
> > they haven't actually done anything wrong at this point.
> 
> Agreed. These warnings absolutely should not be shown, but I don't
> really understand what is showing them.
> 
> -Peff

$ GIT_TRACE=1 git status
trace: built-in: git 'status'
# On branch master
#
# Initial commit
#
trace: run_command: 'submodule' 'summary' '--cached' '--for-status' '--summary-limit' '-1' 'HEAD'
trace: exec: 'git' 'submodule' 'summary' '--cached' '--for-status' '--summary-limit' '-1' 'HEAD'
trace: exec: 'git-submodule' 'summary' '--cached' '--for-status' '--summary-limit' '-1' 'HEAD'
trace: run_command: 'git-submodule' 'summary' '--cached' '--for-status' '--summary-limit' '-1' 'HEAD'
trace: built-in: git 'rev-parse' '--git-dir'
trace: built-in: git 'rev-parse' '--show-cdup'
trace: built-in: git 'rev-parse' '-q' '--git-dir'
trace: built-in: git 'rev-parse' '--is-inside-work-tree'
trace: built-in: git 'rev-parse' '-q' '--verify' 'HEAD^0'
warning: ignoring dangling symref HEAD.
trace: built-in: git 'rev-parse' '--show-toplevel'
trace: built-in: git 'diff-index' '--cached' '--raw' 'HEAD' '--' 'HEAD'
fatal: bad revision 'HEAD'
trace: run_command: 'submodule' 'summary' '--files' '--for-status' '--summary-limit' '-1'
trace: exec: 'git' 'submodule' 'summary' '--files' '--for-status' '--summary-limit' '-1'
trace: exec: 'git-submodule' 'summary' '--files' '--for-status' '--summary-limit' '-1'
trace: run_command: 'git-submodule' 'summary' '--files' '--for-status' '--summary-limit' '-1'
trace: built-in: git 'rev-parse' '--git-dir'
trace: built-in: git 'rev-parse' '--show-cdup'
trace: built-in: git 'rev-parse' '-q' '--git-dir'
trace: built-in: git 'rev-parse' '--is-inside-work-tree'
trace: built-in: git 'rev-parse' '-q' '--verify' '^0'
trace: built-in: git 'rev-parse' '--show-toplevel'
trace: built-in: git 'diff-files' '--raw' '--'
nothing to commit (create/copy files and use "git add" to track)

I did build git myself, and "make clean && make" does exhibit the same
behavior. (Specifically: git checkout v1.7.0 && git clean -xfd && make
clean && make)

It looks like this is all because I have status.submodulesummary = true
in my ~/.gitconfig.

-- 
Jacob Helwig
