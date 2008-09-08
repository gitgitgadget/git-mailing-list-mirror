From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Alternates and push
Date: Sun, 07 Sep 2008 17:02:05 -0700
Message-ID: <7vd4jfjyiq.fsf@gitster.siamese.dyndns.org>
References: <9e4733910809060542s5ede6d6m5bdb894c958ea8b7@mail.gmail.com>
 <20080906162030.GT9129@mit.edu> <7viqt9rvwm.fsf@gitster.siamese.dyndns.org>
 <20080907234118.GA8161@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jon Smirl <jonsmirl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Theodore Tso <tytso@MIT.EDU>
X-From: git-owner@vger.kernel.org Mon Sep 08 02:04:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcUEa-0003MB-If
	for gcvg-git-2@gmane.org; Mon, 08 Sep 2008 02:04:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751502AbYIHACS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Sep 2008 20:02:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751487AbYIHACR
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Sep 2008 20:02:17 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:34952 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751237AbYIHACQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Sep 2008 20:02:16 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 1275B78CD8;
	Sun,  7 Sep 2008 20:02:12 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 7369978CD4; Sun,  7 Sep 2008 20:02:07 -0400 (EDT)
In-Reply-To: <20080907234118.GA8161@mit.edu> (Theodore Tso's message of "Sun,
 7 Sep 2008 19:41:18 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 63206BEE-7D39-11DD-A066-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95198>

Theodore Tso <tytso@MIT.EDU> writes:

> On Sat, Sep 06, 2008 at 11:06:49AM -0700, Junio C Hamano wrote:
>> We could instead redefine the semantics of the existing alternates
>> mechanism.  This technically *breaks* backward compatibility, but I
>> suspect it won't hurt many existing installations:
>> 
>>  - Declare that a freestanding object store is illegal.  In other words,
>>    if a directory "$D/objects" is (1) used as $GIT_OBJECT_DIRECTORY's
>>    value, (2) pointed by some repository's "alternates" file, or (3)
>>    listed in $GIT_ALTERNATE_OBJECT_DIRECTORIES's value, this change makes
>>    it illegal for "$D" not being a proper git repository.
>> 
>>    This will not break your example of your repository's object store
>>    borrowing from the object store inside Linus's repository.
>> 
>>  - When you have "$D/objects" in alternates, start relying on "$D/refs"
>>    being correct (i.e. repository $D is not corrupt).  This technically
>>    makes the system slightly less robust, as we are depending on _other
>>    people's_ good behaviour even more when you use alternates, but you are
>>    already depending on them having good objects in $D/objects anyway, so
>>    it is not a big deal.
>
> One way that wouldn't break backwards compatibility would be to use
> $D/refs if it exists, but if it isn't, fall back to existing behavior
> (which is to say, only use the refs in the repository, not in the
> borrowed repository/object store).  Is there a reason why this would
> be problematic?

I think you just reiterated what I said in "we could instead", and I think
we are in agreement.

I already stated the reason this could be problematic and also I said I do
not think it is a big deal in the above.

I think the question to ask at this point is not "is there a reason why
this would be problematic", but "is it really not a big deal as Junio
claims?" and "aren't there _other_ reasons than the above that makes it
problematic?".

The arguments to make are "Junio is worrying too much; depending on the
other repository's ref is no worse than depending on the objects the other
repository uses, and here is a proof that it is not just 'not a big deal'
but 'no problem at all'", "I've polled the userbase and there is no
existing configuration that will be broken by this change", and "I have
this configuration that will be broken by above change, don't do it".
