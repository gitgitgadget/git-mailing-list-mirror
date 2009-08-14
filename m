From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: merging individual files
Date: Fri, 14 Aug 2009 17:28:24 +0200
Message-ID: <4A858298.4020702@drmicha.warpmail.net>
References: <loom.20090813T192334-7@post.gmane.org> <4A851887.5010701@drmicha.warpmail.net> <loom.20090814T135614-375@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Chris Marshall <christopher.marshall@merchantlink.com>
X-From: git-owner@vger.kernel.org Fri Aug 14 17:28:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mbyi0-0007no-4r
	for gcvg-git-2@gmane.org; Fri, 14 Aug 2009 17:28:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754791AbZHNP2i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Aug 2009 11:28:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932559AbZHNP2i
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Aug 2009 11:28:38 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:36811 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754039AbZHNP2i (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Aug 2009 11:28:38 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 7093351BBA;
	Fri, 14 Aug 2009 11:28:38 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Fri, 14 Aug 2009 11:28:38 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=ZiyiRU251IX0GACgXP6pl4PUZqE=; b=mau99A02baF/xVPXqlYkaeWCrgvQLfQ1h8ald6FBlIHgb06wHTjtHwUGSxPUjHIu/yCYUxAnYmyvSAVYj5KY468VLruMVE5g6/gJVCXEjYSgT+3wFtFIn1dtOQhccaLANrKgA1IVC0RVrYFOao04GPYniyoE7niYRNULus8BxRc=
X-Sasl-enc: KRigVjmtuZ+e3B2568606N7QImK2F9ulydCMltcM7faH 1250263718
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id C7ADC31DD1;
	Fri, 14 Aug 2009 11:28:37 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.3pre) Gecko/20090814 Lightning/1.0pre Shredder/3.0b4pre
In-Reply-To: <loom.20090814T135614-375@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125931>

Chris Marshall venit, vidit, dixit 14.08.2009 16:31:
> Michael J Gruber <git <at> drmicha.warpmail.net> writes:
>>> This strikes me as not too bad of a procedure, as long as there is a 
> graceful
>>> way of determining the most recent common ancestor of br1 and master.  
> What's
>>> the simplest way of doing that?
>>>
>>
>> That would be simply git merge-base master br1.
>>
>> BUT: The main problem here is that git is not file based, but
>> revision/commit/tree based. In the above, you're basically losing all
>> the history common_ancestor_commit..br1 which produced br1's version of
>> f1 and f2, in the sense that a git log master will not show that part of
>> the history at all.
> 
> Well put, I agree.  One of the main arguments I am going to use to try to 
> convince my fellows to switch from perforce to git is the usefulness of git 
> blame.  I would be defeating that with my procedure.
> 
>>
>> If it makes sense to change f1 and f2 without changing f3 that probably
>> means that the pertinent commit should have been split. Is it an option
>> for you to rewrite br1's history? That would be the most gittish solution.
> 
> Yes, I like the idea of rewriting br1's history.
> 
> So, given that f1, f2, ..., fn were changed together in one commit X on br1, I 
> want to break f1 and f2 out of X and put them into X', then leave the rest of 
> the f3,...,fn changes in Y'.
> 
> Let's say X was the last commit on br1.  
> 
> What would the commands to do that look like?
> 

If you're on br1, I would:

git rebase -i X^
# change "pick" to "edit" in front of X in the list you get
git checkout X^ -- f3 f4 f5
git commit --amend
git checkout X -- f3 f4 f5
git commit

For the 2nd commit, using the -c option may be beneficial.

Cheers,
Michael
