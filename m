From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug in "git rev-parse --verify"
Date: Fri, 29 Mar 2013 23:38:32 -0700
Message-ID: <7vboa1qtnb.fsf@alter.siamese.dyndns.org>
References: <51543FDB.9010109@alum.mit.edu>
 <CAPc5daUqzz=9TBmj2Q0MHqEc6gMHxXoGr9+JV3hq76zDKJAyCw@mail.gmail.com>
 <515462FB.9040605@alum.mit.edu> <20130328153808.GB3337@sigill.intra.peff.net>
 <7vli97v558.fsf@alter.siamese.dyndns.org> <51565F96.1020203@alum.mit.edu>
 <7vk3opr0ke.fsf@alter.siamese.dyndns.org> <51567844.7030503@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sat Mar 30 07:39:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULpRQ-0000Fy-QF
	for gcvg-git-2@plane.gmane.org; Sat, 30 Mar 2013 07:39:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754813Ab3C3Gig (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Mar 2013 02:38:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50100 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753959Ab3C3Gif (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Mar 2013 02:38:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5C7CDF083;
	Sat, 30 Mar 2013 06:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=C5lQeWq20TXi3sc+EWsIRwML5kg=; b=tbltjw
	GO+V2oPpC2vxx+1Znw5/+5omA/XUo2h3RyOxIdt/Jjf7Nu0tOCqK+7MX4yi4zcgT
	S5LsVJlVzIls9fjiHWZawrxq1HH5wwR+yhGaz8RUm06aaPoHDnPM/gf3cVlsEKt2
	6L2Fty/pJ5+cYwVFlLRChgiCjiqRIqAh6iqzY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=i7Kspxl+hT7wMzdowQdo1dY34V/bgUUO
	qdBxaUeaScC+J+YYvMXkvs3YZo/SrKItJ0Cws31bg4n5rEha1/ig/3knH1vJBlFd
	8otkRWv2J2Zq12F28jFDewwcAkQChLayNezd+PY67josq6EGDzR//X2L2wlT26as
	SGK8rlyARK0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 51402F082;
	Sat, 30 Mar 2013 06:38:34 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C8F7DF081; Sat, 30 Mar 2013
 06:38:33 +0000 (UTC)
In-Reply-To: <51567844.7030503@alum.mit.edu> (Michael Haggerty's message of
 "Sat, 30 Mar 2013 06:29:40 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 718A3674-9904-11E2-B132-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219560>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> On 03/30/2013 05:09 AM, Junio C Hamano wrote:
>> So why not verify arguments while making sure of their type early
>> with 'rev-parse --verify "$userinput^{desiredtype}"?
>
> Yes, that's a better solution in almost all cases.  Thanks for the tip.
>
> (It doesn't change my opinion that the documentation for "rev-parse
> --verify" is misleading, but given that you don't appear to want to
> change its behavior I will submit a documentation patch.)

It does not matter what I want.  What matters is that changing the
definition is a _wrong_ thing to do, as --verify is designed to be
usable for objects you may not yet have.

What we may want is another type peeling operator, ^{object}.
makes sure it is an object, that lets you say:

    rev-parse --verify 572a535454612a046e7dd7404dcca94d6243c788^{object}

It asks "I have this 40-hex; I want an object out of it", just like
frotz^{tree} is "I have 'frotz'; I want a tree-ish" for any value of
'frotz'.

With that, a use case that it wants to see _any_ object can safely
use 'rev-parse --verify "$userinput^{object}' without an annotated
tag getting in the way.

How does that sound?
