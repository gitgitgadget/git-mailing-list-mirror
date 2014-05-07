From: Max Kirillov <max@max630.net>
Subject: Re: Pull is Mostly Evil
Date: Thu, 8 May 2014 01:37:52 +0300
Message-ID: <20140507223752.GA13933@wheezy.local>
References: <5363BB9F.40102@xiplink.com>
 <xmqqoazgaw0y.fsf@gitster.dls.corp.google.com>
 <5364A143.1060404@bbn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Git Mailing List <git@vger.kernel.org>
To: Richard Hansen <rhansen@bbn.com>
X-From: git-owner@vger.kernel.org Thu May 08 00:38:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WiATV-0007s5-Db
	for gcvg-git-2@plane.gmane.org; Thu, 08 May 2014 00:38:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751990AbaEGWiB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2014 18:38:01 -0400
Received: from p3plsmtpa06-05.prod.phx3.secureserver.net ([173.201.192.106]:45329
	"EHLO p3plsmtpa06-05.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751975AbaEGWiA (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 May 2014 18:38:00 -0400
Received: from wheezy.local ([82.181.158.170])
	by p3plsmtpa06-05.prod.phx3.secureserver.net with 
	id zAdr1n00E3gsSd601Adxpf; Wed, 07 May 2014 15:37:59 -0700
Content-Disposition: inline
In-Reply-To: <5364A143.1060404@bbn.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248386>

Hi.

I might be late to this discussion, but here either
something I don't understand or something is missed.

On Sat, May 03, 2014 at 03:56:51AM -0400, Richard Hansen wrote:
> In my experience 'git pull' is mostly (only?) used for the following
> three tasks:
> 
>  1. update a local branch to incorporate the latest upstream changes
> 
>     In this case, the local branch (master) is a
>     derivative of the upstream branch (origin/master).
>     The user wants all of the commits in the remote branch
>     to be in the local branch.  And the user would like
>     the local changes, if any, to descend from the tip of
>     the remote branch.
> 
>     For this case, 'git pull --ff-only' followed by 'git
>     rebase -p' works well, as does 'git pull
>     --rebase=preserve' if the user is comfortable rebasing
>     without reviewing the incoming commits first.  A plain
>     'git pull' or 'git pull --ff' is suboptimal due to the
>     awkward backwards-parents merge commit.

This is actually not a finally defined use case. What kind
of "local changes" user can have ahead of the remote? As
far I understand, there are 3 cases:

 1a. Changes that are going to be merged back to the master,
     but not yet ready to be there.

This is essentially the same as case 2, but it does not name
the development branch explicitely. Switching parents for
this case is not desirable.

 1b. Some truly local changes which never goes anywhere.

For this case the parent order does not matter.

 1c. The local changes prepared for integration, but instead
     of filing a pull request of otherwise publishing the
     branch for integrator, the leaf developer does the
     integrator's job and merges it back to master and then
     publishing the master.

As far as I understand, this is the only case when somebody
would want the parents to be switched. And this does not
seem to be a good practice, because it's prone to push races
and requires letting everyone to push to master. So maybe
git should not encourage people to do so.

And the name "update", proposed here, does not seem to be
correct. Because what happens is not updating, but merging
feature to master and closing it.

>  2. update a published feature branch with the latest
>     changes from its parent branch

>  3. integrate a more-or-less complete feature/fix back
>     into the line of development it forked off of

-- 
Max
