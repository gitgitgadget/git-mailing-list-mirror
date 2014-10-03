From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 1/2] config: Add safe-include directive
Date: Fri, 03 Oct 2014 11:52:45 -0700
Message-ID: <xmqqsij5kmte.fsf@gitster.dls.corp.google.com>
References: <xmqqy4t7a5vx.fsf@gitster.dls.corp.google.com>
	<1412300254-11281-1-git-send-email-rv@rasmusvillemoes.dk>
	<1412300254-11281-2-git-send-email-rv@rasmusvillemoes.dk>
	<CAPc5daV_txE9NrwvH5VWhXK+UmE7Avy8R2QaZaX0SsTC_+TU-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Joe Perches <joe@perches.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Rasmus Villemoes <rv@rasmusvillemoes.dk>
X-From: git-owner@vger.kernel.org Fri Oct 03 20:52:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xa7yK-00048W-6y
	for gcvg-git-2@plane.gmane.org; Fri, 03 Oct 2014 20:52:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754185AbaJCSww (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Oct 2014 14:52:52 -0400
Received: from smtp.pobox.com ([208.72.237.35]:65023 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751573AbaJCSwv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Oct 2014 14:52:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B7CE93FCA2;
	Fri,  3 Oct 2014 14:52:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=foPJRoQs8CjqqfIsUogiapfkyB0=; b=G0DSwA
	HDa/+dwA/f2ScWVtPZVoz26/QR+c1/WWrMcG00NuiGdm5B6hF2abyHcbncxEgyML
	2oqELP7/2LR3WM7IQwyzcadA0oJe1epHH612umFerRAxgdpUoO+kUVyH0NHwLIn5
	591yogPVDxrrbFnNetATR0+DkMoBN2bm5mdcI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Y6bF/JgOYnRhcGfgCTsk5Cty6OZmObVo
	ZKMbkro9GpWCGJm39p9MzYrZKegrapfA1LdRMdgnmj13Fexs6r2OMCdlKZ8qLe2g
	4h3sgP2bGm18vliaSQaBpc8DSGF/PJI1wPWrGgn2jCs/dmckA4lhHKWd7ICAJqfa
	ReFSC+cmU9E=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id AC53F3FCA1;
	Fri,  3 Oct 2014 14:52:47 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 0F0B63FCA0;
	Fri,  3 Oct 2014 14:52:46 -0400 (EDT)
In-Reply-To: <CAPc5daV_txE9NrwvH5VWhXK+UmE7Avy8R2QaZaX0SsTC_+TU-A@mail.gmail.com>
	(Junio C. Hamano's message of "Thu, 2 Oct 2014 22:27:11 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7756ECEA-4B2E-11E4-B074-9E3FC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257845>

Junio C Hamano <gitster@pobox.com> writes:

> Even though I did allude to ../project.gitconfig in the original message, I
> think there should probably be an explicit syntax to name a path that is
> relative to the root level of the working tree. People do funky things using
> $GIT_DIR and $GIT_WORK_TREE to break the ".. relative to the config
> file is the root level of the working tree" assumption, and also a repository
> can have a regular file ".git" that points at the real location of the directory
> that has "config" in it, in which case its parent directory is very unlikely to
> be the root level of the working tree.

There is another reason why I suspect that it may make the resulting
system more useful if we had a way to explicitly mark the path you
used to safeInclude (by the way, we do not do dashes in names for
configuration by convention) as referring to something inside the
project's working tree.  In a bare repository, we might want to grab
the blob at that path in HEAD (i.e. the project's primary branch)
and include its contents.
