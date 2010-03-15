From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: Dealing with an upstream cherry-picked branch
Date: Mon, 15 Mar 2010 17:07:09 -0400
Message-ID: <76718491003151407p3cdecf8fx1ddebf19ce304f83@mail.gmail.com>
References: <76718491003142117w4fd10449j51deef27548c4d2e@mail.gmail.com>
	 <32541b131003151146qeb6b15bqa9317c6d56443e8e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 15 22:07:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrHVQ-0000FL-TF
	for gcvg-git-2@lo.gmane.org; Mon, 15 Mar 2010 22:07:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936790Ab0COVHM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Mar 2010 17:07:12 -0400
Received: from mail-iw0-f176.google.com ([209.85.223.176]:53519 "EHLO
	mail-iw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932738Ab0COVHL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Mar 2010 17:07:11 -0400
Received: by iwn6 with SMTP id 6so264597iwn.4
        for <git@vger.kernel.org>; Mon, 15 Mar 2010 14:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=NhSrGC8bIducwuc4ofd0IKdZQ4C2SkzXPZzVmNTbF9Q=;
        b=KoUuro2B0uK8QzEqR0hbwD6ubTMnKKRMTsV37hp/x6qSTYDD/elzMu4eCSrOLgn7oC
         fNpmgX4DzMA2wdlHjaBO4OKnvMoEOK7AVWxjzxjnhVQXU4t4OmkAyWA9RxNgg3eMxX+j
         8nMAjFBD7eVjV8RqrfHgxLtwpcUkTaRAIF7Nk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=moechUx80UtaH7mXnbw2wCq4srvJCN1RXRBtpkBRj9QHkGPKlb7FgPQ9LPbi0cqvjc
         3nq0B0+n50a34ql1nCgrD6pBzzAk/6hZyHhBnNT2SQ64Izll9Bi+i0a/PzbO7wSS01W+
         tdREeXgSk11tOF0uSNCq1n3nY0opZp/X5u5dQ=
Received: by 10.231.79.136 with SMTP id p8mr314514ibk.4.1268687229884; Mon, 15 
	Mar 2010 14:07:09 -0700 (PDT)
In-Reply-To: <32541b131003151146qeb6b15bqa9317c6d56443e8e@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142251>

On Mon, Mar 15, 2010 at 2:46 PM, Avery Pennarun <apenwarr@gmail.com> wr=
ote:
> You forgot option 0: tell upstream not to do that.

I have no control over upstream and its currently policy absolutely is
not going to change.

However, I do have control of my mirror of upstream so...

> 0a) Have them do their bugfixes directly in the upstream-a branch,
> then merge sometimes from upstream-a to upstream-master. =C2=A0Then w=
hen
> they cut upstream-b from upstream-master, it should be an easy merge
> for you (since they've already resolved any conflicts between
> upstream-a and upstream-master as they arose over time).
>
> 0b) If they really need to do their bugfixes on upstream-master and
> then cherry-pick them back to upstream-a, have them merge upstream-a
> into upstream-master sometimes *anyway*, resolving any (probably
> trivial) conflicts as they arise. =C2=A0I say the conflicts should be
> trivial because they're just cherry-picks anyway, so git will mostly
> notice they're identical and ignore them. =C2=A0This is easy to do a =
little
> at a time, but gets more complicated if you wait a long time between
> merges.
>
> 0c) Like 0b), only use 'git merge -s ours' to merge from upstream-a
> into upstream-master. =C2=A0This assumes that upstream-a *never* has =
a fix
> other than one that is already in upstream-master, so that all
> conflicts necessarily resolve to exactly what's already in
> upstream-master. =C2=A0This makes it easier for downstream people to =
merge
> but doesn't actually cost any extra effort.

=2E.. I can locally perform the 0b or 0c that they will not do. They
never have a fix not already in upstream-master, so I can do 0c.
[EDIT: I see this is what you suggest below.] I can also put a sanity
check in place to make sure there isn't something unexpected in
upstream-a.

I will explore this option.

> As for your original suggestions:
>
>> 1) Create a local-a integration branch, merged from upstream-a and
>> local-master. Keep this branch up-to-date by periodically merging
>> local-master and upstream-a:
>
> This will be inconvenient since local-master won't actually be useful=
;
> if upstream-a contains a critical patch, you won't be able to test
> your changes in local-master until you merge them into local-a. =C2=A0=
Thus
> the history of local-master, while "clean", will actually be
> meaningless.

Okay.

>> 2) Periodically merge upstream-a into local-master:
>> [...]
>> Then when it is next time to merge upstream-master into local-master=
 either:
>>
>> (a) Backout the upstream-a merges to local-master by reverting the
>> merge commits which introduced them to local-master, then merge
>> upstream-master.
>
> Don't try to revert merge commits; that generally ends in disaster,
> both in terms of your tree's correctness and your ability to
> accurately retrace the history of your branch. =C2=A0Possibly you can=
 make
> it work, but I don't know anybody who has. =C2=A0Even if you can, you=
'll
> still hate yourself in the morning.

Okay, I'll take this as sage advice. :-)

>> (b) Just merge upstream-master and carefully deal with all the
>> conflicts. I think this will necessarily be an evil merge.
>
> This is probably not as hard as it sounds, particularly if upstream-a
> is *purely* a subset (in terms of cherry-picks, not in terms of
> history) of upstream-master. =C2=A0I'd recommend something like this =
(just
> once when it's time to move to a new release branch):
>
> =C2=A0 =C2=A0 =C2=A0 git checkout -b mergey upstream-master
> =C2=A0 =C2=A0 =C2=A0 # take the history of upstream-a but not the con=
tent:
> =C2=A0 =C2=A0 =C2=A0 git merge -s ours upstream-a
> =C2=A0 =C2=A0 =C2=A0 # assuming local-master is your branch based on =
upstream-a:
> =C2=A0 =C2=A0 =C2=A0 git checkout -b local-b local-master
> =C2=A0 =C2=A0 =C2=A0 # merge the changes from upstream-a to upstream-=
master into local-b:
> =C2=A0 =C2=A0 =C2=A0 git merge mergey
>
>> (c) Create a new branch at point Ma and cherry-pick only the local
>> commits from local-master past point Ma. This essentially gives me t=
he
>> clean local-master I would've had if I'd been doing (1) all along.
>
> This will work, but the short form for exactly the same operation is:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git checkout -b local-b local-master
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git rebase --onto upstream-master upstream=
-a

Are you sure that will skip the merges into local-master from
upstream-a? I didn't think so and it's not my recollection based on
using --onto previously.

> It will result in a cleaner history, and importantly, one that
> upstream would probably be willing to merge someday. =C2=A0You won't =
have
> any extra cherry-picked commits confusingly merged into your history
> with the original commits.
>
> The disadvantage is that each of your branches will have a disjoint
> history: there will be no branch showing how you got from local-a to
> local-b, since they're actually two totally different things. =C2=A0I=
n git,
> the ideal case is that if you look at the history of HEAD, you can se=
e
> the *entire* evolution of the product, and using a different
> merge-base for each branch gets in the way of that.
>
> The best option above, IMHO, is my proposed option 0. =C2=A0But any o=
f the
> others will work.

Thank you.

j.
