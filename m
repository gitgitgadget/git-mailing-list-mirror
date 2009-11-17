From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Expand ~ and ~user in core.excludesfile, commit.template
Date: Tue, 17 Nov 2009 14:16:18 -0800
Message-ID: <7v8we4er0t.fsf@alter.siamese.dyndns.org>
References: <1258366060-27966-1-git-send-email-Matthieu.Moy@imag.fr>
 <20091117073426.GB4007@coredump.intra.peff.net>
 <20091117074930.GB11636@glandium.org> <m2lji43l20.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mike Hommey <mh@glandium.org>, Jeff King <peff@peff.net>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org,
	Karl Chen <quarl@quarl.org>
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Tue Nov 17 23:16:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NAWLs-000489-G9
	for gcvg-git-2@lo.gmane.org; Tue, 17 Nov 2009 23:16:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756277AbZKQWQ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Nov 2009 17:16:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756242AbZKQWQ3
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Nov 2009 17:16:29 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:54963 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756217AbZKQWQ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Nov 2009 17:16:28 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E874A80262;
	Tue, 17 Nov 2009 17:16:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Om3rygxtlTXAERgoCjfxOeDFG0Q=; b=SNzXVl
	hyJpvzsYN7zLSlaUVAxY+qA/onQkFcZKJLVuTRSylzq46ySLtBbtZGgG00zskElR
	571kmmU9/ppL7+KjBiTCWSptddhJKMQ5E+DP4N4LHs+gvvKgE9tp/iPwBVSCrlOb
	Nlbj6kCJzoj7B1wbUhIOz96weezuFonI4kP3E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mBYGps5Qh2A19SAYK+JgaB/Hz2mgwGMQ
	6p0Jd3gIK/r/SvMmPp6VsZRgSyC1iQ9fZ/0+z80EANz0v6z2CH0uGi9Mk/dWMEFi
	Oh1B5bYLb83IThKBqy6YNi2WNmZityOCv0T3N3k6h1VJhh63d1YpZKO143OiInXt
	BGx8Y+ebNrs=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5016580261;
	Tue, 17 Nov 2009 17:16:27 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0B7FF8025F; Tue, 17 Nov
 2009 17:16:19 -0500 (EST)
In-Reply-To: <m2lji43l20.fsf@igel.home> (Andreas Schwab's message of "Tue\,
 17 Nov 2009 22\:20\:39 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D9731A1E-D3C6-11DE-9D17-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133105>

Andreas Schwab <schwab@linux-m68k.org> writes:

> Mike Hommey <mh@glandium.org> writes:
>
>> On Tue, Nov 17, 2009 at 02:34:26AM -0500, Jeff King wrote:
>>> Maybe:
>>> 
>>>   A leading path component of "~user" is expanded to the home directory
>>>   of "user"; "~" is expanded to the home directory of the user running
>>>   git.
>>> 
>>> would be more clear?
>>
>> Add "real" before "user running git" and you have my vote. Or maybe
>> using the effective user would be better, and the patch should use
>> geteuid() instead of getuid(), I don't know. ident.c uses getuid(), but
>> I'm wondering if that's what it should use (although it doesn't seem to
>> have been a problem to anyone)
>
> "~" should just expand to the value of $HOME, like in the shell,
> independent of the real home directory of the real or effective user.

How should this interact with installations that run gitosis/gitlite that
use shared account, giving user identity via the ssh key?

Note that the question is not "how would this...", but "how _should_
this...".
