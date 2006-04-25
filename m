From: Sam Vilain <sam@vilain.net>
Subject: Re: [RFC] [PATCH 0/5] Implement 'prior' commit object links
Date: Wed, 26 Apr 2006 11:19:24 +1200
Message-ID: <444EAE7C.5010402@vilain.net>
References: <20060425035421.18382.51677.stgit@localhost.localdomain> <7vwtde2q1z.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 26 01:19:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FYWom-0000sV-VH
	for gcvg-git@gmane.org; Wed, 26 Apr 2006 01:19:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932285AbWDYXTi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Apr 2006 19:19:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932311AbWDYXTi
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Apr 2006 19:19:38 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:3457 "EHLO watts.utsl.gen.nz")
	by vger.kernel.org with ESMTP id S932285AbWDYXTh (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Apr 2006 19:19:37 -0400
Received: by watts.utsl.gen.nz (Postfix, from userid 65534)
	id B247F4FBB; Wed, 26 Apr 2006 11:19:35 +1200 (NZST)
Received: from [127.0.0.1] (longdrop.watts.utsl.gen.nz [192.168.255.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by watts.utsl.gen.nz (Postfix) with ESMTP id 7A6BE1D7A;
	Wed, 26 Apr 2006 11:19:25 +1200 (NZST)
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vwtde2q1z.fsf@assigned-by-dhcp.cox.net>
X-Enigmail-Version: 0.92.1.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.watts.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=5.0 tests=ALL_TRUSTED autolearn=failed 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19179>

Junio C Hamano wrote:

>> 2. revising published commits / re-basing
>>
>>    This is what "stg" et al do.  The tools allow you to commit,
>>    rewind, revise, recommit, fast forward, etc.
>>    
>>
>
>stg wants to have a link to the fork-point commit.  I do not
>know if it is absolutely necessary (you might be able to figure
>it out using merge-base, I dunno).
>  
>

"stg pull" and "stg pick" could conceivably link individual patches in a
patchset to their precedent in a previous series. This would make
looking at the evolution of individual patches over time more feasible.

>>    In this case, the "prior" link would point to the last revision of
>>    a patch.  Tools would probably
>>    
>>
>
>Probably what...???
>  
>

...probably support this as an explicit operation - ie "publish", so
that winding whilst developing is not tracked.

>> 3. sub-projects
>>
>>    In this case, the commit on the "main" commit line would have a
>>    "prior" link to the commit on the sub-project.  The sub-project
>>    would effectively be its own head with copied commits objects on
>>    the main head.
>>    
>>
>
>You say you can have only one "prior" per commit, which makes
>this unsuitable to bind multiple subprojects into a larger
>project (the earlier "bind" proposal allows zero or more).
>  
>

It would still support that. Each commit to the sub-project involves a
change to the tree of the "main" commit line (a copy of the commit into
a sub-directory of it). The advantage is that the "tree" in the main
commit is the combined tree, you don't need to treat the case specially
to just get the contents out.

This is kind of like how SVK works by default - you have one local
repository, inside which you track remote repositories. Each commit on
the upstream repository is copied individually into your own repository.
So your local repository numbers easily reach into tens of thousands
(small numbers in git land, I know) while the upstream revisions are
just in the thousands.

>There may be some narrower concrete use case for which you can
>devise coherent semantics, and teach tools and humans how to
>interpret such inter-commit relationship that are _not_
>parent-child ancestry.  For example, if you have one special
>link to point at a "cherry-picked" commit, rebasing _could_ take
>advantage of it.  When your side branch tip is at D, and commit
>D has "this was cherry-picked from commit E" note, and if you
>are rebasing your work on top of F:
>
>        A---B---C---D
>       /
>  o---o---E---F
>
>the tool can notice that F can reach E and carry forward only A,
>B, and C on top of F, omitting D.  So having such a link might
>be useful.  But if that is what you are going to do, I do not
>think you would want to conflate that with other inter-commit
>relationships, such as "previous hydra cap".
>  
>

Right, I see the problem, a strong argument for a more generic solution
as you presented.

Sam.
