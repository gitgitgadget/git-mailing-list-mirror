From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] commit: match explicit-ident semantics for summary and
 template
Date: Sun, 17 Jan 2010 19:34:55 -0800
Message-ID: <7vfx64uluo.fsf@alter.siamese.dyndns.org>
References: <20100117193401.GA28448@coredump.intra.peff.net>
 <201001172153.44413.j6t@kdbg.org> <7viqb0xubf.fsf@alter.siamese.dyndns.org>
 <20100118014735.GA6831@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jan 18 04:35:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWiOd-0002xE-79
	for gcvg-git-2@lo.gmane.org; Mon, 18 Jan 2010 04:35:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754825Ab0ARDfI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Jan 2010 22:35:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752207Ab0ARDfH
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Jan 2010 22:35:07 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:36206 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751586Ab0ARDfF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jan 2010 22:35:05 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 63EBE91209;
	Sun, 17 Jan 2010 22:35:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=5H/JrnQRFDziYgyKRRmun7AQq/8=; b=qlkM67fyLtwTP0x9vCTwqu3
	QwIxTMQiIg1ge0WUFKfL6xkuXIne4UApsB+lEAGEjpoL5uUM0ApsoQ+sHSTuLs7+
	8nJNzhvlq32JuWrsQHdCqQE6PNdMM/BgPC1dky6xWpkElJs16ion8rDhQpvrTTT+
	LVMl5EPgQ5cG0Sv8NouY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=Rd1q9Hdx75cMnP/+wB6lktq4lC0KXlelLm0YFALP8SU+01/O1
	+1IIgTwA4V0UtN6oiCS38XLqe85MDVOH+01BhmJLygfo70k5bI2iBONkSWsqs7P/
	dI4hknQzRBAszD5sGUYNJfmLMX8BxtrvWTs/eYk5KBGanDFh6YgZoeBIUI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3088D91208;
	Sun, 17 Jan 2010 22:35:00 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 675BA91207; Sun, 17 Jan
 2010 22:34:56 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 74CF739A-03E2-11DF-A0EF-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137364>

Jeff King <peff@peff.net> writes:

> On Sun, Jan 17, 2010 at 02:03:48PM -0800, Junio C Hamano wrote:
>
>> We could say something like
>> 
>> 	if (!(user_ident_explicitly_given & IDENT_EMAIL_GIVEN))
>> 
>> and it probably is a safer change on platforms with GECOS available, but
>> then wouldn't msysgit folks have to fork this code?
>
> I hadn't thought to be specific to "email must be given". That is, I had
> assumed if you gave a name but not email, you would also be considered
> competent enough to avoid the warning. But I really can't see anybody
> doing that, so the semantics you suggest above are fine by me.

It is fine if we keep insisting on getting both explicitly, but as you
said, I think if we have an explicit user.email, it is much more likely
that the user are happy with what we get from the GECOS than the user is
unhappy with GECOS but hasn't learnt user.name configuration.

Also if you have neither user.name nor user.email on your fresh box, the
chance that GECOS gives us the name you desire is much much more likely
than the chance the output from `whoami`@`hostname -f` happens to match
your desired e-mail identity.  I think checking MAIL only would probably
be the best heuristics.
