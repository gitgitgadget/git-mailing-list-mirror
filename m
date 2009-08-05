From: Dan McGee <dpmcgee@gmail.com>
Subject: Re: blame on a deleted/renamed file
Date: Wed, 5 Aug 2009 08:54:09 -0500
Message-ID: <449c10960908050654v3823da76p1ddb5a2bbb5c323d@mail.gmail.com>
References: <449c10960908050516k25ef0a92sd8616de29a93ea5f@mail.gmail.com>
	 <20090805123754.GA13340@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>
To: =?UTF-8?Q?Bj=C3=B6rn_Steinbrink?= <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Wed Aug 05 15:55:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYgwf-000638-8K
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 15:54:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934351AbZHENyL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Aug 2009 09:54:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934323AbZHENyL
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 09:54:11 -0400
Received: from ey-out-2122.google.com ([74.125.78.24]:48851 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933568AbZHENyJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Aug 2009 09:54:09 -0400
Received: by ey-out-2122.google.com with SMTP id 9so163061eyd.37
        for <git@vger.kernel.org>; Wed, 05 Aug 2009 06:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ItiTRIHFwqaXR1HbEI2IdYH2Dpdb+MtAGfPG0xKh0+M=;
        b=tCmjX50ViKGGcBJspWa56gcKOgJW6a4XPE+hn1pqeajStIILB8XtND5aShb1P0OMso
         MKLV3xXsM77U+/tBBCIxlTHYJItoRZh1Jh/X48Cz/2NwMuDI+Oabng9S+mGnMzqwUzfs
         zxjpaLsjQD1nY8OYjcV9MM0fU6xGyEAo87cJs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Y6QT4V6q6NKX4ewO0pksoIRN3tPGGiFCrkmtLCATod5b/EZ+Om72vHCHPrJ4q39/3j
         Fpe3Q8Z/c3b+XxeqlHEW1jwqigZTdIbpy3dQvwPTbc3udcm4tq65SvfuLlHXNGF0ve2Q
         tgHwfLAKWkX/4no27WlYfQRftjYOdQNivW9dM=
Received: by 10.216.88.146 with SMTP id a18mr1801708wef.56.1249480449174; Wed, 
	05 Aug 2009 06:54:09 -0700 (PDT)
In-Reply-To: <20090805123754.GA13340@atjola.homenet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124907>

2009/8/5 Bj=C3=B6rn Steinbrink <B.Steinbrink@gmx.de>:
> On 2009.08.05 07:16:13 -0500, Dan McGee wrote:
>> Is there no easy way in git to get a blame on a file that has either
>> been renamed or deleted? I'll step through my thought process, and a
>> quick google and read of the manpage returned nothing obvious. Here =
is
>> the repository in question if it matters:
>> git://projects.archlinux.org/pacman.git. I located a particular comm=
it
>> I was interested using a plain git-blame:
>> $ git blame scripts/makepkg.sh.in
>>
>> OK, looks like lines moved around enough that we got stuck here, let=
's
>
> How did it get stuck? The output I see follows the changes the whole =
way
> back through scripts/makepkg.in, scripts/makepkg.in and scripts/makep=
kg.

I said nothing about it not following renames. I asked about it
following *those lines*. I know it already made the jump from
scripts/makepkg.sh.in to scripts/makepkg.in, sorry if I wasn't clear
there.

>> see what this patch did:
>> $ git show e19d7da4
>>
>> OK, it did a move of a bunch of lines into functions that GIT couldn=
't
>> quite track:
>> $ git annotate --follow "scripts/makepkg.in" e19d7da4~1
>> fatal: cannot stat path 'scripts/makepkg.in': No such file or direct=
ory
>
> Where does that --follow come from? I don't see that in the man page.

It's not. The git-annotate manpage is misleading as heck though; I see
now I should have went straight to git-blame instead. Why have the two
commands diverged so much?

Thomas Rast had it perfect when suggesting this, which works perfectly
(for what I wanted):
$ git blame e19d7~1 -- scripts/makepkg.in

> And scripts/makepkg.in got added in e19d7da4, so its parent didn't ha=
ve
> it.

Not sure where you are seeing that, it was changed in that revision,
not added...

>> $ git annotate --follow "scripts/makepkg.sh.in" e19d7da4~1
>> fatal: no such path scripts/makepkg.sh.in in e19d7da4~1
>
> Same deal, scripts/makepkg.sh.in didn't exist in e19d7da4~1 either, i=
t
> got renamed from scripts/makepkg.in in b5f8a44be

That was my whole point here- I was stabbing in the dark so I showed
you everything I tried because the git-annotate manpage failed me.

>> Help? Or do I need to think about writing some sort of patch for it?
>> This is the first thing I have seen svn be able to do[1] that git
>> can't. :)
>
> Uhm, no, svn fails in the exact same way, not quite unexpected.
>
> doener@atjola:~ $ mkdir h
> doener@atjola:~ $ cd h
> doener@atjola:h $ svnadmin create repo
> doener@atjola:h $ svn co file://$PWD/repo wc
> Checked out revision 0.
> doener@atjola:h $ cd wc
>
> doener@atjola:wc $ touch foo; svn add foo; svn commit -m init
> A =C2=A0 =C2=A0 =C2=A0 =C2=A0 foo
> Adding =C2=A0 =C2=A0 =C2=A0 =C2=A0 foo
> Transmitting file data .
> Committed revision 1.
> doener@atjola:wc $ svn mv foo bar; svn commit -m rename
> A =C2=A0 =C2=A0 =C2=A0 =C2=A0 bar
> D =C2=A0 =C2=A0 =C2=A0 =C2=A0 foo
> Adding =C2=A0 =C2=A0 =C2=A0 =C2=A0 bar
> Deleting =C2=A0 =C2=A0 =C2=A0 foo
>
> Committed revision 2.
> doener@atjola:wc $ cd ..
>
> doener@atjola:h $ svn blame file://$PWD/repo/bar
> doener@atjola:h $ svn blame file://$PWD/repo/bar@1
> svn: '/bar' is not a file in revision 1

svn blame file://$PWD/repo/foo@1 works perfectly though, that was my us=
e case.

Sorry for doing like a point-by-point refute of your response here, I
probably wasn't clear enough in my original email. However, thank you
Thomas Rast for your suggestions, as the git-blame syntax is much more
powerful and allows me to do exactly what I wanted.

Does anyone object to making the following wording in the git-annotate =
manpage:
The only difference between this command and linkgit:git-blame[1] is th=
at
they use slightly different output formats, and this command exists onl=
y
for backward compatibility to support existing scripts, and provide a m=
ore
familiar command name for people coming from other SCM systems.

slightly stronger? git-blame destroys git-annotate as far as I can see
with the "rev first then file" syntax which actually allows you to get
past annotations on renamed or deleted files.

-Dan
