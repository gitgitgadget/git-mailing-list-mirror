From: Andreas Ericsson <ae@op5.se>
Subject: Re: Git and tagging hook
Date: Tue, 14 Oct 2008 22:49:02 +0200
Message-ID: <48F505BE.8040407@op5.se>
References: <1223268332.4072.7.camel@localhost> <48E9BB72.2080008@op5.se>	 <1223399613.20250.1.camel@localhost> <gcg67d$4o2$1@ger.gmane.org>	 <1223484445.4055.8.camel@localhost> <48ECF072.3000506@op5.se>	 <20081014172227.GB6931@efreet.light.src> <1224007401.4073.40.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jan Hudec <bulb@ucw.cz>, Jakub Narebski <jnareb@gmail.com>,
	git@vger.kernel.org, scmbug-users@lists.mkgnu.net
To: Kristis Makris <kristis.makris@asu.edu>
X-From: git-owner@vger.kernel.org Tue Oct 14 22:50:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KpqqW-0000vW-Tp
	for gcvg-git-2@gmane.org; Tue, 14 Oct 2008 22:50:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751488AbYJNUtN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Oct 2008 16:49:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751479AbYJNUtM
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Oct 2008 16:49:12 -0400
Received: from mail.op5.se ([193.201.96.20]:45388 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751342AbYJNUtL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Oct 2008 16:49:11 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 444BD1B8006A;
	Tue, 14 Oct 2008 22:42:01 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.765
X-Spam-Level: 
X-Spam-Status: No, score=-2.765 tagged_above=-10 required=6.6
	tests=[AWL=-0.266, BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6MKwn5QHKmzx; Tue, 14 Oct 2008 22:41:55 +0200 (CEST)
Received: from clix.int.op5.se (unknown [172.27.78.22])
	by mail.op5.se (Postfix) with ESMTP id E71961B80056;
	Tue, 14 Oct 2008 22:41:52 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <1224007401.4073.40.camel@localhost>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98210>

Kristis Makris wrote:
> Jan, thanks for trying to clarify this for me.
> 
> I am working on adding integration support of Git with bug-trackers,
> using Scmbug. There may be an argument here towards/against distributed
> bug-trackers when it comes to Git.
> 
> Maybe there are things here I don't fully understand yet.
> 
> On Tue, 2008-10-14 at 19:22 +0200, Jan Hudec wrote:
>>>>> Kristis Makris wrote:
>>>>>> I want the integration when I apply the tag to a local repository, NOT
>>>>>> only when I push/pull.
>> Care to explain why that would ever be useful? It's local, which means that:
>>  - the user can take it back without a trace it ever happened (git tag -d or
>>    even git update-ref -d) and
>>  - noone except the user will see it anyway, so it's not like they should
>>    care either.
> 
> I have two use cases:
> 
> (1) A developer maintains besides his local copy a local bug-tracking
> system in which he tracks his changes. We would like to apply various
> verification policies when he commits or tags. For example, for tagging
> we wants to ensure that he tags giving consistent labels to his
> intermediate builds. e.g. as in:
> 
> http://files.mkgnu.net/files/scmbug/SCMBUG_RELEASE_0-26-9/manual/html-single/manual.html#VERIFICATION-CHECKS-CONVENTION-BASED-LABELING
> 

I'm guessing releases will be cut from some sort of central or official
repository anyway, so I fail to see why tags would need to be verified
at create-time rather than at push-time. It's sometimes useful to create
tags for ones own personal use, and commit messages that are no more than
"wip", without signoff or anything. This needs to be implemented at the
receiving end. Not at each developers end.

> Or he may want to have Git force him to also supply a log message along
> with a tag, so that he can remember later more accurately why a tag was
> created and what it really captures. Even if Git (or other SCM systems)
> don't natively support log messages on tags. Scmbug plans to implement
> this.
> 
> http://bugzilla.mkgnu.net/show_bug.cgi?id=219
> 

git supports optional log-messages on tags. There are two different kinds
of tags in git; "annotated" (with logmessage) and "lightweight" (without
logmessage). It's up to each user which sort of tag to create. Using the
example update hook, lightweight tags are by default not allowed to be
pushed to a repository.

> 
> (2) I would like to apply various verification policies when work from a
> local repository is finally merged with the central repository. I assume
> there can/will be a central repository, and there is one "software
> product" that is being released somewhere among the many copies.
> 

Merges happen in the local repository. When a merge is pushed to the
"release" repo, you can analyze the merges and all commits that the sender
is trying to push.

> When its time to merge local changes to a central repository, the
> verification policies may deem that changes are not acceptable to be
> merged with the mainline. e.g. because log messages are too short,
> commits during the merge are issued against bugs in "a central"
> bugtracker that are either closed, assigned to someone else, or just
> plain wrong bug-numbers that belong to other products:
> 

That sort of work belongs in the update hook then. Cautious users, or
release engineers, might want to enable pre-merge hooks and whatnot.

> http://files.mkgnu.net/files/scmbug/SCMBUG_RELEASE_0-26-9/manual/html-single/manual.html#VERIFICATION-CHECKS-VALID-LOG-MESSAGE-SIZE
> http://files.mkgnu.net/files/scmbug/SCMBUG_RELEASE_0-26-9/manual/html-single/manual.html#VERIFICATION-CHECKS-OPEN-BUG-STATE
> http://files.mkgnu.net/files/scmbug/SCMBUG_RELEASE_0-26-9/manual/html-single/manual.html#VERIFICATION-CHECKS-VALID-BUG-OWNER
> http://files.mkgnu.net/files/scmbug/SCMBUG_RELEASE_0-26-9/manual/html-single/manual.html#VERIFICATION-CHECKS-VALID-PRODUCT-NAME
> 
> (I'm not very clear whether this is how Git works)
> 
> Does someone get to write-up a brand new log comment during the merge
> and the merge totally disregards older log comments ? My understanding
> is that log comments on the local copy are preserved (and will need to
> be mapped to bug-numbers in the central bug-tracker. 
> 

Try and find out. It would have been faster than writing that paragraph ;-)

> Thus the local verification policies may need to have already been
> configured to comply with future verification policies of the central
> repository. Else (perhaps considerable) mappings/adjustments will be
> needed during the push to the central copy.
> 
>> Besides, you don't need git tag to create a tag in git, so the hook wouldn't
>> really be guaranteed anyway (I mean, just like the commit hook is not -- you
>> can still commit by calling write-tree, commit-tree and update-ref and avoid
>> the hook).
> 
> I'm assuming someone who follows the recommended avenue of using Git
> wants the advantages of hooks. I certainly can't force people that
> bypass hooks to use them.
> 

Hooks can also be disabled, and they aren't enabled by default. They're also
not cloned along with a repository (that would be stupid, as I most certainly
don't want the email-on-commit hooks we're using at work), so installing
said hooks would still be a manual job done by each developer that wishes to
comply with the policy you're outlining. I have a hard time seeing how that
can benefit the open community.

>> For integration with issue tracker, the local tag is neither final, nor
>> useful to anybody except the user who did it until it hits the central
>> repository. And working on the central repository directly does not seem like
>> a good idea either.
> 
> The local tag is useful to the local user and his local bug-tracker. He
> can have tag operations intercepted so that the tag names show up as
> versions in his bug-tracker. In this way he can keep track of which bugs
> still exist or have recently been introduced/discovered to his local
> copy, before he decides to publish his polished, final version:
> 
> http://files.mkgnu.net/files/scmbug/SCMBUG_RELEASE_0-26-9/manual/html-single/manual.html#TAGS
> 
> And his "local bug-tracker" may be reachable on the web and useful by
> others that take a peek at the users progress (even fetching it with
> Git).
> 

Relying on hooks on the developer side is fragile and *will* break.
It will break often, and it will break badly. Any sort of
"this-commit-is-releasable" verification simply *has* to be done in
the release repository. Otherwise you'll be limiting how devs can
use the scm while gaining absolutely nothing (since it has to be
done in the release repo too for those times when the dev forgot
to enable hook X in a newly cloned repository).

I still haven't figured out what the over-all plan is, so my
advice and warnings may be counter-productive at worst. However,
http://files.mkgnu.net/files/scmbug/doc/latest_manual/html-multi/x113.html
just doesn't make sense to me. It's invalidated by clear and
concise commit messages (which aren't always there, but education
is nine times out of ten better than enforcement; It's better
to understand *why* 6x7 = 42 rather than just knowing that it's
so).

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
