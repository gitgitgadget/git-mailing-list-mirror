Return-Path: <SRS0=YD5J=2F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,PLING_QUERY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 449B4C43603
	for <git@archiver.kernel.org>; Sun, 15 Dec 2019 05:36:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 008E82253D
	for <git@archiver.kernel.org>; Sun, 15 Dec 2019 05:36:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SQ2VzF6t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbfLOFgP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 15 Dec 2019 00:36:15 -0500
Received: from mail-pj1-f42.google.com ([209.85.216.42]:34965 "EHLO
        mail-pj1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbfLOFgP (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Dec 2019 00:36:15 -0500
Received: by mail-pj1-f42.google.com with SMTP id w23so1542078pjd.2
        for <git@vger.kernel.org>; Sat, 14 Dec 2019 21:36:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=QumSR62BqmMVFujrrJZ4S7TtEhjRsyCJTySmitKaNGw=;
        b=SQ2VzF6tYkK/MxsoQ6Lx236tsO3f+cB3RYrCOUZLTAFzrfmUY3HMf5OnHS4MFIaKF+
         tSnyOsZn1pICDOKvkM+jItI9acgqoBvSzboVqWboo8taZst6sPbPVEwwv8J0syvNpiWE
         Z8PovtXInmo08Tq1xrP3WpkPR216MWREhgmdPZjMz96tlFaABcmNLkhyIOOoeofCQoHs
         cYqOSD2Bd+imQu7JuLvzZko7wf9JA9ijtOGAYeE4uNqpw9v03Y9GoBS/YTvbWzEBuKg3
         y5MMBpj9TIebfixleXKH+By9RgWjWcdBwCMFJAKg+A/DUNgcs/v69WVqYbrDXnIekyGG
         MZGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=QumSR62BqmMVFujrrJZ4S7TtEhjRsyCJTySmitKaNGw=;
        b=kLOQuxPDp5CJ3RLruZXz6qIPSw3Gom2BMgm9PH0iHPQqB8fVD9YLMX6nMIV28Qo8/t
         caOXv0FXDryTxIJmyydB4W0jVF9yJv3DsfI6enI6cqIgHckm3Mn/seiK77MieovWoU4s
         mfY6vrNn1zqx3R0MvMloclV313K+Fh8UbUe2rnV6ZqxFXja83B5Ik4/KiGDJ2J9YNYRO
         pRK66F1wXrlYTpfqtVN15kPzr/zp62pSHiEsrWeKKAV0bKCk9E8OX5/C0rywlvqgnFjM
         Auc2QWcLckxTF6Lq1MhmwxoFZ2DzZyQgHwkXIKlKF/FQ7j2vUlNyx0pGqcDX+37cmhz/
         zV4A==
X-Gm-Message-State: APjAAAWpCFpGlu4UnLu8Q5ld3mXCGVMfKp0DWqATtH89xQfbs9BK7euZ
        JQ1mdJJsr0q0HmQEN76cJYeD1d8aJBcq9Ay+Dfm5WBje
X-Google-Smtp-Source: APXvYqzAlcqR3YIWBt7VuLIe4V60mjW/zIwz7m1ZYUdJesaZn/ZFrf0e6RygTi05HsgkrNZ52yl2vNfGT7kdv4S3nGg=
X-Received: by 2002:a17:90a:b384:: with SMTP id e4mr10118591pjr.108.1576388173973;
 Sat, 14 Dec 2019 21:36:13 -0800 (PST)
MIME-Version: 1.0
References: <CAE3VKEpPye+GyR7Uo9WBa=1i1L=dFq9AHfdNnhiw19K-jWLtBA@mail.gmail.com>
 <CAE3VKEppVv=rocJU7jHKu7i=dLyaHhpauTBmm91udjZ_DOpW+g@mail.gmail.com>
 <007401d5b2cf$ac787ed0$05697c70$@gmail.com> <CAE3VKEozjFXBkQCWQ8FSOPJkwPCM05=eb7jdA4AYwJCtNSH1Ng@mail.gmail.com>
 <CAPYjA5YsLyeZvimsUqJpcyNCybVFK2+mKRskjQ79OKJHffdSLg@mail.gmail.com>
In-Reply-To: <CAPYjA5YsLyeZvimsUqJpcyNCybVFK2+mKRskjQ79OKJHffdSLg@mail.gmail.com>
From:   Joshua Teves <jbtevespro@gmail.com>
Date:   Sun, 15 Dec 2019 00:36:03 -0500
Message-ID: <CAPYjA5am3Qua_c==78ASWffEP5poExWR1XZyVvXEYODMYokfog@mail.gmail.com>
Subject: Re: Head, Branch != Head -> Branch?
To:     Tomas Zubiri <me@tomaszubiri.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tomas,
> In what scenarios would you create a new branch and not check it out?

These are some examples of cases where I want to make but not checkout
a new branch:
1. I've made a backup branch in case I'm about to screw up the one I'm
on and want to be able to get back to the branch's current state.
2. I want a branch at this point because I'm planning on doing working
on multiple, independent features from the same point and don't know
when they'll be merged together, and I can only work on each one a
little at the time. It's nice because I can branch from a point that's
stable.

> Is there a scenario where you would do this in detached head mode?

Someone may want to be in detached mode to check out a bug behavior at
some commit without modifying the code at all, so there's no sense in
making a new branch.

---
> Could HEAD attach itself to a nearby branch whenever a command
> requiring an attached branch is called and HEAD points to a commit
> with only 1 branch attached to it? This would not include commit,
> since it does not require an attached branch and thus would not fail
> on detached mode, this should not break bc because it only affects
> commands that would otherwise throw an error.

If they change their mind once detached, it's simple enough to
reattach by just making a new branch where they're checked out. But if
you don't do that, how is git supposed to select a name? There's no
way to pick a good one other than the current SHA... which is exactly
how you'd place yourself currently.

> Alternatively, a more specific error message could be printed,
> prompting the user to attach their head to the branch on the commit.

There actually IS a very clear prompt to reattach:
"If you want to create a new branch to retain commits you create, you may
do so (now or later) by using -b with the checkout command again. Example:

  git checkout -b <new-branch-name>"

Lastly, being in a detached state isn't an error, so I don't see why
an error message needs to be printed. It's quite clear that you're not
attached to any branch in particular, and it's quite clear when you
run git branch what SHA you're on and that you're detached. I as a
user would never want git to try and decide to attach itself to a new
branch, it might make the wrong choice and aggravate me. As it stands
the documentation and resulting text from commands are both quite
clear in my opinion.

mattr94,
I do agree that this is outside a new user's expectation, as Tomas has
stated, because I've taught many people git and this is a common
surprise. However, it's adequately documented and frequently covered
in tutorials. Moreoever, the commands are consistent: checkout checks
out a particular commit/branch, branch creates branches. Perhaps the
documentation could be added removing the newline between note and the
line above, so there's less of a separation between them? That would
do a better job of drawing the reader's eye to the note as being
related. (PS, I only count 4 paragraphs, but maybe I'm looking at the
wrong version?.. sorry if so).

Best,
Josh

On Sun, Dec 15, 2019 at 12:33 AM Joshua Teves <jbtevespro@gmail.com> wrote:
>
> Tomas,
> > In what scenarios would you create a new branch and not check it out?
>
> These are some examples of cases where I want to make but not checkout a =
new branch:
> 1. I've made a backup branch in case I'm about to screw up the one I'm on=
 and want to be able to get back to the branch's current state.
> 2. I want a branch at this point because I'm planning on doing working on=
 multiple, independent features from the same point and don't know when the=
y'll be merged together, and I can only work on each one a little at the ti=
me. It's nice because I can branch from a point that's stable.
>
> > Is there a scenario where you would do this in detached head mode?
>
> Someone may want to be in detached mode to check out a bug behavior at so=
me commit without modifying the code at all, so there's no sense in making =
a new branch.
>
> ---
> > Could HEAD attach itself to a nearby branch whenever a command
> > requiring an attached branch is called and HEAD points to a commit
> > with only 1 branch attached to it? This would not include commit,
> > since it does not require an attached branch and thus would not fail
> > on detached mode, this should not break bc because it only affects
> > commands that would otherwise throw an error.
>
> If they change their mind once detached, it's simple enough to reattach b=
y just making a new branch where they're checked out. But if you don't do t=
hat, how is git supposed to select a name? There's no way to pick a good on=
e other than the current SHA... which is exactly how you'd place yourself c=
urrently.
>
> > Alternatively, a more specific error message could be printed,
> > prompting the user to attach their head to the branch on the commit.
>
> There actually IS a very clear prompt to reattach:
> "If you want to create a new branch to retain commits you create, you may
> do so (now or later) by using -b with the checkout command again. Example=
:
>
>   git checkout -b <new-branch-name>"
>
> Lastly, being in a detached state isn't an error, so I don't see why an e=
rror message needs to be printed. It's quite clear that you're not attached=
 to any branch in particular, and it's quite clear when you run git branch =
what SHA you're on and that you're detached. I as a user would never want g=
it to try and decide to attach itself to a new branch, it might make the wr=
ong choice and aggravate me. As it stands the documentation and resulting t=
ext from commands are both quite clear in my opinion.
>
> mattr94,
> I do agree that this is outside a new user's expectation, as Tomas has st=
ated, because I've taught many people git and this is a common surprise. Ho=
wever, it's adequately documented and frequently covered in tutorials. More=
oever, the commands are consistent: checkout checks out a particular commit=
/branch, branch creates branches. Perhaps the documentation could be added =
removing the newline between note and the line above, so there's less of a =
separation between them? That would do a better job of drawing the reader's=
 eye to the note as being related. (PS, I only count 4 paragraphs, but mayb=
e I'm looking at the wrong version?.. sorry if so).
>
> Best,
> Josh
>
> On Sat, Dec 14, 2019 at 10:40 PM Tomas Zubiri <me@tomaszubiri.com> wrote:
>>
>> It was just a combination of an old gripe I have with expecting git
>> branch to checkout and conflating (HEAD pointing to a commit and
>> branch pointing to a commit) with (HEAD pointing to a branch pointing
>> to a commit).
>>
>> In what scenarios would you create a new branch and not check it out?
>> Is there a scenario where you would do this in detached head mode?
>>
>> ---
>>
>>  Could HEAD attach itself to a nearby branch whenever a command
>> requiring an attached branch is called and HEAD points to a commit
>> with only 1 branch attached to it? This would not include commit,
>> since it does not require an attached branch and thus would not fail
>> on detached mode, this should not break bc because it only affects
>> commands that would otherwise throw an error.
>> Alternatively, a more specific error message could be printed,
>> prompting the user to attach their head to the branch on the commit.
>>
>> Regards.
>> El s=C3=A1b., 14 de dic. de 2019 a la(s) 19:41, <mattr94@gmail.com> escr=
ibi=C3=B3:
>> >
>> >
>> > After going through the code and thinking about this. I think the unex=
pected results came from git branch not checking out the branch I created.
>> > I know git checkout -b master would have been the result I wanted. If =
I were to create another commit with HEAD checked out instead of master, ma=
ster would not update, only HEAD would.
>> > > I guess the real crime here is that git branch does not checkout the=
 branch created. I don't think I ever wanted to create a branch without che=
cking it out, otherwise I would use git tag.
>> >
>> > The problem with this is that git tag doesn't create a new branch, but=
 rather just a new tag so running something like:
>> >
>> > git tag my-tag
>> > git checkout my-tag
>> > git add .
>> > git commit -m "message"
>> >
>> > wouldn't update my-tag either, you would need to create a new branch f=
or that.  Sometimes I want to create a branch without checking it out, as I=
'm sure many other users do.  Is it an issue of documentation where maybe t=
he behavior isn't clear? It does specifically say this in the description o=
f git branch, but to be fair it is buried 6 paragraphs in
>> >
