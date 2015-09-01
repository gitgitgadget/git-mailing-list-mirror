From: Geofrey Sanders <geofrey.sanders@gmail.com>
Subject: Re: Windows path handling changed between versions
Date: Tue, 1 Sep 2015 15:10:01 -0400
Message-ID: <CAJ6Pf+SzzPTw8ycJe8Y0W=xM8iHYU4r=nyTA5bPdhyyLKgVLDQ@mail.gmail.com>
References: <CAFPYLHASH_LZ2YgQWjfPKCwq_n-9HVNotkimiQDY1Qy8_8gtwg@mail.gmail.com>
 <d2bd100f23980ace0ec9f071fbe18add@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 01 21:10:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWqwr-0002ph-UB
	for gcvg-git-2@plane.gmane.org; Tue, 01 Sep 2015 21:10:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752124AbbIATKW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Sep 2015 15:10:22 -0400
Received: from mail-ig0-f180.google.com ([209.85.213.180]:35492 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751461AbbIATKV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Sep 2015 15:10:21 -0400
Received: by igbkq10 with SMTP id kq10so8638670igb.0
        for <git@vger.kernel.org>; Tue, 01 Sep 2015 12:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type:content-transfer-encoding;
        bh=pSwOA3N4BBoKg0qf9/lVVlXHizwyduAzlEcwPObSXzQ=;
        b=ixa8F4wK6GB6qfEtSQuiDkKQS40RMDb6fNqIrcAjJ8KZVXLRe8TK5QrJh3Hk2zmVFC
         1Y3ZY5OCuNzJ9+3oBPhDhoFxoMkXAvhLM7hk47NDtIN4h+uKIPwxAktlTQ9J8/UnhdS3
         FqnHuHM+fy5A0kdaiTPs8nC7+moKJFxaNZ40TXbKGjiWnnQVUMmpbNpzkshqCWFILKOe
         CN1fvw0Om6XjbcayzkIWUX1wYB50JJcievd/nuZ5ldG+5jmMGvQOwf/s0nFZG1P1uYW4
         wMF4Kk/EcDuiS0P82eyP2ImVQvWSgUfNS02OyXjSPqENNFdsrj/Fw3oD/p4ArYzYdmjG
         hbwg==
X-Received: by 10.50.108.100 with SMTP id hj4mr4274303igb.65.1441134620917;
 Tue, 01 Sep 2015 12:10:20 -0700 (PDT)
Received: by 10.79.6.83 with HTTP; Tue, 1 Sep 2015 12:10:01 -0700 (PDT)
In-Reply-To: <d2bd100f23980ace0ec9f071fbe18add@www.dscho.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277032>

I can (eventually) make a proper bug report,in the mean time I'll
address a few particulars:
* I've been using git from regular CMD with Git's bin/ in my path. Not Git Bash.
* I created a new repo by cloning, giving an absolute path for the
working tree location. This is the line from the script I used:
    git clone --separate-git-dir c:\dev\git\%branch% -o MAIN
c:\core\guidewire\MAIN c:\core\guidewire\%branch%
** Yes, the working tree and gitdir are in separate locations. (I
don't think this would have made a difference.)
* I verified the case-sensitivity problem by comparing cd-ing (in
regular CMD) to absolute paths with upper- and lower-case drive
letters. Starting with 'C' made the rev-parse predicates give the
expected answers.

It was not my intention to drop a bunch of work on you or anyone; I'm
sorry it sounded that way! I started out with an email here on the
advice of https://git-scm.com/community. Day-job permitting, I'll
reinstall 1.6.2 and determine the minimum steps to demonstrate the
problem as I originally observed it. When I've got reproducible test
steps, should I open a bug on Github, or come back here?

And finally, if you tell me outright this was all my own fault for
typing the paths wrongly I won't be offended : )

-gws



On Tue, Sep 1, 2015 at 1:30 PM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> Hi Geofrey,
>
> On 2015-09-01 18:55, Geofrey Sanders wrote:
>> I recently upgraded from Windows Git 1.6.2 to 2.5.0 and found myself
>> unable to rebase. Turns out paths didn't used to be case-sensitive and
>> now they are, causing a number of operations to halt. A repo created
>> by pointing at the directory
>>     c:\core\guidewire\Dev\2.4
>> would (I suppose) technically have been invalid the whole time because
>> Windows reports the current path as
>>     C:\core\guidewire\Dev\2.4
>> , but msys Git 1.6.2 evidently made a case-insensitive path comparison
>> so the discrepancy was suppressed.
>
> Are you sure about that? I seem to recall that `pwd` changed behavior between MSys and MSys2, but Git never made case-insensitive comparisons.
>
> It might help me to understand what is going on if I could have preciser information. What exactly do you mean by "A repo created by pointing at ..."? Could you type out the Git commands you used?
>
>> The proximate cause of errors was
>>     git rev-parse --is-inside-work-tree
>> which would output 'false' even inside the working tree.
>
> Ah, you are apparently talking about a worktree separate from your repository?
>
>> "--is-inside-git-dir" also printed 'false' in directories where it
>> should have said 'true'.
>
> Again, I really need preciser information about this: *How* did you end up in that directory? Did you use Git Bash or Git CMD? Did you call `cd` with a relative path, a POSIX path or a POSIX-ified full DOS path?
>
>> I actually missed the problem in plain sight
>> at first, because I created a new repo (in which everything worked as
>> expected), and then did a directory diff... the worktree paths were
>> different but I only noticed the names, not the case difference in the
>> drive letter. More details in this SO question:
>> http://stackoverflow.com/q/32280644/2835086
>
> Please understand that I have a lot of tickets to juggle about and that it is a bit unfair to send me onto a goose chase. I would have preferred a proper GitHub issue, as the "Contribute" section of https://git-for-windows.github.io/ explicitly asks for, but I am okay with discussing this ticket on the mailing list. But studying a StackOverflow thread in addition is a bit much... next, people would ask me to search their Twitter feed for the little tid bit of information I need to help.
>
> So please summarize that StackOverflow question, and while we are at it: StackOverflow suggests coming up with a Minimal, Complete and Verifiable Example. That would be a nice thing to have. Maybe you find it in you to come up with that MCVE.
>
>> I was able to repair my existing repos by changing the 'worktree'
>> value in gitconfig - s/c/C/ did the trick - but the whole thing was a
>> surprise.
>>
>> Is this a bug in the current version? Windows doesn't distinguish on
>> case, so maybe applications shouldn't either.
>> Was this a bug in the prior version? Maybe creating a repo with a
>> worktree path that doesn't match the file system should have been an
>> error from the very beginning.
>> Was this user error? Maybe I did something wrong and should have known
>> better, but got away with it for a while.
>
> I think there is a good chance we can fix this, although a 1.x -> 2.x jump always suggests that certain things change in a backwards-incompatible manner.
>
> Looking forward to more detailed information and that MCVE,
> Johannes
