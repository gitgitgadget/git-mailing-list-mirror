From: Junio C Hamano <gitster@pobox.com>
Subject: Re: BUG 1.7.9: git-update-ref strange behavior with ref with
 trailing newline
Date: Sat, 04 Feb 2012 00:11:06 -0800
Message-ID: <7vliojhvc5.fsf@alter.siamese.dyndns.org>
References: <15093.1328220568@plover.com>
 <20120202223250.GA28618@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Jason Dominus <mjd@plover.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Feb 04 09:11:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RtaiJ-0004ez-97
	for gcvg-git-2@plane.gmane.org; Sat, 04 Feb 2012 09:11:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752655Ab2BDILK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Feb 2012 03:11:10 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48873 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752154Ab2BDILI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Feb 2012 03:11:08 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0F49E3FAB;
	Sat,  4 Feb 2012 03:11:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/2RZgFR/BOz8YZUJLGDrMBE+8YA=; b=AOU4W3
	cguFMDq2XGCZsf4XsA6D7lOi4/JcvbEOY3ywo+TK6ngMagtCn1LNhAOF+6TUWhEx
	xCY9wkR6w/1cuEzX7YMUzuwcns9Tgg/2xAL46p8YRqjJJpMRQoFg7Za0CqsKsXQP
	+npivxEBbHlqlF4ipQcVUOB9bvEqfTri0xRCc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iFe3rnFP34YZLxU9w0uOW2rc0byOQKuR
	mwlUm2nIEKfy2o2jnO6+3LIuOV57rbsvaHdjQH6Y3mj3oMlnTHk+c2adGz/X4sgZ
	k9Bb/ly2IwL9qypDtz4rA1fr+5x9/uHHfwFYEkna+N/Z8Bk4YP35jslguBbZTx1R
	xGbp+t1x+v0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 06FFF3FAA;
	Sat,  4 Feb 2012 03:11:08 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6AE093FA8; Sat,  4 Feb 2012
 03:11:07 -0500 (EST)
In-Reply-To: <20120202223250.GA28618@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 2 Feb 2012 17:32:50 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CA41D8E6-4F07-11E1-88C6-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189859>

Jeff King <peff@peff.net> writes:

> As far as the newlines go, I'm surprised we don't reject that.  We should
> probably run check_refname_format on the proposed contents of the
> symbolic-ref.

Historically the plumbing commands were deliberately left loose on the
input side in the beginning, for the explicit purpose of allowing us to
more easily experiment, tweaking the low level data structures and file
formats.  It's like being able to use a disk editor to experiment with the
filesystem.  You feed good data, and you will see expected results.  You
perform something other parts of the system does not yet expect, and you
find places that need further adjusting if you were to extend the format
you are futzing with the "bare metal manipulation tool" ;-)

It is not surprising at all that we haven't tightened the ones that normal
users would not use, and symbolic-ref is one of them.  You needed to write
scripts that would use symbolic-ref yourself more often in the early days
of Git, but back in those days, (1) people who wrote scripts with plumbing
commands tended to know what they were doing and (2) we did not have that
much interaction between subsystems, like reflogs vs symrefs.

Now, those days are long gone, and we are done with experiments pretty
much.  We should tighten remaining holes as we find them.
