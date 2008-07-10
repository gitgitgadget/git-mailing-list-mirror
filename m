From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] bisect: test merge base if good rev is not an ancestor
 of bad rev
Date: Thu, 10 Jul 2008 16:50:15 -0700
Message-ID: <7vmykpmh8o.fsf@gitster.siamese.dyndns.org>
References: <20080710054152.b051989c.chriscool@tuxfamily.org>
 <alpine.DEB.1.00.0807110035180.3279@eeepc-johanness>
 <7v7ibtnx09.fsf@gitster.siamese.dyndns.org>
 <200807110145.33820.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Fri Jul 11 01:51:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KH5v7-0003S2-Kd
	for gcvg-git-2@gmane.org; Fri, 11 Jul 2008 01:51:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754771AbYGJXua convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Jul 2008 19:50:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751526AbYGJXua
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jul 2008 19:50:30 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:46943 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751442AbYGJXu3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Jul 2008 19:50:29 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 0A45225210;
	Thu, 10 Jul 2008 19:50:26 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id DDABA2520F; Thu, 10 Jul 2008 19:50:18 -0400 (EDT)
In-Reply-To: <200807110145.33820.chriscool@tuxfamily.org> (Christian Couder's
 message of "Fri, 11 Jul 2008 01:45:33 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F7ED01FC-4EDA-11DD-834F-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88061>

Christian Couder <chriscool@tuxfamily.org> writes:

> Le vendredi 11 juillet 2008, Junio C Hamano a =C3=A9crit :
>>
>>     (2)       Good
>>           ?---o (maint)
>>          /
>>      ---x---?---?---?---x (master)
>>         Bad             Bad
>>
>>
>> If (1), you go ahead with the usual bisection.  If (2), you cannot e=
ven
>> bisect.  Instead, you flip good and bad to find the "fix" in the sid=
e
>> branch (the answer has to be either the tip of maint or one previous=
 in
>> the picture) to forward port to, either by merging 'maint' to 'maste=
r' or
>> cherry-picking.
>>
>> The idea to check merge-base first is about automating this process =
(I
>> admit I still haven't looked at Christian's patch text yet).
>
> Well in case (2) my patch does:
>
> -------
> 		cat >&2 <<EOF
> The merge base $_badmb is bad.
> This means the bug has been fixed between $_badmb and $_g.
> EOF
> 		exit 3
> -------
>
> but this can be improved upon in some latter patches.

I think such an "improvement" is getting close to being too clever.  I
should have worded my description on what you would do in (2) a bit mor=
e
carefully.

    If (2), you cannot even bisect.

    Instead, you may decide to merge 'maint' to 'master' to get that fi=
x.
    In which case you do not have to worry about it; you do not do
    anything further.

    If you cannot afford to merge 'maint' to 'master' but somehow need =
to
    forward port the fix by cherry-picking, you need to flip good and b=
ad
    to find the "fix" in the side branch (the answer has to be either t=
he
    tip of maint or one previous in the picture).
