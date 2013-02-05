From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 7/8] fetch: fetch objects by their exact SHA-1 object
 names
Date: Tue, 05 Feb 2013 07:55:42 -0800
Message-ID: <7vk3qmvjpd.fsf@alter.siamese.dyndns.org>
References: <1359571542-19852-1-git-send-email-gitster@pobox.com>
 <1359571542-19852-8-git-send-email-gitster@pobox.com>
 <20130205091938.GB24973@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Shawn Pearce <spearce@spearce.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 05 16:56:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2ksU-0006fl-8M
	for gcvg-git-2@plane.gmane.org; Tue, 05 Feb 2013 16:56:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756155Ab3BEPzq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2013 10:55:46 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33686 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755294Ab3BEPzp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2013 10:55:45 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7FA9FC6D7;
	Tue,  5 Feb 2013 10:55:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yHEJzE1008vBHquEUn4aq7AFDUc=; b=TslIvG
	/5XtSsPkHCednV2sUnRZTZEXOm6S2QVR6qGFfruPzGzFHTc8eavJO/Aw1wKFW4sH
	A2h9zp7qH1N7s2nb4L0+iNKi+Wg+lSnWExJfOzCGy0H08/EMb5rrx8bXBJq/FNm3
	JOrU2zZRWcmjAwABjr5bV+y7qgthIe7uGVusY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Nc5gl1EJ7nlUw/4b4zup51jDFsC9b+m3
	z0kajurJtOSsThHqx10Hs0YjTDANNM4PCkC9MTNGBPpztVcxN8Du0UcoNSCTKY+i
	m9sFnd4QEi51tD8Fj48BLCczRC8g1TtJjF3QGhchI2JN0pB+qSgR/bvIvZ07VSJL
	WLUVdiKkQEI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 751ABC6D6;
	Tue,  5 Feb 2013 10:55:44 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E8D4AC6D4; Tue,  5 Feb 2013
 10:55:43 -0500 (EST)
In-Reply-To: <20130205091938.GB24973@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 5 Feb 2013 04:19:38 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7F8E27CA-6FAC-11E2-BDDA-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215508>

Jeff King <peff@peff.net> writes:

> On Wed, Jan 30, 2013 at 10:45:41AM -0800, Junio C Hamano wrote:
>
>> Teach "git fetch" to accept an exact SHA-1 object name the user may
>> obtain out of band on the LHS of a pathspec, and send it on a "want"
>> message when the server side advertises the allow-tip-sha1-in-want
>> capability.
>
> Hmm. The UI on this is a little less nice than I would have hoped.

Naming with unadvertised *refname*, not object name, needs protocol
extension for the serving side to expand the name to object name;
otherwise the receiving end wouldn't know what tip what it asked
resulted in.

And that belongs to a separate "expand refs" extension (aka
"delaying ref advertisement") that is outside the scope of this
series but can be built on top, as I said in the cover letter.
