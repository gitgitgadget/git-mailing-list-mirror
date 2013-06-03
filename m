From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH v2 7/7] unpack-trees: free cache_entry array members for
 merges
Date: Mon, 03 Jun 2013 17:59:36 +0200
Message-ID: <51ACBD68.4070506@lsrfire.ath.cx>
References: <1370188017-24672-1-git-send-email-rene.scharfe@lsrfire.ath.cx> <1370188017-24672-8-git-send-email-rene.scharfe@lsrfire.ath.cx> <CAMP44s2ym5UEPo8kr6YKf1x_P_0L+o_9vWdCTA6MPDQsRy7d1A@mail.gmail.com> <51AB86BB.3080203@lsrfire.ath.cx> <CAMP44s0Af90Sfi47_mxEGRFHAsAhaoO6T1jjbj7SptucNO-k0w@mail.gmail.com> <51ABAA84.8090301@lsrfire.ath.cx> <CAMP44s3cqa-jETHX+ftbAVMx+oV6PMcVkdH63P93ER-4fH28Hw@mail.gmail.com> <51ABD00C.7080503@lsrfire.ath.cx> <CAMP44s2+Hx-6E7DkmWL_m92jDt5-Cj8FGHpACBZcqp1sn5Tfzw@mail.gmail.com> <51ABD99A.2030303@lsrfire.ath.cx> <CAMP44s2HotyK7hh0nFjCe+BBtu1pyqmkn6=yt9WV6UyhxjrXoQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>,
	Junio C Hamano <gitster@pobox.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 03 18:00:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjXAr-0004Kq-Mq
	for gcvg-git-2@plane.gmane.org; Mon, 03 Jun 2013 17:59:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759180Ab3FCP7x convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 Jun 2013 11:59:53 -0400
Received: from india601.server4you.de ([85.25.151.105]:58259 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759138Ab3FCP7r (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Jun 2013 11:59:47 -0400
Received: from [192.168.2.105] (p579BEDD3.dip0.t-ipconnect.de [87.155.237.211])
	by india601.server4you.de (Postfix) with ESMTPSA id 52F6C1FD;
	Mon,  3 Jun 2013 17:59:45 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.2; WOW64; rv:17.0) Gecko/20130509 Thunderbird/17.0.6
In-Reply-To: <CAMP44s2HotyK7hh0nFjCe+BBtu1pyqmkn6=yt9WV6UyhxjrXoQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226226>

Am 03.06.2013 02:04, schrieb Felipe Contreras:
> On Sun, Jun 2, 2013 at 6:47 PM, Ren=C3=A9 Scharfe
> <rene.scharfe@lsrfire.ath.cx> wrote:
>> Am 03.06.2013 01:23, schrieb Felipe Contreras:
>>
>>> I didn't say we should do 'if (ce) free(ce);' instead of 'free(ce);=
' I
>>> said we should do 'if (cd && ce !=3D o->df_conflict_entry)' instead=
 of
>>> 'if (ce !=3D o->df_conflict_entry)'.
>>
>>
>> I did assume you meant the latter.
>>
>>
>>> There's no reason not to.
>>
>>
>> Only the minor ones already mentioned: More text,
>
> Five characters.
>
>> one more branch in object
>> code,
>
> Which might actually be more optimal.

The difference in absolute numbers will most certainly be within the=20
noise for this one case.

>> no benefit except for some hypothetical future case that's caught by
>> the test suite anyway -- or by code review.
>
> That's not the benefit, the benefit is that the code is clearer.

I don't see that, and I don't like adding a check that I don't expect t=
o=20
be ever needed.  Users are safe because the test suite is going to catc=
h=20
a missing check.

In general, I think those who introduce dependencies should add the=20
necessary checks.  They have to consider the invariants anyway, no=20
matter how many checks you add beforehand for their convenience.

>> I wonder if we already reached the point where we spent more time di=
scussing
>> this change than the time needed by the envisioned developer to find=
 and fix
>> the NULL check that suddenly became necessary. :)
>
> Maybe, but if what you want is to avoid the discussion, you could jus=
t
> add the extra five characters and be done with it.

Or you could submit a patch on top that adds the check.  I'd send it ou=
t=20
if you'd supply a commit message.  My review comment would be "mostly=20
harmless, but I don't like it very much because it's not needed now and=
=20
probably won't ever".

But I'm more interested in a different way forward: Would it make sense=
=20
to push the allocations (and frees) into the merge functions?  Currentl=
y=20
they duplicate one of the cache entries.  Would the merge functions=20
become too ugly or too big if they'd have to build them themselves,=20
avoiding duplication?  Would it be significantly faster?

Ren=C3=A9
