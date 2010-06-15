From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [WIP PATCH 0/3] implement merge strategy for submodule links
Date: Tue, 15 Jun 2010 19:37:43 +0200
Message-ID: <4C17BA67.4060500@web.de>
References: <cover.1276059473.git.hvoigt@hvoigt.net> <201006131959.43356.johan@herland.net> <20100614170222.GB1389@book.hvoigt.net> <201006150159.42680.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Heiko Voigt <hvoigt@hvoigt.net>, git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Tue Jun 15 19:37:53 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOa5B-00075q-Ii
	for gcvg-git-2@lo.gmane.org; Tue, 15 Jun 2010 19:37:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758208Ab0FORhq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jun 2010 13:37:46 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:52018 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752419Ab0FORhp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jun 2010 13:37:45 -0400
Received: from smtp01.web.de  ( [172.20.0.243])
	by fmmailgate03.web.de (Postfix) with ESMTP id EFB3C15685314;
	Tue, 15 Jun 2010 19:37:43 +0200 (CEST)
Received: from [80.128.78.142] (helo=[192.168.178.26])
	by smtp01.web.de with asmtp (WEB.DE 4.110 #4)
	id 1OOa51-0005nL-00; Tue, 15 Jun 2010 19:37:43 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <201006150159.42680.johan@herland.net>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX19MftHWhUSqGrFinn1vJ4nsLHtA/ND55eJhPwBp
	Wcwq62NMHQsZLvBOntfF5jzUfgND4UD/O2ZvRJzo6+bN2axJUb
	RMFFJLaYwP6OCViQI0dA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149211>

Am 15.06.2010 01:59, schrieb Johan Herland:
> My point is that when Git tries to suggest merge resolutions, it should 
> purposefully NOT add these to the index, so that the user HAS to acknowledge 
> them. This is similar to the default behaviour of 'git rerere' which 
> resolves your conflicts automatically, but does not touch the corresponding 
> "unmerged" index entries, so that you manually have to 'git add' the result.

I like that idea, as it avoids having unintended submodule commits added
silently to the superprojects index by the merge.


>> Lets assume Alice creates a feature branch feature_a for her development
>> and needs to modify the submodule and creates a branch there as well. At
>> the same time Bob develops feature_b and also needs changes in the
>> submodule and so he creates a feature branch there as well.
>>
>> Assume we now have the following history in the submodule:
>>
>>   B---C---D         [feature_a]
>>  /         \
>> A---E---F---G---K   [master]
>>      \         /
>>       H---I---J     [feature_b]
>>
>> Now during the development of her branch Alice would link D in the
>> superproject as it is the tip of her branch. Bob would do the same and
>> link to J as his tip. Now Alice sends out her branch to the reviewers
>> and after everybody is happy with it the maintainer merges her branch
>> first. The superproject links to D.
> 
> No. The superproject would get a conflict between the A->D and A->F updates 
> of the submodule. The correct resolution would be to go into the submodule, 
> do the merge to produce G, and then record this as the correct merge 
> resolution in the superproject.

But as far as I understood this patch this merge has already been done
inside the submodule (at least this is what the setup of the test case
seems to do at a quick glance).


> You want Git to do this automatically for you, whereas I think that Git 
> should not be that "clever", because there are situations (as I've 
> demonstrated previously in this thread) where the "cleverness" would do The 
> Wrong Thing.
> 
>> Now Bob does the same and the
>> maintainer wants to merge his branch and gets a merge conflict because D
>> and J do not have a parent/children relationship.
> 
> Well, s/D/G/, but your point still stands. And the correct resolution is, of 
> course, to merge G and J to produce K, and then record K in the superproject 
> as the correct merge resolution.
> 
> Again, the question is whether Git should do these submodule merges 
> automatically, or not.

Hm, maybe I am missing something here, but isn't the question whether Git
should /use/ these submodule merges already done by a human being instead
of /doing them itself/? So isn't it just about making Git so clever it
proposes a merge already present in the submodule for recording in the
superproject when merging there?


> Feel free to post the patches, if you can spend the time making them. So 
> far, there's been no other feedback in this thread, so maybe I'm alone in my 
> worries...

I fully understand your worries concerning automagic merges inside a
submodule. But I really would like to see Git assisting me when merging
submodule commits in the superproject that have already been merged in
the submodule repo. And for me the first commit containing the others
is the one I would like to see then.
