From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] pull: merge into unborn by fast-forwarding from empty tree
Date: Thu, 20 Jun 2013 13:49:13 -0700
Message-ID: <7vmwqkqzhy.fsf@alter.siamese.dyndns.org>
References: <20130620124758.GA2376@sigill.intra.peff.net>
	<aca810600b895ed3f0a3fc575e0f6861e591de5b.1371733403.git.trast@inf.ethz.ch>
	<7v8v24vd0m.fsf@alter.siamese.dyndns.org>
	<20130620201957.GC31364@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@inf.ethz.ch>,
	Stefan =?utf-8?B?U2Now7zDn2xlcg==?= <mail@stefanschuessler.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jun 20 22:49:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UplnF-0007XT-CF
	for gcvg-git-2@plane.gmane.org; Thu, 20 Jun 2013 22:49:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422671Ab3FTUtR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Jun 2013 16:49:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51665 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965660Ab3FTUtQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Jun 2013 16:49:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 12150294ED;
	Thu, 20 Jun 2013 20:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DSZ9RkF6/yYV6k+Vz4sOvOmqVOc=; b=NJeP7X
	Wuq5JseqmNRFCvxLUdczmqkVGZGfmNBm4ufbCsRqj1QHbxOncn6Tc7Nr/HS2qfyg
	1WkMYl8H0LqyCpVldfwJavU/JOtnG3focCxXbfXCQcEMWrjj/TRAW+YDiVoA9PmE
	QM1P8jT/zxknyOc0MagNYBpjC0WgDq6wn6iJk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TLzq7LmHS+jjEcPCnVtx6bwn3gI7BhrM
	l7Ezr0XrnSVFK6f1EFTBCJwkJ80NZx6Ad+O0pweal67NS2pKlbZye71KCDJjwcjF
	FEmJ6urfxTWOrPNDlgfO5MDbA098+4VJzzVhlM8RzCIHbc21ErTYBIf3OcRJrKPT
	jGTXRqnloSU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 069D6294EB;
	Thu, 20 Jun 2013 20:49:16 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 676C4294E8;
	Thu, 20 Jun 2013 20:49:15 +0000 (UTC)
In-Reply-To: <20130620201957.GC31364@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 20 Jun 2013 16:19:57 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DE93F0D0-D9EA-11E2-B0A3-80EC6777888E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228536>

Jeff King <peff@peff.net> writes:

>> Perhaps making sure the index is empty is sufficient, then?
>
> That would not let you pull when you have "foo" staged, but upstream
> does not have "foo" at all. To be fair, that is quite a corner case, and
> simply rejecting the pull entirely may be OK.

That simplicity was what I was hinting at ;-).

> But read-tree already does
> the hard work for us, so I don't think it is a lot of code either way.

OK, I just got an impression from reading the back-and-forth between
you two that read-tree does not want to deal with that case.

But yes, if you say "I have this index, and I am straying away from
an empty tree to that commit", with two-tree form "read-tree -m -u",
everything should work correctly, including the bit that says "nah,
nah, you have added 'foo' but the other guy also adds 'foo', so I'll
refuse".

So please scratch that short-cut suggestion.
