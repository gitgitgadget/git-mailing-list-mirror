From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: StGIT discards local commits on "stg pull"
Date: Mon, 19 Feb 2007 23:07:09 +0000
Message-ID: <b0943d9e0702191507m636348e7yab2a712925f9f55@mail.gmail.com>
References: <20070212022625.rvyyo0kc0wowgogc@webmail.spamcop.net>
	 <b0943d9e0702120131r528fb29ete143b8ce5a0a99e9@mail.gmail.com>
	 <20070212202634.GX4266@nan92-1-81-57-214-146.fbx.proxad.net>
	 <20070212214704.GS5362@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Pavel Roskin" <proski@gnu.org>, git@vger.kernel.org
To: "Yann Dirson" <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Tue Feb 20 00:07:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJHbM-0005SB-Rg
	for gcvg-git@gmane.org; Tue, 20 Feb 2007 00:07:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965517AbXBSXHR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Feb 2007 18:07:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965523AbXBSXHR
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Feb 2007 18:07:17 -0500
Received: from an-out-0708.google.com ([209.85.132.241]:1159 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965517AbXBSXHP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Feb 2007 18:07:15 -0500
Received: by an-out-0708.google.com with SMTP id b33so252579ana
        for <git@vger.kernel.org>; Mon, 19 Feb 2007 15:07:15 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Jb1C7DjKoCXDW5VEV57noiVvj1ZKeAC2mnJZFHkgclLa3n67jRubXJbIbGonS+hkVwrFADlScvz2GO87ehDE59L5i2eu+wauOo2CMIU834FRRG2nvi+CQ1B4TuwHSCAW0Gi9j0JyEESgBAZgX3DBfid63Lj5kEF9HraMh+izx4w=
Received: by 10.114.205.1 with SMTP id c1mr3110718wag.1171926434698;
        Mon, 19 Feb 2007 15:07:14 -0800 (PST)
Received: by 10.115.110.12 with HTTP; Mon, 19 Feb 2007 15:07:09 -0800 (PST)
In-Reply-To: <20070212214704.GS5362@nan92-1-81-57-214-146.fbx.proxad.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40159>

On 12/02/07, Yann Dirson <ydirson@altern.org> wrote:
> On Mon, Feb 12, 2007 at 09:26:34PM +0100, Yann Dirson wrote:
> > No, I agree it's a bug.  Rebasing after a fetch should allow this
> > workflow to work as well.  If the parent branch is not a rewinding
> > one, we should ensure there is nothing lost.  And even for rewinding
> > branches, we should probably keep track of the existence of commits,
> > so we can warn and nothing gets lost without knowing.
>
> Thinking about it, detecting whether we're going to lose a commit is
> just checking *before pulling* whether the current base is reachable
> from the parent's current head.

There is a potential problem with this approach - pulling/fetching
from a tree which is always rebased (either managed with StGIT or
simply running git-rebase before publishing it) would report an error
since the old base is no longer reachable from the current head. In
this case, the current fetch+rebase behaviour would be desirable.

I think the fail-safe solution would be to leave the old behaviour
(i.e. git-pull and pull-does-rebase=no) and people that need to pull
from branches like that described above would use the fetch+rebase
approach. Ideally, we'll have this configurable per-branch (and could
leave the global one as well if the most specific is not available,
but should default to git-pull).

Let me know what you think so that I'll try to release a 0.12.1 update
(I already have the simple patch for using git-pull by default if you
are OK with this scenario).

Thanks.

-- 
Catalin
