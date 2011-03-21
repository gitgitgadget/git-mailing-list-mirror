From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCHv2 2/2] Fix sparse warnings
Date: Mon, 21 Mar 2011 15:04:32 -0700
Message-ID: <AANLkTinYCqK6zm17O_HedOFtbN6VRhYQbFj-YNk+JrV1@mail.gmail.com>
References: <7voc54sb41.fsf@alter.siamese.dyndns.org> <1300730506-6582-1-git-send-email-bebarino@gmail.com>
 <7vzkoop912.fsf@alter.siamese.dyndns.org> <7vd3lknnjy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Johannes Sixt <j.sixt@viscovery.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 21 23:04:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1nDZ-0001Oa-J6
	for gcvg-git-2@lo.gmane.org; Mon, 21 Mar 2011 23:04:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754652Ab1CUWEt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Mar 2011 18:04:49 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:37301 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754567Ab1CUWEs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Mar 2011 18:04:48 -0400
Received: by gwaa18 with SMTP id a18so2618386gwa.19
        for <git@vger.kernel.org>; Mon, 21 Mar 2011 15:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=d/q9bAPfTN2+Q0/l6gshd68/lgwNWTHn4EJfN/OIrB8=;
        b=WzYBGCi8dQ+3Z2yvh8B3h+QSV2pze85zOFkM6Ej7CJNuQe6LqZMst5y+Bqcw2s9rX7
         14GXHI6CyBzNM0VEYXLWXTNGTtQ8j51yPz1ZRUI6Xr9D4EoX016Jmd8SrCGJzmlKLiNi
         uwgdZScfozMYB4ktNlK6Xq/cwDnqTmxc8Z6V4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=EijCM9JdgihUjnbswuZD9SJcTPIPVG1DpTkjuRkEiGrhfPniWeuYH+bLiCV1DU2PSD
         LWX8cghrs3iDy+v1kFT/qkieY19LFA1QJJGh8wrB2Q3yuuj23IyPgby48AgsO6QtatjQ
         kLTZDb8jOSd+0RcGpf80eG1r5NZMUgo3HPKWM=
Received: by 10.236.190.132 with SMTP id e4mr5899868yhn.374.1300745087132;
 Mon, 21 Mar 2011 15:04:47 -0700 (PDT)
Received: by 10.236.105.141 with HTTP; Mon, 21 Mar 2011 15:04:32 -0700 (PDT)
In-Reply-To: <7vd3lknnjy.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169678>

On Mon, Mar 21, 2011 at 2:58 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Still yeek...
>>
>> What I meant was more like at the minimum:
>> ...
>> or much more preferably:
>>
>> =C2=A0- These files use symbols without declaring, because they do n=
ot include
>> =C2=A0 =C2=A0"builtin.h":
>>
>> =C2=A0 =C2=A0 builtin/clone.c (cmd_clone), builtin/fetch-pack.c (cmd=
_fetch_pack), ...
>>
>> =C2=A0- These files define extern symbols without declaring, and the=
y can be
>> =C2=A0 =C2=A0file scope static:
>>
>> =C2=A0 =C2=A0 builtin/fmt-merge-msg.c (init_src_data), ...
>>
>> =C2=A0- These callsites pass literal integer 0 where they mean to pa=
ss a NULL
>> =C2=A0 =C2=A0pointer:
>>
>> =C2=A0 =C2=A0builtin/notes.c (resolve_ref), ...
>>
>> The patch text itself look more or less Ok, but I see you have built=
in.h
>> not as the first include in builtin/pack-redundant.c.
>>

Ah ok, I can do that.

>
> I spotted these two. =C2=A0thread-utils.h already includes pthread.h,=
 and
> builtin.h should come before (though technically exec_cmd.h does not
> depend on any external types, so this is just a conformity issue, not
> correctness one).
>
> Again, thanks.
>
> =C2=A0builtin/pack-redundant.c | =C2=A0 =C2=A02 +-
> =C2=A0thread-utils.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0=
1 -
> =C2=A02 files changed, 1 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/pack-redundant.c b/builtin/pack-redundant.c
> index 760b377..a15e366 100644
> --- a/builtin/pack-redundant.c
> +++ b/builtin/pack-redundant.c
> @@ -6,8 +6,8 @@
> =C2=A0*
> =C2=A0*/
>
> -#include "exec_cmd.h"
> =C2=A0#include "builtin.h"
> +#include "exec_cmd.h"
>
> =C2=A0#define BLKSIZE 512
>
> diff --git a/thread-utils.c b/thread-utils.c
> index 2c8c1e3..7f4b76a 100644
> --- a/thread-utils.c
> +++ b/thread-utils.c
> @@ -1,5 +1,4 @@
> =C2=A0#include "cache.h"
> -#include <pthread.h>
> =C2=A0#include "thread-utils.h"
>
> =C2=A0#if defined(hpux) || defined(__hpux) || defined(_hpux)
>

Ok, I'll squash these in and resend tonight when I get home.

Also, I don't think exec_cmd.h is actually used in some of the builtin
C files (due to some setup fallouts) so I think we can probably just
remove the exec_cmd.h includes if they're within contex and unused.
I'll do that next round.
