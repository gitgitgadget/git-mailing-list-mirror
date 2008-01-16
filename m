From: Junio C Hamano <gitster@pobox.com>
Subject: Re: I don't want the .git directory next to my code.
Date: Wed, 16 Jan 2008 11:23:07 -0800
Message-ID: <7v8x2pr2w4.fsf@gitster.siamese.dyndns.org>
References: <478D79BD.7060006@talkingspider.com>
	<86hcheig3n.fsf@blue.stonehenge.com>
	<478D82FA.2030404@talkingspider.com> <478D95D8.5040806@theory.org>
	<478E3D8E.1090300@talkingspider.com>
	<alpine.LFD.1.00.0801161000310.2806@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mike <fromlists@talkingspider.com>,
	Neil Macneale <mac4-git@theory.org>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Jan 16 20:23:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFDrb-0007pS-2P
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 20:23:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752313AbYAPTXW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 14:23:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751560AbYAPTXV
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 14:23:21 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:61493 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751419AbYAPTXU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2008 14:23:20 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 5B03D352A;
	Wed, 16 Jan 2008 14:23:19 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id A181B3529;
	Wed, 16 Jan 2008 14:23:14 -0500 (EST)
In-Reply-To: <alpine.LFD.1.00.0801161000310.2806@woody.linux-foundation.org>
	(Linus Torvalds's message of "Wed, 16 Jan 2008 10:15:12 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70729>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> Let me do a few examples of why this is a good idea:
>
>  - the whole point of development trees and SCM's (and that's *especially* 
>    true with git) is how you can try things out, go backwards in time, and 
>    generally just do *development*.
>
>    If you do that in what is your public deployment area, you're already 
>    very limited. Not only may you not want to make that .git directory 
>    accessible to others (while you *do* obviously want to make the 
>    deployment itself), you also end up exposing things like your 
>    management scripts and source code along with "generated files" etc 
>    that are the things you actually want to deploy.
>
>    Yes, it's certainly quite possible that you simply don't have any 
>    management scripts etc, and that you don't generate any files, and you 
>    simply want to just deploy the exact files that you also want to track. 

Even without any management script, you cannot do any _development_
in such a tree.  By definition, mucking with the files in the
deployment area means all of your changes are immediately visible by
the clients.

One reason (admittedly misguided) people mentioned why they want
to do this is because they want to be able to "git-add" files
generated on the deployed server by client actions (think of a
Wiki that drops new contents in an area writable by the
webserver).  If your deployment area is _not_ managed by git,
they instead need to write a Makefile target in their
development area that takes new/modified files back to the
development tree and "git-add" those copies.

The right way to manage these client-generated contents would of
course be to commit them to a branch separate from the sources
you develop (otherwise your history will be a mixed mess between
the true development and client content changes), so the
argument is very weak and is not a good justification for
wanting to have deployment and development tree as one.

But I can well imagine that it is a tempting way to work for
people who have not thought about the reason why history
matters, especially for the ones who still suffer from CVS
braindamage that makes separate branches inpractical.
