From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Subject: Re: git stash: add --index-only, or --keep-index should not stash index?
Date: Wed, 16 Mar 2011 22:37:01 +0100
Message-ID: <AANLkTing5ZQKF4PXtX1peynx2uuc8s+aeBP=fbJWXvWw@mail.gmail.com>
References: <4D7A6E37.8080104@gmail.com>
	<4D7E9502.4060502@gmail.com>
	<AANLkTikU0xCBzDya3vyfoH4PwzmRi6qmotxNoVc61b=W@mail.gmail.com>
	<4D80F9F4.9090304@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Neal Kreitzinger <nkreitzinger@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 16 22:37:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PzyP0-00088g-R1
	for gcvg-git-2@lo.gmane.org; Wed, 16 Mar 2011 22:37:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755579Ab1CPVhE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Mar 2011 17:37:04 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:45430 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755459Ab1CPVhC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Mar 2011 17:37:02 -0400
Received: by vws1 with SMTP id 1so2211101vws.19
        for <git@vger.kernel.org>; Wed, 16 Mar 2011 14:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=W4+xJ1XknjMZ1oPxbA1jZQF6vapbT9VHRQy+w33UDG4=;
        b=i2VrQYHn6MQQ/Sgf+DTHgrYAGFnrIMlUaWRNNIBK0D67vgJDpj6Ft63Vufivv145k9
         2K+DdL1vgJGnHuJCfNLlzaNcLmLFAoSe6pNpi2FqSuwZ42tlF7xtD8LFesy7AcNAA5Yi
         FQzyoOXWI7hALgd3bPYZ7xqct6b+WgNnXxvg8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=oSEo8pfxl2vI6mobKwOhB5mVNDfKUaVKJKmbHK6llVLlqodJL0QxVrvG5AxbW+u2QM
         Q2kE6WEH1yJ452w3OkLAxYOEK+Fs9U6Vk4PP9XrFeVQDdnHXpsMZllRFe5X6rbVOLAvs
         6ncD7xSrTMPYgJwW8pl71tj33I3u9kBmLc2aY=
Received: by 10.52.68.18 with SMTP id r18mr762343vdt.82.1300311421648; Wed, 16
 Mar 2011 14:37:01 -0700 (PDT)
Received: by 10.220.202.140 with HTTP; Wed, 16 Mar 2011 14:37:01 -0700 (PDT)
In-Reply-To: <4D80F9F4.9090304@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169200>

On Wed, Mar 16, 2011 at 6:57 PM, Neal Kreitzinger
<nkreitzinger@gmail.com> wrote:
> On 3/15/2011 2:48 PM, Piotr Krukowiecki wrote:
>>
>> On Mon, Mar 14, 2011 at 11:21 PM, Neal Kreitzinger
>> <nkreitzinger@gmail.com> =A0wrote:
>>>
>>> On 3/11/2011 12:47 PM, Piotr Krukowiecki wrote:
>>>>
>>>> Hi,
>>>>
>>>> I wanted to do something like "Testing partial commits" described =
in
>>>> git-stash documentation (see end of mail for reference). I think t=
his
>>>> is a common scenario: you start working on some feature, then disc=
over
>>>> a bug, start fixing it, but realize it needs more work. So now you=
 have
>>>> two features that needs more work (both are not ready for committi=
ng).
>>>>
>>>> The documentation says to use --keep-index in this case.
>>>>
>>>> The problem is that --keep-index leaves changes in index intact, b=
ut at
>>>> the same time it saves them in stash. So if I edit those changes I=
'm
>>>> likely
>>>> to get conflicts when applying the stash.
>>>>
>>>> For example:
>>>>
>>>> $ git init&& =A0 =A0echo a> =A0 =A0a&& =A0 =A0git add .&& =A0 =A0g=
it commit -m a
>>>> $ echo x> =A0 =A0a&& =A0 =A0git add a&& =A0 =A0git stash save --ke=
ep-index
>>>> $ echo y> =A0 =A0a&& =A0 =A0git add a&& =A0 =A0git commit -m y
>>>> $ git stash pop
>>>> Auto-merging a
>>>> CONFLICT (content): Merge conflict in a
>>>>
>>>> Maybe --keep-index should not stash staged changes? This would fix=
 this
>>>> problem. And I can't =A0think of a situation when would want to st=
ash
>>>> changes
>>>> and at the same time keep them.
>>>>
>>>> If --keep-index works correctly maybe a new option, for example
>>>> --index-only
>>>> (or --cached-only?) could be introduced?
>>>>
>>>>
>>>> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>>
>>>> Testing partial commits::
>>>>
>>>> You can use `git stash save --keep-index` when you want to make tw=
o or
>>>> more commits out of the changes in the work tree, and you want to =
test
>>>> each change before committing:
>>>> +
>>>> ----------------------------------------------------------------
>>>> # ... hack hack hack ...
>>>> $ git add --patch foo =A0 =A0 =A0 =A0 =A0 =A0# add just first part=
 to the index
>>>> $ git stash save --keep-index =A0 =A0# save all other changes to t=
he stash
>>>> $ edit/build/test first part
>>>> $ git commit -m 'First part' =A0 =A0 # commit fully tested change
>>>> $ git stash pop =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0# prepare to wo=
rk on all other changes
>>>> # ... repeat above five steps until one commit remains ...
>>>> $ edit/build/test remaining parts
>>>> $ git commit foo -m 'Remaining parts'
>>>> ----------------------------------------------------------------
>>>>
>>>>
>>> behind-the-scenes, git stash saves your working tree as a commit an=
d your
>>> index as another commit. =A0"git-stash apply" and "git-stash pop" o=
nly
>>> apply
>>> your stashed-index if you do "git-stash-apply --index". =A0The defa=
ult is
>>> to
>>> only apply your stashed-work-tree. =A0You can create new branches f=
rom your
>>> stashes with "git-stash branch". =A0You may find that much better t=
o deal
>>> with
>>> for managing your work. =A0Stashes aren't really intended to be the=
 primary
>>> way to manage your work, but instead are a supplement. =A0Branches =
are a
>>> better main tool for managing work. =A0You can create a branch from=
 your
>>> stash
>>> and when the branch is ready you can merge it into your other branc=
h.
>>
>> Thanks for explanation, I understand there is not much pressure on
>> improving it.
>>
>> But it still does not explain how leaving code in index (with
>> --keep-index) while
>> still stashing it might be helpful?
>>
>> I would understand the use of --index-only (I gave an example of use
>> case),
>> or even --workdir-only, but not --keep-index. If I'm missing somethi=
ng
>> please
>> correct me.
>>
>>
> Keep in mind that a key to his workflow is "git-add --patch" method (=
which
> you did not include in your example).

I did - in my first mail.


> The workflow of the manpage assumes
> you will have to resolve conflicts in such a case. =A0If you look at =
the
> "Pulling into a dirty tree" workflow of the same manpage its obvious =
that
> this workflow will almost always get conflicts, but they don't explic=
itly
> include conflict resolution in the example.

ok, for this workflow, when you stash away your changes to do a pull,
you can't do anything to avoid conflicts.

I mean this case:

> You could resolve the conflicts
> for "Testing partial commits" in this way:
>
> Neal's Version of Testing partial commits::
> ----------------------------------------------------------------
> # ... hack hack hack ...
> $ git add --patch foo =A0 =A0 =A0 =A0 =A0 =A0# add just first part to=
 the index
> $ git stash save --keep-index =A0 =A0# save all other changes to the =
stash
> $ edit/build/test first part
> $ git commit -m 'First part' =A0 =A0 # commit fully tested change
> $ git stash pop =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0# prepare to work =
on all other changes
> =A0 (conflict resolution)
> =A0 $ edit conflicted file =A0 =A0 =A0 =A0# keep new version of the h=
unk already
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 # com=
mitted in prior iteration
> =A0 $ git reset HEAD -- foo =A0 =A0 =A0 # clear conflict from index
> =A0 $ git reset HEAD -- foo =A0 =A0 =A0 # (again) reset index to matc=
h HEAD
> # ... repeat above five (or eight) steps until one commit remains ...
> $ edit/build/test remaining parts
> $ git commit foo -m 'Remaining parts'
> ----------------------------------------------------------------
>
> Maybe there's a better way to do this. =A0Hope this helps.

How about following workflow?

   # ... hack hack hack ...
   $ git add --patch foo
   $ git stash save --keep-index
   $ build/test first part         # note I have removed the "edit" par=
t

There are two possibilities now:

1. You're happy with the result - you commit your changes:

   $ git commit -m 'First part'
   $ git stash pop

Important: there will be no conflicts in this case, and committed
changes won't be reverted/applied/conflicted, because you have
not edited them!

I wasn't fully aware of this before (looks like I'm still new to git).


2. You're not happy with the result - maybe something does not
build and you need to stage more changes, or maybe fix is not
working yet.

You should first pop your stashed changes! This way you'll avoid
conflicts, you'll be able to stage/modify other changes. So the
next steps are like this:

   $ git stash pop
   $ edit/add -p
   $ git stash save --keep-index

and now you're back to the "build/test" part.


> =A0 (conflict resolution)
> =A0 $ edit conflicted file =A0 =A0 =A0 =A0# keep new version of the h=
unk already
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 # com=
mitted in prior iteration
> =A0 $ git reset HEAD -- foo =A0 =A0 =A0 # clear conflict from index
> =A0 $ git reset HEAD -- foo =A0 =A0 =A0 # (again) reset index to matc=
h HEAD

I'm not really sure why/how this works :/

--=20
Piotr Krukowiecki
