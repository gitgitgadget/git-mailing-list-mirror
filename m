From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [PATCH v8 4/7] bisect: introduce --no-checkout,
 --update-ref=<ref> support into porcelain.
Date: Mon, 1 Aug 2011 05:40:35 +1000
Message-ID: <CAH3AnrqasW=ZSix0YBgxHg8ca2X+YOvSWknbG2mjsy0NaqV+Mw@mail.gmail.com>
References: <1312113321-28760-1-git-send-email-jon.seymour@gmail.com>
	<1312113321-28760-5-git-send-email-jon.seymour@gmail.com>
	<CAP8UFD2vCGnejSj=Nwkb+kGCpwUaggh5j2V6zBu0iWqNZwvS3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, chriscool@tuxfamily.org, gitster@pobox.com,
	j6t@kdbg.org, jnareb@gmail.com
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 31 21:40:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QnbsU-0008FS-JM
	for gcvg-git-2@lo.gmane.org; Sun, 31 Jul 2011 21:40:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751765Ab1GaTkh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 31 Jul 2011 15:40:37 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:60102 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752285Ab1GaTkf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 31 Jul 2011 15:40:35 -0400
Received: by vws1 with SMTP id 1so4016365vws.19
        for <git@vger.kernel.org>; Sun, 31 Jul 2011 12:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=dDDePtaeS5z1iz+yYcDwwbT+nTOWOOCNRX3s5qeX0rA=;
        b=usaH4GJvydEW1CiK7WZZeG2EIJxLEW9us+KIhf8NahCClgRzKIq25yBH9fq7Tqebai
         noP+vDeJitD8bS0IGSc58fLnStLmMy8hn7uTAW4xUKgCjYPDzxLNpD/tj2Mbvx7JFR67
         LqaY2TIW8BxRhxFTsThuV9013e1+FI8RWD6MY=
Received: by 10.52.21.194 with SMTP id x2mr2842909vde.39.1312141235097; Sun,
 31 Jul 2011 12:40:35 -0700 (PDT)
Received: by 10.52.183.41 with HTTP; Sun, 31 Jul 2011 12:40:35 -0700 (PDT)
In-Reply-To: <CAP8UFD2vCGnejSj=Nwkb+kGCpwUaggh5j2V6zBu0iWqNZwvS3Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178270>

On Mon, Aug 1, 2011 at 5:21 AM, Christian Couder
<christian.couder@gmail.com> wrote:
> On Sun, Jul 31, 2011 at 1:55 PM, Jon Seymour <jon.seymour@gmail.com> =
wrote:
>>
>> + =C2=A0 =C2=A0 =C2=A0 if test -n "$BISECT_UPDATE_REF"; then
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 eval=3D"$eval echo '$BISECT_UPD=
ATE_REF' > '$GIT_DIR/BISECT_UPDATE_REF';"
>> + =C2=A0 =C2=A0 =C2=A0 fi
>
> I don't like this very much. In fact I realize that the eval thing we
> use is buggy because the result of 'eval "eval"' will be the result o=
f
> the last command in "eval", so we won't detect if one of the first
> command in "eval" failed.

How about I fix the eval stitching so that it uses && rather than ; to
connect each statement with a final true at the end so there is no
dangling &&?

>
> So perhaps something like:
>
> =C2=A0 =C2=A0eval "$eval" &&
> + =C2=A0( test -n "$BISECT_UPDATE_REF" || echo "$BISECT_UPDATE_REF" >
> "$GIT_DIR/BISECT_UPDATE_REF" ) &&
> =C2=A0 =C2=A0echo "git bisect start$orig_args" >>"$GIT_DIR/BISECT_LOG=
" || exit
>

Probably this would be better :-)

( test -z "$BISECT_UPDATE_REF" || echo "$BISECT_UPDATE_REF" >
 "$GIT_DIR/BISECT_UPDATE_REF" ) &&

jon.
