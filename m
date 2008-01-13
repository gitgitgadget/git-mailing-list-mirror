From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] index: be careful when handling long names
Date: Sun, 13 Jan 2008 15:08:07 -0800
Message-ID: <7v4pdhpbmw.fsf@gitster.siamese.dyndns.org>
References: <alpine.LFD.1.00.0801121426510.2806@woody.linux-foundation.org>
	<alpine.LFD.1.00.0801121735020.2806@woody.linux-foundation.org>
	<alpine.LFD.1.00.0801121949180.2806@woody.linux-foundation.org>
	<7vtzliqh3u.fsf@gitster.siamese.dyndns.org>
	<7vd4s6qal0.fsf@gitster.siamese.dyndns.org>
	<alpine.LFD.1.00.0801130922030.2806@woody.linux-foundation.org>
	<7vsl11plbe.fsf@gitster.siamese.dyndns.org>
	<7vhchhpd3h.fsf_-_@gitster.siamese.dyndns.org>
	<20080113225321.GA19970@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 14 00:08:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEBwZ-00026u-Od
	for gcvg-git-2@gmane.org; Mon, 14 Jan 2008 00:08:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754515AbYAMXIQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jan 2008 18:08:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754511AbYAMXIQ
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jan 2008 18:08:16 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:54396 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754504AbYAMXIP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jan 2008 18:08:15 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 675714BEC;
	Sun, 13 Jan 2008 18:08:14 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id DD76E4BEB;
	Sun, 13 Jan 2008 18:08:09 -0500 (EST)
In-Reply-To: <20080113225321.GA19970@steel.home> (Alex Riesen's message of
	"Sun, 13 Jan 2008 23:53:21 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70422>

Alex Riesen <raa.lkml@gmail.com> writes:

> Junio C Hamano, Sun, Jan 13, 2008 23:36:34 +0100:
>> +test_expect_success 'very long name in the index handled sanely' '
>> +
>> +	a=a && # 1
>> +	a=$a$a$a$a$a$a$a$a$a$a$a$a$a$a$a$a && # 16
>> +	a=$a$a$a$a$a$a$a$a$a$a$a$a$a$a$a$a && # 256
>> +	a=$a$a$a$a$a$a$a$a$a$a$a$a$a$a$a$a && # 4096
>
> I'd expect it to fail on some systems (everywindowsthing up to w2k,
> maybe some commercial unices).

My understanding is that Everywindowsthing do not come with any
(POSIX compliant) shell that we support by default, so if you
are talking about a limit of shell variable value, I do not
think it is an issue to begin with.  It is just the matter of
picking a sensible shell (I understand both Cygwin and msys
ports use a shell that supports more than 4k bytes in value
given to a variable).

I would agree that it might overflow the argument limit when
this is given to "echo", though.  We cannot do much about it,
but you may have cleverer ideas.
