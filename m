From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 0/3] Thinning the git toplevel directory
Date: Tue, 22 Feb 2011 11:30:41 -0800
Message-ID: <7v4o7vdfz2.fsf@alter.siamese.dyndns.org>
References: <7vmxm4onwk.fsf@alter.siamese.dyndns.org>
 <1297304069-14764-1-git-send-email-pclouds@gmail.com>
 <20110218022701.GA23435@elie>
 <AANLkTik8wUrUnjTiUxUZbg3paaQEc7UERQ6J6jUzA2u5@mail.gmail.com>
 <20110218092518.GB30648@elie> <7vei75p3zr.fsf@alter.siamese.dyndns.org>
 <20110219111103.GA1841@elie> <20110222155637.GC27178@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 22 20:31:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Prxwt-0007yB-4J
	for gcvg-git-2@lo.gmane.org; Tue, 22 Feb 2011 20:31:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755102Ab1BVTa6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Feb 2011 14:30:58 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:59305 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754904Ab1BVTa6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Feb 2011 14:30:58 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A906B3405;
	Tue, 22 Feb 2011 14:32:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6GSIAkmraKuIwMhGJpD0EasWr+Q=; b=gH1bgx
	9fWdjAsbWGKw0dcDnVqivMyhdDAo1q6Mzp8iANb6tfqrL4e1XeSQIMmMfYWSDroR
	4Sb9f3dDOly2ert/dqriGOZ9Kpl5Pt7ru6k94yPAw2yBKiYtdNP6XmjfZxzFwTtC
	ZZm3dwZR17vu4iM/gQjqsMd82aMB+x/B4TKhw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FmVFT8U+dgQ5fSDvhheunR4u/wG5jcTA
	ZkFokvMpZWp4LI14ZCwrPjU1EmMCdxUJeLFHHiUcVYdsHW/2KX14TqzlVUa39/4n
	TaQ5C/qYN/ufXAVCQtBtv346TDxHXAEbAAkpsgzsHMUfs6sAtwUy7bIu24TnEn5W
	NePfBI+nDp0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 45FE13403;
	Tue, 22 Feb 2011 14:32:02 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 0D5A033FC; Tue, 22 Feb 2011
 14:31:53 -0500 (EST)
In-Reply-To: <20110222155637.GC27178@sigill.intra.peff.net> (Jeff King's
 message of "Tue\, 22 Feb 2011 10\:56\:37 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6C44B974-3EBA-11E0-A538-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167579>

Jeff King <peff@peff.net> writes:

> On Sat, Feb 19, 2011 at 05:11:03AM -0600, Jonathan Nieder wrote:
>
>>  - merge builtins/ with commands/.  It never was clear to me why
>>    making a command builtin should require changing its filename.
>
> This may be a bit too radical, but maybe the Makefile should use this
> structure to save maintenance effort. In other words, is there any
> reason not to just have:
>
>   BUILTIN_SOURCES = $(wildcard builtin/*.c)
>   BUILTIN_OBJS = $(patsubst builtin/%.c, builtin/%.o, $(BUILTIN_SOURCES))
>
> and similar for LIB_OBJS and LIB_H?

The developers would have to be careful not to put a throw-away test
programs written in C (especially the ones that has its own "main()") in
builtin/ (or lib/) directories if we go that route.  This obviously cuts
both ways; it sometimes is handy.

> It is one less thing to need to do when writing new code, and one less
> thing to have silly textual conflicts on. It probably doesn't matter
> that much, though; we don't actually add new files or commands all that
> often.

Yeah, you would need to add an entry to the builtin command list yourself
anyway, until we also autogenerate it, which I doubt will ever happen nor
is necessarily a good idea.

> Speaking of Makefiles, one downside to all of this directory
> segmentation is that you can't run "make" from the subdirectories.

I had an impression that "make -C lib/" would be one of the goals, iow,
when we split the directory structure, the next step would be to split the
top-level Makefile so that each directory is covered by its own Makefile,
just like Documentation/ is already usable that way.

Not that libgit.a in its current shape is very useful outside the context
of the git.git proper, though.
