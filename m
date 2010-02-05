From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] push: Use sideband channel for hook messages
Date: Thu, 04 Feb 2010 21:53:16 -0800
Message-ID: <7v3a1gmdo3.fsf@alter.siamese.dyndns.org>
References: <20100205033748.GA19255@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Feb 05 11:06:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdL3J-0003Bj-3V
	for gcvg-git-2@lo.gmane.org; Fri, 05 Feb 2010 11:04:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752464Ab0BEFx0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2010 00:53:26 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:59464 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751444Ab0BEFxZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2010 00:53:25 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6187E97FAD;
	Fri,  5 Feb 2010 00:53:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DNhj4BTj0PzQFzP+N7DtcvxazB8=; b=vd+vaz
	aQK6JWlbdstm6ar4+Q8CmzNoZ65U3wZyQ5O4qaFQYv0X8ej24wfGeyY6CN6Sy5jW
	l11YYt9b3Ews9Co7maH1+vtUgEDa/YxmcgB8TWnFbwKTPePHFSgIAZbOkx0v7dfg
	DPh74vrXAEL1lStbyu6Hh4oG6xzsbv5wCp4GE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HV7WHz612aAYM2u0A9XaedquK8zF8bJA
	GC44lYvPYTPoCJR7uH8w38F6ooVt5ZURmkLn8r55l9/bmAg6dlz+Jtkdz37UoIc3
	ehUN2Q3/4+cr5MFaXFb5M6OuPF77YJcCypTmjlUNKyj8jagoVoYpZGCzlw193lz+
	L4mDx2yZTXk=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 39ED697FAB;
	Fri,  5 Feb 2010 00:53:21 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8E33C97FAA; Fri,  5 Feb
 2010 00:53:18 -0500 (EST)
In-Reply-To: <20100205033748.GA19255@spearce.org> (Shawn O. Pearce's message
 of "Thu\, 4 Feb 2010 19\:37\:48 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C40DBD7C-121A-11DF-A224-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139034>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Rather than sending hook messages over stderr, and losing them
> entirely on git:// and smart HTTP transports, receive-pack now
> puts them onto a multiplexed sideband channel if the send-pack
> client asks for the side-band-64k capablity.  This ensures that
> hooks from the server can report their detailed error messages,
> if any, no matter what git-aware transport is being used.
>
> When the side band channel is being used the push client will wind up
> prefixing all server messages with "remote: ", just like fetch does.
>
> Signed-off-by: Shawn O. Pearce <spearce@spearce.org>

This feels to me a topic that has multiple unrelated changes mixed
together, making it unnecessarily confusing to review.

 - capabilities_to_send -> send_capabilities;

 - use of sideband in communication from send-pack to receive-pack;

 - adding communication in the opposite direction to async infrastructure;

 - use_sideband that is a boolean but is also used to hold
   LARGE_PACKET_MAX (on the receiving end).
