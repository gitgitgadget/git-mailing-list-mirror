From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 7/7] unpack-trees: free cache_entry array members for merges
Date: Sun, 2 Jun 2013 18:23:12 -0500
Message-ID: <CAMP44s2+Hx-6E7DkmWL_m92jDt5-Cj8FGHpACBZcqp1sn5Tfzw@mail.gmail.com>
References: <1370188017-24672-1-git-send-email-rene.scharfe@lsrfire.ath.cx>
	<1370188017-24672-8-git-send-email-rene.scharfe@lsrfire.ath.cx>
	<CAMP44s2ym5UEPo8kr6YKf1x_P_0L+o_9vWdCTA6MPDQsRy7d1A@mail.gmail.com>
	<51AB86BB.3080203@lsrfire.ath.cx>
	<CAMP44s0Af90Sfi47_mxEGRFHAsAhaoO6T1jjbj7SptucNO-k0w@mail.gmail.com>
	<51ABAA84.8090301@lsrfire.ath.cx>
	<CAMP44s3cqa-jETHX+ftbAVMx+oV6PMcVkdH63P93ER-4fH28Hw@mail.gmail.com>
	<51ABD00C.7080503@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>,
	Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Mon Jun 03 01:23:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjHcZ-00041b-OK
	for gcvg-git-2@plane.gmane.org; Mon, 03 Jun 2013 01:23:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755090Ab3FBXXP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 2 Jun 2013 19:23:15 -0400
Received: from mail-la0-f54.google.com ([209.85.215.54]:48053 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754841Ab3FBXXO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 Jun 2013 19:23:14 -0400
Received: by mail-la0-f54.google.com with SMTP id ec20so1697491lab.41
        for <git@vger.kernel.org>; Sun, 02 Jun 2013 16:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=HLUevNxpcilcRr6mBAUcWKvuJIzumkIjv/GqGSJhwwQ=;
        b=uCUsYNrF8EW3F6YVWkWSR8vZ3YVc6g+VCSbh2Lb6V88dg9NNddlqptqbdGSXEtpgdW
         CrnD84J2SBUXN02AVQ6f6ELVsHrpJ4jZKgol0dVNu9BKbesktHacwun4ymtpU4kB/uMk
         QvLkegvCXiE89JeokspjZzcbg7zqx98l1u+sQFPJF7j+X2b74DU0NFWD1wiZbz39znLI
         8UfW7VcQlgquKnAApvQTPxyUx408p68QMRyVTGApGoC8xoEQaESNkWzEsQtXScAHHcfQ
         lAtFWLPsGkVpuIgi8Sn6dIC8sF1CtqloHUp6W4iTvYklbFErbgbwUXIBTrV7a4UfNmH9
         gjPA==
X-Received: by 10.112.236.70 with SMTP id us6mr9445783lbc.121.1370215392353;
 Sun, 02 Jun 2013 16:23:12 -0700 (PDT)
Received: by 10.114.177.164 with HTTP; Sun, 2 Jun 2013 16:23:12 -0700 (PDT)
In-Reply-To: <51ABD00C.7080503@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226193>

On Sun, Jun 2, 2013 at 6:06 PM, Ren=C3=A9 Scharfe
<rene.scharfe@lsrfire.ath.cx> wrote:
> Am 03.06.2013 00:38, schrieb Felipe Contreras:
>
>> On Sun, Jun 2, 2013 at 3:26 PM, Ren=C3=A9 Scharfe
>> <rene.scharfe@lsrfire.ath.cx> wrote:
>>>
>>> Am 02.06.2013 19:59, schrieb Felipe Contreras:
>>>
>>>> On Sun, Jun 2, 2013 at 12:54 PM, Ren=C3=A9 Scharfe
>>>> <rene.scharfe@lsrfire.ath.cx> wrote:
>>>>>
>>>>>
>>>>> Am 02.06.2013 19:25, schrieb Felipe Contreras:
>>>>>>
>>>>>>
>>>>>>
>>>>>> On Sun, Jun 2, 2013 at 10:46 AM, Ren=C3=A9 Scharfe
>>>>>> <rene.scharfe@lsrfire.ath.cx> wrote:
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> +               for (i =3D 0; i < n; i++) {
>>>>>>> +                       struct cache_entry *ce =3D src[i + o->m=
erge];
>>>>>>> +                       if (ce !=3D o->df_conflict_entry)
>>>>>>
>>>>>>
>>>>>>
>>>>>>
>>>>>> It's possible that ce is NULL, but you didn't add that check bec=
ause
>>>>>> free(NULL) still works? Or because ce cannot be NULL?
>>>>>>
>>>>>> If it's the former, I think it's clearer if we check that ce is =
not
>>>>>> NULL either way.
>>>>>
>>>>>
>>>>>
>>>>>
>>>>> It is NULL if one tree misses an entry (e.g. a new or removed fil=
e).
>>>>> free
>>>>> handles NULL and we generally avoid duplicating its NULL-check.
>>>>
>>>>
>>>>
>>>> Yeah, but I can see somebody adding code inside that 'if' clause t=
o
>>>> print the cache entry, and see a crash only to wonder what's going=
 on.
>>>> And to save what? 5 characters?
>>>
>>>
>>>
>>> The person adding code that depends on ce not being NULL needs to a=
dd
>>> that
>>> check as well.  Let's not worry too much about future changes that =
may or
>>> (more likely IMHO) may not be done.  The test suite covers this cas=
e
>>> multiple times, so such a mistake doesn't have a realistic chance t=
o hit
>>> master.
>>
>>
>> What do we gain by not doing this? 5 less characters?
>
>
> By following the convention of not checking for NULL when freeing,

That's not what I asked.

I didn't say we should do 'if (ce) free(ce);' instead of 'free(ce);' I
said we should do 'if (cd && ce !=3D o->df_conflict_entry)' instead of
'if (ce !=3D o->df_conflict_entry)'.

There's no reason not to.

--=20
=46elipe Contreras
