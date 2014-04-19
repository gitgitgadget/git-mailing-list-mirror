From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] blame: add correct paddings in time_buf for align
Date: Sat, 19 Apr 2014 07:20:36 +0700
Message-ID: <CACsJy8AS6O2vNQ7FW0ur=49TSfCRourF53YvEpofMpC7ocMDDg@mail.gmail.com>
References: <43a3735a164c923acc8e6e2681dfbd727cda63de.1397810231.git.worldhello.net@gmail.com>
 <CACsJy8BTBwqFZUU3i3cuv40B6AHw5SRY9DZN2PoKL4XzgEL2eA@mail.gmail.com> <xmqqd2ged0qg.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Brian Gesiak <modocache@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 19 02:21:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WbJ1t-0001bN-JK
	for gcvg-git-2@plane.gmane.org; Sat, 19 Apr 2014 02:21:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753922AbaDSAVJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Apr 2014 20:21:09 -0400
Received: from mail-qa0-f41.google.com ([209.85.216.41]:41915 "EHLO
	mail-qa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753695AbaDSAVH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Apr 2014 20:21:07 -0400
Received: by mail-qa0-f41.google.com with SMTP id j5so2076549qaq.28
        for <git@vger.kernel.org>; Fri, 18 Apr 2014 17:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=M6OcTFSbH9uIxc97F68rWZ3w4wyDPYGYtcCu+BiB4oQ=;
        b=dCxrSWjimDR68LMKNVIfqC4rbAy6FtEjHIjNHR+JCnmbwkVP7VRuP2HME2N0Ajygs2
         dIWkau+HToYAtD3Pj5l+YRrgMG4xG3yyHorLjpT1oHaM6PVDF5Koi/P+NdfBtiptIMYP
         b+Z6y+woK//RLJu/36dpAW+/cEaLLxGPXVo0alLqB3VXATxgvTSxI7TeXeFZdtnZPWxt
         fr4hOqjOqxM61mBmpHaCJMF47va/M2hrMR1yd6wEmJwIvO9wskKIq4i858SuQ2teanX5
         EPwS9/T7zbKR5OzVp4baaKnHukhsj4zcNwpnwujC9IFP99xkM+KAZ40rpNxm2LRJWD4z
         THOw==
X-Received: by 10.224.114.76 with SMTP id d12mr21956749qaq.84.1397866866487;
 Fri, 18 Apr 2014 17:21:06 -0700 (PDT)
Received: by 10.96.138.9 with HTTP; Fri, 18 Apr 2014 17:20:36 -0700 (PDT)
In-Reply-To: <xmqqd2ged0qg.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246492>

On Sat, Apr 19, 2014 at 12:08 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Duy Nguyen <pclouds@gmail.com> writes:
>
>> On Fri, Apr 18, 2014 at 3:44 PM, Jiang Xin <worldhello.net@gmail.com=
> wrote:
>>> When show blame information with relative time, the UTF-8 character=
s in
>>> `time_str` will break the alignment of columns after the date field=
=2E
>>> This is because the `time_buf` padding with spaces should have a
>>> constant display width, not a fixed strlen size.  So we should call
>>> utf8_strwidth() instead of strlen() for calibration.
>>>
>>> Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
>>> ---
>>>
>>> Before applying this patch:
>>>
>>>         5817da01 builtin-blame.c   (Pierre Habouzit             6 =E5=
=B9=B4=E5=89=8D                         21) #include "parse-options.h"
>>>         ffaf9cc0 builtin-blame.c   (Geoffrey Thomas             5 =E5=
=B9=B4=E5=89=8D                         22) #include "utf8.h"
>>>         3b8a12e8 builtin/blame.c   (Axel Bonnet                 3 =E5=
=B9=B4 10 =E4=B8=AA=E6=9C=88=E4=B9=8B=E5=89=8D            23) #include =
"userdiff.h"
>>>         25ed3412 builtin/blame.c   (Bo Yang                     1 =E5=
=B9=B4 1 =E4=B8=AA=E6=9C=88=E4=B9=8B=E5=89=8D             24) #include =
"line-range.h"
>>>         58dbfa2e builtin/blame.c   (Eric Sunshine               9 =E4=
=B8=AA=E6=9C=88=E4=B9=8B=E5=89=8D                   25) #include "line-=
log.h"
>>>         cee7f245 builtin-pickaxe.c (Junio C Hamano              8 =E5=
=B9=B4=E5=89=8D                         26)
>>>
>>> After applying this patch:
>>>
>>>         5817da01 builtin-blame.c   (Pierre Habouzit             6 =E5=
=B9=B4=E5=89=8D                           21) #include "parse-options.h=
"
>>>         ffaf9cc0 builtin-blame.c   (Geoffrey Thomas             5 =E5=
=B9=B4=E5=89=8D                           22) #include "utf8.h"
>>>         3b8a12e8 builtin/blame.c   (Axel Bonnet                 3 =E5=
=B9=B4 10 =E4=B8=AA=E6=9C=88=E4=B9=8B=E5=89=8D                 23) #inc=
lude "userdiff.h"
>>>         25ed3412 builtin/blame.c   (Bo Yang                     1 =E5=
=B9=B4 1 =E4=B8=AA=E6=9C=88=E4=B9=8B=E5=89=8D                  24) #inc=
lude "line-range.h"
>>>         58dbfa2e builtin/blame.c   (Eric Sunshine               9 =E4=
=B8=AA=E6=9C=88=E4=B9=8B=E5=89=8D                       25) #include "l=
ine-log.h"
>>>         cee7f245 builtin-pickaxe.c (Junio C Hamano              8 =E5=
=B9=B4=E5=89=8D                           26)
>>
>>
>> The numbers 21..26 still do not look aligned, both in gmail raw
>> message view and gmane.
>
> Interesting.  In my GNUS/Emacs on a fixed-column terminal where an
> CJK occupies two display columns, they do look aligned, but in my
> Chrome showing news.gmane.org/gmane.comp.version-control.git/, they
> do look jagged.  When these lines shown in the browser get copied
> and pasted to gedit, they still look jagged, but after saving it to
> a file and catting it to the same fixed-column terminal, they are
> perfectly aligned.
>
> Font issues, I guess?

Emacs/x11, gedit and xterm all show aligned listings. So yes probably
font issues. And because it works fine in text-based environment or
editors. I think we're good.
--=20
Duy
