From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH] mergetool: Provide an empty file when no base exists
Date: Thu, 19 Jan 2012 23:07:03 -0800
Message-ID: <CAJDDKr5Z8JHq7H8ZZVLJvYaR+m4HarYdv2FB7p5ByYbDBemBig@mail.gmail.com>
References: <CAJDDKr5mUiJkNk-urNn5fP5x+gkzaTfx2y=K1S0AJZCy7Muwdg@mail.gmail.com>
	<1327042010-79552-1-git-send-email-davvid@gmail.com>
	<7vhazqhn8u.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 20 08:07:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ro8ZZ-0003zg-NI
	for gcvg-git-2@lo.gmane.org; Fri, 20 Jan 2012 08:07:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751835Ab2ATHHF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 Jan 2012 02:07:05 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:55864 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751670Ab2ATHHE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Jan 2012 02:07:04 -0500
Received: by ghbg18 with SMTP id g18so103986ghb.19
        for <git@vger.kernel.org>; Thu, 19 Jan 2012 23:07:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=9Auo8dQokOScDTNVHYk709hAATpALy/wMP99hS+x6DY=;
        b=WLb2AB+xB5CQm19wVk5qyzmC4i8o8wzmaoNc+TmV2KgW+H7TzGE5CoQ3a5sMWSN1OE
         ohUE2z/gYBt7+xqZqNBHO0ugQDaeUlAjWPZFMSLB+0LMiaoNtgpO97f+GDAcYTtIobyy
         1dN6C/Wd2aa9EQE9fGgeRTD5RRQFipGEzNCFY=
Received: by 10.236.189.105 with SMTP id b69mr11162918yhn.90.1327043223412;
 Thu, 19 Jan 2012 23:07:03 -0800 (PST)
Received: by 10.146.151.11 with HTTP; Thu, 19 Jan 2012 23:07:03 -0800 (PST)
In-Reply-To: <7vhazqhn8u.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188856>

On Thu, Jan 19, 2012 at 11:00 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> David Aguilar <davvid@gmail.com> writes:
>
>> Some mergetools cannot cope when $BASE is missing.
>> This can happen when two branches add the same file.
>> Provide an empty file to make these tools happy.
>>
>> Reported-by: Jason Wenger <jcwenger@gmail.com>
>> Signed-off-by: David Aguilar <davvid@gmail.com>
>> ---
>> =C2=A0git-mergetool.sh =C2=A0 =C2=A0 | =C2=A0 =C2=A06 +++++-
>> =C2=A0t/t7610-mergetool.sh | =C2=A0 27 ++++++++++++++++++++++++++-
>> =C2=A02 files changed, 31 insertions(+), 2 deletions(-)
>>
>> diff --git a/git-mergetool.sh b/git-mergetool.sh
>> index 085e213..8521b81 100755
>> --- a/git-mergetool.sh
>> +++ b/git-mergetool.sh
>> @@ -224,7 +224,11 @@ merge_file () {
>> =C2=A0 =C2=A0 =C2=A0mv -- "$MERGED" "$BACKUP"
>> =C2=A0 =C2=A0 =C2=A0cp -- "$BACKUP" "$MERGED"
>>
>> - =C2=A0 =C2=A0base_present =C2=A0 && checkout_staged_file 1 "$MERGE=
D" "$BASE"
>> + =C2=A0 =C2=A0if base_present; then
>> + =C2=A0 =C2=A0 checkout_staged_file 1 "$MERGED" "$BASE"
>> + =C2=A0 =C2=A0else
>> + =C2=A0 =C2=A0 touch "$BASE"
>> + =C2=A0 =C2=A0fi
>
> Using "touch" for things like this is a disease.
>
> You not just want to make sure it exists, but also you want to make s=
ure
> it is empty, so it would make your intention more explicit and clear =
if
> you wrote this as
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0>"$BASE"
>
> instead.
>
> I also wonder if it may help mergetools if we come up with a fake bas=
e
> image using the common material between the two files, in a way simil=
ar to
> how git-merge-one-file.sh does it (look for "Added $4 in both, but
> differently"), but obviously it would belong to a separate patch.
>
> Thanks.

Ah, thanks for the pointer.  I'll resend shortly.  A "fake base" would
be very helpful.
--=20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 David
