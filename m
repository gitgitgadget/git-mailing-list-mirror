From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [RFC] i18n.pathencoding
Date: Wed, 05 Sep 2012 21:49:59 +0200
Message-ID: <5047ACE7.3050000@web.de>
References: <201209010811.33994.tboegi@web.de> <CACsJy8A1GnhTeMzwXwA1C96pp0ERskxZC=SO+QE2__pfwmChow@mail.gmail.com> <7vvcftbt8o.fsf@alter.siamese.dyndns.org> <CACsJy8ARmPwELFhdvu_Y2kZNbYNgTzoqLzriH2oB7WtxM8D7hg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1?= =?UTF-8?B?c2Vu?= 
	<tboegi@web.de>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 05 21:50:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9LcO-0007I9-JH
	for gcvg-git-2@plane.gmane.org; Wed, 05 Sep 2012 21:50:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759269Ab2IETuY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Sep 2012 15:50:24 -0400
Received: from mout.web.de ([212.227.17.12]:57624 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759255Ab2IETuE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2012 15:50:04 -0400
Received: from birne.lan ([195.67.191.22]) by smtp.web.de (mrweb002) with
 ESMTPA (Nemesis) id 0LpfFO-1TlAjh1OHW-00feqp; Wed, 05 Sep 2012 21:50:00 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:15.0) Gecko/20120824 Thunderbird/15.0
In-Reply-To: <CACsJy8ARmPwELFhdvu_Y2kZNbYNgTzoqLzriH2oB7WtxM8D7hg@mail.gmail.com>
X-Provags-ID: V02:K0:FkPyfrcWLyoZlHRMP9r7uAdIk1RhU0DZLkBeo9BMrrl
 znNmmkK+0DAjqmMI9OpSiwTgjqYj6GGLejcc2Cp/+P9Dm32wPu
 dz8TrFOHi6Ez1E2+y03AmjN0XndsqqkJqNqi82DcdJ9bXgrf9i
 TF8N7ZrzkaBAvxpg/pnfhto3VRuZA/I6fbZ7c5i3YSaWZuZw+X
 fPb4454wQLjE9vAlUM3Fg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204843>

On 05.09.12 13:11, Nguyen Thai Ngoc Duy wrote:
> On Wed, Sep 5, 2012 at 12:19 AM, Junio C Hamano <gitster@pobox.com> w=
rote:
>> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
>>> On Sat, Sep 1, 2012 at 1:11 PM, Torsten B=C3=B6gershausen <tboegi@w=
eb.de> wrote:
>>>> @@ -476,7 +476,7 @@ int parse_options(int argc, const char **argv,=
 const char *prefix,
>>>>                 usage_with_options(usagestr, options);
>>>>         }
>>>>
>>>> -       precompose_argv(argc, argv);
>>>> +       reencode_argv(argc, argv);
>>>>         return parse_options_end(&ctx);
>>>>  }
>>>
>>> If you have to re-encode command line arguments, what about paths
>>> coming --stdin or a file?
>>
>> That problem is inherited from the MacOS precompose topic this one
>> builds on.  Not that it is unimportant to fix, though.
>=20
> On fixing that. 76759c7 describes the change as:
>=20
>     The argv[] conversion allows to use the TAB filename completion d=
one
>     by the shell on command line.  It tolerates other tools which use
>     readdir() to feed decomposed file names into git.
>=20
> How come git's internal conversion helps TAB filename completion,
> which is done before git is executed?

Because the shell use readdir() itself when <TAB> is pressed

$echo B=C3=B6 > B=C3=B6
$echo Ba > Ba
$ls=20
Bo =CC=88
Ba

# The terminal program of Mac OS shows the decomposed "=C3=B6" correctl=
y,
"B=C3=B6" is shown as "B=C3=B6", while xterm shows "B=C3=B6" as "Bo =CC=
=88",
that is "o" followod by a "combining diaresis".

The shell seems to do the same:
to add B=C3=B6 to git,

$git add Bo<TAB>

needs to be used.
And as a result, the sheel will pass the "o" in decomposed unicode to g=
it,
which is corrected in precompose_argv().
