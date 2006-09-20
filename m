From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH] add receive.denyNonFastforwards config variable
Date: Wed, 20 Sep 2006 18:46:40 -0400
Message-ID: <20060920224640.GH24415@spearce.org>
References: <Pine.LNX.4.63.0609210027430.19042@wbgn013.biozentrum.uni-wuerzburg.de> <7vfyemf9ah.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 21 00:47:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQAq9-0005yw-K9
	for gcvg-git@gmane.org; Thu, 21 Sep 2006 00:46:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932437AbWITWqq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Sep 2006 18:46:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932438AbWITWqq
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Sep 2006 18:46:46 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:38626 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S932437AbWITWqp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Sep 2006 18:46:45 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GQAps-00068f-WF; Wed, 20 Sep 2006 18:46:33 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 9C98F20E48E; Wed, 20 Sep 2006 18:46:40 -0400 (EDT)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vfyemf9ah.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27423>

Junio C Hamano <junkio@cox.net> wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > If receive.denyNonFastforwards is set to true, git-receive-pack will deny
> > non fast-forwards, i.e. forced updates. Most notably, a push to a repository
> > which has that flag set to true will fail.
> >
> > As a first user, 'git-init-db --shared' sets this flag, since in a shared
> > setup, you are most unlikely to want forced pushes to succeed.
> 
> I am Ok with the general idea, but ...
> 
> > @@ -127,6 +129,16 @@ static int update(struct command *cmd)
> >  		return error("unpack should have generated %s, "
> >  			     "but I can't find it!", new_hex);
> >  	}
> > +	if (deny_non_fast_forwards) {
> > +		struct commit *old_commit, *new_commit;
> > +		old_commit = (struct commit *)parse_object(old_sha1);
> > +		new_commit = (struct commit *)parse_object(new_sha1);
> > +		struct commit_list *bases = get_merge_bases(old_commit,
> > +				new_commit, 1);
> > +		if (!bases || hashcmp(old_sha1, bases->item->object.sha1))
> > +			return error("denying non-fast forward;"
> > +					" you should pull first");
> > +	}
> >  	safe_create_leading_directories(lock_name);
> >  
> >  	newfd = open(lock_name, O_CREAT | O_EXCL | O_WRONLY, 0666);
> 
> I am wondering if there can be more than one base and the old_sha1
> is not returned as the first one.

Not to mention how does this work when the ref didn't exist?
Is this entire block of code being bypassed by something not show
in the context?

-- 
Shawn.
