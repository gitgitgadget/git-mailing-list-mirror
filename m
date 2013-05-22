From: Junio C Hamano <gitster@pobox.com>
Subject: Re: override merge.ff = false using --ff-only
Date: Wed, 22 May 2013 11:12:01 -0700
Message-ID: <7vzjvmj34e.fsf@alter.siamese.dyndns.org>
References: <CAJELnLEGCshD9z9get62+T6Z83OdPJ+A5BNSzsHA1_OC1Q00Hw@mail.gmail.com>
	<CAJELnLFqzVBd57vudsCFrTNMVxETO75GT5T5NO0sDMtgHZJU6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matt McClure <matthewlmcclure@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 22 20:12:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfDWN-0004bY-K2
	for gcvg-git-2@plane.gmane.org; Wed, 22 May 2013 20:12:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756773Ab3EVSMG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 May 2013 14:12:06 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58708 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755970Ab3EVSME (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 May 2013 14:12:04 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1DD55206B7;
	Wed, 22 May 2013 18:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9/xq8NsLIHuymChwkEx94qwd2g4=; b=Smp0Cy
	7JktEhEzMz5DSnIMi6bV40uSPV0ocg2aMe0yOz1Y+EXJtEcOgykiUMEZDLgL3yoc
	oMm31nSZdAlP7OF7etaeEJhlwyl3//4lPVEscUGyym35/G+iWuVPqQX4zb/S4rjk
	2fObSOeDP4sepmIA6EQe+bsvjM0cFe/fGnPkc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cx/huxkurgsOodUl8LBaFhLC+ddPBIXB
	yzu/9+J7/LSjOjFVZ8MNIed/2d05k6nT1O5SajDc1oSPmP1xGeoW96J2FzC02Mcb
	LlhIE00A2UvgCHQqC42gyItIqTzq8wQlbNtYirELFgfdAokWcsofzalcJwM2mLx9
	jWlUf8A56yM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 12717206B5;
	Wed, 22 May 2013 18:12:04 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5CC63206B4;
	Wed, 22 May 2013 18:12:03 +0000 (UTC)
In-Reply-To: <CAJELnLFqzVBd57vudsCFrTNMVxETO75GT5T5NO0sDMtgHZJU6g@mail.gmail.com>
	(Matt McClure's message of "Wed, 22 May 2013 09:21:23 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1AA94A1C-C30B-11E2-BFB4-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225183>

Matt McClure <matthewlmcclure@gmail.com> writes:

> I naively tried to override merge.ff = false using --ff-only on the
> command line. I expected that it would override the configured default
> and perform a fast-forward merge. Instead, it said:
>
>     $ git config -l | grep -F 'merge.ff'
>     merge.ff=false
>
>     $ git merge --ff-only foo
>     fatal: You cannot combine --no-ff with --ff-only.
>
> On the other hand, I see that --ff works just fine in the same initial state.
>
>     $ git merge --ff foo
>     Updating b869407..17b5495
>     Fast-forward
>     ...
>      4 files changed, 2 insertions(+), 5 deletions(-)
>
> Would it be better if --ff-only refused to merge only if the commits
> themselves prevented fast-forwarding?

In general it would be better if any --ff related command line
options made us ignore the configured default like merge.ff the user
may have in the repository, not just --ff-only vs merge.ff
combination, and your "On the other hand" demonstrates that it is
the case for --ff from the command line.

I do not offhand see why --ff-only should behave differently from
that expectation.
