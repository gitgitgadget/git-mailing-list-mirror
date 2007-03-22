From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH] have merge put FETCH_HEAD data in commit message
Date: Thu, 22 Mar 2007 09:10:27 +0000
Message-ID: <200703220910.29030.andyparkins@gmail.com>
References: <20070321120643.GI20583@mellanox.co.il> <7v648u38ws.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>,
	"Michael S. Tsirkin" <mst@dev.mellanox.co.il>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 22 10:10:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HUJJd-0003Dp-TP
	for gcvg-git@gmane.org; Thu, 22 Mar 2007 10:10:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030298AbXCVJKf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Mar 2007 05:10:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030283AbXCVJKf
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Mar 2007 05:10:35 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:59081 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030298AbXCVJKe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Mar 2007 05:10:34 -0400
Received: by nf-out-0910.google.com with SMTP id o25so1394690nfa
        for <git@vger.kernel.org>; Thu, 22 Mar 2007 02:10:33 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=fakonA4k0kdRKs6k0h2AtwxcdKVPpjfF6yDJowlwvjEOXkNpHMK0OhM9qH0FxT8XCXSYmqzv0g9ka2igUc3j7gcQLGRMXTpybWJSmPzdD09iJunxPMBVs3MztorXvlMAdLfmfSZ/iF3E1JWXFqf4pmtih+ktaR3BltmgwhitULA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=AmcJjwIWNALHzZpMCPPYzF+yY7/vijQSdusVkpgX2RuAeVyOoTZ/J8jE2ZGaYIPAs2P4pMO1eAjKqEDLd7/iNr1tJECWsk431AhYdh81fFp3grACML28GsFQYQi6jl1oys7WYRg5ClmpcKxP7cULMRnGTy9S3Vz29DCMAa+sOAk=
Received: by 10.78.195.9 with SMTP id s9mr796798huf.1174554633321;
        Thu, 22 Mar 2007 02:10:33 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTP id g1sm8042169nfe.2007.03.22.02.10.32;
        Thu, 22 Mar 2007 02:10:32 -0700 (PDT)
User-Agent: KMail/1.9.5
In-Reply-To: <7v648u38ws.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42852>

On Wednesday 2007 March 21 15:37, Junio C Hamano wrote:

> I often hear from people who seems to like "fetch & merge",
> instead of "pull & reset ORIG_HEAD", as a workflow to avoid
> undesirable merging.  This might largely be a matter of taste,
> but from philosophical point of view, fetch & merge is a sign of
> distrust (your default is not to merge, and you merge only when
> you choose to), and pull & reset is the opposite (your default
> is to merge, and after you inspect you may choose not to merge).
> Tool support to encourage the former feels somewhat wrong.

It's definitely not wrong - and I realise you aren't advocating removing fetch 
& merge; however I wanted to explain why fetch & merge isn't wrong.  I almost 
never use pull; in fact, of the two work methods you mention, I can't see 
that git-pull would ever be the my regular use case (I wonder if I'm missing 
something and need enlightening?)

Use case (1)

A colleague and I work on the same project; with fundamentally the same code 
base.  He commits to one branch and I commit to an other.  I want to be able 
to see what he's doing, but definitely don't want to merge that branch.  
Regular git-fetch sorts that out.  Occasionally, his branch stabilises to the 
point were we want to merge my changes in.  I'm more familiar with both 
branches than him so it's better if I do the merge and resolve the conflicts.  
git-merge does that job.

Strangely enough, I've also found that it's better to resolve some commits 
before the merge is done.  Using "git-diff mybranch hisbranch" often shows 
changes that are going to conflict, but don't need to - this is usually 
things like "// comment this block out while I'm testing something else".


Use case (2):

I keep branches around for submission to git.  Whenever they're ready to go I 
rebase them on to master resolve conflicts and email them in.  That is 
git-fetch, git-rebase.  I have never run git-pull on my git repository.


Use case (3):

I'm tracking an upstream project that uses svn; git-svn makes light work of 
keeping up to date with it and keeping a "git-svn" branch to track it.  I 
keep my own local changes to it - never for submission upstream - in a 
separate branch; infrequently I merge the upstream branch into my own.


Your favoured case misses out one significant step:
 * git-pull
 * Spend time resolving conflicts
 * git-reset ORIG_HEAD
It's not a sign of distrust that I don't do git-pull; I trust git to do a 
fantastic job when that moment comes.  However, it is a sign of laziness - 
why should I want to resolve conflicts just so they can be thrown away when I 
don't like them.


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
