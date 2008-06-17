From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [StGit PATCH 03/14] Write to a stack log when stack is modified
Date: Tue, 17 Jun 2008 15:11:42 +0100
Message-ID: <b0943d9e0806170711w6da8e841p3ac83a59a81f6577@mail.gmail.com>
References: <20080612052913.23549.69687.stgit@yoghurt>
	 <20080612053424.23549.64457.stgit@yoghurt>
	 <b0943d9e0806170324j12605a55m41b582ad09925cce@mail.gmail.com>
	 <20080617123138.GA6932@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Tue Jun 17 16:13:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8bvK-0003OT-O5
	for gcvg-git-2@gmane.org; Tue, 17 Jun 2008 16:12:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756069AbYFQOLn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Jun 2008 10:11:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754812AbYFQOLn
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jun 2008 10:11:43 -0400
Received: from rv-out-0506.google.com ([209.85.198.236]:53800 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754039AbYFQOLm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Jun 2008 10:11:42 -0400
Received: by rv-out-0506.google.com with SMTP id k40so4239087rvb.1
        for <git@vger.kernel.org>; Tue, 17 Jun 2008 07:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=KgNRo5QqvJD/NRPqxw7b9FQaMe/k/Tt0U4tanA7nrd8=;
        b=AMsDs9nSeN8PCA1RvDnQp18RdYvb4R2HVCbpNTaK7dxG69UnKwwNxC26QuG8TBAEU9
         h/KARXl81at+VNdTChtUVSZtQTxV/Ja71Zqwdw/N5kubGWEu0iFDdXrzfa54eYXvmySt
         jRMn7f6gDsDjd0i+eL4sxVepm1aUqSfO0wn1s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=e+pg6jaccv4kQuzOrpxzVC11ANpTNIqDSs2oK2+hAsbiG9isJNwkFt+eYJc5ZmtNjj
         lSmtSe0RbUKkkPlXZMJ5YXOaTVuNH63zkuiaMfKzbs5qEM+TbpG/dB0qCwyhhqoa1Sqp
         a9pdmUnHuUOgizywk4uPnhCOCldW6LmTVbzFU=
Received: by 10.114.81.1 with SMTP id e1mr7990550wab.11.1213711902121;
        Tue, 17 Jun 2008 07:11:42 -0700 (PDT)
Received: by 10.114.193.12 with HTTP; Tue, 17 Jun 2008 07:11:42 -0700 (PDT)
In-Reply-To: <20080617123138.GA6932@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85299>

2008/6/17 Karl Hasselstr=F6m <kha@treskal.com>:
> On 2008-06-17 11:24:53 +0100, Catalin Marinas wrote:
>> 2008/6/12 Karl Hasselstr=F6m <kha@treskal.com>:
>> >  class _Directory(object):
>> > -    def __init__(self, needs_current_series =3D True):
>> > +    def __init__(self, needs_current_series =3D True, log =3D Tru=
e):
>>
>> i.e. we make log =3D False here by default.
>
> I might not have understood precisely what you meant; but I don't
> think API backwards compatibilty should be an issue here? I simply fi=
x
> all callers. If log should default to true or false is immaterial --
> it just means some extra text in one or the other of two equally
> common cases.

Not an issue, I just favour the existing one when the two cases are
almost equal.

>> > --- /dev/null
>> > +++ b/stgit/lib/log.py
>> > @@ -0,0 +1,254 @@
>> > +r"""This module contains functions and classes for manipulating
>>
>> Why does this start with an 'r'? I thought this is for regular
>> expressions.
>
> "r" in front of a string literal means "raw" (or some such). Escape
> sequences aren't recognized inside a raw string -- e.g., r'\n' =3D=3D
> '\\n'. They are useful when you have to write strings with embedded
> backslashes, such as regexes -- or this string, which has \n in it.

Thanks, I didn't know this.

>> > +A stack log is a git branch. Each commit contains the complete st=
ate
>> > +of the stack at the moment it was written; the most recent commit=
 has
>> > +the most recent state.
>> > +
>> > +For a branch C{I{foo}}, the stack log is stored in C{I{foo}.stgit=
}.
>>
>> The main question. Is this history preserved after a git-gc?
>
> Yes. It's stored in a regular git branch. (The design is such that it
> should even be possible to pull a stack log from another repository
> and _still_ get everything you need.)

But how are the patches recreated when undoing (the
refs/patches/<branch>/* files)? Using the Bottom/Top tree ids that a
patch had in the past? Are these trees still present after a git-gc?

>> > +  - C{patches}: a tree containing one subtree for each patch, nam=
ed
>> > +    after that patch. Each such subtree contains:
>> > +
>> > +      - C{a}, C{b}: the patch's I{bottom} and I{top} trees.
>> > +
>> > +      - C{info}: a blob containing::
>> > +
>> > +          Author: <author name and e-mail>
>> > +          Date: <patch timestamp>
>> > +
>> > +          <commit message>
>>
>> I might not fully understand this but can we not store just the
>> commit object if the patch, which would have the bottom/top
>> information.
>
> You can't store a commit object in a tree. (Well, with submodules you
> can, but said commit object isn't protected from gc and won't be
> included when pulling.) The idea with this format is that with the tw=
o
> trees and the info file, you can recreate the patch's commit -- not
> exactly, but close enough as makes no difference.

What I meant is the SHA1 value of the patch commit instead of
Bottom/Top, Author and Date. The corresponding commit object has all
this information.

>> > +The simplified log contains no information not in the full log; i=
ts
>> > +purpose is ease of visualization."""
>>
>> Ah, OK. But I think it would be more useful to see the diff between
>> subsequent revisions of a stack rather than the full patch diff.
>
> Have you tried looking at a patch stack log (in gitk, say)?

I tried "gitk master.stgit" and got scared :-)

> That is, "stg log -g" in this patch series.

This is more readable.

> It shows you diffs between
> subsequent revisions of the simplified log. I'm sure it's far from
> perfect, but I think it's actually quite useful.

It is useful, though it might take a bit of time to get used to it. It
might also be a bit difficult if you want to revert some changes to a
single patch but not do a full stack undo which would affect other
patches.

--=20
Catalin
