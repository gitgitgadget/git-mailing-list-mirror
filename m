From: Junio C Hamano <gitster@pobox.com>
Subject: Re: RFC: optionally reject case-clone branch names
Date: Wed, 28 May 2014 14:58:12 -0700
Message-ID: <xmqqy4xlbm6j.fsf@gitster.dls.corp.google.com>
References: <1401231368.18134.63.camel@stross>
	<xmqq7g55esg5.fsf@gitster.dls.corp.google.com>
	<1401299791.18134.74.camel@stross>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git mailing list <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Wed May 28 23:58:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wplrb-0008Qi-PO
	for gcvg-git-2@plane.gmane.org; Wed, 28 May 2014 23:58:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755058AbaE1V6T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2014 17:58:19 -0400
Received: from smtp.pobox.com ([208.72.237.35]:50471 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753882AbaE1V6S (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2014 17:58:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id AB7151A4B3;
	Wed, 28 May 2014 17:58:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6L2r6w6ZF1kx86szLWN5Q7UpvDg=; b=cREsAZ
	IxpRvCImHRiferXMmWcx+MX+nCQqUt8cttNvp/2jc2nSRu7fgIlOaJzKfVWVREnn
	P6xqvinlRPu6IOf5CNvn7giDut1t6qlfP600taAg2qwWHLSqFr4brisgvO5e6559
	Pf7kxERR37XhtDR4gs+PfoAMGv4eJ7k26AePA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FUe+/BaAKFJNZezvDGYw7t+hJ3+YVhAo
	semIbb+V3GrMH8XIDIJfXrizhzaJ5LTGVPIIoev/C80HLLBkWQlWws5XDRd3LoqF
	IhLrfiGnqzdlN+CHx+287tDWj8kDv6nnfTa6LRMkIsmLiBeKg0aXbQD/JI4eEWW3
	8uVP1des9qg=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A21151A4B2;
	Wed, 28 May 2014 17:58:17 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 59EE11A4AD;
	Wed, 28 May 2014 17:58:14 -0400 (EDT)
In-Reply-To: <1401299791.18134.74.camel@stross> (David Turner's message of
	"Wed, 28 May 2014 13:56:31 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 2ADAD104-E6B3-11E3-B9C3-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250336>

David Turner <dturner@twopensource.com> writes:

> On Wed, 2014-05-28 at 10:14 -0700, Junio C Hamano wrote:
>> David Turner <dturner@twopensource.com> writes:
>> 
>> > RFC follows:
>> >
>> > 1. On a case-insensitive server, git receive-pack ought to always reject
>> > branches which are same-but-for-case of existing branches.
>> > 2. On a case-sensitive server, the same rule by default, with an option
>> > to allow the old behavior.
>> >
>> > Let me know if, should I write these patches, they would be likely to be
>> > accepted.
>> 
>> There is another a lot simpler possiblity, no?
>> 
>> 3. On any server whose administrator chooses to enforce "one case
>>    variant only" rule, install a pre-receive hook that enforces the
>>    rule.
>
> The reason I discovered this issue is that a user came to me to complain
> that suddenly their pulls were failing.  Then I had to track down what
> the actual problem was (a colleague actually pointed it out to me).
>
> We could add some hooks, but we have a lot of repos, some of which
> already have unique hooks that we would have to edit.  And this approach
> wouldn't help the next person who gets into this situation, who would
> have to again figure out what went wrong, and add the appropriate hook.
>
> Basically, I'm trying to take a poka-yoke approach. Does this seem
> reasonable?

Sort of.  I think #1 is uncontroversial; there is nothing else that
can be done that is more sensible.  As to #2, as your Subject line
says, I think it should be "optionally reject", that is, "the old
behaviour by default, with an option to allow the same ruleas #1".
