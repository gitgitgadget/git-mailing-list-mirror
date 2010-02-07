From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] gitweb: notes feature
Date: Sun, 07 Feb 2010 10:38:15 -0800
Message-ID: <7vock0evs8.fsf@alter.siamese.dyndns.org>
References: <1265300338-25021-1-git-send-email-giuseppe.bilotta@gmail.com>
 <201002070248.03855.johan@herland.net>
 <cb7bb73a1002070314t4f382d31k91423eac00a68715@mail.gmail.com>
 <201002071341.36440.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 07 19:38:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NeC1j-00079h-OU
	for gcvg-git-2@lo.gmane.org; Sun, 07 Feb 2010 19:38:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932346Ab0BGSi3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Feb 2010 13:38:29 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:33116 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756207Ab0BGSi2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Feb 2010 13:38:28 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 23D579877D;
	Sun,  7 Feb 2010 13:38:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=zwQvV0Clsad9QrKxg7mu/RsID7E=; b=wy0wLY9bqC7nS5zlCL2Isp+
	SgrZ1kt8qCPZsBAJ45H6ZP3WVry5Kmi9+KtiZLn+IRnOP8qeUh+ZjoZQr+DX22tf
	0E12Z21NJKCpKbTcZindZlmx6utFo0/Chwd830lmWZfRAS23L07BDwkiFRPDKuEQ
	ZPIPGwciUcNn7CSSLxp0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=G/7ByhyuyN0IJYqkVEaN7jGXzZCUoTHyNpuUJmCfLqMqAUj17
	ucYlqWTkLe19e5RfeGcigoMvYXhjBcW0Z/0wD7QrDx7VeB9VtQh4eBrtarMIP/cc
	EWZYoXOC4riCuLl21+M90YhaCswgIxwL40S8hFykaKla1griokoqLEazaE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C8B7E98779;
	Sun,  7 Feb 2010 13:38:22 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CB71698777; Sun,  7 Feb
 2010 13:38:16 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F85B502C-1417-11DF-B456-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139245>

Jakub Narebski <jnareb@gmail.com> writes:

> That is just bikeshedding, but I'd rather not use '@', which currently
> is used only for _reflog_ based revision specifiers: [<ref>]@{<date>},
> [<ref>]@{<n>}, @{-<n>}, for notes which are not reflog based.

Probably a nicer way to say the same thing is to avoid "reflog based"
which sounds like you are talking about an implementation detail.

A fundamental reason to favor your "bikeshedding" (I don't think it is a
bikeshedding---it is a sound argument against using "@{...}") is that the
at-brace notation applies to a ref, not to an arbitrary commit.  Applying
@{yesterday} to an arbitrary commit does not make any sense.

Notes are fundamenally metainformation about an _object_ [*1*] and are not
metainformation about refs.  Since whatever magic notation to denote notes
we choose wants to be applied to an arbitrary commit, it shouldn't be the
at-brace syntax.

[Footnote]

*1* Yes, I am aware of movements to misuse notes to annotate anything
after mapping it to a random SHA-1 value, but I think that is outside the
scope of notes.  Our design decision should be based on supporting the
primary use of annotating an object, and that might still keep such a use
working, in which case that would be an added bonus.  But our design
shouldn't be constrained by such a secondary use.
