From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH resend] perl/Makefile.PL: teach makefiles about possible
 old Error.pm files
Date: Wed, 21 May 2008 15:51:40 -0700
Message-ID: <7vzlqjz2wz.fsf@gitster.siamese.dyndns.org>
References: <20080517011614.GA11029@foursquare.net>
 <20080521222150.GA29696@foursquare.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Chris Frey <cdfrey@foursquare.net>
X-From: git-owner@vger.kernel.org Thu May 22 00:55:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JyxBH-0005cO-IO
	for gcvg-git-2@gmane.org; Thu, 22 May 2008 00:53:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757154AbYEUWvx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 May 2008 18:51:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757008AbYEUWvx
	(ORCPT <rfc822;git-outgoing>); Wed, 21 May 2008 18:51:53 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:41638 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755619AbYEUWvx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 May 2008 18:51:53 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 74FBFD468;
	Wed, 21 May 2008 18:51:50 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id C1B62D465; Wed, 21 May 2008 18:51:47 -0400 (EDT)
In-Reply-To: <20080521222150.GA29696@foursquare.net> (Chris Frey's message of
 "Wed, 21 May 2008 18:21:50 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 7FD4B3AA-2788-11DD-A7DD-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82585>

Chris Frey <cdfrey@foursquare.net> writes:

> If a previous version of git was installed on a system without a
> proper Error.pm, git will install its own.  But the next time
> git is compiled on that system, that Error.pm will prevent git from
> installing its own copy the second time.  This causes a broken
> git install on such systems.
>
> This patch fixes this bug by tagging git's Error.pm with an
> INSTALLED_BY flag, and checking for it during the compile.

I think this is a wrong direction to go.

We do not currently deal with broken installations, and "stow" is just one
easy way to install and keep a stale version.  The right solution would be
to check if "Error.pm" we find on the system (be it installed by previous
incarnation of git or some other packages) works as expected, and refrain
from using it if it doesn't.

When the system has a slightly older version of Error.pm, it does not
really matter if that old one case from our own Error.pm (because back
then the system did not have Error.pm at all), or the user installed a
slightly older version of Error.pm from elsewhere.

IOW, I won't be interested in a solution that adds INSTALLED_BY.  Even if
it is ours, as long as it is fresh enough, there is no reason to replace
it with a new copy.  Even if it is _not_ ours, if it is stale and does not
work as we expect, we might have to install our own on our path.
