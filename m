From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] fast-export: add new --refspec option
Date: Thu, 09 May 2013 16:23:37 -0700
Message-ID: <7v38tv7n5y.fsf@alter.siamese.dyndns.org>
References: <1368063095-22861-1-git-send-email-felipe.contreras@gmail.com>
	<1368063095-22861-3-git-send-email-felipe.contreras@gmail.com>
	<7vvc6r7pii.fsf@alter.siamese.dyndns.org>
	<CAMP44s2yoBFZU+LzHWT30ijbQ2rknmV1ZoB9qDDYvvme2chB7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 10 01:23:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UaaBd-0006MC-9x
	for gcvg-git-2@plane.gmane.org; Fri, 10 May 2013 01:23:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752759Ab3EIXXk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 May 2013 19:23:40 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57129 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752279Ab3EIXXk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 May 2013 19:23:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 88C391D35D;
	Thu,  9 May 2013 23:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8RmKqCklhbyv0Ln+5z8a2T7QufM=; b=WI7k4e
	QOAhCZb2yjKSCYurYwQ/hu6DSszUb4wWE4m455PDbqA+QDXLOjwznnREoqENzS65
	v7luUTReNc4ae4aKR1tgb8yTm068LQLxu20uPpk36cYgFUpDDS9bwPrKr3gkJINT
	LNesNuLDCJZef4NLS99V42EoPmIEfpJL8H8io=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uwYm9dG6DUX1LTdcZJ0QMdrD+s60bJG5
	IeyQdQA6zUy86We9ZmWEkEBwn0CeRy4DR7mlGEbbgRPqzGpzJNFzrL/86jiYzPi9
	X1RrEKdh5YLzePX6Kd/S8a9rGCOf1QceXTr55bN5cQJtwyrhu/2bH2hGLlysbsWI
	TNAoNPy4VYo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7D3961D35C;
	Thu,  9 May 2013 23:23:39 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D17CA1D35A;
	Thu,  9 May 2013 23:23:38 +0000 (UTC)
In-Reply-To: <CAMP44s2yoBFZU+LzHWT30ijbQ2rknmV1ZoB9qDDYvvme2chB7g@mail.gmail.com>
	(Felipe Contreras's message of "Thu, 9 May 2013 17:53:52 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7AAA64E8-B8FF-11E2-A376-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223803>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Of course, but how do you implement that? That's mixing refspecs and
> revlist arguments, which AFAIK don't mix:

Simple.  You treat everything as refspecs and form revision ranges
out of them.  Note that that is exactly the reason why "git push"
can take "master" as a short-hand for "master:master" [*1*].

> % git fast-export ^next:new-next master:new-master --not
> refs/tags/*:refs/tags/backup/*

I thought you stopped mentioning the bottom of the range
(e.g. ^next) in the output from export stream at around 49266e8a11cf
(fast-export: don't handle uninteresting refs, 2012-11-28).

What does ^next:new-next (or mapping after "--not" in general) even
mean?  They would not make sense, would they?

So I would imagine you would be spelling that as:

    git fast-export master:new-master --not next refs/tags/*

or something, no?


[Footnote]

*1* Of course, unlike "git push", but similar to "git bundle",
    export does not know who the "receiving side" is and what they
    have, so in addition to the positives, you would need to tell
    the command where the bottoms of the range you are exporting
    are, so there needs to be some difference between the way "git
    push" and export/bundle specify the ranges.

    But that does not affect what should happen on the positive end
    of the ranges, which both "git push" and export/bundle need to
    specify anyway.
