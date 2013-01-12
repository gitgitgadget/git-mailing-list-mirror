From: Jardel Weyrich <jweyrich@gmail.com>
Subject: Re: [BUG] Possible bug in `remote set-url --add --push`
Date: Sat, 12 Jan 2013 07:33:22 -0200
Message-ID: <CAN8TAOv0Cm8CgiJSweFtRzOqO78OtNKa4G+x7z6M5Bt+odUmiQ@mail.gmail.com>
References: <CAN8TAOsnX1Mr72LPa47KKXDeUZPgSHTJ6u4YpPFPrtsK7VdN+A@mail.gmail.com>
 <7vliby98r7.fsf@alter.siamese.dyndns.org> <4836187.09xoy3kJnj@blacky>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Sascha Cunz <sascha-ml@babbelbox.org>
X-From: git-owner@vger.kernel.org Sat Jan 12 10:34:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TtxU0-0007Nw-DH
	for gcvg-git-2@plane.gmane.org; Sat, 12 Jan 2013 10:34:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752671Ab3ALJeG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 12 Jan 2013 04:34:06 -0500
Received: from mail-we0-f171.google.com ([74.125.82.171]:46003 "EHLO
	mail-we0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752417Ab3ALJeE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 Jan 2013 04:34:04 -0500
Received: by mail-we0-f171.google.com with SMTP id u3so1199744wey.2
        for <git@vger.kernel.org>; Sat, 12 Jan 2013 01:34:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=OJMi89ei0OCgIypdlOY2ALYjIJMREZUlrwFveXV4PMo=;
        b=gsCv4H8CvKlkDpRtFV0RB5quYhx/BAXoMX6pmdoF0+28rDaajTqqyTi9tUh1n2LrKP
         NFDeQ/txQflor3SkzoKlfwaa8DbPpOfOvJaDY8vaQ8i5IjjyTAxOo2RvPAySvcY0T+gh
         ESWCIhtbTN5PfcAL8LwOlOpXFCR6C/Aqr/LQmhLSXW1sjSk7EJQREGjLZQgo9lAvTzj6
         j1pLC4HevQ0dqSEsw+/iP0FEL8X9zNVw8YiW00jjAtrVK9Ru8nICnAzOIcsKT0tAOAxi
         kvvIqDf7aOEfsMVt1Lig051wKKjFACaQq+3M8bBzOtJUcd4iogsXig4Aiko12zidehTg
         7FWQ==
X-Received: by 10.180.33.44 with SMTP id o12mr3140565wii.28.1357983242293;
 Sat, 12 Jan 2013 01:34:02 -0800 (PST)
Received: by 10.194.118.167 with HTTP; Sat, 12 Jan 2013 01:33:22 -0800 (PST)
In-Reply-To: <4836187.09xoy3kJnj@blacky>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213279>

On Sat, Jan 12, 2013 at 6:44 AM, Sascha Cunz <sascha-ml@babbelbox.org> =
wrote:
> Am Freitag, 11. Januar 2013, 23:10:36 schrieb Junio C Hamano:
>> Jardel Weyrich <jweyrich@gmail.com> writes:
>> > I believe `remote set-url --add --push` has a bug. Performed tests
>> > with v1.8.0.1 and v1.8.1 (Mac OS X).
>> >
>> > Quoting the relevant part of the documentation:
>> >> set-url
>> >>
>> >>     Changes URL remote points to. Sets first URL remote points to
>> >>     matching regex <oldurl> (first URL if no <oldurl> is given) t=
o
>> >>     <newurl>. If <oldurl> doesn=E2=80=99t match any URL, error oc=
curs and
>> >>     nothing is changed.
>> >>
>> >>     With --push, push URLs are manipulated instead of fetch URLs.
>> >>     With --add, instead of changing some URL, new URL is added.
>> >>     With --delete, instead of changing some URL, all URLs matchin=
g regex
>> >>     <url> are deleted. Trying to delete all non-push URLs is an e=
rror.>
>> > Here are some steps to reproduce:
>> >
>> > 1. Show the remote URLs
>> >
>> > jweyrich@pharao:test_clone1 [* master]$ git remote -v
>> > origin  /Volumes/sandbox/test (fetch)
>> > origin  /Volumes/sandbox/test (push)
>> >
>> > 2. Add a new push URL for origin
>> >
>> > jweyrich@pharao:test_clone1 [* master]$ git remote set-url --add -=
-push
>> > origin \>
>> >     /Volumes/sandbox/test_clone2
>> >
>> > 3. Check what happened
>> >
>> > jweyrich@pharao:test_clone1 [* master]$ git remote -v
>> > origin  /Volumes/sandbox/test (fetch)
>> > origin  /Volumes/sandbox/test_clone2 (push)
>>
>> The original pushurl was replaced with the additional one, instead
>> of being left and the new one getting added.  That looks certainly
>> wrong.
>>
>> However, the result of applying the attached patch (either to
>> v1.7.12 or v1.8.1) still passes the test and I do not think it is
>> doing anything differently from what you described above.
>>
>> What do you get from
>>
>>       git config -l | grep '^remote\.origin'
>>
>> in steps 1. and 3. in your procedure?  This question is trying to
>> tell if your bug is in "git remote -v" or in "git remote set-url".
>
> I'm not sure, if there is a bug at all. According to man git-push:
>
>         The <pushurl> is used for pushes only. It is optional and def=
aults to
>    <url>.
>         (From the section REMOTES -> Named remote in configuration fi=
le)
>
> the command:
>     git remote add foo git@foo-fetch.org/some.git
>
> will set "remote.foo.url" to "git@foo-fetch.org". Subsequently, fetch=
 and push
> will use git@foo-fetch.org as url.
> Fetch will use this url, because "remote.foo.url" explicitly sets thi=
s. push
> will use it in absence of a "remote.foo.pushurl".
>
> Now, we're adding a push-url:
>     git remote set-url --add --push foo git@foo-push.org/some.git
>
> Relevant parts of config are now looking like:
>         [remote "foo"]
>         url =3D git@foo-fetch.org/some.git
>         pushurl =3D git@foo-push.org/some.git
>
> Since, pushurl is now given explicitly, git push will use that one (a=
nd only
> that one).
>
> If we add another push-url now,
>     git remote set-url --add --push foo git@foo-push-also.org/some.gi=
t
>
> the next git-push will push to foo-push.org and foo-push-also.org.
>
> Now, using --set-url --delete on both of these urls restores the orig=
inal
> state: only "remote.foo.url" is set; meaning implicitly pushurl defau=
lts to
> url again.
>
> To me this is exactly what Jardel was observing:
>
>> In step 2, Git replaced the original push URL instead of adding a ne=
w
>> one. But it seems to happen only the first time I use `remote set-ur=
l
>> --add --push`. Re-adding the original URL using the same command see=
ms
>> to work properly.
>
>> And FWIW, if I delete (with "set-url --delete") both URLs push, Git
>> restores the original URL.
>
> Or am I missing something here?

You're right. However, as I quoted earlier, the git-remote man-page sta=
tes:

       set-url
           Changes URL remote points to. <suppressed>
           With --push, push URLs are manipulated instead of fetch URLs=
=2E
           With --add, instead of changing some URL, new URL is added.

It explicitly mentions that it should **add a new URL**.
So when I do `git remote set-url --add --push origin
git://another/repo.git`, I expect git-push to use both the default
push URL and the new one. Or am I misinterpreting the man-page?

>
> Might be that the "bug" actually is that the expectation was
>
>         git remote add foo git@foo-fetch.org/some.git
>
> should have created a config like:
>
>         [remote "foo"]
>         url =3D git@foo-fetch.org/some.git
>         pushurl =3D git@foo-fetch.org/some.git
>
> since that is what "git remote -v" reports.
>
> If that is the case, we might want to amend the output of 'git remote=
 -v' with
> the information that a pushurl is not explicitly given and thus defau=
lts to
> url.

Correct. Adding a remote doesn't automatically generate a pushurl for i=
t.

To me, it seems that git-push checks for the existence of pushurl's in
the config, and if it finds any, it ignores the defaul push URL during
the actual push. In better words, it pushes only to pushurls, if it
finds any, otherwise it pushes to the default URL.

To comply with the statements in the git-remote man-page, git-remote
should add a pushurl configuration containing the default push URL,
along with the one passed to `set-url --add --push`. Or git-push
should _not ignore_ the default URL in the presence of pushurls,
effectively pushing to both. These are the solutions I can think of
right now, supposing I'm correct about the cause(s).

>
> Sascha
