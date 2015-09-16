From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v2 2/2] git-p4: handle "Translation of file content failed"
Date: Wed, 16 Sep 2015 13:38:52 +0200
Message-ID: <C8BD1D98-21BB-420B-884E-79D0FC71D119@gmail.com>
References: <1442249728-89494-1-git-send-email-larsxschneider@gmail.com> <1442249728-89494-3-git-send-email-larsxschneider@gmail.com> <55F7BE2A.80609@diamand.org> <5FF97F9B-E2FB-4919-BCAF-5462ED9D1EEE@gmail.com> <55F897D0.9000100@diamand.org>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Wed Sep 16 13:39:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZcB3F-0002FJ-Lc
	for gcvg-git-2@plane.gmane.org; Wed, 16 Sep 2015 13:39:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753288AbbIPLi5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Sep 2015 07:38:57 -0400
Received: from mail-wi0-f177.google.com ([209.85.212.177]:32823 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752595AbbIPLi4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Sep 2015 07:38:56 -0400
Received: by wiclk2 with SMTP id lk2so68728596wic.0
        for <git@vger.kernel.org>; Wed, 16 Sep 2015 04:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Tz1wgmhlRCyhLSB+q4jwpL7zAyx56tPjhJ3H0sC8eQk=;
        b=MclwFqsprWEUh4JP5p8XiT7M2yUPs4dozpTKhiPE0F4Mf9HvFG3I+4aH4+fQ72sXBZ
         9Y4kBEVhqRsLSsyb0E0J66jfSHeSfPxlHPAJ7z8zmbEnStUAuwvAHTA2sK7WbdW7J6br
         lG/coMVtPe2eZ+MFC0itKjHmO98HDIAPJgkcTDpDYZHLtr+rMwYy9Uoe7v/eB7sdDVcM
         QM2OuMnPAPB0lWE2vVd1QnDafdEeSGN6Yoyjs3pLwG3m76kJzi0GmnqipZH6UFEnU/7/
         7EpGzDSL9AJKKesL+dGCpwSRj4Spn8Ferxnxus5/iYL1E0Oy3zAGUnxcTxaSNx3JoKi0
         rPlQ==
X-Received: by 10.180.92.225 with SMTP id cp1mr18194198wib.2.1442403534887;
        Wed, 16 Sep 2015 04:38:54 -0700 (PDT)
Received: from [10.146.248.71] ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id bq7sm26108518wjc.31.2015.09.16.04.38.54
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 16 Sep 2015 04:38:54 -0700 (PDT)
In-Reply-To: <55F897D0.9000100@diamand.org>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278022>


On 16 Sep 2015, at 00:12, Luke Diamand <luke@diamand.org> wrote:

> On 15/09/15 16:38, Lars Schneider wrote:
>>=20
>> On 15 Sep 2015, at 08:43, Luke Diamand <luke@diamand.org> wrote:
>>=20
>=20
>=20
>>> Do we know the mechanism by which we end up in this state?
>> Unfortunately no. I tried hard to reproduce the error with =93conven=
tional=94 methods. As you can see I ended up manipulating the P4 databa=
se=85
>>=20
>> However, it looks like this error happens in the wild, too:
>> https://stackoverflow.com/questions/5156909/translation-of-file-cont=
ent-failed-error-in-perforce
>> https://stackoverflow.com/questions/887006/perforce-translation-of-f=
ile-content-failed-error
>=20
> It's described in the Perforce FAQ here:
>=20
> http://answers.perforce.com/articles/KB/3117
>=20
> i.e. it looks to be caused by mixing old and new P4 clients.
Good find! No idea why I did not find this article before=85 I will cop=
y the text from the KB into the git commit message to explain the probl=
em.
=20
>=20
>>>>=20
>>>> Known issue: This works only if git-p4 is executed in verbose mode=
=2E
>>>> In normal mode no exceptions are thrown and git-p4 just exits.
>>>=20
>>> Does that mean that the error will only be detected in verbose mode=
? That doesn't seem right!
>> Correct. I don=92t like this either but I also don=92t want to make =
huge changes to git-p4.
>> You can see the root problem here:
>> https://github.com/git/git/blob/97d7ad75b6fe74960d2a12e4a9151a55a5a8=
7d6d/git-p4.py#L110-L114
>>=20
>> Any idea how to approach that best?
>=20
> I guess what we have is not ideal but probably good enough.
ok. thanks!

I will add another test case without =93=97verbose" to document that th=
ere is work to do :-)

>=20
>=20
>>>> +            try:
>>>> +                text =3D p4_read_pipe(['print', '-q', '-o', '-', =
'%s@%s' % (file['depotFile'], file['change'])])
>>>> +            except Exception as e:
>>>=20
>>> Would it be better to specify which kind of Exception you are catch=
ing? Looks like you could get OSError, ValueError and CalledProcessErro=
r; it's the last of these you want (I think).
>> I think it is just a plain exception. See here:
>> https://github.com/git/git/blob/97d7ad75b6fe74960d2a12e4a9151a55a5a8=
7d6d/git-p4.py#L111
>=20
> OK, you're right (probably less than ideal behaviour from read_pipe()=
 and die() but let's not try to fix that).
ok

>=20
>=20
>>>> +                if p4_version_string().find('/NT') >=3D 0:
>>>> +                    text =3D text.replace('\r\n', '\n')
>>>> +                contents =3D [ text ]
>>>=20
>>> The indentation on this bit doesn't look right to me.
>> I believe it is exactly how it was:
>> https://github.com/git/git/blob/97d7ad75b6fe74960d2a12e4a9151a55a5a8=
7d6d/git-p4.py#L2397-L2399
>=20
> OK.
>=20
>>=20
>>=20
>> In general, what is the appropriate way to reference code in this em=
ail list? Are GitHub links OK?
>=20
> I'm not an expert, but it feels possibly a bit ephemeral - if someone=
 is digging through email archives in a future where that github projec=
t has been moved elsewhere, the links will all be dead.

Right. However, you could disassemble the URL and use the commit hash, =
the filename and the line number. They are not ephemeral because they a=
re part of the repo.

Thanks,
Lars