From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Finding a branch point in git
Date: Mon, 28 May 2012 14:36:04 +0200
Message-ID: <CAMP44s04msWMOaaH8U30XXg5yXJnEd=bULJ7VPxWSD0Wfh2=EA@mail.gmail.com>
References: <CAMP44s0f7AJPQSTDgvy0U7vx8nxzq2a3vMhSr2Tcc61fetFkJA@mail.gmail.com>
	<20120528062026.GB11174@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon May 28 14:36:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYzBE-0003JH-9L
	for gcvg-git-2@plane.gmane.org; Mon, 28 May 2012 14:36:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752786Ab2E1MgH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 May 2012 08:36:07 -0400
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:45868 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751938Ab2E1MgF convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 May 2012 08:36:05 -0400
Received: by lahd3 with SMTP id d3so1868858lah.19
        for <git@vger.kernel.org>; Mon, 28 May 2012 05:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=1ExLRX0h8uSBe9jTDfG2Ost6W6DpPWVtVEPEIxwDZn4=;
        b=J0U9ZIEi6IrfL3lqhvCYHOCL5Z/rOedaz8u58YL4zKjBjMzg8/zKeubJuFOYnHLBKS
         faU6ZwtwFYm/va6/zBOGLxzbOf6rHPm2FfdsBUjDoRF94XbHvoDtQJj18Sn1uc+d4kwc
         dxVul3Lwdj6N3y67VeNDuCgDWqdAHcTjONYj9Cgu/c1tzhEHQ4SM5/dqAvp9Y3+WJSt2
         87dyuCYfiCEn3axmw9o1dgE6bQ0nmRHJpqz8Ascz0K0us4qGhPR4N8L8o4YvfuWMDLoL
         Ma/K1odb7CFxqawRGRMaJ/zSV6jCMFo9kXZqtOiRGAqFVbcBsVH0Cg9eNxuW+W2KZZ0d
         jN/A==
Received: by 10.112.82.165 with SMTP id j5mr3652291lby.50.1338208564045; Mon,
 28 May 2012 05:36:04 -0700 (PDT)
Received: by 10.112.107.65 with HTTP; Mon, 28 May 2012 05:36:04 -0700 (PDT)
In-Reply-To: <20120528062026.GB11174@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198706>

On Mon, May 28, 2012 at 8:20 AM, Jeff King <peff@peff.net> wrote:
> On Sun, May 27, 2012 at 02:37:32PM +0200, Felipe Contreras wrote:
>
>> When discussing git vs. mercurial, and what can mercurial do that gi=
t
>> can't, I inevitably see somebody mention that mercurial branches can
>> be used to find the branch point (the point at which a branch starte=
d;
>> even if it's a long-lived one that has been merged to 'master'
>> multiple times).
>>
>> There have been a few solutions in stackoverflow[1], but none that
>> work in all cases.
>>
>> But I think I've found an ad-hoc one that uses the commit messages t=
o
>> find the first merge of a branch, and then the merge-base.
>>
>> For reference, if somebody is interested:
>>
>> ---
>> [alias]
>> =C2=A0 =C2=A0 branch-point =3D !sh -c 'merge=3D$(git rev-list --min-=
parents=3D2
>> --grep=3D"Merge.*$1" --all | tail -1) && git merge-base $merge^1
>> $merge^2'
>> ---
>
> I think this approach works for two-branch cases, but there is some
> subtlety with the regex. My initial thought was that you were looking
> for "Merge 'branch_A'" in the commit message (and that is what is
> implied by your stackoverflow response). If you always merge the topi=
c
> into the main branch, then you will find the first merge. But imagine
> this history:
>
> -- X -- A -- B -- C -- D -- =C2=A0E =C2=A0(master)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 \ =C2=A0 =C2=A0 =C2=A0 =C2=A0 \ =C2=A0 =C2=
=A0 =C2=A0 =C2=A0/
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\ =C2=A0 =C2=A0 =C2=A0 =C2=A0 \ =C2=
=A0 =C2=A0 =C2=A0/
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 G -- H -- I -- J =C2=A0(branch A)
>
> where I is a merge from master to branch A (e.g., for testing), and t=
hen
> E is a merge from branch A to master (the actual integration).
>
> Searching for "Merge 'branch_A'" will find E, and then you will take
> the merge base of J and D, which is C. But the answer you want is A.
> However, we also say "Merge master into 'branch_A'" when HEAD is not
> master. So your regex _would_ catch that, and would find I, for which
> the merge base is A.

Yeap.

> What about a history with multiple branches?
>
> --X--A--B--C--D----E =C2=A0(master)
> =C2=A0 =C2=A0 =C2=A0\ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /
> =C2=A0 =C2=A0 =C2=A0 G--H--I---J =C2=A0 (branch X)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \ =C2=A0 =C2=A0/
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0K--L =C2=A0 =C2=A0(branch Y)
>
> where Y is merged to X (commit J), and then X is merged to master
> (commit E). Searching for the earliest merge mentioning X will find J=
,
> the merge between X and Y. But the merge base of its parents is H.
>
> You can improve your regex by specifying a pair of branches and
> looking for "Merge X into master" and "Merge master into X" (IOW, mak=
e
> sure we don't see merges between X and other branches). Then you woul=
d
> find E, which yields the correct answer.

Yes, but then you would need to specify a second branch. I would avoid
that if possible.

> There are also even more complex cases. It doesn't make much sense to
> ask about where branch Y split from master, since it actually came fr=
om
> branch X in the above example. But let's say we branched straight fro=
m
> master, merged our result to X, which got merged to master, and then =
we
> built some more commits on Y and merged them to master. Like:
>
> --X--A--B--C--D----E--F (master)
> =C2=A0 =C2=A0 |\ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 / =C2=A0/
> =C2=A0 =C2=A0 | \ =C2=A0 =C2=A0 =C2=A0 =C2=A0 / =C2=A0/
> =C2=A0 =C2=A0 =C2=A0\ G--H----I =C2=A0/ =C2=A0(branch X)
> =C2=A0 =C2=A0 =C2=A0 \ =C2=A0 =C2=A0 =C2=A0 / =C2=A0/
> =C2=A0 =C2=A0 =C2=A0 =C2=A0K--L--M--O =C2=A0(branch Y)
>
> The only merge between master and X is F, but its merge base is M. We
> missed the earlier merge to master because it actually happened acros=
s
> two different commits.

Cases 2) and 3) would work if the search was for "Merge branch 'X'",
but then case 1) would fail. One possible solution would be to find
the earliest "Merge branch 'X' into (\w+)", and then search if there
are any earlier "Merge branch '$1' into X".

There's also another case that doesn't work:

-- X -- A -- B (master)
         \
          \
           C (branch A)

Shouldn't be hard to add checks for those cases I think.

Cheers.

--=20
=46elipe Contreras
