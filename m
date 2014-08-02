From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: cherry picking and merge
Date: Sat, 2 Aug 2014 17:29:31 +0100
Organization: OPDS
Message-ID: <7CCCA1CCC7F342FA9037AAFEDCEDB53F@PhilipOakley>
References: <51C01AAA-3CFB-4110-BAE9-7D04CA8EE53A@comcast.net> <20140801024329.GA28914@vauxhall.crustytoothpaste.net> <53DBBFE8.8060607@gmail.com> <5AF18A76-DD3B-4B9A-BF70-EFE4BB852C3D@comcast.net> <4EA0D79811C348C6893039D315E6E190@PhilipOakley> <FC00A4BB-6CB9-421D-83D6-4E1AFBB4CB3C@comcast.net>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252;
	format=flowed	reply-type=original
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Jakub Narebski" <jnareb@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	<git@vger.kernel.org>
To: "Mike Stump" <mikestump@comcast.net>
X-From: git-owner@vger.kernel.org Sat Aug 02 18:29:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XDcBe-0002bP-O9
	for gcvg-git-2@plane.gmane.org; Sat, 02 Aug 2014 18:29:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754712AbaHBQ3d convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 2 Aug 2014 12:29:33 -0400
Received: from out1.ip05ir2.opaltelecom.net ([62.24.128.241]:20678 "EHLO
	out1.ip05ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754618AbaHBQ3c (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 2 Aug 2014 12:29:32 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AmwrAMEQ3VMCYJjrPGdsb2JhbABZgw1jAUWHL4EEyywBAgEBDHcXBQEBAQE4NoN+BQEBBAEIAQEoAQUeAQEhBQYCAwUCAQMVAQIJJRQBBBoGBwMUBhMIAgECAwGIHQMJDLZAiSMIhxQXiX+FTTWDAYEcBZFdolY8L4EEAh4EAg
X-IPAS-Result: AmwrAMEQ3VMCYJjrPGdsb2JhbABZgw1jAUWHL4EEyywBAgEBDHcXBQEBAQE4NoN+BQEBBAEIAQEoAQUeAQEhBQYCAwUCAQMVAQIJJRQBBBoGBwMUBhMIAgECAwGIHQMJDLZAiSMIhxQXiX+FTTWDAYEcBZFdolY8L4EEAh4EAg
X-IronPort-AV: E=Sophos;i="5.01,787,1400022000"; 
   d="scan'208";a="563219028"
Received: from host-2-96-152-235.as13285.net (HELO PhilipOakley) ([2.96.152.235])
  by out1.ip05ir2.opaltelecom.net with SMTP; 02 Aug 2014 17:29:30 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254703>

=46rom: "Mike Stump" <mikestump@comcast.net>
Sent: Friday, August 01, 2014 11:10 PM
(part 2)
> On Aug 1, 2014, at 11:57 AM, Philip Oakley <philipoakley@iee.org>=20
> wrote:
>> For some central control use styles, the ideas behind _distributed_=20
>> version control are anathema and (Git) just grinds away at the=20
>> policies that are expected.
> ...
>> of the 'relativity' that comes with being distributed - truth has to=
=20
>> give way to a web of trust). Also the artefacts that Git validates=20
>> are at a different level of abstraction i.e. the whole project as a=20
>> commit, rather than just a few/one file at a time.
>
> Ah, so that gives me an idea.  [ pause ] If we try the cherry-pick as=
=20
> retroactively creating a feature branch, cherrying into that, then=20
> merge unconditionally so that no change happens that into trunk (thus=
=20
> killing those conflicts), and then git merge that feature branch into=
=20
> branch then it all works perfectly.  See, another existence proof tha=
t=20
> you are wrong, this time with git itself.
>
> It was 13 lines of code, so, apparently, it is possible and easy to=20
> do, in git.  Now, we just want the cherry-pick to create a temporary=20
> cherry branch, cherry the pick into it, merge and drop into trunk and=
=20
> merge into branch=85
>
> I tested with the below and it worked just fine.  Things to clean up,=
=20
> we want the meta data on the cherry on the merge commit, but, you get=
=20
> the idea.
>

I've annotated some of the bits to make sure we are on the same=20
wavelength as to what this does...

> branch=3Db
> master=3Dmaster
> base=3D$(git merge-base $branch $master)

> cherry=3D"$1"  # not quite sure where this commit is located relative=
 to=20
> either $branch or $master

>
# create a new branch, starting at base, for our cherry picked commit
> git checkout -b cherry-$branch $base
> git cherry-pick "$cherry" # which also commits onto our cherry pick=20
> barnch

> git checkout $master
> git merge -s ours cherry-$branch # "mark/remember" the cherry branch,=
=20
> its fix and it's base point, but don't actualy use it here on $master

> git checkout $branch
> git merge cherry-$branch # bring the 'fix' into $branch

> git branch -d cherry-$branch # remove the fix branch that started at=20
> $base - branches are ephemeral anyway.

# still on $branch, which already has the change merged in (Git style) =
?
> git cherry-pick --strategy=3Dours --allow-empty "$cherry" # check its=
=20
> all already included?
> git commit --allow-empty
>

Does my annotation match your understanding? It wasn't clear to me wher=
e=20
$1 had been hiding previously, nor why the common fix didn't use a=20
"merge -s ours cherry-$branch" in both cases - that maybe my=20
misunderstanding about how your workflow goes.

> I tested that with two cherries with further changes on master to=20
> ensure that it works for more than a single one, no problem.  Wow,=20
> even tried a merge of master back into b, and it worked just fine, no=
=20
> conflicts, yet, all the code was jammed up together nicely.
>
> So, if you wish to continue your position, please explain why it can=92=
t=20
> get this better, given the existence proof above of it working better=
=20
> in git.
>
=2E..
> I have two possible conflict fixups in the above.  In my case (I have=
=20
> a specific patch in gcc-land i wanted to cherry), those fixups were=20
> trivial (no conflicts).  When they are trivial, I don=92t care much t=
hat=20
> there were two of them.  When non-trivial, well, I=92m resigned to th=
e=20
> idea that I have to explain what is going on.
>
>> Selecting a compatible workflow is a problem of usage,
>
> Not when the workflow is mandated on you to work around trivial littl=
e=20
> bugs that can be fixed but for which the author=92s don't even=20
> comprehend the bug.
>
>> rather than a problem in Git.
> --


Philip.=20
