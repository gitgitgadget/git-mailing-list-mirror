From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/7] submodule groups
Date: Wed, 11 May 2016 22:50:24 -0700
Message-ID: <xmqq37pnj04f.fsf@gitster.mtv.corp.google.com>
References: <1462928397-1708-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: jrnieder@gmail.com, Jens.Lehmann@web.de, git@vger.kernel.org,
	pclouds@gmail.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu May 12 07:50:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0jWF-0007sK-1T
	for gcvg-git-2@plane.gmane.org; Thu, 12 May 2016 07:50:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752183AbcELFui (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 May 2016 01:50:38 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51055 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752087AbcELFu2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2016 01:50:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 2804613075;
	Thu, 12 May 2016 01:50:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=I12yBMVq/am6S+6iR6VnhXabMUU=; b=J6iOOx
	g8SEkasq6j+IkmPqnSNLPaHoMwOYFlry+gL4MULzt9pmkDv0DgYNfnQWmXXkaGgM
	fLwlUncGBgp5StbxKX9Ydjkayqbma+LnuzVPQJCFiPWmtgkpyYctka8PWIrxRgQP
	0RY/r/meSI8j9Artu0uKdgejZn5YqNEAQHhgc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mHKlgDCADqB5gQhds/vesVwxUSErOKml
	U+n1UUi3mw0CaU86+cejbTGMxqpe23kS9QkqUrNGmnLjVG5d0wbh1waTOTWdgNbN
	K2cOrsBXusY56/la07s89DQKX5/RRSczSOirwii/O7xM6gfJeoA+FHnbKtPkuGxU
	a4EVI+vUZNE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 2033113074;
	Thu, 12 May 2016 01:50:27 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 90DF113072;
	Thu, 12 May 2016 01:50:26 -0400 (EDT)
In-Reply-To: <1462928397-1708-1-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Tue, 10 May 2016 17:59:50 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6D1FBC3E-1805-11E6-8F13-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294391>

Stefan Beller <sbeller@google.com> writes:

> If you have lots of submodules, you probably don't need all of them at once,
> but you have functional units. Some submodules are absolutely required,
> some are optional and only for very specific purposes.
>
> This patch series adds labels to submodules in the .gitmodules file.

I hate to bring this up in this thread, primarily because I cannot
see how to make it mesh well with the "submodule spec lets you
specify a group of submodule with labels", but for completeness of
discussion, I'll mention it anyway.

Instead of specifying "all files written in Perl" to work on by
giving a pathspec with three elements, e.g.

    git cmd -- \*.perl \*.pl \*.pm

I've often wondered if it would be a good idea to let attributes
file to specify "these paths form the group Perl" with something
like:

    *.pm        group=perl
    *.pl        group=perl
    *.perl      group=perl
    *.h         group=c
    *.c         group=c

and say

    git cmd -- ':(group=perl)'

instead.

The reason why I suspect that this may not work well with submodule
labels is because submodule labels (or any attribute we give via
.gitmodules to a submodule) are keyed by a submodule name, which is
the primary unchanging key (so that people can "mv" a submodule in
the context of the toplevel superproject without losing track of
submodule identity), not by paths to submodules, while the "group"
thing I want is merely a short-hand for pathspec elements and wants
to be keyed by paths.

But there may be somebody more clever than I who can come up with a
way to unify these two similar concepts without confusing end users.
