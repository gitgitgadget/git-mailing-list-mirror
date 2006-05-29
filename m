From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH] git-receive-pack needs to set umask(2)
Date: Mon, 29 May 2006 07:33:18 -0400
Message-ID: <20060529113318.GA27254@spearce.org>
References: <v0irnpn8ea.fsf@marajade.sandelman.ca> <e5d6i0$rnf$1@sea.gmane.org> <Pine.LNX.4.63.0605290910210.8863@wbgn013.biozentrum.uni-wuerzburg.de> <447ADAEF.3030806@Intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 29 13:34:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fkfzx-0002dc-LK
	for gcvg-git@gmane.org; Mon, 29 May 2006 13:33:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750767AbWE2LdX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 May 2006 07:33:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750791AbWE2LdX
	(ORCPT <rfc822;git-outgoing>); Mon, 29 May 2006 07:33:23 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:31911 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1750767AbWE2LdW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 May 2006 07:33:22 -0400
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1Fkfzp-0004RJ-De; Mon, 29 May 2006 07:33:17 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 01B0020E445; Mon, 29 May 2006 07:33:18 -0400 (EDT)
To: Salikh Zakirov <Salikh.Zakirov@Intel.com>
Content-Disposition: inline
In-Reply-To: <447ADAEF.3030806@Intel.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20943>

Salikh Zakirov <Salikh.Zakirov@Intel.com> wrote:
> Johannes Schindelin wrote:
> > See also
> > 
> > http://thread.gmane.org/gmane.comp.version-control.git/13856/focus=13876
> 
> I've read the thread, but couldn't find a practical solution there.
>  
> > The essence of the thread: If you want to do anything useful in a non-bare 
> > repository, you are likely using other tools than git, which do not 
> > interpret core.umask or $GIT_DIR/umask.
> > 
> > If you use a bare repository, just make it shared. No need for an umask.
> 
> Could you please elaborate on what does it mean "make it shared"?
> 
> My setup: I have a bare GIT repository on a machine, where everybody can
> SSH into (with full shell access). I've assigned the repo to a special group
> where everybody belongs, and done a 'find repo.git -type d | xargs chmod 2775'
> 
> The problem: After someone pushed to the repository, the object directories 
> (i.e repo.git/objects/??)
> get created with 755 access rights, and effectively prevent everyone else from pushing
> objects starting with the same prefix.
> 
> The obvious solution to use umask 002 is not applicable, because
> 1) It does not seem practical to enforce umask 002 in everyone's rc files, 
> because just one forgetful or careless person can break access for all others
> 2) I have 'umask 002' in my ~/.profile. Somehow, it does not help,
> because ~/.profile is not read on non-interactive SSH sessions
> (to verify that, just try to do 'ssh somehost umask')
> 
> The current workaround for the problem is a cron script, which
> makes 'find | xargs chmod 2775' every 5 minutes. It works, but is ugly.
> 
> Is there any better way to keep correct access rights in a shared repository?

Try setting 'core.sharedRepository' to true:

	git repo-config core.sharedRepository true

and running your chmod script one last time.  See
Documentation/config.txt for some details on this switch.

-- 
Shawn.
