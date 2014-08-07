From: Nico Williams <nico@cryptonector.com>
Subject: Re: "Branch objects" (was: Re: cherry picking and merge)
Date: Thu, 7 Aug 2014 12:22:08 -0500
Message-ID: <20140807172207.GP23449@localhost>
References: <CANQwDwcHSO+KwhZbo4BTcWnAWGWbJzNQ7CY2m3nq+p0t9uDeqg@mail.gmail.com>
 <20140806200726.GE23449@localhost>
 <alpine.LSU.2.00.1408071222510.13901@hermes-1.csi.cam.ac.uk>
 <20140807155828.GM23449@localhost>
 <alpine.LSU.2.00.1408071735410.23775@hermes-1.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Mike Stump <mikestump@comcast.net>,
	git discussion list <git@vger.kernel.org>
To: Tony Finch <dot@dotat.at>
X-From: git-owner@vger.kernel.org Thu Aug 07 19:22:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XFROK-0001MC-PD
	for gcvg-git-2@plane.gmane.org; Thu, 07 Aug 2014 19:22:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932422AbaHGRWN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Aug 2014 13:22:13 -0400
Received: from sub4.mail.dreamhost.com ([69.163.253.135]:34200 "EHLO
	homiemail-a86.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932263AbaHGRWK (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Aug 2014 13:22:10 -0400
Received: from homiemail-a86.g.dreamhost.com (localhost [127.0.0.1])
	by homiemail-a86.g.dreamhost.com (Postfix) with ESMTP id 260C5360075;
	Thu,  7 Aug 2014 10:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=cryptonector.com; h=date
	:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=cryptonector.com; bh=KoPpxgE6GowD7k
	/rXWjswWzW0Ks=; b=wJS3raPQTBgUcZvlVxwYRAKdncTDaVg/O+jTVpYUXMB7/5
	PzhOpRzUKTU30luMqVYBW1nuZZ5YWBp2bjxtGWRRfz8zx0puq1S0HmZOMEHVihr5
	afRYWyIxOALfY7rj8ce4pekns6DoT+7CU/X9rQGlYPkQGXC0XLdW8+Z/PlH/k=
Received: from localhost (108-207-244-174.lightspeed.austtx.sbcglobal.net [108.207.244.174])
	(Authenticated sender: nico@cryptonector.com)
	by homiemail-a86.g.dreamhost.com (Postfix) with ESMTPA id 4AB5136006B;
	Thu,  7 Aug 2014 10:22:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.00.1408071735410.23775@hermes-1.csi.cam.ac.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254981>

On Thu, Aug 07, 2014 at 05:42:34PM +0100, Tony Finch wrote:
> Nico Williams <nico@cryptonector.com> wrote:
> > On Thu, Aug 07, 2014 at 12:38:48PM +0100, Tony Finch wrote:
> > > But [a rebasing workflow] is inconvenient for deploying the patched
> > > version to production (which is the point of developing the fixes) - I
> > > want a fast-forwarding branch for that.
> >
> > I'm not sure I follow this.  You deploy what you build, and you build
> > the HEAD of the production branch, whatever that is.  If it gets
> > rebased, so it it does.
> 
> The problem is that the production branch gets copied around: pushed to
> the repo server, pulled by other team members, etc. Forced pushes
> are accident-prone, as is resetting a rebased branch after a pull.

When I rebase and I need the old HEAD around I do something like this:

$ git checkout $branch_to_rebase
$ ver=${branch_to_rebase##*-}
$ git checkout -b ${branch_to_rebase%-${ver}}-$((ver+1))
$ git rebase ...

or like this:

$ git checkout $branch_to_rebase
$ git branch ${branch_to_rebase}-$(date +%Y-%m-%d)
$ git rebase ...

Either way I retain the old HEAD with some name.  This requires
discipline, so scripting it is useful.  But if you want discipline then
you want git to know that "for this branch, don't prune/gc old HEADs
orphaned after rebases" and "push the rebase history for this branch".

> > > https://git.csx.cam.ac.uk/x/ucs/git/git-repub.git
> >
> > Yeah, that's useful.
> 
> Glad you think so :-)

Thank you.

Nico
-- 
