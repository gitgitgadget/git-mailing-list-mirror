From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH 1/2] git-am foreign patch support: format autodetection
Date: Tue, 26 May 2009 00:49:14 +0200
Message-ID: <cb7bb73a0905251549s49d7fc28ge63b12e52029dd0b@mail.gmail.com>
References: <1243278846-14120-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <1243278846-14120-2-git-send-email-giuseppe.bilotta@gmail.com>
	 <7vk544u8hx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 26 00:49:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8iyy-0007g4-7H
	for gcvg-git-2@gmane.org; Tue, 26 May 2009 00:49:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752991AbZEYWtQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 May 2009 18:49:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752893AbZEYWtP
	(ORCPT <rfc822;git-outgoing>); Mon, 25 May 2009 18:49:15 -0400
Received: from mail-bw0-f222.google.com ([209.85.218.222]:52072 "EHLO
	mail-bw0-f222.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752523AbZEYWtO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 May 2009 18:49:14 -0400
Received: by bwz22 with SMTP id 22so3405871bwz.37
        for <git@vger.kernel.org>; Mon, 25 May 2009 15:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=WJEEFmOkS+qS2oy+UKDfEKUo0QC4GxA1jcxK8/WWzDM=;
        b=xBL2d0U9U3o6AlL1XbZTT49zr+k39w7cnFaUgqZ4j+fs8ncOtEVgfjwCkmtrQhXZsM
         gGMeGLFFoXfF6voM3/KVB1xonrKfyk1v31s/frNQUTyE3zm9f4p6dWi9TAx0Jt9Rj9dP
         O3Ij/NpXJ+ISAGPrFz1hIRP1IKPwxzdbEU6eM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=qmp4Ne9OYK64zUnJOoigLcCeSiIpg9C8rGd/oDlj0lmbSX4eyl7Z56NFgmK/v7Dz2f
         Z23dJbC8Cs5OMEAYZY4r4MDoJ7Wq/3pziqktNcu/wR626wBvlseQ9TSIXfnFuMxQayc7
         /b/fDEOU6uh6dX8tX1sbCRKNqELHyXqMYNNJA=
Received: by 10.204.31.77 with SMTP id x13mr7432272bkc.6.1243291754135; Mon, 
	25 May 2009 15:49:14 -0700 (PDT)
In-Reply-To: <7vk544u8hx.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119980>

On Tue, May 26, 2009 at 12:23 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:
>
>> This patch is the first step towards the introduction of a framework=
 to
>> allow git-am to import patches not in mailbox format.
>>
>> Currently detected formats are
>> =A0 * the mailbox format itself, which is assumed by default if inpu=
t is
>> =A0 =A0 form stdin
>> =A0 * Mercurial's output from 'hg export'
>> =A0 * Stacked Git's output from 'stg export' with the default export
>> =A0 =A0 template; StGIT patch series are also detected and expanded.
>
> I personally do not trust "autodetection" (especially done by others =
;-),
> and prefer to have an explicit override by the users, but that aside.=
=2E.

No problem. --patch-format or just --format ?

> =A0 =A0 =A0 =A0if test -z "$patch_format" && {
> =A0 =A0 =A0 =A0 =A0 test $# =3D 0 || test "x$1" =3D x-
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0then
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0patch_format=3Dmbox
> =A0 =A0 =A0 =A0else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0patch_format=3D$(guess_patch_format)
> =A0 =A0 =A0 =A0fi
>
> Having this extra logic inside the main codeflow makes it extremely h=
arder
> to read; have it in a separate shell function.

I assume you mean the patch format detection, yes?

>> +# a single non-stdin argument was passed, check if it's a StGit pat=
ch series
>> +# index by checking if the first line begins with '# This series'
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 read l1
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 case "$l1"=
 in
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 '# This se=
ries '*)
>> +# replace the argument list with the files listed in the series ind=
ex,
>> +# prefixing them with the series index dirname, skipping comment li=
nes
>
> Can the "series-index-name" file begin with '-' (which would affect t=
he
> way how 'set "@"' works in the loop below)? =A0A standard trick would=
 be to
> do something like this.
>
> =A0 =A0 =A0 =A0series_index=3D"$1"
> =A0 =A0 =A0 =A0shift ;# discard
> =A0 =A0 =A0 =A0set x
> =A0 =A0 =A0 =A0while ...
> =A0 =A0 =A0 =A0do
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0set "$@" another
> =A0 =A0 =A0 =A0done
> =A0 =A0 =A0 =A0shift ;# discard 'x' protection

Ah, good point. I'll do it that way.

>> + =A0 =A0 # (which is not stdin) to try to understand the format.
>> + =A0 =A0 if test $patch_format =3D none
>
> I do not understand this duplication and inconsistency. =A0Why have t=
he
> detection in two places?

It's not in two places. The first part sets the patch format only if
we are either reading from stdin or have been passed a stgit patch
series. Otherwise, we still don't know what we're getting, so now we
inspect the first patch to see what format it's in. (Consider for
example the case of appication of a StGIT patch which is not part of a
series.)

>> + =A0 =A0 case "$patch_format" in
>> + =A0 =A0 mbox)
>> + =A0 =A0 =A0 =A0 =A0 =A0 git mailsplit -d"$prec" -o"$dotest" -b -- =
"$@" > "$dotest/last" || =A0{
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rm -fr "$dotest"
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 exit 1
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 ;;
>> + =A0 =A0 *)
>> + =A0 =A0 =A0 =A0 =A0 =A0 echo "Patch format $patch_format is not cu=
rrently handled, sorry"
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 exit 1
>
> No fixing broken "Subject:" line for your format here?

No, I put that in the second patch, because it was a different thing
(patch processing as opposed to format detection).


--=20
Giuseppe "Oblomov" Bilotta
