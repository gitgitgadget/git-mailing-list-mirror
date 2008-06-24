From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [NON-TOY PATCH] git bisect: introduce 'fixed' and 'unfixed'
Date: Tue, 24 Jun 2008 15:30:59 -0700
Message-ID: <7vej6mbh3w.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0806241515460.9925@racer>
 <20080624163810.GA4654@sigill.intra.peff.net>
 <alpine.DEB.1.00.0806241750030.9925@racer>
 <alpine.DEB.1.00.0806241808400.9925@racer>
 <20080624174157.GB9500@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 25 00:32:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBH46-0002rc-7Z
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 00:32:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752188AbYFXWbR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 18:31:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752094AbYFXWbR
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 18:31:17 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:37992 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752043AbYFXWbR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 18:31:17 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 5F95F8C30;
	Tue, 24 Jun 2008 18:31:13 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 650828C2F; Tue, 24 Jun 2008 18:31:08 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 40839052-423D-11DD-9A4B-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86161>

Jeff King <peff@peff.net> writes:

> On Tue, Jun 24, 2008 at 06:09:28PM +0100, Johannes Schindelin wrote:
>
>> 	And this is my first attempt at a proper patch for it.
>> 
>> 	Now with documentation, and hopefully all places where the
>> 	user is being told about a "bad" commit.
>
> This looks reasonably sane to me. The only thing I can think of that
> we're missing is that "git bisect visualize" will still show the refs as
> "bisect/bad" and "bisect/good".
>
> To fix that, you'd have to ask people to start the bisect by saying "I
> am bisecting to find a fix, not a breakage." And then you could change
> the refnames and all of the messages as appropriate.

It probably is not just a good idea, but is a necessary fix, to remove
confusion like this example that appears everywhere:

>  		echo >&2 'You '$THEN'need to give me at least one good' \
> -			'and one bad revisions.'
> +			'and one bad (or fixed) revision.'
>  		echo >&2 '(You can use "git bisect bad" and' \
>  			'"git bisect good" for that.)'

People who are reading the change Dscho did in the "patch" form may not
notice it, but imagine how the above looks to the end user who was told
that "new bisect can now look for fixes", who does not need to nor even
want to know that the new feature is implemented by making bad and fixed
synonyms.

They need to mentally reword "good" into "unfixed" and "bisect bad" into
"bisect fixed" while reading the output from the above pieces, but the
point of this new "look for fixes" feature is they do not have to do the
rewording anymore!
