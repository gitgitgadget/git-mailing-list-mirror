From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: [RFC 2/2] Automatically transform .git/{branches,remotes} into .git/config
Date: Mon, 28 Nov 2005 13:59:04 +0100
Message-ID: <200511281359.04741.Josef.Weidendorfer@gmx.de>
References: <Pine.LNX.4.63.0511211455120.13775@wbgn013.biozentrum.uni-wuerzburg.de> <7vfyph1ebq.fsf@assigned-by-dhcp.cox.net> <438AC32E.5010100@op5.se>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Nov 28 14:00:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EgibA-000525-L0
	for gcvg-git@gmane.org; Mon, 28 Nov 2005 13:59:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932078AbVK1M7I (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 Nov 2005 07:59:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932080AbVK1M7I
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Nov 2005 07:59:08 -0500
Received: from mailout1.informatik.tu-muenchen.de ([131.159.0.18]:19675 "EHLO
	mailout1.informatik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id S932078AbVK1M7H (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Nov 2005 07:59:07 -0500
Received: from dhcp-3s-61.lrr.in.tum.de (dhcp-3s-61.lrr.in.tum.de [131.159.35.61])
	by mail.in.tum.de (Postfix) with ESMTP id 8B33728BC
	for <git@vger.kernel.org>; Mon, 28 Nov 2005 13:59:06 +0100 (MET)
To: git@vger.kernel.org
User-Agent: KMail/1.9
In-Reply-To: <438AC32E.5010100@op5.se>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay2.informatik.tu-muenchen.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12873>

On Monday 28 November 2005 09:43, Andreas Ericsson wrote:
> Junio C Hamano wrote:
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> > 
> > 
> >>I only realized that we -- in the good tradition of UNIX -- have many 
> >>different formats for different configurations: Some configurations are in 
> >>.gitignore, some are in .git/branches/, some in .git/remotes/, some in 
> >>.git/config, and even some in environment variables!
> > 
> > 
> > Can you live with something like this?
> > 
> >  - we will add new ones to config, now we have it;

It is not really fitting for all purposes (eg. syntax restrictions).


> I'd still like to see git-repo-config and git-user-config. Otherwise 
> we'll need to continue having user-based environment variables 
> (GIT_COMMITTER_IDENT and friends).

In fact, it would be nice to have different "config levels" supported
by git. I can imagine:
(1) user config (typically in $HOME/.gitrc)
(2) project config (in .git/project.conf)
(3) repository config; i.e. separate for every clone
    (in .git/repo.conf instead of .git/config as of now?)
Even for one such level, it would be nice to be able to seperate the
config into multiple files; ie. remote config in a .git/remote.conf,
and a porcelain should be able to have its own config files, but still
using git's config parser.

To allow for this, git_config() should not be hardcoded to only
read .git/config, but perhaps a list of files in environment variable
GIT_CONFIG_FILES.

For (2), git-clone should copy some files, e.g. the .git/project.conf
or .git/info/exclude. But project config probably should be kept
up to date among all repositories for a project, i.e. it should be
version controlled itself, but independent from the project.
We could use a project config head .git/refs/projectconfig for this;
of course post-1.0 material.


Josef
