From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 10/10] push: teach push to be quiet if local ref is strict subset of remote ref
Date: Fri, 02 Nov 2007 00:52:00 -0700
Message-ID: <7vk5p15bkv.fsf@gitster.siamese.dyndns.org>
References: <1193593581312-git-send-email-prohaska@zib.de>
	<11935935822846-git-send-email-prohaska@zib.de>
	<11935935821136-git-send-email-prohaska@zib.de>
	<11935935823045-git-send-email-prohaska@zib.de>
	<11935935821800-git-send-email-prohaska@zib.de>
	<11935935823496-git-send-email-prohaska@zib.de>
	<11935935821192-git-send-email-prohaska@zib.de>
	<7vfxztm2dx.fsf@gitster.siamese.dyndns.org>
	<52171BF7-50E2-473E-A0BD-CB64D38FD502@zib.de>
	<7vejfcl8aj.fsf@gitster.siamese.dyndns.org>
	<F5F68690-68A3-4AFC-A79C-FF02910F0359@zib.de>
	<7v8x5jiseh.fsf@gitster.siamese.dyndns.org>
	<B3C76DB8-076D-4C43-AC28-99119A05325C@z ib.de>
	<7vve8nglrt.fsf@gitster.siamese.dyndns.org>
	<B16F7DA1-E3E5-47A4-AFD3-6680741F38F1@zib.de>
	<7vlk9jgeee.fsf@gitster.siamese.dyndns.org>
	<6B0CD829-A964-410B-8C23-74D26BD2C0FA@zib.de> <!
	47299855.9010204@op5.se> <3550D197-CA8C-4B06-9A95-3C7F18EBEFA7@zib.de>
	<7vfxzpbtxv.fsf@gitste! r.siamese.dyndns.org>
	<63FCD695-B952-4624-854C-0F1C662D94D1@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Ericsson <ae@op5.se>, git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Fri Nov 02 08:52:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InrKO-0000Sv-FR
	for gcvg-git-2@gmane.org; Fri, 02 Nov 2007 08:52:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752601AbXKBHwL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2007 03:52:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752592AbXKBHwK
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Nov 2007 03:52:10 -0400
Received: from sceptre.pobox.com ([207.106.133.20]:33663 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752204AbXKBHwI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2007 03:52:08 -0400
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 888372EF;
	Fri,  2 Nov 2007 03:52:27 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id D73C48F3E3;
	Fri,  2 Nov 2007 03:52:23 -0400 (EDT)
In-Reply-To: <63FCD695-B952-4624-854C-0F1C662D94D1@zib.de> (Steffen Prohaska's
	message of "Fri, 2 Nov 2007 08:21:26 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63071>

Steffen Prohaska <prohaska@zib.de> writes:

> On Nov 1, 2007, at 9:18 PM, Junio C Hamano wrote:
>
>> The context of this "forced" is that you say (in the following
>> paragraph) the user's main objective was to "push", but I do not
>> think "to push" is ever the main objective.
>
> Right. I should probably describe a bit more of the context.

Boring ;-)

> We have a shared branch for a group of developer who are located
> ...
> In this setting a user really want to push. Because only then
> the code will be tested and available for all others. ...

Pretty much expected, sane, and unsurprising.  Then you are in
the first category I quoted, and...

>>  - If it is to give integrated result for others to work further
>>    on, then you need to resolve before being able to achieve
>>    that goal.  There is no escaping from it.

... it still holds that what the developer wants to do is not
just "to push", but "to push after making sure what he is going
to push is in a good enough shape to be pushed".  Your _workflow_
is forcing to integrate right away before pushing; don't blame
git for this.

>>  - On the other hand, if it is to show what you did as early as
>>    possible in a working shape, and if the updated shared
>>    repository has changes from somebody else that conflicts you,
>>    in a CVS/SVN style shared workflow, there is no way for you
>>    to show what you did in isolation.  If you try to follow that
>>    model in git and insist pushing to the same branch, then you
>>    are forced to resolve first.
>>
>>    But you do not have to.  You could push out to another new
>>    branch, and say "Here is how you could do it, although this
>>    is based on an older codebase and conflicts with what
>>    recently happened to the tip".  You could even ask other
>>    party whose changes conflict with yours to help with the
>>    merge by saying "I pushed it out, you are more familiar with
>>    that area of the code and with your changes near the tip of
>>    the trunk, so could you merge it and push out the result?"
>
> ... I know we could use git to establish a more complex workflow
> that would give better guarantees on the published branches.

Don't get me wrong.  You do not always have to use the "push to
a side branch and ask for help from others", but git opens the
door for you to do so more conveniently, rather than strictly
sticking to the CVS workflow.    I re-quoted the whole "On the
other hand" part because I think this is something not often
done by people with CVS background --- with CVS you can do
exactly the same thing but it is too cumbersome and people don't
do so in practice.  With git, such an interaction is not just
possible but is a very natural thing to do.

Your more advanced people can be the first ones to employ this
"new communication medium" to help work better among them.  You
do not have to force the "side communication" as an official
part of workflow to the whole group.

SCM is just a tool to help developer communication.  Use it
wisely.

> We haven't figured out much more of our workflow. The first
> milestone is to migrate from CVS to git continuing to use a
> CVS-style workflow.

I think that is an interesting admission.  As somebody else on
the thread already said, if you are sticking to CVS workflow,
there are things that can and cannot be naturally done with
git.  Don't break git when you hit the situation in the latter
category without understanding how the world works.

> error: remote 'refs/heads/master' is ahead of local 'refs/heads/
> master'. Use --verbose for more details.

I'd rather have "Read section XXX of the user's guide".
