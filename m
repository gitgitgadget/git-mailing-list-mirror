From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH v2 7/7] unpack-trees: free cache_entry array members for
 merges
Date: Mon, 03 Jun 2013 01:06:52 +0200
Message-ID: <51ABD00C.7080503@lsrfire.ath.cx>
References: <1370188017-24672-1-git-send-email-rene.scharfe@lsrfire.ath.cx> <1370188017-24672-8-git-send-email-rene.scharfe@lsrfire.ath.cx> <CAMP44s2ym5UEPo8kr6YKf1x_P_0L+o_9vWdCTA6MPDQsRy7d1A@mail.gmail.com> <51AB86BB.3080203@lsrfire.ath.cx> <CAMP44s0Af90Sfi47_mxEGRFHAsAhaoO6T1jjbj7SptucNO-k0w@mail.gmail.com> <51ABAA84.8090301@lsrfire.ath.cx> <CAMP44s3cqa-jETHX+ftbAVMx+oV6PMcVkdH63P93ER-4fH28Hw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>,
	Junio C Hamano <gitster@pobox.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 03 01:07:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjHMd-0006DM-Hv
	for gcvg-git-2@plane.gmane.org; Mon, 03 Jun 2013 01:07:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755224Ab3FBXHA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 2 Jun 2013 19:07:00 -0400
Received: from india601.server4you.de ([85.25.151.105]:58189 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755029Ab3FBXG7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Jun 2013 19:06:59 -0400
Received: from [192.168.2.105] (p579BEDD3.dip0.t-ipconnect.de [87.155.237.211])
	by india601.server4you.de (Postfix) with ESMTPSA id 5400E1FF;
	Mon,  3 Jun 2013 01:06:57 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.2; WOW64; rv:17.0) Gecko/20130509 Thunderbird/17.0.6
In-Reply-To: <CAMP44s3cqa-jETHX+ftbAVMx+oV6PMcVkdH63P93ER-4fH28Hw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226192>

Am 03.06.2013 00:38, schrieb Felipe Contreras:
> On Sun, Jun 2, 2013 at 3:26 PM, Ren=C3=A9 Scharfe
> <rene.scharfe@lsrfire.ath.cx> wrote:
>> Am 02.06.2013 19:59, schrieb Felipe Contreras:
>>
>>> On Sun, Jun 2, 2013 at 12:54 PM, Ren=C3=A9 Scharfe
>>> <rene.scharfe@lsrfire.ath.cx> wrote:
>>>>
>>>> Am 02.06.2013 19:25, schrieb Felipe Contreras:
>>>>>
>>>>>
>>>>> On Sun, Jun 2, 2013 at 10:46 AM, Ren=C3=A9 Scharfe
>>>>> <rene.scharfe@lsrfire.ath.cx> wrote:
>>>>>>
>>>>>>
>>>>>> +               for (i =3D 0; i < n; i++) {
>>>>>> +                       struct cache_entry *ce =3D src[i + o->me=
rge];
>>>>>> +                       if (ce !=3D o->df_conflict_entry)
>>>>>
>>>>>
>>>>>
>>>>> It's possible that ce is NULL, but you didn't add that check beca=
use
>>>>> free(NULL) still works? Or because ce cannot be NULL?
>>>>>
>>>>> If it's the former, I think it's clearer if we check that ce is n=
ot
>>>>> NULL either way.
>>>>
>>>>
>>>>
>>>> It is NULL if one tree misses an entry (e.g. a new or removed file=
). free
>>>> handles NULL and we generally avoid duplicating its NULL-check.
>>>
>>>
>>> Yeah, but I can see somebody adding code inside that 'if' clause to
>>> print the cache entry, and see a crash only to wonder what's going =
on.
>>> And to save what? 5 characters?
>>
>>
>> The person adding code that depends on ce not being NULL needs to ad=
d that
>> check as well.  Let's not worry too much about future changes that m=
ay or
>> (more likely IMHO) may not be done.  The test suite covers this case
>> multiple times, so such a mistake doesn't have a realistic chance to=
 hit
>> master.
>
> What do we gain by not doing this? 5 less characters?

By following the convention of not checking for NULL when freeing, we=20
reduce the size of the code slightly and have one less branch=20
instruction in the object code.  That's not particularly exciting in a=20
single instance but makes a difference if followed throughout the code =
base.

What do we gain by adding a duplicate check?  A few minutes of debuggin=
g=20
time by the person who will add some code and forget the NULL check?=20
And how likely is that to happen?

Ren=C3=A9
