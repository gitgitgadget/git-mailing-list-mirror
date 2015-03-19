From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/14] numparse module: systematically tighten up integer parsing
Date: Wed, 18 Mar 2015 23:31:06 -0700
Message-ID: <xmqq1tkllcr9.fsf@gitster.dls.corp.google.com>
References: <1426608016-2978-1-git-send-email-mhagger@alum.mit.edu>
	<xmqqk2yfo3y0.fsf@gitster.dls.corp.google.com>
	<550884B3.5010102@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.org>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Mar 19 07:31:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYTz9-00062p-U0
	for gcvg-git-2@plane.gmane.org; Thu, 19 Mar 2015 07:31:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751402AbbCSGbL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2015 02:31:11 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:58516 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750905AbbCSGbJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2015 02:31:09 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AF2693A61D;
	Thu, 19 Mar 2015 02:31:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FqJdUU1G25iHfStKTdeeDB4qwYo=; b=tEI6+T
	CK/1zeGuMjC25yCbseeKse8GQkdiqPdvKVogOG8pmuQBJ/auHQBp8G4yAOtszbll
	Xdc3ILrHKP6OtpWRDyAYUaI3alXbZ5JuclZUbfp25u1n95AinRGHM46/eitaphDV
	PtcBFAwPr4l0nh8QlI2aQXhpTyCS8nonoOvVE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=atiZrVDhaQ1ZH6JljWr3hjeEXoo2T0WS
	GZNcoEADEs5FWa/q9WMsRsZ3/OJVkQEy4Iuvg/zSoLdoQtYLg4DP5jA3GrE/UhVO
	ToffhvGOeC3zbeIOj98jpQ3Yy25q5a6YrJqNJVc2BSBibn4E9+Be5XCat7jqNnJU
	mVv2DWpsyJo=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A5F143A61C;
	Thu, 19 Mar 2015 02:31:08 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EB1ED3A61A;
	Thu, 19 Mar 2015 02:31:07 -0400 (EDT)
In-Reply-To: <550884B3.5010102@alum.mit.edu> (Michael Haggerty's message of
	"Tue, 17 Mar 2015 20:46:59 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 86CC24FA-CE01-11E4-981C-FAE19E42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265788>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Here were my thoughts:
>
> * I wanted to change the interface to look less like
>   strtol()/strtoul(), so it seemed appropriate to make the names
>   more dissimilar.

One reason I prefer the names in the compat-util is that it makes it
clear that what is converted into what (e.g. "str" to "ul") and what
type the result is stored ("i" or "ui"), and as an added bonus, with
a short-and-sweet "to" it is already so clear we are "converting"
that we do not have to use verbs like "parse_" or "convert_".  From
parse_i() and convert_i(), I cannot tell which one lacks the endptr
and parses to the end and which one takes the endptr and tells the
caller where the conversion ended (and it also does not tell us that
they are converting from a string).

> * The functions seemed long enough that they shouldn't be inline,
>   and I wanted to put them in their own module rather than put
>   them in git-compat-util.h.

I actually agree on this, but that is not a justification why they
have to be named very differently.

Having said that, I would say that it will be futile to discuss this
further, as we seem to agree to disagree.
