From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] add macro REALLOCARRAY
Date: Mon, 15 Sep 2014 11:24:04 -0700
Message-ID: <xmqqtx487nej.fsf@gitster.dls.corp.google.com>
References: <5415C89C.4090509@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Mon Sep 15 20:24:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTawg-0007sg-Cg
	for gcvg-git-2@plane.gmane.org; Mon, 15 Sep 2014 20:24:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753682AbaIOSYJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Sep 2014 14:24:09 -0400
Received: from smtp.pobox.com ([208.72.237.35]:57313 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752279AbaIOSYI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Sep 2014 14:24:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6781F392C4;
	Mon, 15 Sep 2014 14:24:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Hi4HSiMQ9fPe
	lxghHJoeqddY2Y8=; b=Vgde5r6hBYNnhNao+oos4EP/DkWc4L5Qo1yQVS4j487i
	4xhVZIrZicsZZmG0BCWkvr3TS+KCCoXFkzUAEUYwKCmMP5lrnE+xN1nQzQawcYbV
	Zi4n5sBxycqa7/QLMCSLLEVLTbJknu0ftUCaMn30wC6In9NFZMk8MFn8eHu287M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=U+1/By
	6qu8qVTIIz+EE0GCIIvcgnuSDKTZ8AnsW260wkN11W8y98Honm/IuhcDei7jQvm7
	NxrRCGwx0Nr6Al7yWl2L4pTBPQgqy0gfGNJlKFoLCnDt17Z0sWgx5s9d+8tVcj+3
	zqjDPGxDFXZU+whslAO1WyHDvvbkJViKX5Gm8=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5EE65392C3;
	Mon, 15 Sep 2014 14:24:07 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id D40DF392C0;
	Mon, 15 Sep 2014 14:24:06 -0400 (EDT)
In-Reply-To: <5415C89C.4090509@web.de> (=?utf-8?Q?=22Ren=C3=A9?= Scharfe"'s
 message of "Sun, 14
	Sep 2014 18:55:56 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 7A96ED56-3D05-11E4-A3DB-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257063>

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> The macro ALLOC_GROW manages several aspects of dynamic memory
> allocations for arrays: It performs overprovisioning in order to avoi=
d
> reallocations in future calls, updates the allocation size variable,
> multiplies the item size and thus allows users to simply specify the
> item count, performs the reallocation and updates the array pointer.
>
> Sometimes this is too much.  Add the macro REALLOCARRAY, which only
> takes care of the latter three points and allows users to specify the
> number of items an array can store directly.  It can increase and
> also decrease its size.  Using this macro avoids duplicating the
> array pointer name and takes care of item sizes automatically.
>
> Signed-off-by: Rene Scharfe <l.s.r@web.de>
> ---

Makes sense.  Originally I had two minor gripes against this

 #1 a macro that modifies its arguments feels a bit too magical, and
    we would not want to overuse them.

 #2 REALLOC_ARRAY(array, size) would have been easier to read.

But #1 is shared with ALLOC_GROW(), and as long as we use it
everywhere (and by the looks of 2/2 we fairly widely do), readers
will get used to the pattern.  #2 still stands, though.

Thanks.

>  Documentation/technical/api-allocation-growing.txt | 3 +++
>  git-compat-util.h                                  | 2 ++
>  2 files changed, 5 insertions(+)
>
> diff --git a/Documentation/technical/api-allocation-growing.txt b/Doc=
umentation/technical/api-allocation-growing.txt
> index 542946b..4b5f049 100644
> --- a/Documentation/technical/api-allocation-growing.txt
> +++ b/Documentation/technical/api-allocation-growing.txt
> @@ -34,3 +34,6 @@ item[nr++] =3D value you like;
>  ------------
> =20
>  You are responsible for updating the `nr` variable.
> +
> +If you need to specify the number of elements to allocate explicitly
> +then use the macro `REALLOCARRAY(item, alloc)` instead of `ALLOC_GRO=
W`.
> diff --git a/git-compat-util.h b/git-compat-util.h
> index 4e7e3f8..d926e4c 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -626,6 +626,8 @@ extern int odb_mkstemp(char *template, size_t lim=
it, const char *pattern);
>  extern int odb_pack_keep(char *name, size_t namesz, const unsigned c=
har *sha1);
>  extern char *xgetcwd(void);
> =20
> +#define REALLOCARRAY(x, alloc) x =3D xrealloc((x), (alloc) * sizeof(=
*(x)))
> +
>  static inline size_t xsize_t(off_t len)
>  {
>  	if (len > (size_t) len)
