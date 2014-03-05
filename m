From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] diff: simplify cpp funcname regex
Date: Wed, 05 Mar 2014 12:31:50 -0800
Message-ID: <xmqqzjl4fkuh.fsf@gitster.dls.corp.google.com>
References: <20140305003639.GA9474@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Thomas Rast <tr@thomasrast.ch>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 05 21:32:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLITv-0000Es-N9
	for gcvg-git-2@plane.gmane.org; Wed, 05 Mar 2014 21:32:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752946AbaCEUbz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2014 15:31:55 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34862 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751630AbaCEUby (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2014 15:31:54 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 19B46703AE;
	Wed,  5 Mar 2014 15:31:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QDSCVMEWH3gzk7akVZuykNreXLY=; b=FzdyPB
	v/8g8CYiX4Xxibk6QZUMG05jiZcIxHsrPDpxBm2Net/K3Fdbk/OIFZLAGeVuan4v
	NfvljWaoiFRxQPyHvUC6o7qgdI2dXYq3T52yAYfcIINWD7MeJe4g7TEqKb7oV1lT
	c97ExbwS9sO6rPzlSeCRoIelORkApw/jNlZ5c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=V/wAtrhA+RKgiJCmzZK1kRAlwPuOqgB+
	uBx/ttDnzv6JNAyNSqiP34pKGMSHcy456Qpuk2pcPMdoBs55F3m15QAGy8AVZ8+s
	UJ4V7aS138bdyMsI243f10i3k7MwVyuCy3gvJ/74eOtQG3RdRR8DYGWu9zRVagYL
	q0UBIsaoPxg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0435B703AD;
	Wed,  5 Mar 2014 15:31:54 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1CBB4703A9;
	Wed,  5 Mar 2014 15:31:53 -0500 (EST)
In-Reply-To: <20140305003639.GA9474@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 4 Mar 2014 19:36:40 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 2FE41386-A4A5-11E3-810A-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243477>

Jeff King <peff@peff.net> writes:

> types, we simply look for an identifier at the start of the
> line that contains a "(", meaning it is either a function
> definition or a function call, and then not containing ";"
> which would indicate it is a call or declaration.

It is not worth worrying about:

foo(arg,
    another);

that is not indented, so I think that simplicity is good.

> For example, for top-level changes
> outside functions, we might find:
>
>   N_("some text that is long"
>
> that is part of:
>
>   const char *foo =
>   N_("some text that is long"
>   "and spans multiple lines");

Unfortunate, but cannot be avoided.

>
> Before this change, we would skip past it (using the cpp regex, that is;
> the default one tends to find the same line) and either report nothing,
> or whatever random function was before us. So it's a behavior change,
> but the existing behavior is really no better.

True.
