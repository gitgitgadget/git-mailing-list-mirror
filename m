From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] xdiff: print post-image for common records instead of
 pre-image
Date: Tue, 10 Jan 2012 14:58:42 -0800
Message-ID: <7vy5tf88rh.fsf@alter.siamese.dyndns.org>
References: <7vlipx4q3r.fsf@alter.siamese.dyndns.org>
 <4F072B9C.1030005@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Joey Hess <joey@kitenet.net>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Wed Jan 11 00:25:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rkl4a-000817-TD
	for gcvg-git-2@lo.gmane.org; Wed, 11 Jan 2012 00:25:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933049Ab2AJXZi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Jan 2012 18:25:38 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59093 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933679Ab2AJW6o convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Jan 2012 17:58:44 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 258E1520C;
	Tue, 10 Jan 2012 17:58:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=6Qnu4wVzHd+V
	zG7Iz1UuiTcQQNE=; b=w0Jw4hibB06c/+ON8EOwmDFn7rx+BRIyeIx9Jh34W6gS
	2SGBg+HPPGhp5sO4oSPfrW2JZe23ZfTMUd1R/GWrW8Cx9KqBQnyA7IRsRat7sV0e
	DvXptpoTpt9hy9cVt8Qo95EXGTR63BilAptQ5O40iQ5ZeiESkTTAZ3Bh7eAC9H0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=qWW3UN
	6YEyXIHaFH6MwTg4K5hBJdrhIa0bukzJ00x+OZGbAJ3fi0uvalX6zHhFScZOrrid
	FlBIvbgLbt4EMC/gCoF27Vhy3G0hbYiuI1VeOfNUwBao0yM4XzTEgg5uTZXHcJnW
	EBM8w8+BI25srfqWRp5gni0/mMjqseNa1eTyE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1C0AE520B;
	Tue, 10 Jan 2012 17:58:44 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 99A09520A; Tue, 10 Jan 2012
 17:58:43 -0500 (EST)
In-Reply-To: <4F072B9C.1030005@lsrfire.ath.cx> (=?utf-8?Q?=22Ren=C3=A9?=
 Scharfe"'s message of "Fri, 06 Jan 2012 18:13:00 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A517CEFE-3BDE-11E1-810D-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188305>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> Normally it doesn't matter if we show the pre-image or th post-image
> for the common parts of a diff because they are the same.  If
> white-space changes are ignored they can differ, though.  The
> new text after applying the diff is more interesting in that case,
> so show that instead of the old contents.
>
> Note: GNU diff shows the pre-image.
>
> Suggested-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>

I was looking at this one again, and I think one possible downside of
showing post-image for the context lines is that the resulting patch wo=
uld
not apply to the pre-image tree anymore. Probably GNU folks thought tha=
t
it is a big enough issue. Or perhaps they didn't simply care either way=
 ;-)

In any case, showing pre-image lines as the context at least makes the
patch easier to apply, but the result would be different from the inten=
ded
post-image and would appear as if indentation fixes in the patch are
reverted, so you would need manual fix-up after applying such a patch
generated with (gnu) "diff -w".

I tried to generate an output from "show -w", with this change, on a
commit that is largely indentation fix. The resulting patch seems to ap=
ply
cleanly with "apply --ignore-space-change" to the parent of the commit
"show -w" was taken from; of course the result needs some manual fix-up=
s
for the indentation changes, but that is not a news anyway.  So I suspe=
ct
it won't be a huge downside and I think the benefit of being able to se=
e
the post-image in the context when the user is more interested in how t=
he
file looks like after the change outweighs it.

Thanks again.
