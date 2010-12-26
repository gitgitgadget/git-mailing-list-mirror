From: =?utf-8?B?0JDQu9C10LrRgdC10Lkg0JrRgNC10LfQvtCy?= <zapped@mail.ru>
Subject: Re[2]: [PATCH 3/3] Fixes bug: GIT_PS1_SHOWDIRTYSTATE is no not respect diff.ignoreSubmodules config variable
Date: Mon, 27 Dec 2010 01:25:57 +0300
Message-ID: <1824011293.20101227012557@mail.ru>
References: <1293240049-7744-1-git-send-email-zapped@mail.ru> <1293240049-7744-3-git-send-email-zapped@mail.ru> <4D15E48A.9050805@web.de>
Reply-To: =?utf-8?B?0JDQu9C10LrRgdC10Lkg0JrRgNC10LfQvtCy?= <zapped@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Sun Dec 26 23:26:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PWz2V-00058B-Gg
	for gcvg-git-2@lo.gmane.org; Sun, 26 Dec 2010 23:26:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752925Ab0LZW0A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Dec 2010 17:26:00 -0500
Received: from smtp4.mail.ru ([94.100.176.44]:43558 "EHLO smtp4.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752900Ab0LZW0A (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Dec 2010 17:26:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru; s=mail;
	h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Subject:CC:To:Message-ID:Reply-To:From:Date; bh=1ssgBg6QFzTqho+fR3+/NMYYnis9fi3hvm7omCjKb10=;
	b=DgZGBgYZdBaz1b1Nw4HcwlaJGu+pypY4oTg/Hd2nTInYy8+Bz0w3vu1kCFUyhUEno4+UDpduPa/sMDqA+m4bno0UZ8RZCtqP7XGrFpvgvAvV3Fls0791rDJKVqRSfNEe;
Received: from [91.76.208.161] (port=63530 helo=ppp91-76-208-161.pppoe.mtu-net.ru)
	by smtp4.mail.ru with asmtp 
	id 1PWz2M-0000fW-00; Mon, 27 Dec 2010 01:25:58 +0300
X-Mailer: The Bat! (v3.99.3) Professional
X-Priority: 3 (Normal)
In-Reply-To: <4D15E48A.9050805@web.de>
X-Mras: Ok
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164200>

Hello!

I`m sorry, but I`m newbie in making and distributing of public patches.
So, don't beat me much ))

JL> it would have been easier for me if the commit message would have
JL> described the problem you tried to fix a bit more in detail ;-).
My problem was in the following.
I use Git on Windows XP under Cygwin. So its perfomance is slower than
on *nix, I guess.
My project has 40 submodules (external libs) and some of them could
have untracked files (for some reasons). So when I run any command in Bash
after its execution Bash "thought" for 2-3 seconds. That was annoying.
I do not remember the version of Git I used at that moment but I
remember it was an update from 1.6.x to early 1.7.x. So I decided to roll back
to 1.6.x ))
Then there was some updates of Git. But after updating the problem
still happened.
When I tried to discover the reason of such a behaviour I found that
Git got status for all submodules including untracked content and so
marked them with *
Then I read manual and found diff.ignoreSubmodules and tried to set up for each
submodule in a .gitmodules but nothing changed (as it seemed to me at
that time).
So I've found the easiest way to solve my problem - this patch )
Maybe after this patch there was some changes in Git solved this
problem but I did not investigate it, sorry.

JL> 2) If diff.ignoreSubmodules is unset it leads to an error
JL>    every time the prompt is displayed:
JL>    'fatal: bad --ignore-submodules argument:'
Yeah, you're right

JL> Am 25.12.2010 02:20, schrieb Zapped:
>> Signed-off-by: Zapped <zapped@mail.ru>
>> ---
>>  contrib/completion/git-completion.bash |    3 ++-
>>  1 files changed, 2 insertions(+), 1 deletions(-)
>> 
>> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
>> index d3037fc..50fc385 100755
>> --- a/contrib/completion/git-completion.bash
>> +++ b/contrib/completion/git-completion.bash
>> @@ -280,7 +280,8 @@ __git_ps1 ()
>>               elif [ "true" = "$(git rev-parse --is-inside-work-tree 2>/dev/null)" ]; then
>>                       if [ -n "${GIT_PS1_SHOWDIRTYSTATE-}" ]; then
>>                               if [ "$(git config --bool bash.showDirtyState)" != "false" ]; then
>> -                                     git diff --no-ext-diff --quiet --exit-code || w="*"
>> +                                     is=$(git config diff.ignoreSubmodules)
>> +                                     git diff --no-ext-diff --quiet --exit-code --ignore-submodules=$is || w="*"
>>                                       if git rev-parse --quiet --verify HEAD >/dev/null; then
>>                                               git diff-index --cached --quiet HEAD -- || i="+"
>>                                       else

JL> Thanks for resubmitting this as an inline patch for review (although
JL> it would have been easier for me if the commit message would have
JL> described the problem you tried to fix a bit more in detail ;-).

JL> After testing this patch it looks like it has a few issues:

JL> 1) it will break any per-submodule configuration done via
JL>    the 'submodule.<name>.ignore' setting in .git/config or
JL>    .gitmodules, as using the --ignore-submodules option
JL>    overrides those while only setting 'diff.ignoreSubmodules'
JL>    should not do that.

JL> 2) If diff.ignoreSubmodules is unset it leads to an error
JL>    every time the prompt is displayed:
JL>    'fatal: bad --ignore-submodules argument:'

JL> 3) And for me it didn't change the behavior at all:

JL>    - The '*' in the prompt vanishes as I set diff.ignoreSubmodules
JL>      as expected with or without your patch.
JL>      Am I missing something here?

JL>    - The real problem here is that the '+' never goes away even
JL>      when 'diff.ignoreSubmodules' is set to 'all'. This is due
JL>      to the fact that 'diff.ignoreSubmodules' is only honored by
JL>      "git diff", but not by "git diff-index".

JL> So the real issue here seems to be the "git diff-index" call, which
JL> doesn't honor the 'diff.ignoreSubmodules' setting. In commit 37aea37
JL> Dscho (CCed) introduced this configuration setting while explicitly
JL> stating that it only affects porcelain. As the other config options
JL> always influence porcelain and plumbing, it looks like we would want
JL> to have this option honored by plumbing too, no?

JL> So are there any reasons for the plumbing diff commands not to honor
JL> the diff.ignoreSubmodules setting?
