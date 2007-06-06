From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/6] git-fsck: Do thorough verification of tag objects.
Date: Wed, 06 Jun 2007 02:21:18 -0700
Message-ID: <7vwsyh4ewh.fsf@assigned-by-dhcp.cox.net>
References: <200706040251.05286.johan@herland.net>
	<200706040951.06620.johan@herland.net>
	<7vtztl7dqi.fsf@assigned-by-dhcp.cox.net>
	<200706061006.33139.johan@herland.net>
	<7vejkp5ua1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthias Lederhofer <matled@gmx.net>, git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Jun 06 11:21:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hvrhn-0003ik-Ma
	for gcvg-git@gmane.org; Wed, 06 Jun 2007 11:21:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753228AbXFFJVU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Jun 2007 05:21:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753921AbXFFJVU
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jun 2007 05:21:20 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:60076 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753228AbXFFJVT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jun 2007 05:21:19 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070606092119.TODS15717.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Wed, 6 Jun 2007 05:21:19 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 89MJ1X0081kojtg0000000; Wed, 06 Jun 2007 05:21:18 -0400
In-Reply-To: <7vejkp5ua1.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Wed, 06 Jun 2007 02:03:50 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49276>

Junio C Hamano <gitster@pobox.com> writes:

> Johan Herland <johan@herland.net> writes:
> ...
>> Or would you rather switch around the "verbose" and the
>> "parse_and_verify_tag_buffer()" (i.e. not even attempt the thorough
>> verification unless in verbose mode)?
>
> Actually I was thinking about doing something like this.
>
> -	if (parse_and_verify_tag_buffer(0, data, size, 1) && verbose)
> +	if (parse_and_verify_tag_buffer(0, data, size, verbose))

Well, after running fsck with --verbose, I take the whole
suggestion back.  I think it is a good idea to do the "thorough"
tag validation in general, and it should not be buried under the
verbose output, which is almost useless unless in a very narrow
special case that you are really trying to see which exact
object is corrupt.

So I think your original patch to signal error on thorough tag
validation failure is probably a good approach in general.
People need to know that in git.git fsck would return non-zero
because of v0.99 tag, but the people who get hit/annoyed by this
ought to be minority.  It may be the case that a major portion
of git users currently are the ones who futz with the git.git
repository, but there would be a serious problem if it continues
to be the case ;-)
