From: Jan Koprowski <jan.koprowski@gmail.com>
Subject: Re: Solve continuous integration (pending head / commit queue) 
	problem using git
Date: Fri, 12 Feb 2010 19:07:38 +0100
Message-ID: <c41cd75d1002121007k4da9a617t161b699a3bca0fa7@mail.gmail.com>
References: <c41cd75d1002120837t20f2a47fi41e8c67245c4284c@mail.gmail.com>
	 <32541b131002120942w50a29e7cjf2c10820b3286017@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 12 19:07:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nfzvd-0007nG-MC
	for gcvg-git-2@lo.gmane.org; Fri, 12 Feb 2010 19:07:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752838Ab0BLSHk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 12 Feb 2010 13:07:40 -0500
Received: from mail-bw0-f212.google.com ([209.85.218.212]:33038 "EHLO
	mail-bw0-f212.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752092Ab0BLSHj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Feb 2010 13:07:39 -0500
Received: by bwz4 with SMTP id 4so3072677bwz.2
        for <git@vger.kernel.org>; Fri, 12 Feb 2010 10:07:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=Om/v5bILgRhtLrESnPvyzZNqFm4RjbVDU7iRE3usVRI=;
        b=TisUm89o7/DJfqlU6hc3+jR5uW9mM3STsO4BnxE4msj4ptxoQCbArLDyGN9w/eYXz1
         A8nhY8G9vS3ZMNoD/ywqPqznwrj4+oW3za/YWWp2K+NvfTwZ1raTavzeInckU0VlgGwF
         8+jq+KpsvrR9d87emHEfarrLB4nStBDFvnDsM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=VHuR/VddczPtj9eidLLtUCUGsglHPdEtV+RJ15WQMkukM1YH0y4EWD3W6dpRaebU3B
         Psah5csNG+w3q0nrEkzFzyaIY+FWSCSGgbDuHuxgIZA/s1ygxiSh64mCRpIXDqwzryP8
         2bFqNc3GbXn7uYOATYVK+2FGmyPh0aY1tsKGs=
Received: by 10.204.16.88 with SMTP id n24mr1078497bka.89.1265998058359; Fri, 
	12 Feb 2010 10:07:38 -0800 (PST)
In-Reply-To: <32541b131002120942w50a29e7cjf2c10820b3286017@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139736>

On Fri, Feb 12, 2010 at 6:42 PM, Avery Pennarun <apenwarr@gmail.com> wr=
ote:
> On Fri, Feb 12, 2010 at 11:37 AM, Jan Koprowski <jan.koprowski@gmail.=
com> wrote:
>> Now. My idea. There is some revision tagged as "stable". *Clone* and
>> *pull* operations is somehow "overloaded" from server side and alway=
s!
>> return last revision tagged as stable. After compiling external tool
>> just move tag to another revision which pass all tests. Of course
>> there is some additional parameter (for example --last or --unstable=
)
>> which can clone fine way of repository.
>>
>> Two questions.
>> 1) Maybe I try to invent the wheel again. Is there any way to take t=
he
>> effect without overloading standard git behaviours.
>> 2) If not how overload git behaviors on git "server side" repo?
>
> In general, code that lies to you about what's the most revision is
> evil. =C2=A0Sometimes you *do* want to fetch that revision it's lying=
 to
> you and saying doesn't exist, precisely because you'd like to help fi=
x
> it before integration.
>
> What you really want is:
>
> - nobody can push to the "integration branch" except the "integration=
 manager"
>
> - the "integration manager" should be a computer program, so that you
> can have "continuous integration"
>
> This isn't actually that hard. =C2=A0Give each user their own reposit=
ory;
> no user can write to any other user's repository. =C2=A0(This is the
> default setup on github.com, for example.) =C2=A0Alternatively, just =
tell
> people to never, ever push to the master branch by themselves. =C2=A0=
People
> are easily capable of following rules like that unless they're
> actively trying to screw you.
>
> Then set up something like gitbuilder
> (http://github.com/apenwarr/gitbuilder) (Full disclosure: I wrote it)
> to build *all* the branches from *all* the users. =C2=A0This sounds l=
ike it
> would create exponential work for the build machine, but it doesn't,
> since most users will have mostly the same commits anyway.
>
> When gitbuilder tags a particular commit as having built and passed
> all tests, then it becomes a candidate for merging into the
> integration branch. =C2=A0Write a little script that goes through can=
didate
> branches, checks their gitbuilder status, and if they've passed,
> pushes them into the integration branch. =C2=A0The push will only suc=
ceed
> if the integration branch can be fast-forwarded to match the branch
> you're trying to push; if you can't, it'll be rejected, which is what
> you want, since merging (even conflict-free merging) might break
> tests.
>
> That mechanism works pretty well at my company, with one exception: w=
e
> didn't bother with an automatic tool that merges into master. =C2=A0W=
e
> prefer to have a release manager do that.
>
> Have fun,
>
> Avery
>

Probably I don't have a problem (or it is a lateness). Because only
tagging as stable and making two compile loops: one per management
always compiling stable tag and second compiling latest repo... And
that is all :D

--=20
><> Jan Koprowski [696775174] GSM
