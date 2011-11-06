From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] apply: get rid of useless x < 0 comparison on a
 size_t type
Date: Sun, 06 Nov 2011 10:35:42 -0800
Message-ID: <7vsjm15cap.fsf@alter.siamese.dyndns.org>
References: <1320581184-4557-1-git-send-email-avarab@gmail.com>
 <1320581184-4557-2-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jim Meyering <jim@meyering.net>,
	Fredrik Gustafsson <iveqy@iveqy.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 06 19:35:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RN7ZQ-00051K-Bd
	for gcvg-git-2@lo.gmane.org; Sun, 06 Nov 2011 19:35:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754225Ab1KFSfr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 Nov 2011 13:35:47 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43113 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754139Ab1KFSfq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Nov 2011 13:35:46 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3736756C2;
	Sun,  6 Nov 2011 13:35:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=28wgK6zzLgk2
	tYhIA9lzh6ds1eA=; b=JgVO5Da1SeYdtOr4hCcpwdkI71jk0jv4LwIfep16qzQC
	/55YEXciQkpJB/yu38VkzBI3vNp5Kss/+oUP5NvC37APCOMcXq6WMopqHFUJA2Ln
	lRkpyPH4PSxKvNVmGaKfFddUIYa/OxsYFfdfhV0Ca/MQMjY8ATVqCqw6ZYNRVGU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=diJtBh
	iaUsB5WlFAsLIqKzS6i9j+wOlFMbZGv0BYOJxxQryClzTkS+zORKIuFVaO2y2cCq
	/1yJqA9yi5E+w+x/+MeXSzVa1xwjeqGfgWS4DL8BcxYtTnl5Ynr/4jA7RevbC0ij
	7ikAVrElgk+9ViDMzbMNSLArQOfcoGkTmBGSw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2903856C1;
	Sun,  6 Nov 2011 13:35:46 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E754B56BE; Sun,  6 Nov 2011
 13:35:43 -0500 (EST)
In-Reply-To: <1320581184-4557-2-git-send-email-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Sun, 6 Nov
 2011 13:06:22 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 232FF13E-08A6-11E1-98EC-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184923>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> According to the C standard size_t is always unsigned, therefore the
> comparison "n1 < 0 || n2 < 0" when n1 and n2 are size_t will always b=
e
> false.
>
> This was raised by clang 2.9 which throws this warning when compiling
> apply.c:
>
>     builtin/apply.c:253:9: warning: comparison of unsigned expression=
 < 0 is always false [-Wtautological-compare]
>             if (n1 < 0 || n2 < 0)
>                 ~~ ^ ~
>     builtin/apply.c:253:19: warning: comparison of unsigned expressio=
n < 0 is always false [-Wtautological-compare]
>             if (n1 < 0 || n2 < 0)
>                           ~~ ^ ~
>
> This check was originally added in v1.6.5-rc0~53^2 by Giuseppe Bilott=
a
> while adding an option to git-apply to ignore whitespace differences.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.c=
om>
> ---

I agree that these quantities can never be negative, so I'll apply the
patch as is.

But I have this suspicion that this was a rather sloppy defensive check=
 to
protect this codepath against potential breakage in another codepath (m=
ost
likely update_pre_post_images() touched by the same patch) that adjusts
image->line[].len the caller of this function uses to feed these two
parameters. Giuseppe may have been not confident enough that the code
added to that function ensures not to undershoot when it reduces "len",=
 or
something.

Giuseppe, can you explain what is going on?

Thanks

>  builtin/apply.c |    3 ---
>  1 files changed, 0 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/apply.c b/builtin/apply.c
> index 84a8a0b..b3b59db 100644
> --- a/builtin/apply.c
> +++ b/builtin/apply.c
> @@ -250,9 +250,6 @@ static int fuzzy_matchlines(const char *s1, size_=
t n1,
>  	const char *last2 =3D s2 + n2 - 1;
>  	int result =3D 0;
> =20
> -	if (n1 < 0 || n2 < 0)
> -		return 0;
> -
>  	/* ignore line endings */
>  	while ((*last1 =3D=3D '\r') || (*last1 =3D=3D '\n'))
>  		last1--;
