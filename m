From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] sha1_file: don't malloc the whole compressed result when
 writing out objects
Date: Sun, 21 Feb 2010 22:17:53 -0800
Message-ID: <7v8walyesu.fsf@alter.siamese.dyndns.org>
References: <alpine.LFD.2.00.1002202323500.1946@xanadu.home>
 <7vd3zys79d.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1002211522120.1946@xanadu.home>
 <7v3a0umdb8.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1002211950250.1946@xanadu.home>
 <7v635p4z26.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1002220034540.1946@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Mon Feb 22 07:28:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NjRcS-0005iH-9j
	for gcvg-git-2@lo.gmane.org; Mon, 22 Feb 2010 07:18:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752546Ab0BVGSF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2010 01:18:05 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:56671 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751901Ab0BVGSD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2010 01:18:03 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E4E8B9B6B2;
	Mon, 22 Feb 2010 01:18:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=a/s2ebHzqD7K8Oe8Avp0owrBFzA=; b=pBTe1q
	OdF4NrialNYwyaAnp3QBCgr0PNlQ8aRpQD3G53K51AVYeJJaS9kN6s7aULEVaodu
	n4Twl01IrhfHY7+ulsgk7t4+NiuUYHLHcDbimfLJlrrKMFupbhSg9XOKgtWwojp5
	hceXl5qrQfUDJBt4AxdWnHDJtPDiP6dgZ/uLo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mvs3r4kiLGFi3rOGwIFviyWPyRWNTjid
	RAOye8M27cFe8bQaCsDEb9X6+6p388gQq58fR35mpoRhjhF7z7zJ/UCTQw+Y/Cc6
	J7zPGwdlqcpSf9A6XMXCb4sqvDwVrwmV15DepNXQ4TtBNczOOGeDRrd3LJNMb37w
	xMDhy6uvrhs=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id AF5CA9B6AE;
	Mon, 22 Feb 2010 01:18:00 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4B0C19B6AA; Mon, 22 Feb
 2010 01:17:56 -0500 (EST)
In-Reply-To: <alpine.LFD.2.00.1002220034540.1946@xanadu.home> (Nicolas
 Pitre's message of "Mon\, 22 Feb 2010 00\:50\:18 -0500 \(EST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 06D2D838-1F7A-11DF-BAF4-D83AEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140617>

Nicolas Pitre <nico@fluxnic.net> writes:

> And what real life case would trigger this?  Given the size of the 
> window for this to happen, what are your chances?

> Of course the odds for me to be struck by lightning also exist.  And if 
> I work really really hard at it then I might be able to trigger that 
> pathological case above even before the next thunderstorm.  But in 
> practice I'm hardly concerned by either of those possibilities.

The real life case for any of this triggers for me is zero, as I won't be
mistreating git as a continuous & asynchronous back-up tool.

But then that would make the whole discussion moot.  There are people who
file "bug reports" with an artificial reproduction recipe built around a
loop that runs dd continuously overwriting a file while "git add" is asked
to add it.
