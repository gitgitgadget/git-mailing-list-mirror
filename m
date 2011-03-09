From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] i18n: avoid conflict with ngettext from libintl
Date: Wed, 09 Mar 2011 12:43:28 -0800
Message-ID: <7vfwqw9g9b.fsf@alter.siamese.dyndns.org>
References: <loom.20110304T210337-216@post.gmane.org>
 <7vtyfi606a.fsf@alter.siamese.dyndns.org> <4D7165A3.5080308@colin.guthr.ie>
 <7vlj0u5wyw.fsf@alter.siamese.dyndns.org> <4D7223A9.6080105@colin.guthr.ie>
 <7vsjuz520w.fsf@alter.siamese.dyndns.org>
 <7vhbbf50vu.fsf@alter.siamese.dyndns.org> <20110306225641.GB24327@elie>
 <AANLkTikctSrfqKCdeYUyvUmAZjr=i7kaFhPeB-LfwgUz@mail.gmail.com>
 <20110309103104.GA30980@elie> <20110309105236.GC30980@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 09 21:43:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PxQET-0007pS-Q5
	for gcvg-git-2@lo.gmane.org; Wed, 09 Mar 2011 21:43:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752608Ab1CIUnk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Mar 2011 15:43:40 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:54780 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752559Ab1CIUnj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2011 15:43:39 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5697A3FD5;
	Wed,  9 Mar 2011 15:45:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7R7RMtxXbTzw7QCcgfRTxxTwJiY=; b=g5Dx+S
	gZIO4JlcoWuLZ6PEexqBv/zZJzVB73QAjzpHmxXQNbn7fSOrM3jwI2XmKPSZJLi6
	jT3jL4STwHCqLsvGBg8ZGIJd9mz+rE510Je3kj9dT9VENPyFOHS2jf2SJ+JYRf08
	khMDRA9JaOuWynT/nmxm7WV2fYR26hLn1Zig4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=r/brJeDr/N/LNXPm+/jFWKqQ6px+FfOb
	vuCVTXKhFZmN3fq4YAKqWCIbPPcvykA7dOoT1lG5KyXEpQ16x1FQJqlhwSZ2alZX
	UDeavF4SIn/pl2ZSkZIEOqNwhgBEbg4UPjKg/hO9ogFY+N49BJU9JsPPEj8raP2E
	BrfvQE/+fNY=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1C4A13FD3;
	Wed,  9 Mar 2011 15:45:03 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 9328D3FCB; Wed,  9 Mar 2011
 15:44:58 -0500 (EST)
In-Reply-To: <20110309105236.GC30980@elie> (Jonathan Nieder's message of
 "Wed, 9 Mar 2011 04:52:36 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1B9351AE-4A8E-11E0-AB39-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168755>

Jonathan Nieder <jrnieder@gmail.com> writes:

> To avoid having to worry about a conflicting ngettext symbol when
> libintl is part of libc, also rename the no-op ngettext stub to
> git_ngettext and make ngettext a macro referring to it.  This is
> probably never necessary (because git's ngettext is declared "static
> inline") but it buys peace of mind.

Hmph.  An obviously safer alternative would be to use git_ngettext() in
our source all over the place, and it would by even more peace of mind but
that is even longer.

> This change does not protect against conflicts due to a header
> included _after_ git's i18n support (e.g., pthread.h) being the first
> to pull in libintl.  We can deal with that separately if it happens.

Also the same problem exists already for the _() macro.
