From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Add possibility to store configuration in
 ~/.config/git/config file
Date: Fri, 25 May 2012 14:25:38 -0700
Message-ID: <7vd35sq7fx.fsf@alter.siamese.dyndns.org>
References: <1337975239-17169-1-git-send-email-nguyenhu@ensibm.imag.fr>
 <20120525203056.GC4364@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: NGUYEN Huynh Khoi Nguyen <nguyenhu@ensimag.imag.fr>,
	git@vger.kernel.org, Matthieu.Moy@grenoble-inp.fr,
	NGUYEN Huynh Khoi Nguyen <nguyenhu@ensibm.imag.fr>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 25 23:25:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SY219-0003uK-VA
	for gcvg-git-2@plane.gmane.org; Fri, 25 May 2012 23:25:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756098Ab2EYVZr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 May 2012 17:25:47 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52749 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753054Ab2EYVZq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 May 2012 17:25:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4C8D08ED4;
	Fri, 25 May 2012 17:25:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=D6pkuS2hoaD3ROvWnAjXAWge4Ns=; b=fYK4dD
	cA9jLJ8hqLBju/Sv9UVGZ7DyZcvf8QvP4jto7zNn3vrX4AcNMRv7CIfknoHHAWrI
	Q3l9oHQd8NHCoLPqxjrK+6+3dVCXM2UIdxzBRIHUJHkZFLNh6hBCFzBV1hZtdj9s
	3hNRRUdnaJ010oCoYPCGN3/m+792RaUoImY9A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wdWY8uz4+qj2bGosl3VT/kL7TI2IBk9r
	n/tjG+ut3teu+aF1G3PiSI5EUHHfgrM71wlk2KgQhzKv9l0xsRn58yqLJ0qcLFPs
	phrSXYSSZxmL7pVRUftIxoSB9jAPLvkUdXkWy0mIh19G/N/zYZPITRxgzrRyQM8J
	Ke7ErklE/DI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3271F8ECC;
	Fri, 25 May 2012 17:25:44 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9F6578EB0; Fri, 25 May 2012
 17:25:39 -0400 (EDT)
In-Reply-To: <20120525203056.GC4364@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 25 May 2012 16:30:56 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2CF6A098-A6B0-11E1-A453-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198527>

Jeff King <peff@peff.net> writes:

> On Fri, May 25, 2012 at 09:47:18PM +0200, NGUYEN Huynh Khoi Nguyen wrote:
>
>> git will store its configuration in ~/.config/git/config file if this file
>> exists and ~/.gitconfig file doesn't, otherwise git store its configuration
>> in ~/.gitconfig as usual
>
> What about reading? For maximum compatibility, we should always read
> from _both_ of them, and choose between them only when writing, no? It
> looks like your patch will only read from one or the other.
>
> At first people will have only one or the other, but people using
> multiple versions of git, or people following already-written
> instructions on the web about modifying ~/.gitconfig could end up with
> both.

Isn't it actually much worse than that?

If you read from .gitconfig and also from the new location, but update
only the new location, people who use two versions of git will be in a
very confusing situation.  Randomly, some of their updates are always in
effect, and others only appear sometimes, and after wasting a lot of time
and hair scratching their heads, they will realize that writing with old
versions of Git will store values to a place visible to both versions,
while writing with new versions will store values to a place visible only
to new versions.

I'd rather see it ignore the new location as long as ~/.gitconfig exists
(and if only the new location exists, read from and write to it), and have
users make a conscious decision to transition.  That is:

 - If ~/.gitconfig exists, do not do anything new.  Just exercise the
   original code.  For these users, ~/.config/ does _not_ exist as far as
   Git is concerned.

 - (optional) If ~/.gitconfig exists, offer _moving_ it to the new
   location after telling the user to make sure that the user will never
   use older version of git again, and move it if the user agrees.

 - Otherwise, read from and write to the new location.
