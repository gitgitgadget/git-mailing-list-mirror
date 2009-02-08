From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] use lock token in non-URI form in start_put
Date: Sat, 07 Feb 2009 18:28:06 -0800
Message-ID: <7vzlgx3bnt.fsf@gitster.siamese.dyndns.org>
References: <498DE0B9.6080603@gmail.com>
 <alpine.DEB.1.00.0902072114360.10279@pacific.mpi-cbg.de>
 <7v1vuavv4l.fsf@gitster.siamese.dyndns.org>
 <be6fef0d0902071745r355309c2o76622b3af8df53bc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 08 03:29:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVzQR-0006KH-Bx
	for gcvg-git-2@gmane.org; Sun, 08 Feb 2009 03:29:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752546AbZBHC2N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Feb 2009 21:28:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752536AbZBHC2N
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Feb 2009 21:28:13 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:39943 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752460AbZBHC2M (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Feb 2009 21:28:12 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 1ACA62AA9D;
	Sat,  7 Feb 2009 21:28:12 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 4E72A2A4FE; Sat, 
 7 Feb 2009 21:28:08 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 21B64E18-F588-11DD-B443-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108913>

Tay Ray Chuan <rctay89@gmail.com> writes:

> In section 6.5 which you cite below, the token is unique, and we hold
> the server's word for it.

Are you sure you are not reading too much into that guarantee?

I somehow thought that the natural reading of the guarantee is *not* that
the tokens are unique over the lifetime of the server installation (iow, a
lock token you obtained today will never be used in the future, and it is
a token that the server never has used before), but it merely guarantees
that there are no any two outstanding locks that share the same URI, lest
one client's unlock request breaks the wrong lock.  But I may be wrong here.

>> That is why I asked in my previous question what in the codepath protects
>> ourselves from using problematic characters.
>
> You're right, section 6.5 doesn't enforce that lock tokens are UUIDs.
>
> Any solutions to this? Perhaps one could have a function, say,
> get_unique_remote_postfix, and the function would check for URI
> schemes which we know are safe for use in file names, namely,
> "urn:uuid:" and "opaqulocktoken:". However, if its a URI we are unsure
> of, then it would generate a random string.

Let me show even more ignorance of mine with this codepath.

What breaks and how, if we do not even use a random string but a fixed
suffix ".temp" here?  I am not suggesting we actually do that, but I'd
like to see how important the uniqueness is here to better understand the
issue.
