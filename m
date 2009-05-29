From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: [RFC][StGit PATCH] Add support for merge-friendly branches
Date: Fri, 29 May 2009 10:16:52 +0100
Message-ID: <b0943d9e0905290216m3c2bb639kc951510c72212ff@mail.gmail.com>
References: <20090528111212.21925.45527.stgit@pc1117.cambridge.arm.com>
	 <20090528124817.GA22262@diana.vm.bytemark.co.uk>
	 <b0943d9e0905280738n51476ab7vd0498ea7a236c4a7@mail.gmail.com>
	 <20090529083739.GB9760@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?Karl_Hasselstr=F6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Fri May 29 11:17:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9yDP-00083C-KD
	for gcvg-git-2@gmane.org; Fri, 29 May 2009 11:17:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754094AbZE2JQx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 May 2009 05:16:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753979AbZE2JQw
	(ORCPT <rfc822;git-outgoing>); Fri, 29 May 2009 05:16:52 -0400
Received: from ey-out-2122.google.com ([74.125.78.26]:61643 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751047AbZE2JQv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 May 2009 05:16:51 -0400
Received: by ey-out-2122.google.com with SMTP id 22so38132eye.37
        for <git@vger.kernel.org>; Fri, 29 May 2009 02:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=6JFD0WH1cqcP/LnWOBZRLebbkGQ5r5VZ5becf90/pck=;
        b=fp+OpX/YkUEaebJIGJCAxLVoTtbII29GEB5K4bdyB/s30IzI96Zo9j8Sx/9liOI4r+
         tuem0nImnKSwNe82678BxazA2QZr9I1jCrWi3pAr4blMJlmPx2lWqxSgRPh7/MJNRJWi
         cuWQtK69zUfYKOijoORU8+naGdAWoaEjTwizA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=vqchAWVEE+XbQ5Umh0AFgs3tXbqoIDzwC48WdjW2CERH8PNZgQSHu1KU6C34dLM9uI
         Gl77HA6nOPTkM9O+e/FHEK1H/oaxanROyLGw57TF6KSUZirdJzsZh4LnzS0UDDn6n4KT
         oW8tegE54SY2bEidh6bM0ZQPTDIaPUZYJw5mQ=
Received: by 10.216.2.210 with SMTP id 60mr846457wef.21.1243588612360; Fri, 29 
	May 2009 02:16:52 -0700 (PDT)
In-Reply-To: <20090529083739.GB9760@diana.vm.bytemark.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120264>

2009/5/29 Karl Hasselstr=F6m <kha@treskal.com>:
> On 2009-05-28 15:38:44 +0100, Catalin Marinas wrote:
> I think I would've kludged this by making --theirs merges from the
> StGit branch to the public branch. But "stg publish" should definitel=
y
> make the kludge history less ugly.

That's what I'm trying to do, keep the public history clean. One
advantage of merging the full StGit branch is that people could
retrieve the latest patch version but for those interesting in
cherry-picking you can just export the volatile StGit branch.

Regarding the resulting tree, rebasing a StGit stack is equivalent, on
a linear history branch, to a merge of the new stack base into the
linear branch. Rather than having to solve conflicts twice, the pubish
command just fakes this merge and sets the resulting tree.

>> > Hmm. Couldn't the merge base conceivably be higher up in the
>> > stack? Like, right at the beginning, don't we have public_head =3D=
=3D
>> > stack.head? That would be caught by the "same tree" check" a bit
>> > earlier, but after adding another patch, don't we have public_head
>> > =3D=3D stack.head^ ? Which would give merge_base =3D=3D public_hea=
d.
>>
>> We could have public_head =3D=3D stack.head^... but that's not an is=
sue.
>> The merge_base above is checked against the base of the stack rather
>> than the top as we assume that the base isn't volatile. So even if
>> public_head is the same as some patch commit, the merge_base above
>> would always be the base of the stack. Only if the stack base was
>> updated, we get a different merge_base (equal to the previous stack
>> base).
>
> The situation I described looks like this:
>
> =A0 =A0B--o--o--o--o--o--P--T
>
> Time goes from left to right. B is the stack base, P the head of the
> public branch, T the stack top. merge_base(P, T) is P, and not B.

I don't check merge_base(P, T) but merge_base(P, B) to avoid the
issues you described. So that's always B.

--=20
Catalin
