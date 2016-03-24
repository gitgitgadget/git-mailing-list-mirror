From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Resumable git clone?
Date: Thu, 24 Mar 2016 08:53:25 -0700
Message-ID: <xmqqy497an4a.fsf@gitster.mtv.corp.google.com>
References: <20160302012922.GA17114@jtriplet-mobl2.jf.intel.com>
	<xmqqziuh46hb.fsf@gitster.mtv.corp.google.com>
	<C59B0CDA60BC402B900305A9D62D815B@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "Josh Triplett" <josh@joshtriplett.org>,
	"Konstantin Ryabitsev" <konstantin@linuxfoundation.org>,
	"Git List" <git@vger.kernel.org>, <sarah@thesharps.us>,
	<viro@zeniv.linux.org.uk>
To: "Philip Oakley" <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Thu Mar 24 16:53:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aj7Zs-0006gw-49
	for gcvg-git-2@plane.gmane.org; Thu, 24 Mar 2016 16:53:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756418AbcCXPxe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2016 11:53:34 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:64530 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756077AbcCXPx3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2016 11:53:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C0B474A9CE;
	Thu, 24 Mar 2016 11:53:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HYWSr+G7+fOmmyIrqVYu1vTVPXM=; b=rpjy6M
	SXaEHblmBA+/jScKDmEtavtAZPMKkQzl+ZyT05RGygntHvFnm9rVO6RzzjVR4Y9h
	05ro2RLCI71pUXGilPEScpYuR3RXgzk6DaZFyS/MvO0LiTGh47p+U+IKcniaE8pC
	giWe7B5iBZYPXSmiJoV05aEj/hylzy6l4lT9o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sq9/M4C78Cw+7xBwpOyjgXnyJedBIg8F
	xc+I4pjZJfD+LOz9j+ET0lm9JdNYpYftei2FMaxGnNSAifRUaPCkonlBxZvmdMaa
	XBXgf1NSGiAnO0uBxHEApJP+IBGoi5DCwBAQ2Rw/PK/aUVPTklfXqjoYL3PIPsuT
	08KVNSKqNIw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B78B14A9CD;
	Thu, 24 Mar 2016 11:53:27 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id A3DA34A9CA;
	Thu, 24 Mar 2016 11:53:26 -0400 (EDT)
In-Reply-To: <C59B0CDA60BC402B900305A9D62D815B@PhilipOakley> (Philip Oakley's
	message of "Thu, 24 Mar 2016 08:00:08 -0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8BEE0970-F1D8-11E5-9F0F-EB7E6AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289753>

"Philip Oakley" <philipoakley@iee.org> writes:

> From: "Junio C Hamano" <gitster@pobox.com>
>>
>>> If you clone a repository, and the connection drops, the next attempt
>>> will have to start from scratch.  This can add significant time and
>>> expense if you're on a low-bandwidth or metered connection trying to
>>> clone something like Linux.
>>
>> For this particular issue, your friendly k.org administrator already
>> has a solution.  Torvalds/linux.git is made into a bundle weekly
>> with
>>
>>    $ git bundle create clone.bundle --all
>>
>> and the result placed on k.org CDN.  So low-bandwidth cloners can
>> grab it over resumable http, clone from the bundle, and then fill
>> the most recent part by fetching from k.org already.
>
> Isn't this use of '--all' a bit of oversharing?

Not for the exact use case mentioned; k.org administrator knows what
is in Linus's repository and is aware that there is no remote-tracking
branches or secret branches that may make the resulting bundle unsuitable
for priming a clone.

> " I also think "--all" is a bad advice for another reason.

I do not think it is a good advice for everybody, but the thing is,
what you are responding is not an advice.  It is just a statement of
a fact, what is already done, one of the existing practices that an
approach to "resumable clone" may want to help.
