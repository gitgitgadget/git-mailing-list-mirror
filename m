From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH/RFC][GSoC] make "git diff --no-index $directory $file"
 DWIM better.
Date: Sun, 15 Mar 2015 17:28:43 -0400
Message-ID: <CAPig+cRFCktpG2ksNnRZiFxDqmQnq38MafkA1E-LC6CHtcuk9g@mail.gmail.com>
References: <CAHLaBN+93mp6PQmtfjOHSvfW7iwDXwPitGQ5W1am9KBm9EZV2Q@mail.gmail.com>
	<CAPig+cQgvwd=5hLGeOpY1r_476HbpUarumsu_QDU4HwB7ynXmw@mail.gmail.com>
	<CAHLaBN+RVpDrG9OewUS7LCYaEOvVqsTY3znapgMj7VrMJWHaDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: Yurii Shevtsov <ungetch@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 15 22:28:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YXG5Z-0000X8-VD
	for gcvg-git-2@plane.gmane.org; Sun, 15 Mar 2015 22:28:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751430AbbCOV2p convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 Mar 2015 17:28:45 -0400
Received: from mail-yh0-f41.google.com ([209.85.213.41]:34842 "EHLO
	mail-yh0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751166AbbCOV2o convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Mar 2015 17:28:44 -0400
Received: by yhct68 with SMTP id t68so11548904yhc.2
        for <git@vger.kernel.org>; Sun, 15 Mar 2015 14:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=KAXarSQZr+bx50nfrH6XjM1jqJ610Qts56fFDx2HP14=;
        b=wcLKcv90nRTXPJfwQi8yAwQW39ynKf2s06mdPPaFteiRtp3hZC+v/q/DAcg2awpYjR
         GXqEkIJfW1ocAhygufGvtDBKC6/PJyPhj3cqMGr5X8A64BDLpum+ASEAW31A0bHhBLO5
         HRPE8fKJxTyTwvvo1z+vEG9UVHTQjJCBIIHMJNV9UpgzafzMHmY+4ChTOBpsZ1yDoyVZ
         PyfcPAZ9T0hhaR1outZBrhPhnQ75zF1YDULAbiHiQdc7WK8pAsj0dYtYYzE7/mc03ToQ
         QoiURhLkaEjFEMFugCTLQoYXLsxmZsI6cfXKqVEV3VVfvARcZ3ptbJe0PtUeU+L68r2D
         y7mA==
X-Received: by 10.236.105.210 with SMTP id k58mr57726869yhg.52.1426454923449;
 Sun, 15 Mar 2015 14:28:43 -0700 (PDT)
Received: by 10.170.73.7 with HTTP; Sun, 15 Mar 2015 14:28:43 -0700 (PDT)
In-Reply-To: <CAHLaBN+RVpDrG9OewUS7LCYaEOvVqsTY3znapgMj7VrMJWHaDw@mail.gmail.com>
X-Google-Sender-Auth: MZ0kCj7ysBzFxlFfv-2OGbnKwAs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265526>

[re-adding cc:git]

On Sun, Mar 15, 2015 at 2:45 PM, Yurii Shevtsov <ungetch@gmail.com> wro=
te:
>> On Sun, Mar 15, 2015 at 11:35 AM, Yurii Shevtsov <ungetch@gmail.com>=
 wrote:
>>> make "git diff --no-index $directory $file" DWIM better.
>>
>> Specify the area affected by the change, followed by a colon, follow=
ed
>> by the change summary. Drop the period at the end. So, something lik=
e:
>>
>>     diff: improve '--no-index <directory> <file>' DWIMing
>>
>>> Changes 'git diff --no-index $directory $file' behaviour.
>>> Now it is transformed to 'git diff --no-index $directory/&file $fil=
e'
>>> instead of throwing an error.
>>
>> Write in imperative mood, so "Change" rather than "Changes". By
>> itself, the first sentence isn't saying much; it would read better i=
f
>> you combined the two sentences into one.
>
> Got it! My commit message requires improvements
>>> ---
>>> -       if (mode1 && mode2 && S_ISDIR(mode1) !=3D S_ISDIR(mode2))
>>> -               return error("file/directory conflict: %s, %s", nam=
e1, name2);
>>> +       if (mode1 && mode2 && S_ISDIR(mode1) !=3D S_ISDIR(mode2)) {
>>> +               struct strbuf dirnfile;
>>
>> Is this name supposed to stand for "dir'n'file", a shorthand for
>> "dir-and-file"? Perhaps a simpler more idiomatic name such as "path"
>> would suffice. Also, you can initialize the strbuf here at point of
>> declaration:
>>
>>     struct strbuf path =3D STRBUF_INIT;
>
> Yes it is supposed to be "dir-and-file" I thought "path" isn't
> descriptive enough because it could be path to dir. But if you insist=
,
> no problems

The reason I asked was because it is not uncommon for variable names
with an 'n' suffix to mean "length" of something, so the 'n' in 'dirn'
was a bit confusing. I personally find the idiomatic name 'path'
easier to grok, however, Junio, of course, has final say-so. It's okay
to argue for your choice in naming if you feel strongly that it is
better.

>>> +               const char *dir, *file;
>>> +               char *filename;
>>> +               int ret =3D 0;
>>> +
>>> +               dir =3D S_ISDIR(mode1) ? name1 : name2;
>>> +               file =3D (dir =3D=3D name1) ? name2 : name1;
>>> +               strbuf_init(&dirnfile, strlen(name1) + strlen(name2=
) + 2);
>>
>> Unless this is a performance critical loop where you want to avoid
>> multiple re-allocations, it's customary to pass 0 for the second
>> argument. Doing so makes the code a bit easier to read and understan=
d,
>> and avoids questions like this one: Why are you adding 2 to the
>> requested length? I presume that you're taking the "/" and NUL into
>> account, however, strbuf takes NUL into account on its own as part o=
f
>> its contract, so you probably wanted to add only 1.
>
> Yes I thought about performance. I thought it is reasonable since I
> always know size of resulting string. Checked strbuf.c one more time,
> yo=D0=B3 are right I should really add only 1

A few reasons I probably would just pass 0 in this case: (1) this
string construction is not performance critical; (2) a person reading
the code has to spend extra time double-checking the math; (3) the
math may become outdated if someone later alters the string
construction in some way, thus it's a potential maintenance burden;
(4) terser code tends to be easier to read and understand at a glance,
so the less verbose the code, the better.

However, as usual, it's entirely acceptable to argue for your version
if you feel strongly about it.

>>> +               strbuf_addstr(&dirnfile, dir);
>>> +               if (dirnfile.buf[dirnfile.len - 1] !=3D '/')
>>
>> I don't know how others feel about it, but it makes me a bit
>> uncomfortable to see potential access of array item -1. I suppose, i=
n
>> this case, neither name will be zero-length, however, I'd still feel
>> more comfortable seeing that documented formally, either via assert(=
):
>>
>>     assert(dirnfile.len > 0);
>>     if (dirnfile.buf[dirnfile.len - 1] !=3D '/')
>>
>> or:
>>
>>     if (dirnfile.len > 0 && dirnfile.buf[dirnfile.len - 1] !=3D '/')
>
> My fault again
