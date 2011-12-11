From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: best way to fastforward all tracking branches after a fetch
Date: Mon, 12 Dec 2011 00:26:13 +0530
Message-ID: <CAMK1S_gjZSBv5ASz4GhV25TsRKuzBvZ9D7_X+bniP9K0BQQCmA@mail.gmail.com>
References: <jbvj5o$skt$1@dough.gmane.org>
	<20111211022218.GA22749@sita-lt.atc.tcs.com>
	<jc2l2a$som$1@dough.gmane.org>
	<m3ehwbge8f.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Gelonida N <gelonida@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 11 19:56:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZoZk-0004bn-RA
	for gcvg-git-2@lo.gmane.org; Sun, 11 Dec 2011 19:56:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751620Ab1LKS4Z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 11 Dec 2011 13:56:25 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:63419 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752263Ab1LKS4O convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Dec 2011 13:56:14 -0500
Received: by ggdk6 with SMTP id k6so327471ggd.19
        for <git@vger.kernel.org>; Sun, 11 Dec 2011 10:56:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=tmG6+33MLzQF7ZcAjSGTz0ivKs4BPNnWKYWAoPkbGEM=;
        b=nyt3KNv+RD5kzlkJRszisI2SIH1/W/lWSslNvIgcK8ugfo0DS8qaX7XQhW5fwsbEu5
         8Wa9FfVkTUikmjVNFBfirnBNG1+9iiuuUb/1jRY2UHbUmzkC9+XoBMuaBLl64I0cbUpm
         2LJlCvAEvO2yxOn9N9xtPDd/p416H9I9ALVus=
Received: by 10.182.111.8 with SMTP id ie8mr2228248obb.50.1323629773307; Sun,
 11 Dec 2011 10:56:13 -0800 (PST)
Received: by 10.182.12.225 with HTTP; Sun, 11 Dec 2011 10:56:13 -0800 (PST)
In-Reply-To: <m3ehwbge8f.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186807>

2011/12/11 Jakub Narebski <jnareb@gmail.com>:
> Don't remove people from Cc, please.
>
> Gelonida N <gelonida@gmail.com> writes:
>> On 12/11/2011 03:22 AM, Sitaram Chamarty wrote:
>> > On Sat, Dec 10, 2011 at 01:26:32PM +0100, Gelonida N wrote:
>
>> > So what you want would boil down to this script (untested):
>> >
>> > =C2=A0 =C2=A0 #!/bin/bash
>> > =C2=A0 =C2=A0 git status --porcelain -uno | grep . && {echo dirty =
tree, exiting...; exit 1; }
>> >
>> > =C2=A0 =C2=A0 for b in `git for-each-ref '--format=3D%(refname:sho=
rt)' refs/heads`
>> > =C2=A0 =C2=A0 do
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 git checkout $b
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 git merge --ff-only @{u}
>> > =C2=A0 =C2=A0 done
>>
>> Is there no way to distinguish tracking branches from other branches=
?
>> without checking them out?
>>
>> In order to save time I'd like to avoid checking out local branches.
>
> You can use 'upstream' field name in git-for-each-ref invocation,
> for example
>
> =C2=A0git for-each-ref '--format=3D%(refname:short) %(upstream:short)=
' refs/heads |
> =C2=A0 =C2=A0 =C2=A0 =C2=A0grep -e ' [^ ]' |
> =C2=A0 =C2=A0 =C2=A0 =C2=A0sed =C2=A0-e 's/ .*$//
>
> This could probably be done using only sed -- grep is not necessary.
>
>> Ideally I would even like to avoid checking out branches, which don'=
t
>> need to be forwarded.
>
> You can use git-update-ref plumbing, but you would have to do the
> check if it does fast-forward yourself, and provide reflog message
> yourself too.

if it's not the currently checked-out branch, 'git branch -f foo
origin/foo' seems to work fine.  However, it only updates the branch
reflog, not the HEAD reflog also, naturally.

=46WIW...

> Something like
>
> =C2=A0git for-each-ref '--format=3D%(refname) %(upstream)' |
> =C2=A0while read refname upstream
> =C2=A0do
> =C2=A0 =C2=A0 =C2=A0 =C2=A0# there is upstream
> =C2=A0 =C2=A0 =C2=A0 =C2=A0test -n "$upstream" || break
> =C2=A0 =C2=A0 =C2=A0 =C2=A0# and if fast-forwards
> =C2=A0 =C2=A0 =C2=A0 =C2=A0test $(git merge-base $refname $upstream) =
=3D $(git rev-parse $refname) || break
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git update-ref -m "$message" $refname $ups=
tream
> =C2=A0done
>
>> I also had to remember on which branch I was in order to avoid, that=
 I
>> am at a random branch after running the script.
>>
>> I could imagine something like my snippet below , though I guess,
>> there's something more elegant.
>>
>> git stash
>> mybranch=3D`git branch | sed -n 's/\* *//p'`
>> # do_script . . .
>> git checkout $mybranch
>> git stash apply
>
> Don't use git-branch in scripting. =C2=A0See __git_ps1 function in
> contrib/completion/git-completion.bash how it can be done:
>
> =C2=A0b=3D"$(git symbolic-ref HEAD 2>/dev/null)" ||
> =C2=A0b=3D"$(git rev-parse --verify HEAD)"
>
> Nb. the second part is here only if there is possibility that you are
> on detached HEAD (unnamed branch).
>
> HTH (hope that helps)
> --
> Jakub Nar=C4=99bski



--=20
Sitaram
