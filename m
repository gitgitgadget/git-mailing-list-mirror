From: Marc Khouzam <marc.khouzam@gmail.com>
Subject: Re: git-completion.tcsh
Date: Thu, 23 Apr 2015 17:08:53 -0400
Message-ID: <CAFj1UpHBk1JFmSv4T=wQUNiade9ZW8yiaco9z2-wGJh7yXATuA@mail.gmail.com>
References: <20150401115519.Horde.JM0TEyhacRn5LYAEffMggQ1@webmail.informatik.kit.edu>
	<481BCBD7-457B-4AFB-B878-1417C8C5940C@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	git@vger.kernel.org
To: Perry Rajnovic <perry.rajnovic@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 23 23:09:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YlOMz-0002sE-Sr
	for gcvg-git-2@plane.gmane.org; Thu, 23 Apr 2015 23:09:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031201AbbDWVI6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 23 Apr 2015 17:08:58 -0400
Received: from mail-wg0-f52.google.com ([74.125.82.52]:34232 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031198AbbDWVIz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Apr 2015 17:08:55 -0400
Received: by wgso17 with SMTP id o17so31559091wgs.1
        for <git@vger.kernel.org>; Thu, 23 Apr 2015 14:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=HZcunSSWZ1EQhAS6mbN5Hi1Gx0GhxYKIgYpN6i9cb5g=;
        b=K5noCegFQ9mlqFnJNGqFdLhYaudclB92533IQa+5m3TcYHFozkxyLylJ+8qHgwWpsh
         z/C4QkfG8fAXbcEq0e67EXcFi+bwKbTEF6A/T02ejB0n6ey/NYl5z8tXcohVBa9QnthO
         u6WZ0dDuANiputF+SDxgGOLYg79t0XYfpk58nt3YQ4shdFpm/pV+VFWW9bPWSnUn6oO/
         XIxuRBODL1dhPf4bddvLLvYp9ipMPn74bLuvj7elW40DJUqz/m1tnEEPDKr17vee1cCz
         Lh2dIRmBoFT+kk9skXhqTaD4TRRVx0Ioi/fWm62M6j7BtxpITOiGwEYyV58BVKG+wKzN
         l9tQ==
X-Received: by 10.180.83.130 with SMTP id q2mr303300wiy.89.1429823333142; Thu,
 23 Apr 2015 14:08:53 -0700 (PDT)
Received: by 10.28.176.5 with HTTP; Thu, 23 Apr 2015 14:08:53 -0700 (PDT)
In-Reply-To: <481BCBD7-457B-4AFB-B878-1417C8C5940C@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267710>

Hi,

I did notice the problem a while ago and had traced it back to the
fact that the bash completion scripts no longer adds the trailing '/'
at the end of directories.
Tcsh needs that '/' to know not to add that annoying extra space.

Bash 3 needed to put it that trailing '/' but bash 4 did not.  Two
years ago (!) changes were made in commit
3ffa4df4b2a26768938fc6bf1ed0640885b2bdf1 to allow bash 3 to work
without the trailing '/'.  That caused
the problem in the tcsh script.

The thing is that with master of today, I don't see the problem any
more.  I can't tell you when it started working again.
What is interesting is that the reason it now works is that the
git-completion.bash script no longer returns anything
for the case you mention:
  git add f<tab>
Instead, it seems to rely on file completion only.  File completion is
simulated by the tcsh script, so things work.

I tried with both git add and git rm and didn't see the problem as you
described it.

You can troubleshoot the git-completion.tcsh script by running the
generated final script directly.  For example, to see the completions
for a command line like:
    git rm f<tab>
you can run:
  bash ~/.git-completion.tcsh.bash git 'git rm f'

I plan on posting a patch to add debug printouts to make this process s=
impler.

Marc

On Thu, Apr 9, 2015 at 12:41 AM, Perry Rajnovic
<perry.rajnovic@gmail.com> wrote:
> G=C3=A1bor,
>
> I updated git to include the macports install with bash completion.  =
under bash it does not exhibit the problem as I described it. To be sur=
e that the completion scripts installed via macports weren=E2=80=99t ne=
wer/different (the .bash completion file had a few minor diffs from wha=
t I had been using), i reinstalled the tcsh completion using those file=
s, but the same behavior happened.
>
> So i=E2=80=99m seeing what you=E2=80=99re seeing, bash completion wor=
ks fine, it=E2=80=99s likely to be something in the wrapper handling.
>
> (updated) environment
> Darwin 14.3.0 Darwin Kernel Version 14.3.0: Mon Mar 23 11:59:05 PDT 2=
015; root:xnu-2782.20.48~5/RELEASE_X86_64 x86_64 (OS X 10.10.3)
> Apple Terminal Version 2.5.3 (343.7)
> git 2.3.4 (+bash_completion, via MacPorts)
> tcsh 6.17.00 (Astron) 2009-07-10 (x86_64-apple-darwin) options wide,n=
ls,dl,al,kan,sm,rh,color,filec
> GNU bash, version 4.3.33(1)-release (x86_64-apple-darwin14.0.0)
>
> Thanks!
>
> Perry
>
>> On Apr 1, 2015, at 20:55, SZEDER G=C3=A1bor <szeder@ira.uka.de> wrot=
e:
>>
>>
>> Quoting Perry Rajnovic <perry.rajnovic@gmail.com>:
>>
>>> When using the auto-completion included with git for tcsh, several
>>> commands do directly completion with an additional space appended t=
o
>>> the end, which defeats the ability to complete to a deeper
>>> sub-directory.
>>>
>>> For example, if I have a git repository including the following:
>>> basedir/foo/bar/somefile.c
>>>
>>> (works as expected, git add)
>>> $ cd basedir
>>> $ git add f<tab>
>>> $ git add foo/
>>> $ git add foo/b<tab>
>>> $ git add foo/bar/
>>> $ git add foo/bar/s<tab>
>>> $ git add foo/bar/somefile.c
>>>
>>> (works not as expected, git rm)
>>> $ cd basedir
>>> $ git rm f<tab>
>>> $ git rm foo
>>> $ git rm foo<backspace>/b<tab>
>>> $ git rm foo/bar
>>> there=E2=80=99s a trailing space after foo and bar in the above lin=
es, which
>>> means it=E2=80=99s not possible to initiate completion or immediate=
ly start
>>> typing, i must back-space before continuing.
>>>
>>> I=E2=80=99m fairly certain i=E2=80=99ve seen this for other command=
s as  well, but
>>> i=E2=80=99m not sure to what extent this occurs throughout the comm=
ands.
>>>
>>> Environment info:
>>> OS: Darwin 14.1.0 Darwin Kernel Version 14.1.0: Thu Feb 26 19:26:47
>>> PST  2015; root:xnu-2782.10.73~1/RELEASE_X86_64 x86_64 (OSX 10.10.2=
)
>>> Apple Terminal Version 2.5.1 (343.6)
>>> git version 2.3.2 (via MacPorts)
>>> tcsh 6.17.00 (Astron) 2009-07-10 (x86_64-apple-darwin) options
>>> wide,nls,dl,al,kan,sm,rh,color,filec
>>
>> The tcsh completion script is just a wrapper, it relies on the bash
>> completion script to do the heavy lifting and tunnels its output int
>> tcsh's completion infrastructure.
>> Could you try bash completion in your environment first to see,
>> whether it's a bash completion issue that I can't reproduce or an
>> issue with the tcsh wrapper?
>>
>> Cc'ing Marc, author of the tcsh wrapper.
>>
>>
>> G=C3=A1bor
>
