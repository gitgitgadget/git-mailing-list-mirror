From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH 5/6] Use floating point for --dirstat percentages
Date: Wed, 27 Apr 2011 04:02:28 +0200
Message-ID: <201104270402.29085.johan@herland.net>
References: <BANLkTim9U4cOnV+5=Mp-2g_M6+JOiM5e7A@mail.gmail.com>
 <1303776102-9085-6-git-send-email-johan@herland.net>
 <7vpqo9ez03.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 04:02:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QEu5N-0006P8-61
	for gcvg-git-2@lo.gmane.org; Wed, 27 Apr 2011 04:02:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756413Ab1D0CCb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2011 22:02:31 -0400
Received: from smtp.getmail.no ([84.208.15.66]:39698 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756328Ab1D0CCa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2011 22:02:30 -0400
Received: from get-mta-scan04.get.basefarm.net ([10.5.16.4])
 by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LKA00AAXGC5MS50@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Wed, 27 Apr 2011 04:02:29 +0200 (MEST)
Received: from get-mta-scan04.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 7EBBA1EEED56_DB77935B	for <git@vger.kernel.org>; Wed,
 27 Apr 2011 02:02:29 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan04.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 679191EEED3D_DB77935F	for <git@vger.kernel.org>; Wed,
 27 Apr 2011 02:02:29 +0000 (GMT)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LKA002LXGC5Y610@get-mta-in03.get.basefarm.net> for
 git@vger.kernel.org; Wed, 27 Apr 2011 04:02:29 +0200 (MEST)
User-Agent: KMail/1.13.7 (Linux/2.6.38-ARCH; KDE/4.6.2; x86_64; ; )
In-reply-to: <7vpqo9ez03.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172148>

On Tuesday 26 April 2011, Junio C Hamano wrote:
> Johan Herland <johan@herland.net> writes:
> > Allow specifying --dirstat cut-off percentage as a floating point
> > number.
> > 
> > When printing the dirstat output, floating point numbers are presented
> > in rounded form (as opposed to truncated).
> 
> Why isn't it sufficient to change
> 
> 	permille = this_dir * 1000 / changed
> 
> to
> 
> 	permille = (this_dir * 2000 + changed) / (changed * 2)
> 
> or something?  If rounding is the only issue that bothers you (I admit
> that it does bother me, now that you brought it up), that is.

Actually, rounding doesn't bother me at all (or rather, I don't really care 
if we round or truncate, as long as we're consistent).

It's just that once I s/strtoul/strtod/, and started propagating the 
"double"s through the code, I found that doing the final calculation and 
output with "double"s was more natural than the (somewhat hackish, IMHO) 
permille/percent thing. And that's when I finally came across the fact that 
"%6.1f" rounds whereas the earlier version truncated.

I thought about it for a second, and figured that rounding was probably what 
most users expected.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
