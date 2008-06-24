From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] pre-commit hook should ignore carriage returns at EOL
Date: Tue, 24 Jun 2008 15:31:20 -0700
Message-ID: <7v3an2bh3b.fsf@gitster.siamese.dyndns.org>
References: <53A5AFCF-94C7-465E-A181-1DA69F251F5B@gmail.com>
 <alpine.LFD.1.10.0806241418360.32759@sys-0.hiltweb.site>
 <39C2861E-F800-40AE-8C15-4FC3BB51EF16@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ian Hilt <Ian.Hilt@gmx.com>, git@vger.kernel.org
To: Christian Holtje <docwhat@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 25 00:32:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBH47-0002rc-HW
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 00:32:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754668AbYFXWbu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 18:31:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754636AbYFXWbt
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 18:31:49 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:55964 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752741AbYFXWbd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 18:31:33 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 2A43B10D8A;
	Tue, 24 Jun 2008 18:31:31 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id D620110D88; Tue, 24 Jun 2008 18:31:26 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 4B1D4EFE-423D-11DD-B795-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86160>

Christian Holtje <docwhat@gmail.com> writes:

> The code is checking for \r$ and then doing a different space check
> depending on that, not one after another.
>
> Thanks for the feedback. I'll put up v2 in a second.

Please don't.

It's an ancient sample hook that is not be enabled by default.  I do not
want people to be wasting too much time on the relic.

However, if this sample is to be changed at all, please do it right.

If somebody suddenly adds CR at the end of an existing file that ought to
have LF line endings, we _DO_ want to catch that as a breakage.  So the
title of the commit "should ignore carriage returns at EOL" is WRONG.  It
shouldn't, in general.

One thing the hook could and probably should do these days is if the file
type says you _ought to_ have CRLF line endings, actively make sure your
lines do end with CRLF (this is a much stronger and better check than
blindly ignoring CR before LF for such files).  And on the other hand, if
the file should end with LF, do make sure it does not have CR before it.

The person who did the sample hook you are looking at couldn't do so
because there weren't autocrlf nor gitattributes(5) facility back then.
But you can use them now to rewrite this properly.

I wonder if "git diff --check" can be used for most if not all of the
checking, without the big Perl script you are touching in your patch.
That facility did not exist when the current sample hook was written,
either.
