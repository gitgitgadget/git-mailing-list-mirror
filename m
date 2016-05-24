From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtin/commit.c: memoize git-path for COMMIT_EDITMSG
Date: Tue, 24 May 2016 15:25:00 -0700
Message-ID: <xmqqy46z2iwz.fsf@gitster.mtv.corp.google.com>
References: <1464027390-1512-1-git-send-email-pranit.bauva@gmail.com>
	<xmqq7feka8kk.fsf@gitster.mtv.corp.google.com>
	<vpq1t4rri2a.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Pranit Bauva <pranit.bauva@gmail.com>, git@vger.kernel.org,
	larsxschneider@gmail.com, chriscool@tuxfamily.org,
	christian.couder@gmail.com, peff@peff.net
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed May 25 00:25:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5KlG-00048V-Gh
	for gcvg-git-2@plane.gmane.org; Wed, 25 May 2016 00:25:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752680AbcEXWZI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2016 18:25:08 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55414 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751759AbcEXWZH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2016 18:25:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E4A351E324;
	Tue, 24 May 2016 18:25:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=t0VSAQbcb8J5b5sgKGzQzSPfJuA=; b=BlvtGR
	e7GQHsQm6DALepi0ynZ8jAwbqwJN/MK1eKxAHFNGnPXjuvA7dpScokg4tgk/zrdk
	CQZJDXG3W6gptwWpntf1HVhZJzM2MqQ/5K/wMw0K4xJHzIKimH00doJccS20TYbl
	SPqNZqL/xOoGcjB+hGL+ibVO+/4cKxK76N+04=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pbtJFGTxQVYKKYzP4UmZEz7htl51un4Y
	CrwMFacMgqSx6zcSLop9HX3Ii8nUnHqlSgFW8gproV0K1/UwH0QhIh1JN4Yi3SFW
	VKH8iKpObtDWFCmyhoZjOvTg96433zcaJtgSqTLncEOzkAImaFzj1aLrHoGTclMA
	r6phW0jVWTk=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D370C1E322;
	Tue, 24 May 2016 18:25:04 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8B9F31E31A;
	Tue, 24 May 2016 18:25:03 -0400 (EDT)
In-Reply-To: <vpq1t4rri2a.fsf@anie.imag.fr> (Matthieu Moy's message of "Tue,
	24 May 2016 10:11:57 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5C5B20D4-21FE-11E6-82E0-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295538>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

>> More importantly, when is this function evaluated and returned value
>> used to fill commit_editmsg_path[]?
>
> I may have missed something, but I'd say "never", as the code is not
> compilable at least with my gcc:

It was a rhetorical question ;-)  But "the more important part" was
that initialization by calling non-trivial function is not a good
idea even in C++ where it is allowed, as you said below.

> And indeed, this construct is a huge source of trouble, as it would mean
> that git_path_commit_editmsg() is called 1) unconditionnally, and 2)
> before entering main().

Indeed.  Thanks.
