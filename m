From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH/RFC] Have git-cvsserver call hooks/update before really altering the ref
Date: Wed, 14 Feb 2007 01:33:42 -0800
Message-ID: <7vfy99t761.fsf@assigned-by-dhcp.cox.net>
References: <200702131512.45412.andyparkins@gmail.com>
	<7v4pppuwpv.fsf@assigned-by-dhcp.cox.net>
	<200702140913.55506.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martyn Smith <martyn@catalyst.net.nz>,
	Martin Langoff <martin@catalyst.net.nz>, git@vger.kernel.org
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 14 10:33:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHGWT-0001Ev-N0
	for gcvg-git@gmane.org; Wed, 14 Feb 2007 10:33:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750836AbXBNJdo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 04:33:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750830AbXBNJdo
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 04:33:44 -0500
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:53874 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750836AbXBNJdn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 04:33:43 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070214093342.XOI21177.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Wed, 14 Feb 2007 04:33:42 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id PMZi1W0061kojtg0000000; Wed, 14 Feb 2007 04:33:42 -0500
In-Reply-To: <200702140913.55506.andyparkins@gmail.com> (Andy Parkins's
	message of "Wed, 14 Feb 2007 09:13:53 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39627>

Andy Parkins <andyparkins@gmail.com> writes:

> On Wednesday 2007 February 14 05:36, Junio C Hamano wrote:
>
>> Everybody else seems to say 'print "error 1 blah blah"'.  Are
>> you sure "error 2 message" is Kosher protocol-wise?
>
> Oops.  No I'm not sure at all.  I hadn't noticed that was a protocol command; 
> I'd read it as being output to stderr which appears to be just commentary to 
> the CVS client.  I assume you don't want a patch just to correct that?

I did not even read the protocol when I wondered what that 2 vs
1 was, and I wanted to know what was the right thing to send to
the client.  In other words, I was lazy ;-)

`error ERRNO-CODE ` ' TEXT \n'
     The command completed with an error.  ERRNO-CODE is a symbolic
     error code (e.g. `ENOENT'); if the server doesn't support this
     feature, or if it's not appropriate for this particular message,
     it just omits the errno-code (in that case there are two spaces
     after `error').  Text is an error message such as that provided by
     strerror(), or any other message the server wants to use.  The
     TEXT is like the `M' response, in the sense that it is not
     particularly intended to be machine-parsed; servers may wish to
     print an error message with `MT' responses, and then issue a
     `error' response without TEXT (although it should be noted that
     `MT' currently has no way of flagging the output as intended for
     standard error, the way that the `E' response does).

I suspect Martin and Martyn chose 1 to match EPERM (I am looking
at /usr/include/asm-generic/errno-base.h), and I think your new
error case falls into EPERM category as well.  Since your patch
is currently queued in 'pu', I can just go ahead and fix it
myself with "git commit --amend", but an Ack from down under
would certainly be appreciated ;-).
