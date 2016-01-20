From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] filter-branch: resolve $commit^{tree} in no-index case
Date: Tue, 19 Jan 2016 18:43:53 -0800
Message-ID: <xmqq4me96kd2.fsf@gitster.mtv.corp.google.com>
References: <xmqqbn8h9squ.fsf@gitster.mtv.corp.google.com>
	<xmqq7fj59rs2.fsf@gitster.mtv.corp.google.com>
	<20160119213705.GA28656@sigill.intra.peff.net>
	<xmqq37tt9r9g.fsf@gitster.mtv.corp.google.com>
	<20160119215100.GB28656@sigill.intra.peff.net>
	<20160119215928.GA6556@sigill.intra.peff.net>
	<20160119222802.GC6556@sigill.intra.peff.net>
	<20160120012253.GD16090@google.com>
	<20160120013436.GA24541@sigill.intra.peff.net>
	<xmqqbn8h6mrl.fsf@gitster.mtv.corp.google.com>
	<20160120020039.GD24541@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	John Fultz <jfultz@wolfram.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 20 03:44:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLikc-0004IO-Ct
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jan 2016 03:44:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757208AbcATCn6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2016 21:43:58 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:54910 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753283AbcATCn4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jan 2016 21:43:56 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 30F873DEE4;
	Tue, 19 Jan 2016 21:43:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9hzE1F2CMOsMonP6fATjgC7rJRc=; b=sAKEL1
	5fsu45d+UaZXtxm9kgZVgSnMTIneBHjIW8aUPhXMJHK1WCQx4iU2CNL4Be+1mUaK
	UrBmzAqgS6kUBARzB7t/iiHXw3b8ufr6bxVp1I5eigxGC7dnDk1lBAO0uBbraSZQ
	OsY217PSjNH1tJvud8Ie4Ek/36IUoR+HfU35Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RqWOL8H/s9JfGYhea7ASgRDmO5unWRZ6
	4yoKgrA3yZvX+uu/5pEhwYxhR/3AqOikri1zZY34ONTwIL4xV3j8gjA5yIIGk8Ud
	/Tek9zsDcSqPE3YXSOhm8ztu0OKR0YINbGbVk9JFwvQ54HSGpxvId4AJH07NA2QU
	jrwXT0pB0jA=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 285D63DEE3;
	Tue, 19 Jan 2016 21:43:55 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id A001B3DEE2;
	Tue, 19 Jan 2016 21:43:54 -0500 (EST)
In-Reply-To: <20160120020039.GD24541@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 19 Jan 2016 21:00:39 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A587F15C-BF1F-11E5-B86E-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284417>

Jeff King <peff@peff.net> writes:

> On Tue, Jan 19, 2016 at 05:51:58PM -0800, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>> 
>> >> Mph.  We could get the best of both worlds by introducing a "git
>> >> rev-parse --compare <a> <b>" that compares object ids.  Actually...
>> >> 
>> >> How about something like this?
>> >
>> > Thanks. I had in my head that we could do something like that, but
>> > hadn't quite worked it out. I think what you wrote works.
>> 
>> But wouldn't "diff-tree --quiet" essentially be that command?
>
> I think Jonathan was responding to my point that "diff-tree --quiet"
> _isn't_ quite the same, if you have mis-formatted tree objects. If the
> sha1s are different, a rev-parse comparison will keep the commit. But
> "diff-tree" will actually do the diff, and may consider different sha1s
> to have the same content, dropping the second one.
>
> It's a minor point, but I find one of my primary uses for filter-branch
> these days is massaging out bogus objects made by older or buggy git
> clients (not that I see _that_ many of them; I think it speaks more to
> the fact that I don't really use filter-branch much these days).

I (think I) understand that use case, but this function compares the
parent tree and the tree of the commit we just created, and it does
so in order to skip the one we just created (when --prune-empty is
given).  It is not about "tree-filter returned a tree, let's compare
them and if the old one and the new one looks the same (even though
they do not have identical object name) and replace the old one with
the new before giving it to commit-filter, so that we have a larger
chance of noticing a case where we did not have to rewrite and instead
were able to reuse the old commit and tree".

In other words, I do not think "broken tree object may look the same
to diff-tree, but I do want to replace it" is relevant to this
codepath; it is not something this function handles, I think.

What am I not seeing?
