From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-daemon: Simplify child management and associated
 logging by
Date: Wed, 13 Aug 2008 12:28:55 -0700
Message-ID: <7v8wv0ogso.fsf@gitster.siamese.dyndns.org>
References: <20080812193613.32388.92145.stgit@aristoteles.cuci.nl>
 <20080812212534.6871.19377.stgit@aristoteles.cuci.nl>
 <7vzlnhq48b.fsf@gitster.siamese.dyndns.org> <20080812225642.GA15265@cuci.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Stephen R. van den Berg" <srb@cuci.nl>
X-From: git-owner@vger.kernel.org Wed Aug 13 21:30:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTM2s-0001sS-NR
	for gcvg-git-2@gmane.org; Wed, 13 Aug 2008 21:30:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752412AbYHMT3G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2008 15:29:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752346AbYHMT3F
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Aug 2008 15:29:05 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:49453 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751951AbYHMT3E (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2008 15:29:04 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 647CB53CC5;
	Wed, 13 Aug 2008 15:29:03 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 689AD53CC4; Wed, 13 Aug 2008 15:29:00 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 1664781A-696E-11DD-93ED-B29498D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92255>

"Stephen R. van den Berg" <srb@cuci.nl> writes:

> Junio C Hamano wrote:
>>"Stephen R. van den Berg" <srb@cuci.nl> writes:
>>Sorry, but this does too many things in one patch.
>
> Yes, I know, got carried away.  Then again, the code has a lot of
> overlapping places (spacewise); I kind of leapt from one place to the
> next; you fix one thing, and then the next wart stares you in the face.
> I'll see if I can split it up, if that suits you better.
>
>> - Taking advantage of poll() getting interrupted by SIGCHLD, so that you
>>   do not have to do anything in the signal handler, is so obvious that I
>>   am actually ashamed of not having to think of it the last time we
>>   touched this code.  Is there a poll() that does not return EINTR but
>>   just call the handler and restart after that as if nothing has
>>   happened, I have to wonder...
>
> Only if the signal is set to SIG_IGN on all systems I worked with since
> 1987.

Yeah, rub it in.  That's why I said I am actually ashamed that I did not
notice that as an obviously much more simpler approach.
