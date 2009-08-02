From: skillzero@gmail.com
Subject: Re: Subtree merging of sub-directories between repositories?
Date: Sun, 2 Aug 2009 11:05:43 -0700
Message-ID: <2729632a0908021105m10bfb8ddx700464d06fd38023@mail.gmail.com>
References: <2729632a0908012337l6d84ba76o81239d324ba11cf2@mail.gmail.com>
	 <32541b130908020130q11f1fa03yca276ab86c2ea4d5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 02 20:06:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MXfRY-0006OM-Hu
	for gcvg-git-2@gmane.org; Sun, 02 Aug 2009 20:06:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753274AbZHBSFp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 2 Aug 2009 14:05:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753243AbZHBSFo
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Aug 2009 14:05:44 -0400
Received: from qw-out-2122.google.com ([74.125.92.25]:10349 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753237AbZHBSFo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 Aug 2009 14:05:44 -0400
Received: by qw-out-2122.google.com with SMTP id 8so1544296qwh.37
        for <git@vger.kernel.org>; Sun, 02 Aug 2009 11:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=FUNqig4IxB22qZQYW6hs8W7+o8xFfpyzkrUCdCF4Mng=;
        b=mmpa7iNOU5bux5MoV7W1Iuje0BrEefgFHwb0QhtYNBPaADvGTpk7WZ64eJqi3b+MRG
         gs6GPvgdT2x3igSqxulAdIQapW7XXO9+yE8ucDxQg6G+pvmMojLfFkPwpNMi14rDl5Mo
         HPnY33a1QXLQ2JRIrv7hTGqldCb3nuOGHhc7c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ZZP1uQdq7tIri5pGuL/UzNiz7C1uXYtEzHBWlSm/QpvR9UfNESdU+wJHcRDn0zpEh0
         L5vdLjCllgpSg9YP/BXQXHNxmnsifR58eknsC+bwm2tYr7JEDdSz9MVCK8RD9qOKH8VL
         IXVSBq53pn2RxfDBtIaoLriaTEjNxPYBL2Qq4=
Received: by 10.224.45.195 with SMTP id g3mr3972536qaf.168.1249236343712; Sun, 
	02 Aug 2009 11:05:43 -0700 (PDT)
In-Reply-To: <32541b130908020130q11f1fa03yca276ab86c2ea4d5@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124674>

On Sun, Aug 2, 2009 at 1:30 AM, Avery Pennarun<apenwarr@gmail.com> wrot=
e:
> On Sun, Aug 2, 2009 at 2:37 AM, <skillzero@gmail.com> wrote:
>> Is it possible to use the subtree merge strategy to import just one
>> directory from a repository into a directory of a different
>> repository? The subtree merge example describes bringing in an entir=
e
>> repository as a directory, but I'm not sure how to adapt that to jus=
t
>> import part of the source repository. The repositories are completel=
y
>> different, but repository A has a couple directories I want to impor=
t
>> into repository B (along with the history that affected those
>> directories). I may also make changes on either side and it would be
>> nice to be able to re-merge in either direction.
>>
>> I was thinking I might need something like the git-subtree script, b=
ut
>> maybe this can be done with standard git commands?
>
> git tracks the history of the entire tree, not each subtree. =C2=A0So=
 if
> you use the existing set of commit objects in A, then you'll pull in
> *all* the files of A.
>
> You have basically two choices here:
>
> 1) Merge the *entire* history of project A into project B, and during
> the merge, delete the files you don't want. =C2=A0(This will result i=
n a
> repo that's about the size of A+B, even if you only keep 1% of the
> files, and every change to every file in A will now show up in B's
> history.) =C2=A0Merging future changes from A to B will be relatively=
 easy
> (although you'll get conflicts on those files you deleted), but
> merging from B back to A will probably make a mess.
>
> 2) Use "git subtree split" to take the subdir of A and give it a
> history of its own, then merge that history into a subdir of B (using
> "git subtree add" or any other subtree merge method you want to use).
> You can then git subtree split/merge back and forth between A and B i=
n
> the future to copy future changes from one to the other.
>
> The disadvantage of #2 is that git subtree ends up creating new "fake=
"
> commit objects for your new shared subproject. =C2=A0If you merge the=
 new
> subproject back into A, you'll end up with some duplicate commit
> messages (unless you use --squash).

Thanks for the help. I tried #2 and it sort of worked. The history was
imported, but the resulting paths were flattened. Here's what I did:

=46rom repository 1:
git subtree split --prefix=3DA/B/C --rejoin
=2E.. printed commit ID 11f1ef890c49634e822a40a818a6ac88bfc50f07

=46rom repository 2:
git remote add -f Repo1 /path/to/repo/1
git subtree add --prefix=3DX/Y/C 11f1ef890c49634e822a40a818a6ac88bfc50f=
07

If I do 'git log X/Y/C', I only see a single commit:

    Add 'X/Y/C/' from commit '11f1ef890c49634e822a40a818a6ac88bfc50f07'

    git-subtree-dir: X/Y/C
    git-subtree-mainline: 8b07aa647895aa8a7597dc545821bfd195ecaf7f
    git-subtree-split: 11f1ef890c49634e822a40a818a6ac88bfc50f07

The full history doesn't seem to be associated with that directory. If
I do 'git log --name-only --topo-order', I see the full history, but
the files are listed as:

file.c

and I was expecting to see:

X/Y/C/file.c

Because I'd want to be able to do 'git log X/Y/C' and see all the
commits that affect that directory.

Is there a way to import such that the relative paths are retained? So
for the above example, since file.c came from A/B/C/file.c in the
original repository, I'd want it to show up in the log for
X/Y/C/file.c.
