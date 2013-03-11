From: Max Horn <max@quendi.de>
Subject: Re: rebase: strange failures to apply patc 3-way
Date: Mon, 11 Mar 2013 22:10:06 +0100
Message-ID: <E042F4D9-79DF-4AEF-8EDE-41BA9E5FB9EC@quendi.de>
References: <7A483B92-D671-46CA-9EFD-83C6F4C97B5E@quendi.de> <494292C5-EBD9-487B-8846-9D9DD23ACB83@quendi.de> <CADeaMWp_R0HLwEYn7O3oX4-0OoSeqLfzz_2AYXT-Po88nM4HkQ@mail.gmail.com> <205D17C4-F737-46E9-BC48-D16D5948C707@quendi.de> <CADgNjan9v++__TSPE55j7+=BBZrVEkMD52O+9kXAm-C8SRV+Ww@mail.gmail.com> <B21B6CEC-7507-47A1-9BBB-FB95EA6B831F@quendi.de> <CADgNja=Ej8jnYn027GX986VrmuqVemM7aE59rynHzUpToPVaEw@mail.gmail.com> <3B5EA38E-9603-4321-AA3C-74354BBC8BFC@quendi.de> <513B8037.7060107@gmail.com> <C79E1B20-2C42-49FF-A964-285A7049FDED@quendi.de> <CADgNjanQxMFrQG=7SqgAXv5PW8OEfG+1kZt_Mrq27OcP1uyGtA@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Andrew Wong <andrew.kw.w@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 11 22:11:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UF9zv-0003cK-Mn
	for gcvg-git-2@plane.gmane.org; Mon, 11 Mar 2013 22:11:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754589Ab3CKVKn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Mar 2013 17:10:43 -0400
Received: from merkurneu.hrz.uni-giessen.de ([134.176.2.3]:42360 "EHLO
	merkurneu.hrz.uni-giessen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754011Ab3CKVKj convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Mar 2013 17:10:39 -0400
Received: from mailgw82.hrz.uni-giessen.de by merkurneu.hrz.uni-giessen.de with ESMTP; Mon, 11 Mar 2013 22:10:17 +0100
Received: from merkurneu.hrz.uni-giessen.de (merkurneu.hrz.uni-giessen.de [134.176.2.3])
	by mailgw82.hrz.uni-giessen.de (Postfix) with ESMTP id AAF7C4800083;
	Mon, 11 Mar 2013 22:10:07 +0100 (CET)
Received: from [134.176.2.3] by merkurneu.hrz.uni-giessen.de with ESMTP; Mon, 11 Mar 2013 22:10:07 +0100
In-Reply-To: <CADgNjanQxMFrQG=7SqgAXv5PW8OEfG+1kZt_Mrq27OcP1uyGtA@mail.gmail.com>
X-Mailer: Apple Mail (2.1283)
X-HRZ-JLUG-MailScanner-Information: Passed JLUG virus check
X-HRZ-JLUG-MailScanner: No virus found
X-Envelope-From: max@quendi.de
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217910>


On 11.03.2013, at 20:15, Andrew Wong wrote:

> On 3/10/13, Max Horn <max@quendi.de> wrote:
>> I did run
>>=20
>>  touch lib/*.* src/*.* && git update-index --refresh && git diff-fil=
es
>>=20
>> a couple dozen times (the "problematic" files where in src/ and lib)=
, but
>> nothing happened. I just re-checked, and the rebase still fails in t=
he same
>> why...
>>=20
>> Perhaps I should add some printfs into the git source to figure out =
what
>> exactly it thinks is not right about those files... i.e. how does it=
 come to
>> the conclusion that I have local changes, exactly. I don't know how =
Git does
>> that -- does it take the mtime from (l)stat into account? Perhaps pr=
oblems
>> with my machine's clock could be responsible?
>=20
> Instead of using "touch", maybe it'd be better if you run "ls-files"
> and "stat" at the point where rebase failed. You should run the
> command as soon as rebase failed. Don't try to run any git commands,
> as they might change the index state.

So I tried this:

  git rebase branches/stable-4.6  # ... which leads to the error
  git ls-files -m

but got nothing. Perhaps you had something else in mind, though, but I =
am not quite sure what... sorry for being dense, but if you let me know=
 what exactly you meant, I'll be happy to try that. As for the stat com=
mand:

>=20
> And yes, git does make use of mtime and ctime from lstat to some
> degree when detecting file changes. Inserting printf's to print the
> timestamp might help, but the output might be too overwhelming to mak=
e
> out useful information, especially during a rebase.
>=20
> BTW, it looks like "stat" command on OS X only prints out timestamps
> in seconds, and doesn't show you the nanoseconds part, which may be
> significant in your situation. Instead of using the "stat" command,
> try using this python command to print out the nanoseconds parts:
> python -c "import sys;import os;s=3Dos.stat(sys.argv[1]);print('%d, %=
f,
> %f' % (s.st_size, s.st_ctime, s.st_mtime))" file1

I can do that, but I am not quite sure what the output should tell me? =
BTW, I think OS X just does not provide the stat information on a nanos=
econd level, at least that python command doesn't seem to yield useful =
extra data... Here is what I got after I just triggered the failing reb=
ase (today it's again a different file it fails on that yesterday...). =
=46or comparision, I run stat first on the file with "conflicts", and t=
hen on a file that is not being touched by the rebase:

  File: =91BAD-FILE=92
  Size: 21058     	Blocks: 48         IO Block: 4096   regular file
Device: e000004h/234881028d	Inode: 19108072    Links: 1
Access: (0644/-rw-r--r--)  Uid: (  502/   mhorn)   Gid: (   20/   staff=
)
Access: 2013-03-11 21:40:14.000000000 +0100
Modify: 2013-03-11 21:40:12.000000000 +0100
Change: 2013-03-11 21:40:14.000000000 +0100
 Birth: 2013-03-11 21:40:12.000000000 +0100
  File: =91NEUTRAL-FILE=92
  Size: 1425      	Blocks: 8          IO Block: 4096   regular file
Device: e000004h/234881028d	Inode: 18180450    Links: 1
Access: (0644/-rw-r--r--)  Uid: (  502/   mhorn)   Gid: (   20/   staff=
)
Access: 2013-03-11 17:58:30.000000000 +0100
Modify: 2013-03-10 14:20:39.000000000 +0100
Change: 2013-03-10 14:20:39.000000000 +0100
 Birth: 2013-02-27 16:18:57.000000000 +0100

Here is the output of the python script for the two files:
21058, 1363034414.000000, 1363034412.000000
1425, 1362921639.000000, 1362921639.000000


One thing I notice is that ctime equals atime and both are larger than =
mtime. But I have no clue if that has any significance... hmm



> Perhaps you could hack git-am.sh a bit to get more debugging info too=
=2E
> Hm, maybe a good place to start is un-silencing the output of "git
> apply". Inside "git-am.sh", you should see a line like:
>    git apply $squelch
> Remove the $squelch, and see what output it generates.


error: BAD-FILE: does not match index

I inserted "git ls-files -m" before that but that didn't print anything=
 nor had it any other effect.

>=20
> Also, since you're getting the 3-way merge, you could also insert the
> "ls-files" and "stat" right after "git-merge-recursive", but before
> "die".
>=20

Aha, so that was interesting: I inserted both a "stat" invocation, and =
also invoked the "md5" tool to be able to tell whether the file content=
 matched what I thought it should match. Doing that caused the breaking=
 commit to shift. So, I added a second stat / md5 pair on the new break=
ing file. After doing that, the rebase suddenly completed! I reset -- h=
ard to the previous state, tried again, and again it worked. And this a=
fter consistently failing (albeit in differing places) in maybe a hundr=
ed or more tries before. Removing those two calls, it failed again. I t=
ried inserting a "sleep 1", just in case it's a race, but with that it =
still failed.

I then re-added the stat / md5 calls, and -- it failed again, but this =
much earlier (in commit 8, not around commits 14-18).=20

So I added the new conflicting fail to the stat/md5 calls (for a total =
of three files), and it failed in commit 4. Despite adding the new file=
 (number 4),  it got stuck in this very commit in several attempts. I t=
hen for a while did some other stuff (like reading through the "git ls-=
files" man page ;-). Trying the rebase once more, with the stat / md5 c=
alls on four files, it went back to failing in the place it started out=
 failing today (commit 16). Adding / remove the stat&md5 invocations di=
dn't seem to have an effect at this point.



Thanks,
Max