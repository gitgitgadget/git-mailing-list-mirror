From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Avoid perl in t1300-repo-config
Date: Wed, 27 Jun 2007 21:30:25 -0700
Message-ID: <7vmyykog4e.fsf@assigned-by-dhcp.pobox.com>
References: <81b0412b0706270545w65ca2556yaafaac6ff31b5961@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"Frank Lichtenheld" <frank@lichtenheld.de>,
	"Junio C Hamano" <gitster@pobox.com>
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 28 06:30:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3leH-0002hN-LS
	for gcvg-git@gmane.org; Thu, 28 Jun 2007 06:30:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752786AbXF1Ea2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Jun 2007 00:30:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752413AbXF1Ea1
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jun 2007 00:30:27 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:52880 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751113AbXF1Ea1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jun 2007 00:30:27 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070628043027.QZTX1594.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Thu, 28 Jun 2007 00:30:27 -0400
Received: from assigned-by-dhcp.pobox.com ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id GsWS1X0041kojtg0000000; Thu, 28 Jun 2007 00:30:26 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51080>

"Alex Riesen" <raa.lkml@gmail.com> writes:

> It fixes the test on system where ActiveState Perl is used.
> It is also shorter.
> ...
> -git config --null --list | perl -0ne 'chop;($key,$value)=split(/\n/,$_,2);print "Key: $key\n";print "Value: $value\n" if defined($value)' > result
> +git config --null --list | xargs -n1 -0 echo 'Key:' > result

This now makes us rely on "xargs -0", which is probably much
less portable than Perl isn't it?  Because the point of the test
is that it can show things in NUL terminated format, I'd rather
keep it use a bit more portable stuff.  Also I am not sure if
the two tests are really testing the same thing.

Maybe postprocess "git config -z" output with "tr '[\000]' 'Q'"
or something so that the comparison of the result does not have
to worry about NULs?  I dunno.

By the way, is it possible for gmail users to avoid attachments
when sending patches in?
