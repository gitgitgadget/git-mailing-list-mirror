From: Elijah Newren <newren@gmail.com>
Subject: Re: EasyGit Integration
Date: Tue, 9 Jun 2009 16:00:14 -0600
Message-ID: <51419b2c0906091500q6aaff225q42bd79e6349a1143@mail.gmail.com>
References: <d411cc4a0906091159r51e7d16t4d66c6225322fb60@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git list <git@vger.kernel.org>
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 10 00:00:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ME9Mn-0006bI-JQ
	for gcvg-git-2@gmane.org; Wed, 10 Jun 2009 00:00:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754922AbZFIWAP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Jun 2009 18:00:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756696AbZFIWAO
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jun 2009 18:00:14 -0400
Received: from qw-out-2122.google.com ([74.125.92.25]:54807 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752818AbZFIWAN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Jun 2009 18:00:13 -0400
Received: by qw-out-2122.google.com with SMTP id 5so218440qwd.37
        for <git@vger.kernel.org>; Tue, 09 Jun 2009 15:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=7Nefz2xcPTJDEaX+eY8+NxSS1w2YMGLiYmBP9nQ3+qo=;
        b=LyVb5Q1h1HdxlQzdjUv+zVoTzo/iteVuP3qE9s0tZ4hJYw8b6AnLyNhXQcT9WNA2hs
         MTvIMHDkr+BRITbxDP3iJzmYsg5ukkPEk/nCqJyccWC3jTtss9k7UlUje3CGPMsAO4eG
         zSdnawBG/SkJvDZZa1F+JPelM3vZZudXuweS8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=KKb80Er77u4FGGkkfwG8OyRzVjJxdXjFk5fT5zybKpCSaUum4n6Aa7yRZBiHoXJ4Cy
         1ywRdZyXAPZuNd6ymBoYFB8fetfY2+OSlmr0Ntvw0sL2/s7NCEy8t9VHwl149cLkho2c
         AmnN17y6F1ij08k2okStUV56sjl0EkcopwzSg=
Received: by 10.229.86.145 with SMTP id s17mr156282qcl.10.1244584814756; Tue, 
	09 Jun 2009 15:00:14 -0700 (PDT)
In-Reply-To: <d411cc4a0906091159r51e7d16t4d66c6225322fb60@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121230>

Hi,

On Tue, Jun 9, 2009 at 12:59 PM, Scott Chacon<schacon@gmail.com> wrote:
> Hey all,
>
> I have been playing with the EasyGit project lately and I have been
> really impressed.

Thanks for bringing this up.  I should have done better at proposing
some of these changes upstream...

> * breaks the various things that 'checkout' does into separate
> commands - moves 'revert' to doing what 'checkout -- path' does, move=
s
> current 'revert' to 'cherry-pick --revert' (which someone mentioned
> was a good idea at the last GitTogether), and adds 'unstage' for

As a side note, the mapping from eg revert to git commands is not so
simple; you'll miss a lot of cases if you were to make a simple alias.
 :-)

<snip a highlight of some changes in eg>

I'll note that you can run 'eg changes --details' to get a (hopefully
up-to-date and) complete list...

> Some other things that might be nice:
>
> * 'git backout' for 'git reset HEAD^'

May cause confusion for mercurial users (hg backout =3D=3D current git
revert).  I don't have a better proposal, though.  'uncommit'?


Also, a consistency proposal that I have not yet gotten to
implementing in eg; It'd be nice to add more consistency with these
commands:
 - continue incomplete am: git am --resolved
 - continue incomplete rebase: git rebase --continue
 - continue incomplete merge: git commit
so that it looks like this (while still allowing the old ways for
backward compatibility):
 =3D> continue incomplete am: git am --continue
 =3D> continue incomplete rebase: git rebase --continue
 =3D> continue incomplete merge: git merge --continue   (or is this
going overboard?)

And to change this:
 - abort incomplete am: git am --abort
 - abort incomplete bisect: git bisect reset
 - abort incomplete merge: git reset --hard HEAD
 - abort incomplete rebase: git rebase --abort
so that it looks like this (again still allowing old ways):
 =3D> abort incomplete am: git am --abort
 =3D> abort incomplete bisect: git bisect --abort
 =3D> abort incomplete merge: git merge --abort
 =3D> abort incomplete rebase: git rebase --abort

> These things may seem pretty simple and even sort of stupid if you're
> used to Git as we are - most of them you can just setup an alias
> pretty easily, but you would be amazed at how many people go nuts
> because of this stuff. =C2=A0If these simple things were in as defaul=
ts,
> sooo many of the remaining 'git is hard and obtuse' arguments would
> become obsolete. =C2=A0'checkout', 'add' and 'reset' seem to be where
> people have the most difficulty, due to their overloading.
>
> Does this resonate with anyone else? =C2=A0Does 1.7 seem like a good =
goal
> for amending some of these things? =C2=A0Completely redefining 'rever=
t'
> seems like the only backward incompatible change - everything else is
> just wrappers and whatnot, I think.

Mostly just wrappers, yes.  There are two other big incompatible
changes, both to push: (1) 'eg push' is basically hardcoded to do what
push.default=3Dtracking now does (although now that push.default exists=
,
I'm considering dropping this change in eg), and (2) eg push will try
to check whether the remote repository is bare and deny the push
unless one of the arguments is a refspec that has a ':' character in
it (i.e. a push-side check, rather than git's recent receive-side
check; having both probably doesn't make sense, so it's another thing
I'm reconsidering).

Also, I wondered whether others would consider the different defaults
for commit & diff to be a big backward incompatible change, though the
fact that you didn't seem to notice it and lots of others don't either
suggest it's not that big (for experienced users).  There are also
more minor changes to the defaults of bundle, log, and status, but
those are innocuous enough that they hardly qualify as backward
incompatible.


Thanks,
Elijah
