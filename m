From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [RFC] Add bad-branch-first option for git-bisect
Date: Tue, 25 Jan 2011 10:20:29 +0100
Message-ID: <AANLkTin1rS-ZBDx4j-UNFH4z9tnTiv5LBodLO-G2U2UF@mail.gmail.com>
References: <4D3CDDF9.6080405@intel.com>
	<AANLkTimUkv9+g_+wFcyGhwMjE9zYAKjMn32GL-WOVmoe@mail.gmail.com>
	<4D3D54D3.7040801@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	"apenwarr@gmail.com" <apenwarr@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Shuang He <shuang.he@intel.com>
X-From: git-owner@vger.kernel.org Tue Jan 25 10:20:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Phf4s-0004R2-GV
	for gcvg-git-2@lo.gmane.org; Tue, 25 Jan 2011 10:20:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753148Ab1AYJUe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Jan 2011 04:20:34 -0500
Received: from mail-ew0-f46.google.com ([209.85.215.46]:53221 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753113Ab1AYJUa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Jan 2011 04:20:30 -0500
Received: by ewy5 with SMTP id 5so2425510ewy.19
        for <git@vger.kernel.org>; Tue, 25 Jan 2011 01:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=KpLtrTI0FQ68C2HVstUDGUrOKFdZSRJjLD9E28FTYBA=;
        b=WhXoVdLoF5LBuBvup/RZMUPK6DRKieRXur8KDCCLQ1i90PMcMjDVhhhBCUWIvhSFCh
         PQBO7Qh1ebz89tWwnmxuVuckwJXPqHB2kKWTzk7paAsc6HUyCoBnha+39t32W+wqcetr
         gZTcJbUWihFFR94MH5KSmlRM4TRH7JseFLg6c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=B+b+T0E720j1N2D3l/dt7cK35TzCn8/fQfNxqAtK+pAHL3uFh3ciHRXpwoHDg9YHT2
         5N+zDTmPkQNDgcHHJ+9bBmHj2twIN8JREbbo5uB6d7c+WgwZppfP0J9/66BJtS4xR6xo
         +Hm4VezGqSomLPZZ14AFY1rwsgCieoxHwi/X4=
Received: by 10.216.183.145 with SMTP id q17mr4697140wem.5.1295947229083; Tue,
 25 Jan 2011 01:20:29 -0800 (PST)
Received: by 10.216.30.65 with HTTP; Tue, 25 Jan 2011 01:20:29 -0800 (PST)
In-Reply-To: <4D3D54D3.7040801@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165478>

On Mon, Jan 24, 2011 at 11:30 AM, Shuang He <shuang.he@intel.com> wrote=
:
> On 2011/1/24 17:53, Christian Couder wrote:
>>
>> Hi,
>>
>> On Mon, Jan 24, 2011 at 3:03 AM, Shuang He<shuang.he@intel.com> =A0w=
rote:
>>>
>>> Hi
>>> =A0 =A0 The default git-bisect algorithm will jump around the commi=
t tree,
>>> on the purpose of taking least steps to find the first culprit comm=
it.
>>> We may find it sometime would locate a old culprit commit that we'r=
e not
>>> concerned about anymore.
>>
>> Yes, it can be a problem.
>
> I'm honored to be given so much comment :)
> Thank you

I am honored by your interest in git bisect and the fact that you
provided a patch :-)
Thanks!


>> If the quality of these branches is too bad, I think they should not
>> have been merged in the first place.
>> If they are not merged (and not marked as good), then git bisect wil=
l
>> not look at them, since it will look only at commits that are
>> ancestors of the bad commit it is given.
>>
>> Or if one is merged but it causes too many problems, then perhaps a
>> replacement commit could be used to unmerge the branch.
>>
>> Another possibility is to have in a file a list of commits that are
>> the last commits on these branches before the merge commits, and do =
a:
>>
>> git bisect good $(cat good_commits_file.txt)
>>
>> at the beginning of each bisection.
>>
>> So I think the long term solution in this case is not what your are
>> suggesting.
>
> Yeah, I agree that the issue I addressed above will not be a problem =
if all
> those branches are maintained very well.
> Actually we've implemented a automated bisect system for Intel Linux
> Graphics Driver Project, and so we'd like the system
> helps us to locate issue in an more automatic way when branches are n=
ot
> maintained as good as expected.

I think there is always a price to pay when you bisect if the branches
are not well maintained.
Maybe your algorithm could help in some cases, but my opinion is that
there will probably still be many problems and a human will often have
to take a look.

>>> =A0 =A0 =A0 =A0 2. Some of those branches may not synchronized with=
 main
>>> branch in time. =A0Say feature1 is broken when feature2 branch is c=
reated,
>>> and
>>> feature1 is fixed just a moment later after feature2 branch is crea=
ted,
>>> and when feature2's development is done, and developer want to merg=
e
>>> feature2 branch back to master branch, feature2 will be firstly
>>> synchronized to master branch tip, then merge into master. =A0For t=
he same
>>> reason addressed in issue 1, this will also lead git-bisect into wr=
ong
>>> direction.
>>
>> I am not sure what you mean by " feature2 will be firstly synchroniz=
ed
>> to master branch tip", and I think this should mean a rebase that
>> would fix the bug if feature1 has already been merged into the maste=
r
>> branch.
>>
>> But anyway in this case, I think that git bisect will find that the
>> first bad commit is the last commit in the branch, just before it wa=
s
>> merged. And by looking at the branch graph it should be quite easy t=
o
>> understand what happened.

Now I think I was wrong here, as git bisect will probably find that
the first commit in the branch (not the last one) is the first bad
commit.

[...]

>> - the name "bisectbadbranchfirst" seems wrong to me, because git
>> branches are just some special tags; "firstparentsonly" would be a
>> better name,
>
> It's recursively applying bad branch first algorithm, not just consta=
ntly
> stick to first parent.
> Given this condition:
> =A0 =A0A -> B -> C -> D -> E -> F -> G -> H =A0 (master)
> =A0 =A0 =A0 =A0 \ a =A0-> b -> c -> d -> e / =A0(feature 1)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0\ x -> y -> z/ =A0 =A0 =A0(feature 2)
> start with H as bad commit, and A as good commit, if y is the target =
bad
> commit. bad-branch-first algorithm will do it like this:
> =A0 =A01. In first round stick to master branch, so it will locate G =
as first
> bad commit
> =A0 =A02. In second round stick to feature1 branch, then it will loca=
te d as
> first bad commit
> =A0 =A03. In third round stick to feature2 branch, then it will final=
ly locate y
> as first bad commit
> So you could see, it's always sticking to branch where current bad co=
mmit
> sit

I see. It is interesting, but why not develop a "firstparentsonly"
algorithm first?

As Avery explains in his email, it is already interesting to have a
"firstparentsonly" algorithm because some people are only interested
to know from which branch the bug comes from.
When they know that, they can just contact the relevant people and be
done with it.

And when we have a "firstparentsonly" algorithm, then your algorithm
could be just a script that repeatedly uses git bisect with the
"firstparentsonly" algorithm. And this script might be integrated in
the "contrib" directory if it not considered important to be
integrated as an algorithm into git bisect.

Thanks,
Christian.
