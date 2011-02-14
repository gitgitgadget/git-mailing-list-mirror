From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [1.8.0] Provide proper remote ref namespaces
Date: Mon, 14 Feb 2011 10:30:45 -0800
Message-ID: <7vbp2etqne.fsf@alter.siamese.dyndns.org>
References: <AANLkTi=yFwOAQMHhvLsB1_xmYOE9HHP2YB4H4TQzwwc8@mail.gmail.com>
 <m3mxm28v3i.fsf@localhost.localdomain> <201102140036.42197.johan@herland.net>
 <201102141040.35819.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Nicolas Pitre <nico@fluxnic.net>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 14 19:31:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pp3Cd-0008Gs-KH
	for gcvg-git-2@lo.gmane.org; Mon, 14 Feb 2011 19:31:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751153Ab1BNSbK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Feb 2011 13:31:10 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:57558 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750800Ab1BNSbJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Feb 2011 13:31:09 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 64FFE3A40;
	Mon, 14 Feb 2011 13:32:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FD7a1q/8qf8JYSdf9qVaa/BFA/g=; b=tBfW7D
	2wJNwGw26hDym9IhXe9bowhV7onaY9Odnd7Y/ufSVA7um8jdyWMtiELdya5+X8xq
	w/dl+Xh90+KBqgisP8k6ELqZFhjMDconDo1urPZXnK5yRjZJLDs747RDPLEr8rdL
	9uR4e1tSuo+YaLXdPBXPj1oJGGHMxz6eKKSt0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qjt7VvYzCaZJgG8uc6fR8z41Mqb6mdZj
	Saq1vtYKYcEZDU+rItdF0cHHcykZXDh/7jEiPIlNflvNrFbrhUZ+lwlbIVaQB/Ya
	iGPA7MdK/G43WrCw9zjj39o0lg52S+hQeyZgXzv3ks11ZaeHXJm4fRRGsh7bgTDl
	f3OzFytGmIk=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C6D4E3A3A;
	Mon, 14 Feb 2011 13:32:02 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 4A7943A34; Mon, 14 Feb 2011
 13:31:51 -0500 (EST)
In-Reply-To: <201102141040.35819.jnareb@gmail.com> (Jakub Narebski's message
 of "Mon\, 14 Feb 2011 10\:40\:32 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B7841504-3868-11E0-B5CE-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166745>

Jakub Narebski <jnareb@gmail.com> writes:

> Please consider this use case:
>
> Let's assume that current maintainer steps aside for a bit, and new interim
> temporary maintainer takes mantle.  One would add new remote _temporarily_,
> but one would want for tags that temporary maintainer created to be as good
> as tags from 'origin' remote... and not be deleted when you remove temp
> remote and its remote-tracking branches.

Why don't you want to delete them?

When the "interim" maintainer gives the baton back to the authoritative
maintainer, the tags that are blessed between these two maintainers will
surely be propagated [*1*] to the authoritative repository and you will
have them at refs/tags or refs/remotes/origin/tags in your repository.

And at that point, if you do not want to have refs/remotes/interim/heads/
branches, you surely do not mind cleaning refs/remotes/interim/tags/
hierarchy as well, no?

Having said all that, if we assume *1* above, then we wouldn't have needed
separate tag namespace in the first place.

Further, think about the case where the "interim" maintainer ends up
becoming the authoritative maintainer, which is the same thing as not
assuming *1* above.  You would want to consolidate refs/remotes/origin/tags
and refs/remotes/interim/tags, and we do not expect any collisions when we do
so.

Which suggests that tags namespace is really special in that it does want
to be globally unique and agreed namespace, unlike branch namespace.
