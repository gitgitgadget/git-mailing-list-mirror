From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Subject: Re: git stash: add --index-only, or --keep-index should not stash index?
Date: Tue, 15 Mar 2011 20:48:20 +0100
Message-ID: <AANLkTikU0xCBzDya3vyfoH4PwzmRi6qmotxNoVc61b=W@mail.gmail.com>
References: <4D7A6E37.8080104@gmail.com>
	<4D7E9502.4060502@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Neal Kreitzinger <nkreitzinger@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 15 20:48:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PzaEH-0002Fs-M6
	for gcvg-git-2@lo.gmane.org; Tue, 15 Mar 2011 20:48:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932561Ab1COTsW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Mar 2011 15:48:22 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:63489 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758584Ab1COTsV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Mar 2011 15:48:21 -0400
Received: by vws1 with SMTP id 1so925713vws.19
        for <git@vger.kernel.org>; Tue, 15 Mar 2011 12:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=A6Md/jJkfdOolM1b5QR5We1N7WZfCmIYuoFkoH7yoPg=;
        b=uxDz3f4RlpPFCsFCR2Kn4Mrm4HX1YVL3kUmYzfHjLlmH66PC3VlcmVkMrLvUOg891L
         6QehKLQYhNK30HxetGAFzOwD+DTV1m+0WV1KclI6F1HRBgSfzmDlbhnOvuiY0ikiob6R
         NkxxFSTfRjFk0kSeCqmPgyT/XaXQk1uN9/4X0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=gX+kBJbUyIIrG3uV8BvlCFbNZQE++w2+YRLqrYAOADNZLXjgEzKLfbgLQijwLJBUOo
         LkUk5MC0aiAmt9k0feeUUbIcaiayZTLkteNiOV5s3R2n7VQcfL0T4a4wGSkqHIqfGw0s
         H+TWdybfE9UjaWDfVe4Pr5Y387z/DYktVX7TQ=
Received: by 10.220.7.142 with SMTP id d14mr3232978vcd.59.1300218500785; Tue,
 15 Mar 2011 12:48:20 -0700 (PDT)
Received: by 10.220.202.140 with HTTP; Tue, 15 Mar 2011 12:48:20 -0700 (PDT)
In-Reply-To: <4D7E9502.4060502@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169087>

On Mon, Mar 14, 2011 at 11:21 PM, Neal Kreitzinger
<nkreitzinger@gmail.com> wrote:
> On 3/11/2011 12:47 PM, Piotr Krukowiecki wrote:
>>
>> Hi,
>>
>> I wanted to do something like "Testing partial commits" described in
>> git-stash documentation (see end of mail for reference). I think thi=
s
>> is a common scenario: you start working on some feature, then discov=
er
>> a bug, start fixing it, but realize it needs more work. So now you h=
ave
>> two features that needs more work (both are not ready for committing=
).
>>
>> The documentation says to use --keep-index in this case.
>>
>> The problem is that --keep-index leaves changes in index intact, but=
 at
>> the same time it saves them in stash. So if I edit those changes I'm
>> likely
>> to get conflicts when applying the stash.
>>
>> For example:
>>
>> $ git init&& =A0echo a> =A0a&& =A0git add .&& =A0git commit -m a
>> $ echo x> =A0a&& =A0git add a&& =A0git stash save --keep-index
>> $ echo y> =A0a&& =A0git add a&& =A0git commit -m y
>> $ git stash pop
>> Auto-merging a
>> CONFLICT (content): Merge conflict in a
>>
>> Maybe --keep-index should not stash staged changes? This would fix t=
his
>> problem. And I can't =A0think of a situation when would want to stas=
h
>> changes
>> and at the same time keep them.
>>
>> If --keep-index works correctly maybe a new option, for example
>> --index-only
>> (or --cached-only?) could be introduced?
>>
>>
>> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>
>> Testing partial commits::
>>
>> You can use `git stash save --keep-index` when you want to make two =
or
>> more commits out of the changes in the work tree, and you want to te=
st
>> each change before committing:
>> +
>> ----------------------------------------------------------------
>> # ... hack hack hack ...
>> $ git add --patch foo =A0 =A0 =A0 =A0 =A0 =A0# add just first part t=
o the index
>> $ git stash save --keep-index =A0 =A0# save all other changes to the=
 stash
>> $ edit/build/test first part
>> $ git commit -m 'First part' =A0 =A0 # commit fully tested change
>> $ git stash pop =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0# prepare to work=
 on all other changes
>> # ... repeat above five steps until one commit remains ...
>> $ edit/build/test remaining parts
>> $ git commit foo -m 'Remaining parts'
>> ----------------------------------------------------------------
>>
>>
> behind-the-scenes, git stash saves your working tree as a commit and =
your
> index as another commit. =A0"git-stash apply" and "git-stash pop" onl=
y apply
> your stashed-index if you do "git-stash-apply --index". =A0The defaul=
t is to
> only apply your stashed-work-tree. =A0You can create new branches fro=
m your
> stashes with "git-stash branch". =A0You may find that much better to =
deal with
> for managing your work. =A0Stashes aren't really intended to be the p=
rimary
> way to manage your work, but instead are a supplement. =A0Branches ar=
e a
> better main tool for managing work. =A0You can create a branch from y=
our stash
> and when the branch is ready you can merge it into your other branch.

Thanks for explanation, I understand there is not much pressure on impr=
oving it.

But it still does not explain how leaving code in index (with
--keep-index) while
still stashing it might be helpful?

I would understand the use of --index-only (I gave an example of use ca=
se),
or even --workdir-only, but not --keep-index. If I'm missing something =
please
correct me.


--=20
Piotr Krukowiecki
