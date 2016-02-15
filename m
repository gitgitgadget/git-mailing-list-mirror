From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/4] .gitignore, reinclude rules, take 2
Date: Mon, 15 Feb 2016 15:49:02 -0800
Message-ID: <xmqqegcdo7pt.fsf@gitster.mtv.corp.google.com>
References: <1455527019-7787-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 16 00:49:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVStC-0002Bl-6g
	for gcvg-git-2@plane.gmane.org; Tue, 16 Feb 2016 00:49:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752671AbcBOXtG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Feb 2016 18:49:06 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:55256 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752361AbcBOXtE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Feb 2016 18:49:04 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B7AAD45A02;
	Mon, 15 Feb 2016 18:49:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Uflm+fBqQ08n
	V10f2mOGORJW7Ts=; b=EA6wVR6VSHdnfn/V+agY5RxHqwzmcxgUBV1fWN10LzMr
	LP5GC7pOB3MF/Prk2V8iWh0YgyCgcVyj5l7Zn39Ya855zmp6cUmrqkMz5s0vYoOT
	Nr+FaU2uMlZABmMhpDn7ZwjZxCWlTuUAG7jjdTxkGIGeSRsnOCI7uAtqb7F1liI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=aZ36vg
	I/Hjwoq9bCZLoWGL9U893POlx+E13o3nI8PJs15i8jKXiRct4QujIaaVbYwHuqiS
	TUBR9Rwy0M1RS+e8BJ0lSNANUMclExA74C4i1YB5XYpI2WpEqOeBAOfYYC900nyb
	rQgKL3WEVilodA72kDSVMLpt7L8aD9g+62tbI=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B06B945A01;
	Mon, 15 Feb 2016 18:49:03 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 3286845A00;
	Mon, 15 Feb 2016 18:49:03 -0500 (EST)
In-Reply-To: <1455527019-7787-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Mon, 15
 Feb 2016 16:03:35 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B14ACA80-D43E-11E5-848F-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286291>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Take one was bad and reverted in commit 8c72236. Take two provides a
> more complete solution to the pair of rules
>
>   exclude/this
>   !exclude/this/except/this
>
> 3/4 should do a better job at stopping regressions in take 1. 4/4
> provides the solution. I think I have tested (and wrote tests) for al=
l
> the cases I can imagine.

Thanks.  The data structure used in 3/4 smells iffy from performance
point of view--have you tried it on a large trees with deep nesting?

>
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (4):
>   dir.c: fix match_pathname()
>   dir.c: support tracing exclude
>   dir.c: support marking some patterns already matched
>   dir.c: don't exclude whole dir prematurely
>
>  Documentation/git-check-ignore.txt          |   1 +
>  Documentation/git.txt                       |   5 +
>  Documentation/gitignore.txt                 |  17 ++-
>  dir.c                                       | 204 ++++++++++++++++++=
+++++++++-
>  dir.h                                       |   3 +
>  t/t3001-ls-files-others-exclude.sh          |   7 +-
>  t/t3007-ls-files-other-negative.sh (new +x) | 153 ++++++++++++++++++=
+++
>  7 files changed, 378 insertions(+), 12 deletions(-)
>  create mode 100755 t/t3007-ls-files-other-negative.sh
