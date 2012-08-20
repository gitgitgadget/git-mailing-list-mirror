From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git on HP NonStop
Date: Mon, 20 Aug 2012 09:29:38 -0700
Message-ID: <7vfw7hle6l.fsf@alter.siamese.dyndns.org>
References: <001101cd79f2$f21b3bd0$d651b370$@schmitz-digital.de>
 <7vr4r98rfd.fsf@alter.siamese.dyndns.org>
 <004b01cd7a34$dbf2c160$93d84420$@schmitz-digital.de>
 <alpine.LNX.2.01.1208191824100.29175@frira.zrqbmnf.qr>
 <000701cd7ebf$af552aa0$0dff7fe0$@schmitz-digital.de>
 <503217F2.5070105@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Joachim Schmitz <jojo@schmitz-digital.de>,
	'Jan Engelhardt' <jengelh@inai.de>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Aug 20 18:29:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3UrQ-0002FX-AB
	for gcvg-git-2@plane.gmane.org; Mon, 20 Aug 2012 18:29:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757230Ab2HTQ3p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Aug 2012 12:29:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59802 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752723Ab2HTQ3m (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 12:29:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0177D7621;
	Mon, 20 Aug 2012 12:29:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Ea2U2RzL6uY1WgfdstYzOds0tSs=; b=n4Cwkt
	7uv+D8/5p8ch3w1qfdv3qcKFVh28PToRuvpuxw+kDiAHkKpH3uouY0fxxdJJplwm
	EC1gd9HisAcd0vPe98Dt9ElPAJH1szf3a/PrDEKio44hTgWJLGWSyjKtVCoJQUV9
	ZZHfxfdMZop4+peciigJzTvZ8MBoH7UMl0//M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qGKCnh4sJuT3fKEp04Q3k4JIw+H3kEjR
	jGEIvTdQ5+AWIeoK4HHFXaz/EfZEwuUMhPQy4Dz8a0u1aNq66n/Tsq2705ijvxia
	uWTlcVeJGUBEGzW9jTX0K0c841h7iwEdV7k7P9KkTvAnvJNEBRF55/b/cEwNxXPj
	BZEtb8hjjaY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E2911761F;
	Mon, 20 Aug 2012 12:29:41 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5385F761D; Mon, 20 Aug 2012
 12:29:40 -0400 (EDT)
In-Reply-To: <503217F2.5070105@viscovery.net> (Johannes Sixt's message of
 "Mon, 20 Aug 2012 12:56:50 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3D86AB56-EAE4-11E1-AC2B-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203852>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Am 8/20/2012 12:36, schrieb Joachim Schmitz:
>> int var = var;
>> char *othervar = othervar;
>> 
>> ... 
>>
>> What is the reason for using that self-init stuff? I don't think it is
>> really portable, is it?
>
> It is used to avoid "var may be used uninitialized" warnings for some
> compilers. Officially (according to the C standard), it is undefined
> behavior. But I've observed considerable resistance by Junio to fix this
> properly.

I had resisted

	-	int foo = foo;
        +	int foo = 0;

in the past.  If some compiler is not seeing that "foo" is never
used uninitialized, such a compiler will generate an unnecessary
initialization, so it is not a _proper_ fix anyway (in fact, I do
not think a proper fix exists, short of simplifying the code so that
less sophisticated compilers can see that "foo" is never used
uninitialized).

So, no, I never resisted a "proper" fix.  I resisted swapping an
unsatisfactory workaround with another.

Between the two unsatisfactory workarounds, the latter (explicit
and unnecessary assignment to an innocuous value) is lessor of two
evils, so I do not particularly mind it, though.  Indeed, I think
more recent history shows that we have such changes.
