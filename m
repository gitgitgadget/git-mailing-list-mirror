From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] dir.c: allow re-include after a dir is excluded in some cases
Date: Wed, 19 Nov 2014 10:48:22 -0800
Message-ID: <xmqqmw7nrpqh.fsf@gitster.dls.corp.google.com>
References: <CACsJy8BHvucnEAW065OXOe5NBQkxp7+8HJb7XCGYgOa=pkxLVA@mail.gmail.com>
	<1416393058-5497-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: phil-gitml@phil.spodhuis.org, git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 19 19:48:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XrAIo-0007Nq-4i
	for gcvg-git-2@plane.gmane.org; Wed, 19 Nov 2014 19:48:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755182AbaKSSs0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 Nov 2014 13:48:26 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:52229 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754554AbaKSSsZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Nov 2014 13:48:25 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B13621DB18;
	Wed, 19 Nov 2014 13:48:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=11RU3m+8bLBK
	f1keVr/bfMON2Og=; b=jSIVuLl3HiXpTml4H99/QgY1047m1hiBLI/kajf8LB54
	4HXlGWwmBvlruJtyGyYUZr/Pv5Gl9Kiqz8zFQVG47d5s2hVOwRvbWw2s9lEk+hGc
	pv+bqrLII3Rz+eujdXCJg9JsWB4durKsOWD4zm4Djj0GIlIWsUUZ7Jq7bmh14F0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=EnuFOP
	xjYHAIFLbv6vVWgKOf5HmcjUe2UwyIy7yOIpN4nzgqK1pEydGZXWdK/+4YBSKHZ2
	udlf4idHYoWoymFzUcsHR9phqd5ka8HY0+tGbko5lsbODbrJ5ZIaqxir3wHilm0b
	Z5zuTLTz3CCj3ZtdTmDXDeGG5msgRqW7KM/28=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A40631DB16;
	Wed, 19 Nov 2014 13:48:24 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EF1A91DB15;
	Wed, 19 Nov 2014 13:48:23 -0500 (EST)
In-Reply-To: <1416393058-5497-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Wed, 19
 Nov 2014 17:30:58 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A3F4D236-701C-11E4-8374-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.tx=
t
> index 09e82c3..0340c44 100644
> --- a/Documentation/gitignore.txt
> +++ b/Documentation/gitignore.txt
> @@ -82,10 +82,9 @@ PATTERN FORMAT
> =20
>   - An optional prefix "`!`" which negates the pattern; any
>     matching file excluded by a previous pattern will become
> -   included again. It is not possible to re-include a file if a pare=
nt
> -   directory of that file is excluded. Git doesn't list excluded
> -   directories for performance reasons, so any patterns on contained
> -   files have no effect, no matter where they are defined.
> +   included again.
> +   It is usually not possible to re-include a file if a parent
> +   directory of that file is excluded. See NOTES for details.
>     Put a backslash ("`\`") in front of the first "`!`" for patterns
>     that begin with a literal "`!`", for example, "`\!important!.txt`=
".
> =20
> @@ -144,6 +143,12 @@ use 'git update-index {litdd}assume-unchanged'.
>  To stop tracking a file that is currently tracked, use
>  'git rm --cached'.
> =20
> +It is usually not possible to re-include a file if a parent director=
y
> +of that file is excluded because of performance reasons. However, if
> +there are negative rules in the same .gitignore file that contains t=
he
> +rule to ignore a specific directory, and those negative rules contai=
n
> +a slash, then re-inclusion is possible.

Does that mean "performance reasons" goes out the window???

What trade-off are the users making by choosing to do so?  Is it
explained in the documentation well enough to allow them to make an
informed decision?
