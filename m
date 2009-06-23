From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] rebase -i: use some kind of config file to save author information
Date: Mon, 22 Jun 2009 22:25:16 -0700
Message-ID: <7vljnja5dv.fsf@alter.siamese.dyndns.org>
References: <20090620023413.3995.3630.chriscool@tuxfamily.org>
	<alpine.DEB.1.00.0906212354030.26154@pacific.mpi-cbg.de>
	<7v1vpdqiv2.fsf@alter.siamese.dyndns.org>
	<200906230657.48627.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Tue Jun 23 07:25:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MIyVr-0006R8-S0
	for gcvg-git-2@gmane.org; Tue, 23 Jun 2009 07:25:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751410AbZFWFZQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Jun 2009 01:25:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752735AbZFWFZP
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Jun 2009 01:25:15 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:39411 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751666AbZFWFZO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jun 2009 01:25:14 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090623052515.VZDT20976.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Tue, 23 Jun 2009 01:25:15 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id 7HRG1c00R4aMwMQ04HRGV8; Tue, 23 Jun 2009 01:25:16 -0400
X-VR-Score: -100.00
X-Authority-Analysis: v=1.0 c=1 a=8s1IcQ_F8yQA:10 a=dIu3SnmMAAAA:8
 a=QrsLvkZGXTt2A3oqTA4A:9 a=w71Pc60Kl-oOJ5FwynUA:7
 a=nMHYYEv9gNe51cSfbl8OsRRs2UsA:4 a=Rn8qiON8_f4A:10
X-CM-Score: 0.00
In-Reply-To: <200906230657.48627.chriscool@tuxfamily.org> (Christian Couder's message of "Tue\, 23 Jun 2009 06\:57\:47 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122074>

Christian Couder <chriscool@tuxfamily.org> writes:

> This patch would use the message from HEAD instead of "$DOTEST"/message, but 
> it looks like we are changing "$DOTEST"/message sometimes with 
> the "make_squash_message" function.

Heh, that is why it was "something along this line" patch ;-)

Regarding the C rewrite vs rebase--i.sh update, I tend to agree with Dscho
that changing the scripted Porcelain is not worth it if we are rewriting
the whole thing in C soon.  But perhaps we can allow combinations of the
two options ("-[cC] commit" and "-F file") given to "git commit"?  The
intent of the caller in such a case is quite clear---use the authorship
but do use the message from the other source (if we do this, it would
probably make sense to do that also for "-m message").  The version
entirely written in C obviously does not even need such an option (it can
read authorship from HEAD and use its own message), but the point is if
going that route would eliminate the need to store "which commit were we
dealing with when we gave the control back" information on disk.  I
suspect that the sequencing information is already on disk (i.e. $TODO
file) and author-script may be redundant information.
