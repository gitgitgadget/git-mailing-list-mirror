From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH] Fix checkout of large files to network shares under 
	Windows XP
Date: Tue, 20 Apr 2010 14:42:56 +0200
Message-ID: <t2xbdca99241004200542ud4e8ea5azcad918c37bcacf1a@mail.gmail.com>
References: <4BCC5083.30801@gmail.com> <4BCCC05E.4030206@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, msysgit@googlegroups.com,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Tue Apr 20 14:43:19 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4CnM-0004q0-N1
	for gcvg-git-2@lo.gmane.org; Tue, 20 Apr 2010 14:43:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754511Ab0DTMnA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Apr 2010 08:43:00 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:36800 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753814Ab0DTMm7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Apr 2010 08:42:59 -0400
Received: by bwz19 with SMTP id 19so16853bwz.21
        for <git@vger.kernel.org>; Tue, 20 Apr 2010 05:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=JMOtogCYIQzYuG5Mrvzf9Z21w17m0keMF/dw8Asgvzo=;
        b=lOIWyqYTQq8iS/dFy8cBM4JjW7gFhNWKalS6+qlw/iO9vXzmQi876hRj+fJAI5j/T0
         vBkWpKV+m+sbUW2oZhFJ+ko+5oxpOwvvh15cO0NhmKOJGBjWR9kEulWNAFDamye3Sic7
         UJtRw4rvE0MNfBsMhuZisrhcdMB9Rfiuw2Yow=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=STenUKzLU7ve8+WgpbOrvPBkHy1O0ZGZvMAQ1QcpgSF7Vte1L24hs6Z1bguAhwPJnQ
         8SkNHuHAUBkeao7Z0KMg835jnxb7E+DyEwAa3zIrd6KJNloEm81o54bo2pUAqM+1JWK7
         zVbzVZGbLDDbh1Zi1ZYJoJ8Wn561jTYB5pm3I=
Received: by 10.204.62.19 with HTTP; Tue, 20 Apr 2010 05:42:56 -0700 (PDT)
In-Reply-To: <4BCCC05E.4030206@lsrfire.ath.cx>
Received: by 10.204.139.68 with SMTP id d4mr1495073bku.66.1271767376639; Tue, 
	20 Apr 2010 05:42:56 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145370>

On Mon, Apr 19, 2010 at 22:43, Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.=
ath.cx> wrote:

>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (written < 0 && errno=
 =3D=3D EINVAL) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 // There seems to be a bug in the Windows XP network stack that
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 // causes writes with sizes > 64 MB to fail, so we halve the size
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 // until we succeed or ultimately fail.
>
> C style comments (/*...*/) are preferred over C++ style comments (//.=
=2E.)
> for git.

Oh well, I've changed that.

> Is there a known-good size, or at least a mostly-working one? =C2=A0W=
ould it
> make sense to start with that size instead of halving and trying unti=
l
> that size is reached?

As the comment says, the greatest size that worked in my experiments
is 64 MB, and other posts on the Internert suggest the same limit, but
it's still an unconfirmed / undocumented issue. Anyway, I'm now
starting with 64 MB right away if a write failed.

>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 size /=3D 2;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 buf +=3D written;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 total +=3D written;
>
> What about other errors? =C2=A0You need to break out of the loop inst=
ead of
> adding -1 to buf and total, right?

Right, I've fixed that, thanks.

>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 if (total + size > count)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 size =3D count - total;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>> + =C2=A0 =C2=A0 }
>
> Shouldn't the loop be left in the successful case, too? =C2=A0write(2=
) is
> allowed to write less than requested, so the caller already needs to
> deal with that case anyway.

I prefer to make the wrapper as transparent as possible. If a direct
call to write would not write less than requested, the wrapper should
not either.

I've updated work/issue-409 in 4msysgit.git accordingly.

--=20
Sebastian Schuberth
