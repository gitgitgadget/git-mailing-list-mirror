From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [BUG] Possible bug in `remote set-url --add --push`
Date: Mon, 14 Jan 2013 14:07:34 +0100
Message-ID: <50F40316.7010308@drmicha.warpmail.net>
References: <CAN8TAOsnX1Mr72LPa47KKXDeUZPgSHTJ6u4YpPFPrtsK7VdN+A@mail.gmail.com> <7vliby98r7.fsf@alter.siamese.dyndns.org> <4836187.09xoy3kJnj@blacky> <CAN8TAOv0Cm8CgiJSweFtRzOqO78OtNKa4G+x7z6M5Bt+odUmiQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sascha Cunz <sascha-ml@babbelbox.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jardel Weyrich <jweyrich@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 14 14:08:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tujlc-0004AU-Kf
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jan 2013 14:07:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756106Ab3ANNHf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Jan 2013 08:07:35 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:46046 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752518Ab3ANNHe (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Jan 2013 08:07:34 -0500
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 1057420CE5;
	Mon, 14 Jan 2013 08:07:34 -0500 (EST)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute6.internal (MEProxy); Mon, 14 Jan 2013 08:07:34 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=t2k9d5VAp3q/4SNp2t7MUp
	O1R3I=; b=GBI0dQdfpzDESFZo4fyAiYUrO3I71Po4xUnlzdxGP/avSX5yHLwhH6
	r02Dpjt+LzrhQcoC8k5Y5/muEL1gQW7+gpz/EBBynmxOjiltiw/qyeILAYr5qu68
	paQtSpMI/HZtH+rpTYRrVHQfnCuzr9AUtjx5kp2P5DNXkwgLad6KY=
X-Sasl-enc: i2ZVAPgkRBObu/sXPdGbOEFZh1BWFU1hQTHCYTrdYquY 1358168853
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 4FCC38E07DA;
	Mon, 14 Jan 2013 08:07:33 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130110 Thunderbird/17.0.2
In-Reply-To: <CAN8TAOv0Cm8CgiJSweFtRzOqO78OtNKa4G+x7z6M5Bt+odUmiQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213487>

Jardel Weyrich venit, vidit, dixit 12.01.2013 10:33:
> On Sat, Jan 12, 2013 at 6:44 AM, Sascha Cunz <sascha-ml@babbelbox.org=
> wrote:
>> Am Freitag, 11. Januar 2013, 23:10:36 schrieb Junio C Hamano:
>>> Jardel Weyrich <jweyrich@gmail.com> writes:
>>>> I believe `remote set-url --add --push` has a bug. Performed tests
>>>> with v1.8.0.1 and v1.8.1 (Mac OS X).
>>>>
>>>> Quoting the relevant part of the documentation:
>>>>> set-url
>>>>>
>>>>>     Changes URL remote points to. Sets first URL remote points to
>>>>>     matching regex <oldurl> (first URL if no <oldurl> is given) t=
o
>>>>>     <newurl>. If <oldurl> doesn=E2=80=99t match any URL, error oc=
curs and
>>>>>     nothing is changed.
>>>>>
>>>>>     With --push, push URLs are manipulated instead of fetch URLs.
>>>>>     With --add, instead of changing some URL, new URL is added.
>>>>>     With --delete, instead of changing some URL, all URLs matchin=
g regex
>>>>>     <url> are deleted. Trying to delete all non-push URLs is an e=
rror.>
>>>> Here are some steps to reproduce:
>>>>
>>>> 1. Show the remote URLs
>>>>
>>>> jweyrich@pharao:test_clone1 [* master]$ git remote -v
>>>> origin  /Volumes/sandbox/test (fetch)
>>>> origin  /Volumes/sandbox/test (push)
>>>>
>>>> 2. Add a new push URL for origin
>>>>
>>>> jweyrich@pharao:test_clone1 [* master]$ git remote set-url --add -=
-push
>>>> origin \>
>>>>     /Volumes/sandbox/test_clone2
>>>>
>>>> 3. Check what happened
>>>>
>>>> jweyrich@pharao:test_clone1 [* master]$ git remote -v
>>>> origin  /Volumes/sandbox/test (fetch)
>>>> origin  /Volumes/sandbox/test_clone2 (push)
>>>
>>> The original pushurl was replaced with the additional one, instead
>>> of being left and the new one getting added.  That looks certainly
>>> wrong.
>>>
>>> However, the result of applying the attached patch (either to
>>> v1.7.12 or v1.8.1) still passes the test and I do not think it is
>>> doing anything differently from what you described above.
>>>
>>> What do you get from
>>>
>>>       git config -l | grep '^remote\.origin'
>>>
>>> in steps 1. and 3. in your procedure?  This question is trying to
>>> tell if your bug is in "git remote -v" or in "git remote set-url".
>>
>> I'm not sure, if there is a bug at all. According to man git-push:
>>
>>         The <pushurl> is used for pushes only. It is optional and de=
faults to
>>    <url>.
>>         (From the section REMOTES -> Named remote in configuration f=
ile)
>>
>> the command:
>>     git remote add foo git@foo-fetch.org/some.git
>>
>> will set "remote.foo.url" to "git@foo-fetch.org". Subsequently, fetc=
h and push
>> will use git@foo-fetch.org as url.
>> Fetch will use this url, because "remote.foo.url" explicitly sets th=
is. push
>> will use it in absence of a "remote.foo.pushurl".
>>
>> Now, we're adding a push-url:
>>     git remote set-url --add --push foo git@foo-push.org/some.git
>>
>> Relevant parts of config are now looking like:
>>         [remote "foo"]
>>         url =3D git@foo-fetch.org/some.git
>>         pushurl =3D git@foo-push.org/some.git
>>
>> Since, pushurl is now given explicitly, git push will use that one (=
and only
>> that one).
>>
>> If we add another push-url now,
>>     git remote set-url --add --push foo git@foo-push-also.org/some.g=
it
>>
>> the next git-push will push to foo-push.org and foo-push-also.org.
>>
>> Now, using --set-url --delete on both of these urls restores the ori=
ginal
>> state: only "remote.foo.url" is set; meaning implicitly pushurl defa=
ults to
>> url again.
>>
>> To me this is exactly what Jardel was observing:
>>
>>> In step 2, Git replaced the original push URL instead of adding a n=
ew
>>> one. But it seems to happen only the first time I use `remote set-u=
rl
>>> --add --push`. Re-adding the original URL using the same command se=
ems
>>> to work properly.
>>
>>> And FWIW, if I delete (with "set-url --delete") both URLs push, Git
>>> restores the original URL.
>>
>> Or am I missing something here?
>=20
> You're right. However, as I quoted earlier, the git-remote man-page s=
tates:
>=20
>        set-url
>            Changes URL remote points to. <suppressed>
>            With --push, push URLs are manipulated instead of fetch UR=
Ls.
>            With --add, instead of changing some URL, new URL is added=
=2E
>=20
> It explicitly mentions that it should **add a new URL**.
> So when I do `git remote set-url --add --push origin
> git://another/repo.git`, I expect git-push to use both the default
> push URL and the new one. Or am I misinterpreting the man-page?
>=20
>>
>> Might be that the "bug" actually is that the expectation was
>>
>>         git remote add foo git@foo-fetch.org/some.git
>>
>> should have created a config like:
>>
>>         [remote "foo"]
>>         url =3D git@foo-fetch.org/some.git
>>         pushurl =3D git@foo-fetch.org/some.git
>>
>> since that is what "git remote -v" reports.
>>
>> If that is the case, we might want to amend the output of 'git remot=
e -v' with
>> the information that a pushurl is not explicitly given and thus defa=
ults to
>> url.
>=20
> Correct. Adding a remote doesn't automatically generate a pushurl for=
 it.
>=20
> To me, it seems that git-push checks for the existence of pushurl's i=
n
> the config, and if it finds any, it ignores the defaul push URL durin=
g
> the actual push. In better words, it pushes only to pushurls, if it
> finds any, otherwise it pushes to the default URL.
>=20
> To comply with the statements in the git-remote man-page, git-remote
> should add a pushurl configuration containing the default push URL,
> along with the one passed to `set-url --add --push`. Or git-push
> should _not ignore_ the default URL in the presence of pushurls,
> effectively pushing to both. These are the solutions I can think of
> right now, supposing I'm correct about the cause(s).
>=20
>>
>> Sascha

All that "set-url --push --add" does is adding a remote.foo.pushurl
entry to the config. If there was none, there will be one after that.

If there is no pushurl entry, "push" takes the url entry instead. This
is the "default URL for push", but not a pushurl entry.

It seems to me that everything works as designed, and that the man page
talk about "push URLs" can be read in two ways, one of which is correct
(and which is obvious if you know the above, i.e. the "config
background") and one of which is incorrect (and which may be obvious if
you read just that man page paragraph).

Michael
