From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 12/12] Teach Makefile to check header dependencies
Date: Sun, 31 Jan 2010 13:26:23 -0800
Message-ID: <7vaavuc6f4.fsf@alter.siamese.dyndns.org>
References: <20100123144201.GA11903@progeny.tock>
 <7v3a1u6bfz.fsf@alter.siamese.dyndns.org>
 <20100126154357.GA4895@progeny.tock> <20100126155714.GM4895@progeny.tock>
 <7viqaic8gs.fsf@alter.siamese.dyndns.org>
 <20100131211429.GA4550@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Erik Faye-Lund <kusmabite@googlemail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 31 22:26:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NbhJf-0001MI-21
	for gcvg-git-2@lo.gmane.org; Sun, 31 Jan 2010 22:26:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754065Ab0AaV0m convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 31 Jan 2010 16:26:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754042Ab0AaV0m
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Jan 2010 16:26:42 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:41911 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753835Ab0AaV0l convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 31 Jan 2010 16:26:41 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A917096262;
	Sun, 31 Jan 2010 16:26:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Cb9Py0RqQ4U6
	40UrXvHPy0HWlIM=; b=Va0r1wPQ1LtAq53zyaKi8sfO0JEFPUU1RimiTswislQF
	E6dS+qPyNEtbfvpaYV/B+1fa35bHM8OYqrdP77EfpDVHkHGy7U3lzqvaE+DclD3u
	DATeiMpBjtZ8lrH+SSmLYQBLRNnrE3q6QU2EyMBMxmbICCMunKBgE+YMsY9sr5Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=YxlLJQ
	42NJ8tAdvbv4z6HXfEP/wtZ8ofC74KP/KMZQOiFimrTYrdf4nRyAXTThUBvr93bI
	YZre8AOq4ofwgRmNjcmN4GktF1xZLqJYMujikl4OEPwL7z8v1BAL5eux83p/M/VR
	5PgfPSM+soQFP2ZOlApIJiLjDT2H4r+MYZgmQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2F30B9625F;
	Sun, 31 Jan 2010 16:26:34 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B4FFB9625E; Sun, 31 Jan
 2010 16:26:25 -0500 (EST)
In-Reply-To: <20100131211429.GA4550@progeny.tock> (Jonathan Nieder's message
 of "Sun\, 31 Jan 2010 15\:14\:29 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 4E627414-0EAF-11DF-B9ED-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138564>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Junio C Hamano wrote:
> ...
>> Three observations:
>>=20
>>  * "make distclean" should remove $(dep_files);
>
> It removes $(dep_dirs) in "make clean".  Do you think they should be
> kept around?  Or is this about when COMPUTE_HEADER_DEPENDENCIES is
> turned off but .o.d files remain?

Yes, the last one.  After playing around, with or without COMPUTE/CHECK=
,
and then making a final build, it would be nice if "make distclean"
removed all the intermediate build products without the same special
"debug build" options (and without COMPUTE, dep_dirs is empty so nothin=
g
is removed).  It is also fine if "make clean" did so.

>>  * I wish CHECK_HEADER_DEPENDENCIES pointed out unnecessary dependen=
cies
>>    hardcoded in the Makefile.
>
> That would not be hard to do, but wouldn=E2=80=99t the $(GIT_OBJS): $=
(LIB_H)
> rule create a lot of noise?
>
> How about if it checks for duplicate dependencies and unnecessary
> dependencies that are not in LIB_H?

That would be ideal, I think.
