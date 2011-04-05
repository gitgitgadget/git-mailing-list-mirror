From: Dan McGee <dpmcgee@gmail.com>
Subject: Re: [PATCH] Share color list between graph and show-branch
Date: Mon, 4 Apr 2011 19:32:05 -0500
Message-ID: <BANLkTint1+c0h9DExydWeeafdgawEJPuMw@mail.gmail.com>
References: <1301535506-1166-1-git-send-email-dpmcgee@gmail.com>
	<7v7hbbcfoj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 05 02:32:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6uBp-0006yE-HB
	for gcvg-git-2@lo.gmane.org; Tue, 05 Apr 2011 02:32:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751190Ab1DEAcI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Apr 2011 20:32:08 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:51912 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751009Ab1DEAcG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Apr 2011 20:32:06 -0400
Received: by wwa36 with SMTP id 36so7072783wwa.1
        for <git@vger.kernel.org>; Mon, 04 Apr 2011 17:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=L+F02XzY+jYj1tq1zzZxATQ0xyx0Wq+2A/aW5rpAxpI=;
        b=OhyYcOM6SUeOgESotRSPP/rdAwKdTiT8veS3PMWxnQW4DTYZmxFkxYMgzixPwBX252
         ruGtejY8cVKDMN6IjBvOq724Zn/E89dq3npVGCdmTB7T4ZhpnFWer/vOOQOjHpXbytQB
         9Rsj9fLALYJCOE7nAKmGDWzWMXsbHIs2g2RZc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=EUz7GESZdRenbFIlYGVbmU+vmonBVScz0yLIPYwQapKyTiQNNSj2S/UKgjV5G8XwZt
         PnlX3umb7bj0GUhx0M1eWK8uizU/MSDz9klTUv5z29wuntZPB8Fipb80GUFWruqYq//y
         n5lthOQZI+WEN6tZO5p9IABeCQ99GorrFBI2c=
Received: by 10.227.195.6 with SMTP id ea6mr7779402wbb.74.1301963525163; Mon,
 04 Apr 2011 17:32:05 -0700 (PDT)
Received: by 10.227.147.16 with HTTP; Mon, 4 Apr 2011 17:32:05 -0700 (PDT)
In-Reply-To: <7v7hbbcfoj.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170851>

On Sun, Apr 3, 2011 at 2:12 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Dan McGee <dpmcgee@gmail.com> writes:
>
>> diff --git a/color.h b/color.h
>> index c0528cf..a7da793 100644
>> --- a/color.h
>> +++ b/color.h
>> @@ -53,6 +53,10 @@ struct strbuf;
>> =C2=A0 */
>> =C2=A0extern int git_use_color_default;
>>
>> +extern const char *column_colors_ansi[13];
>> +
>> +/* Ignore the RESET at the end when giving the size */
>> +#define COLUMN_COLORS_ANSI_MAX (ARRAY_SIZE(column_colors_ansi) - 1)
>
> Sneaky.
>
> I first went "Huh? -- this array-size macro cannot work", expecting t=
hat
> the array is not decleared with a fixed size in the header.
>
> It may make sense to unify these two palettes whose slot assignment d=
oes
> not have any meaning, but it feels that the above change totally goes
> against the spirit of using ARRAY_SIZE() macro, the point of which is=
 to
> liberate programmers from having to count and adjust the size when ad=
ding
> the contents to the array.
>
> Wouldn't it make more sense to do something like
>
> =C2=A0 =C2=A0>>> in the header <<<
> =C2=A0 =C2=A0extern const char *custom_colors_ansi[];
> =C2=A0 =C2=A0extern const int CUSTOM_COLORS_ANSI_MAX;
>
> =C2=A0 =C2=A0>>> in the code <<<
> =C2=A0 =C2=A0const char *custom_colors_ansi[] =3D {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0... as before ...
> =C2=A0 =C2=A0};
> =C2=A0 =C2=A0/* Does not count the last element "RESET" */
> =C2=A0 =C2=A0const int CUSTOM_COLORS_ANSI_MAX =3D ARRAY_SIZE(custom_c=
olors_ansi) - 1;
>
> to avoid mistakes?

Duh. This makes way more sense, I'll resend the patch with the
necessary changes; I couldn't think of an elegant way to do it at the
time.

On another note, we also have this whole crazy "- 1" bit and the RESET
element at the end, and yet I see nowhere that slot is actually used.
It looks like this was introduced by commit 1e3d4119d21df28.

-Dan
