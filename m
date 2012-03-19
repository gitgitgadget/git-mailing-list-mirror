From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Please discuss: what "git push" should do when you do not say
 what to push?
Date: Mon, 19 Mar 2012 15:38:07 -0700
Message-ID: <7v1uoo9pyo.fsf@alter.siamese.dyndns.org>
References: <7v7gyjersg.fsf@alter.siamese.dyndns.org>
 <7vty1ndcoi.fsf@alter.siamese.dyndns.org> <4F6461D7.40303@pileofstuff.org>
 <7vipi1d9r7.fsf@alter.siamese.dyndns.org> <4F6792DE.80208@pileofstuff.org>
 <7v62e09sig.fsf@alter.siamese.dyndns.org>
 <CANgJU+VF-3LnwkrWgSQ1r50R=zjw8vsK1G686OqetSUGHuFcfw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andrew Sayers <andrew-git@pileofstuff.org>, git@vger.kernel.org
To: demerphq <demerphq@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 19 23:38:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S9lDh-00036r-2Z
	for gcvg-git-2@plane.gmane.org; Mon, 19 Mar 2012 23:38:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758077Ab2CSWiM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Mar 2012 18:38:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49391 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757939Ab2CSWiK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Mar 2012 18:38:10 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 61A677734;
	Mon, 19 Mar 2012 18:38:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=08NA9Tx8IN6fsBMdcXgezD3N4lA=; b=EIEGHp
	nUmqbvvGxdKenruerRNEIr7X2eOy8oJDj7RvfDu7YvLNbvVa4dwLtp2dtiB/zk6s
	KYCfDL1mXjwjWL839feixQI5tLofwb0A9fpupcYAlmGTyM/xS3LlC5NGQVa5P8l4
	hghFDkYKmdLr9dcOKw4CdGjxfgjS5pTK5XHnU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PS91Ez2vuIIxaZV/yfw/fqn3sLDXBxfH
	MU8X+aAPbR7rAH9BJndbjgN7XYwsLhI5EyCvaGJ8Y+2T+HdjjY79UBV+nuHiuPEY
	lgoJvYkyK088ezsAoMY26PL4vgO5Hp9cXSz1SIjfP1Fn3j3q1gLHOGb2F+fiprit
	DYuIY31GtLg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 578397733;
	Mon, 19 Mar 2012 18:38:09 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AB8887732; Mon, 19 Mar 2012
 18:38:08 -0400 (EDT)
In-Reply-To: <CANgJU+VF-3LnwkrWgSQ1r50R=zjw8vsK1G686OqetSUGHuFcfw@mail.gmail.com>
 (demerphq@gmail.com's message of "Mon, 19 Mar 2012 23:20:28 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3385ACE0-7214-11E1-B496-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193469>

demerphq <demerphq@gmail.com> writes:

> ... I thought the worse case here is
> minor inconvenience, not data loss or anything else that is obviously
> harmful.

If your definition of harm is limited to data loss then we wouldn't be
talking about updating the default from matching to current or upstream.
"If your push failed, pushed what you did not mean to, or did not push
what you meant to, you would correct the mistake" applies equally to a new
person who expected "current" (or "upstream") and got "matching", or an old
person who expected "matching" and got "current".

The purpose of the default change is to reduce surprises to people who
haven't yet learned Git too well.  And for them,

    I was on master, I said 'git push' without saying what to push to
    where, and it resulted in master updated at the central repository.

is the least surprising outcome.  Note that a learnt Git user would not
express what he did this way; he will say 'I was on *my* master' and
'the master at the central repository was updated with *my* master', but
the change of the default is to help those who haven't even learned that
your branches and branches at the central server are not always connected.

Choice of "upstream" is more convenient for users who learned Git a bit
more and knows the distinction between branches you have and branches the
central server has.  For them, "I was on my 'topic' branch, that was
forked from the 'master' branch at the central repository. I said 'git
push', and I updated the 'master' over there with my 'topic'", is also not
surprising, but it is more advanced audience than those helped by the
default setting to push 'current'.

In either way, once people learn sufficiently to the point that they can
choose their own default that suit them, there is no need for handholding.
They won't be surprised.

But except for one case you should *not* forget about.

The ones who get pulled the old default under their feet while not paying
too much attention to this discussion. The change will hit them with a
surprise, and that is what I am trying to avoid here.
