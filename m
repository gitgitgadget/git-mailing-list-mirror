From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: Rebasing a branch that contains merges
Date: Mon, 19 Feb 2007 10:48:23 +0000
Message-ID: <200702191048.24091.andyparkins@gmail.com>
References: <200702190912.24067.andyparkins@gmail.com> <7vmz3a8p6g.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 19 11:48:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJ64Q-0006tr-Q1
	for gcvg-git@gmane.org; Mon, 19 Feb 2007 11:48:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750910AbXBSKsb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Feb 2007 05:48:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750912AbXBSKsb
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Feb 2007 05:48:31 -0500
Received: from nf-out-0910.google.com ([64.233.182.187]:45150 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750910AbXBSKsa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Feb 2007 05:48:30 -0500
Received: by nf-out-0910.google.com with SMTP id o25so2388143nfa
        for <git@vger.kernel.org>; Mon, 19 Feb 2007 02:48:28 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=OrXeQ41xHnICNjVBYDTH4jf1zyryDbMPqDatAEN7IapRRrYB7Hczn9kh5+b0zoXmcgGUB/fEvbxNxKZU9ISx1O17VXuZqe7lzT9JmOg23bRx/sIqfFlTv47nE8yc93XTOIdNHb+AOe4yLpihDPlbRt1XlDdDwoc2yfEAT5NWQHY=
Received: by 10.49.92.18 with SMTP id u18mr5599843nfl.1171882108929;
        Mon, 19 Feb 2007 02:48:28 -0800 (PST)
Received: from davejones ( [194.70.53.227])
        by mx.google.com with ESMTP id d2sm25949064nfe.2007.02.19.02.48.26;
        Mon, 19 Feb 2007 02:48:26 -0800 (PST)
User-Agent: KMail/1.9.5
In-Reply-To: <7vmz3a8p6g.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40116>

On Monday 2007 February 19 09:36, Junio C Hamano wrote:

> > This is an unreasonable thing to expect a version control
> > system to be able to do ...
>
> I do not necessarily think so.  If you have this:

Sorry; by "unreasonable", I meant "unreasonable to expect that your VCS is 
clever enough to do it".  It's an offhand compliment to git; I can't imagine 
any other VCS is capable of this sort of thing, so the discussion wouldn't 
even happen.

> However, you have to be careful.  The thing is, you do not want
> to 'rebase' a merge if the other branch came from somewhere not
> under your control.  If 'a', 'o', 'X', 'Y' and 'M' are under
> your control, and 'x' are from somebody else's tree in the
> following picture:

Absolutely.  We can take that as a given though can't we?  That is always true 
for a rebase, irrespective of whether its got merges in the branch.  As your 
diagrams show, dealing with merges during a rebase just makes things more 
complicated in that you can now have one parent of the merge being rebasable 
and one not.

My original query should have stated my assumption: that all the merged 
branches are mine to rebase as I see fit.

> and if you say "rebase --onto X a Y", it is not useful to rebase
> 'x' when you want to rewrite your history.  They are somebody
> else's history, and other people might have got it already, too.
> Even if you _could_ rebase them, you would rather not.

Coo; this obviously makes things much harder.  What if there are further 
merges on the merged branches?  It's going to get hard to specify which of 
the merge branches you want to rebase and which you don't.

> the tool which parents of merges you would want to rebase and
> which ones you do not want to touch but recreate the merge by
> merging with your rebased branches again.  In the above 'ideal',

So - rebase would need some sort of language to tell it which branch to 
favour.

 $ git checkout branch-with-merges
 $ git rebase other-branch
 rebase: Aborted because commit 123456abcdef has multiple parents:
 rebase:  - 123456789abcdef
 rebase:  - abcdef123456789
 $ git rebase --include-parent abcdef123456789 other-branch

Yuck.  I've made myself ill now.  It's not going to be pretty is it?

For now, I wanted to make git-rebase just abort if there are merge commits in 
the rebased branch, I had a quick look at git-rebase.sh to see if I could 
find the place were this could be detected and have got lost.  So I've failed 
again :-)

At the moment, git-rev-list --no-merges is used.  I don't think that, that's 
the correct thing to do.  That just filters out the merge.  Doesn't that risk 
loss of history as I showed in my first email?


Andy

-- 
Dr Andy Parkins, M Eng (hons), MIEE
andyparkins@gmail.com
