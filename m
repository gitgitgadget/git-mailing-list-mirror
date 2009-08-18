From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] stash: accept options also when subcommand 'save' is
 omitted
Date: Tue, 18 Aug 2009 13:20:03 -0700
Message-ID: <7vbpmcc1sc.fsf@alter.siamese.dyndns.org>
References: <1250599567-31428-1-git-send-email-Matthieu.Moy@imag.fr>
 <vpqws51l1hb.fsf@bauges.imag.fr>
 <20090818174509.GA27518@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Aug 18 22:20:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdVAQ-0000LF-Rd
	for gcvg-git-2@lo.gmane.org; Tue, 18 Aug 2009 22:20:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751793AbZHRUUR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2009 16:20:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751411AbZHRUUR
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Aug 2009 16:20:17 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:57742 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751124AbZHRUUQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Aug 2009 16:20:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 98FD42E106;
	Tue, 18 Aug 2009 16:20:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=di/Ma4bDuPhUB81uhLQO4knCFxs=; b=BNJQpxOZNohSkNJcH5meHMu
	w2lZyRc5zAm60e3VjHRodiI3YmsrXT7XEw4/CZoD5GjnclHJl1pV4vOLNtVZ84wV
	/wutaNaWmitXMbgOPNzQAhePhV7y6Vzq6xq6UZ52e8Rp+f9HeasWjc+apjo5tJco
	8ZrLD37g55lLXBIj+vr8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=g2WUU166rDNamsW8vR5qRXM5vfWa4pLgOX4NcgpU/mfPdFqPy
	lA1MA6JsRhKveYuIj6xOlEhcX0MGoW7WvtuCHoT59ffHtr7zxpYVKahf31doAuTR
	xrpBjj+lmbQ/QJ7799dRAG0rCF8HPRBbU+Tz/r3TLeOWQSQGwnGeuFXdws=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 57B0D2E100;
	Tue, 18 Aug 2009 16:20:13 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 54CB12E0FA; Tue, 18 Aug 2009
 16:20:04 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 890B020A-8C34-11DE-B44F-3142836986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126450>

Jeff King <peff@peff.net> writes:

> On Tue, Aug 18, 2009 at 03:01:52PM +0200, Matthieu Moy wrote:
> ...
> I think yours is nicer, especially as we have just added the
> '-p|--patch' option, as well. With what is there now, you can do "git
> stash -p", but not "git stash -p -k".
>
>> But I may have missed its drawbacks ;-)
>
> The only I can think of is that bogus input will provoke 'save'. So
> something like:
>
>   git stash --apply
>
> will invoke "git stash save --apply", which doesn't even complain. It
> just tries to make a stash with message --apply. Now of course this
> input is obviously bogus, but probably the right thing to do is
> complain.
>
> OTOH, I think it is the fault of "git stash save --apply" for not doing
> the complaining, so your patch really isn't making it worse. Probably it
> should barf on anything unrecognized starting with a '-', and allow '--'
> to separate the message from the rest of the options (in the rare case
> that you want a message starting with '-').

Sounds like a sane approach.

I am Ok with the idea of queuing a patch to update js/stash-dwim ea41cfc
(Make 'git stash -k' a short form for 'git stash save --keep-index',
2009-07-27) with an implementation along this line; the "stash -p" one
f300fab (DWIM 'git stash save -p' for 'git stash -p', 2009-08-13) also
may need to adjusted (it could become no-op, I suspect).
