From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: [PATCH] rebase --abort: do not update branch ref
Date: Mon, 22 Nov 2010 07:23:27 -0500
Message-ID: <AANLkTikwZTZhP5biBEsf62g+GTkZN7NwX=zeF2PKhmwO@mail.gmail.com>
References: <1290337881-26449-1-git-send-email-martin.von.zweigbergk@gmail.com>
	<7v1v6evyq5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 22 13:23:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PKVQq-0007sQ-OM
	for gcvg-git-2@lo.gmane.org; Mon, 22 Nov 2010 13:23:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755282Ab0KVMX3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 22 Nov 2010 07:23:29 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:51090 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754525Ab0KVMX2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Nov 2010 07:23:28 -0500
Received: by qwc9 with SMTP id 9so743847qwc.19
        for <git@vger.kernel.org>; Mon, 22 Nov 2010 04:23:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=9vCjCDRgxLXIVa9LSRZ7voR9u8IC4PYlb4kSpXWtgMI=;
        b=iNuZVHQ3RaRGGTMQ6fkHSfDJtTD+cIK/7a/DuxKdjTVr9iYPdz1oDIiZC4oekFZhSw
         eHq5QynxEw/H1UT/Bk8DsrrWjxUQqAu43xhJgMvWkezYQP3BK5uf0yVUbAJFC9807eVP
         dxU9EhvctWxOsWdbrK3JlbAXBzCdu5nV4aTOA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=yGSqVfLCCsxgizWkLIBbxi1A7mT6OIprX3WbydiNXa1EXlBxionR3+bX4QmTyabGMF
         DkUr720LNA4iuLZg/RiTW2J4gcoRu91amiUkNJWMc8rXqDDzfwvGq6sQZ3X9X6okYjkW
         c1CeaXRGnyFlymGiuOIhsoZIAV5Sfh1W9i4J4=
Received: by 10.224.19.145 with SMTP id a17mr259091qab.194.1290428607690; Mon,
 22 Nov 2010 04:23:27 -0800 (PST)
Received: by 10.224.200.138 with HTTP; Mon, 22 Nov 2010 04:23:27 -0800 (PST)
In-Reply-To: <7v1v6evyq5.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161884>

On Sun, Nov 21, 2010 at 10:11 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Martin von Zweigbergk <martin.von.zweigbergk@gmail.com> writes:
>
>> diff --git a/git-rebase.sh b/git-rebase.sh
>> index ec08f9c..3d194b1 100755
>> --- a/git-rebase.sh
>> +++ b/git-rebase.sh
>> @@ -278,12 +278,17 @@ do
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if test -d "$dotest=
"
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 then
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 GIT_QUIET=3D$(cat "$dotest/quiet")
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 move_to_original_branch
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 dotest=3D"$GIT_DIR"/rebase-apply
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 GIT_QUIET=3D$(cat "$dotest/quiet")
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 move_to_original_branch
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fi
>
> Micronit. =C2=A0It appears that GIT_QUIET is set to the same value in=
 either
> case, so perhaps you would also want to move it outside of the if blo=
ck,
> i.e.
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0test -d "$dotest" || dotest=3D"$GIT_DIR/re=
base-apply"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0GIT_QUIET=3D$(cat "$dotest/quiet)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0... your rewrite to move_to_original_branc=
h here ...
>
> no? =C2=A0Staring at it further, I wonder who pays attention to GIT_Q=
UIET in
> this codepath that will soon exit, though.

Yes, I just didn't care to change it in this patch, because I'm changin=
g
this code in the refactor I'm currently working on. OTOH, I don't mind
if you do squash that in either. It might make sense since we don't yet
know if my refactoring series will accepted.

Btw, I'm sure you noticed it, but also I sent a little fix for the test
included in this patch. I have never used the In-Reply-To header, so I'=
m
not sure I used it right (judging by how the threaded Gmane view
presents it, I did not).

Regards,
Martin
