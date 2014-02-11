From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFH] hackday and GSoC topic suggestions
Date: Tue, 11 Feb 2014 11:38:09 -0800
Message-ID: <xmqqeh39phi6.fsf@gitster.dls.corp.google.com>
References: <20140205225702.GA12589@sigill.intra.peff.net>
	<xmqq1tz9qxyl.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 11 20:38:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WDJA5-0001rA-8m
	for gcvg-git-2@plane.gmane.org; Tue, 11 Feb 2014 20:38:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932193AbaBKTiR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Feb 2014 14:38:17 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62851 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754263AbaBKTiN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Feb 2014 14:38:13 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E1A8C69EE8;
	Tue, 11 Feb 2014 14:38:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Vu5jRNEkXrCk6gO1sTvAyCpjLCE=; b=Gpy5C/
	gnDUdyGatTd7/C868rirbWFRLtSRFynLkqe7+vbYmSLro/yLdX1o7eBuf2pvlWbq
	Xfruubflz7bZnd8ETWmXJ3pMS1aXGLOBdX5Xv8Bn5bsM6bUbrvhXt8yYtnKELRO/
	l2PoF36TP6iYjfskly1pGg+0LOZahJZG+AYVo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=q08ouFlJnsqARtjK1AJojxENQO7fZ6Za
	28p2rDcygvIkvUMN1fADhphAZa9FQd4nW6AxifrZzyTjJ+JP2axjCWb2HMJ6TFSX
	QfWka6rgwSL74M2D2wuWBJ0eBFHua4ApxxbnABB13W8YObMgXaOOHUw5ZIqBJBFN
	6esvjQYTqk8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C42BF69EE7;
	Tue, 11 Feb 2014 14:38:12 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BDAE569EE4;
	Tue, 11 Feb 2014 14:38:10 -0500 (EST)
In-Reply-To: <xmqq1tz9qxyl.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Tue, 11 Feb 2014 10:57:22 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 0A2311B8-9354-11E3-B02A-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241957>

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>>  - Branch rename breaks local downstream branches
>>    http://article.gmane.org/gmane.comp.version-control.git/241228
>
> If you have a branch B that builds on A, if you are renaming A to C,
> you may want B to automatically set to build on C in some cases, and
> in other cases your renaming A is done explicitly in order to severe
> the tie between A and B and setting the latter to build on C can be
> a bad thing---after all, the user's intention may be to create a
> branch A starting at some commit immediately after this rename so
> that B will keep building on that updated A.
>
> So I am not sure if this is a bug.

Having said that, the current behaviour of leaving B half-configured
to build on a missing branch is undesirable. If we were to change
this so that any branch B that used to build on branch A being
renamed to build on the branch under the new name C, the user may
have to do an extra "--set-upstream-to A" on B after recreating A if
this was done to save away the current state of A to C and then keep
building B on an updated A, so we may have to give _some_ clue what
we are doing behind their back when we rename, e.g.

	$ git branch -m A C
        warning: branch B is set to build on C now.

or something.
