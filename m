From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 0/3] Per-repository end-of-line normalization
Date: Fri, 07 May 2010 09:33:49 -0700
Message-ID: <7v4oijhdsi.fsf@alter.siamese.dyndns.org>
References: <x2s40aa078e1005061340vaf404ab3g30b2b98ca408205@mail.gmail.com>
 <cover.1273183206.git.eyvind.bernhardsen@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, hasan.aljudy@gmail.com,
	kusmabite@googlemail.com, torvalds@linux-foundation.org,
	prohaska@zib.de
To: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 07 18:34:15 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OAQVC-0004JU-DE
	for gcvg-git-2@lo.gmane.org; Fri, 07 May 2010 18:34:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756918Ab0EGQeJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 May 2010 12:34:09 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:56934 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756457Ab0EGQeF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 May 2010 12:34:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id CACFDB14E4;
	Fri,  7 May 2010 12:34:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZJBuDL79YyFk3RfXJakncfBWJ6M=; b=J/mOqq
	Y9I+6mDSMC/OCUOdTBDknT1JaIeU4i/Mi7PrRk+DbL0ixrnsxbn7pcBYQkTNLlfL
	ToS7V8zI8yNrd6aV4KFWMTQl4yIkJjLyTUHdHIHo+cFpCm74l7RqV6QVyFnhgPPY
	N0KcuqJfc15UBncDIvMaj1+n5Ocsj8aq4dywA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ifnhH5WclS5v9C+gAriEbw2rOkcgFyll
	m96xlLhFAoQ9ejDUttXNJTmIzPUth9L13tIcimwgpM16i4gSduT2CyILo9cJGjay
	3FT6ePMClisza2cVptjZ6X6gDtEVLHipTmYnHIFIjev3eDp9hfMO/Ao0dFHmic6P
	1mow/2LwJWs=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 66D23B14D9;
	Fri,  7 May 2010 12:33:58 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 57128B14D8; Fri,  7 May
 2010 12:33:51 -0400 (EDT)
In-Reply-To: <cover.1273183206.git.eyvind.bernhardsen@gmail.com> (Eyvind
 Bernhardsen's message of "Fri\,  7 May 2010 00\:27\:32 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 55FDC16E-59F6-11DF-923B-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146538>

Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com> writes:

> - An attribute called "auto-eol" is set in the repository to turn on
>   normalization of line endings.  Since attributes are content, the
>   setting is copied when the repository is cloned and can be changed in
>   an existing repository (with a few caveats).  Setting this attribute
>   is equivalent to setting "core.autocrlf" to "input" or "true".

In what way is this attribute different from existing "crlf" attribute?

It feels as if this series is fixing shortcomings of the combination of
core.autocrlf configuration and crlf attribute while trying very hard to
keep their shortcomings when the user doesn't say so.  What is the
downside of making the existing "core.autocrlf" + "crlf" combination do
what your patch wanted to do without retaining this "keep the existing
shortcomings for backward compatibility"?

> 1. Setting core.autocrlf in your global or system configuration is a
> pain

This is a wrong thing to do to begin with, and not worth discussing.  You
know and your readers know that line ending convention in the repository
data (i.e. blobs) is under project control while line ending convention in
the working tree is end user preference.

> 2. Setting core.autocrlf in an individual repository would be okay
> except that naive users will do it after they have already cloned:
> unless core.autocrlf is set globally, the clone will have the wrong line
> endings, and the user needs to know how to refresh it manually (rm -rf *
> && git checkout -f).

This may be a worthy goal.  But if a "auto-eol" attribute "fixes" this,
perhaps "crlf" attribute can be taught to fix it the same way, no?
