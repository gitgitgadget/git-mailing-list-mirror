From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git pull fails with http urls?
Date: Tue, 04 Sep 2007 12:17:06 -0700
Message-ID: <7vsl5umea5.fsf@gitster.siamese.dyndns.org>
References: <1188915053.5705.12.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Richard Purdie <rpurdie@rpsys.net>
X-From: git-owner@vger.kernel.org Tue Sep 04 21:17:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISdtl-0002mw-SO
	for gcvg-git@gmane.org; Tue, 04 Sep 2007 21:17:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752187AbXIDTRN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Sep 2007 15:17:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751680AbXIDTRN
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Sep 2007 15:17:13 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:46129 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752079AbXIDTRM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2007 15:17:12 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 6FDDC12E73C;
	Tue,  4 Sep 2007 15:17:30 -0400 (EDT)
Cc: Petr Baudis <pasky@suse.cz>
In-Reply-To: <1188915053.5705.12.camel@localhost.localdomain> (Richard
	Purdie's message of "Tue, 04 Sep 2007 15:10:53 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57634>

Pasky seems to have a locally modified version at repo.or.cz to
add HEAD to the result of update-server-info, but as far as I
can see, update-server-info never placed HEAD in the result, and
I do not think ls-remote compensated it by adding HEAD by hand,
so that change is fixing the symptom rather than fixing the
regression, but I am not sure where the true regression is.
Most likely we broke git-fetch while trying to deal with
repositories with insanely large number of refs (aka
"fetch--tool partial rewrite in C").

Having said all that, I think it is a good idea nevertheless to
add HEAD information across all transports, like Pasky's patch
does.  Currently http/ftp/rsync do not report HEAD while git
native protocols do.

Pasky, care to submit "server-info: Add HEAD to info/refs" for
inclusion?
