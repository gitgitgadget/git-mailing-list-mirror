From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 7/7] unpack-trees: free cache_entry array members for merges
Date: Mon, 3 Jun 2013 11:10:05 -0500
Message-ID: <CAMP44s09s26Gyvqu___cQg2LsUnMrzZAa0pbUnGp85fDUEeapg@mail.gmail.com>
References: <1370188017-24672-1-git-send-email-rene.scharfe@lsrfire.ath.cx>
	<1370188017-24672-8-git-send-email-rene.scharfe@lsrfire.ath.cx>
	<CAMP44s2ym5UEPo8kr6YKf1x_P_0L+o_9vWdCTA6MPDQsRy7d1A@mail.gmail.com>
	<51AB86BB.3080203@lsrfire.ath.cx>
	<CAMP44s0Af90Sfi47_mxEGRFHAsAhaoO6T1jjbj7SptucNO-k0w@mail.gmail.com>
	<51ABAA84.8090301@lsrfire.ath.cx>
	<CAMP44s3cqa-jETHX+ftbAVMx+oV6PMcVkdH63P93ER-4fH28Hw@mail.gmail.com>
	<51ABD00C.7080503@lsrfire.ath.cx>
	<CAMP44s2+Hx-6E7DkmWL_m92jDt5-Cj8FGHpACBZcqp1sn5Tfzw@mail.gmail.com>
	<51ABD99A.2030303@lsrfire.ath.cx>
	<CAMP44s2HotyK7hh0nFjCe+BBtu1pyqmkn6=yt9WV6UyhxjrXoQ@mail.gmail.com>
	<51ACBD68.4070506@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>,
	Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Mon Jun 03 18:10:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjXKn-0002Dy-9F
	for gcvg-git-2@plane.gmane.org; Mon, 03 Jun 2013 18:10:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759049Ab3FCQKJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 Jun 2013 12:10:09 -0400
Received: from mail-lb0-f170.google.com ([209.85.217.170]:46193 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756567Ab3FCQKH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Jun 2013 12:10:07 -0400
Received: by mail-lb0-f170.google.com with SMTP id t11so1283679lbd.1
        for <git@vger.kernel.org>; Mon, 03 Jun 2013 09:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=e+VqT4kzhoP4eCngt412er1f05HntmcO8GRN4/ygu1E=;
        b=cp79eKyJa6mxMvGzRzoctan3765dfkrI5XpSTVmIIo/TTI8VzLqOs/Un09+TNwvXfg
         mrj4kwYHqLn6Je+ZaqzB/Q83DF/3GIsnZwNDAdPVx2E3xr57/pVQ2VIkzP1BtfTxV9TK
         b1tfLnQkAURVBDTSIIEqw+MrGUNHrkI7DCqQLNCUUcReUGfW+6DUDxoSc6Q+YNa4ed8E
         ZmQmlZMvhBdxZjMt8HeZBuIkByFrF3uA5ZckAKn86WairQq6nFjnOiaK9Aplr1ArlgqK
         7yap2MVwS+vEuJrVhpIZDJDqIuZ7DaHHPsKtcOa6tyetKAtHCDGpFXOM5Jb2B2ep8OJ1
         bT6w==
X-Received: by 10.112.33.17 with SMTP id n17mr11070141lbi.72.1370275805671;
 Mon, 03 Jun 2013 09:10:05 -0700 (PDT)
Received: by 10.114.177.164 with HTTP; Mon, 3 Jun 2013 09:10:05 -0700 (PDT)
In-Reply-To: <51ACBD68.4070506@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226227>

On Mon, Jun 3, 2013 at 10:59 AM, Ren=C3=A9 Scharfe
<rene.scharfe@lsrfire.ath.cx> wrote:
> Am 03.06.2013 02:04, schrieb Felipe Contreras:
>>
>> On Sun, Jun 2, 2013 at 6:47 PM, Ren=C3=A9 Scharfe
>> <rene.scharfe@lsrfire.ath.cx> wrote:
>>>
>>> Am 03.06.2013 01:23, schrieb Felipe Contreras:
>>>
>>>> I didn't say we should do 'if (ce) free(ce);' instead of 'free(ce)=
;' I
>>>> said we should do 'if (cd && ce !=3D o->df_conflict_entry)' instea=
d of
>>>> 'if (ce !=3D o->df_conflict_entry)'.
>>>
>>>
>>>
>>> I did assume you meant the latter.
>>>
>>>
>>>> There's no reason not to.
>>>
>>>
>>>
>>> Only the minor ones already mentioned: More text,
>>
>>
>> Five characters.
>>
>>> one more branch in object
>>> code,
>>
>>
>> Which might actually be more optimal.
>
>
> The difference in absolute numbers will most certainly be within the =
noise
> for this one case.

If you want to ignore the performance, you should ignore the branch as =
well.

>>> no benefit except for some hypothetical future case that's caught b=
y
>>> the test suite anyway -- or by code review.
>>
>>
>> That's not the benefit, the benefit is that the code is clearer.
>
>
> I don't see that, and I don't like adding a check that I don't expect=
 to be
> ever needed.

It's called self-documenting code; by adding a check for the NULL
pointer, we are stating that ce can be NULL, if we don't do that,
people reading that code would need to figure that out themselves.

> Or you could submit a patch on top that adds the check.

I already sent a patch that has that check.

http://article.gmane.org/gmane.comp.version-control.git/225972

--=20
=46elipe Contreras
