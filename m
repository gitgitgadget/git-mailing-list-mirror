From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 19/29] refs: don't dereference on rename
Date: Mon, 02 May 2016 10:55:58 -0700
Message-ID: <xmqq7ffcuyxd.fsf@gitster.mtv.corp.google.com>
References: <cover.1461768689.git.mhagger@alum.mit.edu>
	<27f8b223e42dcf1cf3c010833e0aff7baa4559c2.1461768690.git.mhagger@alum.mit.edu>
	<xmqqy47y98zx.fsf@gitster.mtv.corp.google.com>
	<57230F71.2020401@alum.mit.edu>
	<1461972108.4123.43.camel@twopensource.com>
	<57242B22.4050202@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: David Turner <dturner@twopensource.com>, git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Jeff King <peff@peff.net>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon May 02 19:56:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axI4n-0007LM-KH
	for gcvg-git-2@plane.gmane.org; Mon, 02 May 2016 19:56:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754659AbcEBR4G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 May 2016 13:56:06 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60623 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753818AbcEBR4D (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 May 2016 13:56:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 5BD4F16551;
	Mon,  2 May 2016 13:56:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0zIzDfFgZJ4SriJ8JjNpyYeV+qg=; b=XW+zuN
	qny3WzcaiFy2OOeGlhRFsJ+7r0srg4oXvYtjyBFVoTD/7fxX7eez9iuG9HUUoNg8
	tg2qPsUuKbVr/wJnczqj9PMF3nuwJevvOgLN4HDwXwyreY3ee4RA+HvjYl+ZAK8D
	st97omAjLJ//mf7xVWmT0OQbVQNCEh8VY/x64=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AoDf+wLyeDnWFKddRWlwWKss2NmsgQ+E
	r6FVU/ruMpjqNCbXlIeIQohPNaiTpOrZldjoCtSPmyHDT4BxPR2Bt/V4+TbEZJos
	GycsU6mvqSd951cpCL8Fws9gttE4IFuMdLYyrKGE6SFOx87AEhptm/uTaGU9QjgQ
	XXisafzeYwo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 0E05E16550;
	Mon,  2 May 2016 13:56:01 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 267B61654E;
	Mon,  2 May 2016 13:56:00 -0400 (EDT)
In-Reply-To: <57242B22.4050202@alum.mit.edu> (Michael Haggerty's message of
	"Sat, 30 Apr 2016 05:48:50 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 210EC308-108F-11E6-B634-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293252>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> The point is that `read_ref_full()` is now called with
> `RESOLVE_REF_NO_RECURSE` turned on. So if `newrefname` is a symbolic
> reference, then `read_ref_full()` sets `sha1` to zeros.

Yes, that was an obvious rationale in the patch that was not
explained in the proposed log message (and made me ask you to
explain it).  I was wondering why this was not loosened
conditionally (i.e. only pass null_sha1 when symbolic ref is
involved, in which case you _must_ pass null_sha1 because we no
longer have anything to compare with).

Your explanation on the "in all possible interleaving, deletion of
what might have been updated in the middle by other people does not
matter" was a sufficient explanation why it does not have to be
conditional.

> I'll document this in v2 of this patch.

Thanks.
