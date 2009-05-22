From: Andreas Ericsson <ae@op5.se>
Subject: Re: can anybody explain the following to a git noob?
Date: Fri, 22 May 2009 14:22:26 +0200
Message-ID: <4A169902.4070902@op5.se>
References: <855e4dcf0905212046o3e1d6ec6l487829a0a411dcaf@mail.gmail.com>	 <32541b130905212202q9aed54cn892171b7e654812f@mail.gmail.com>	 <855e4dcf0905212244r454a5c21w7bdbfb566a28efb8@mail.gmail.com>	 <4A1671E5.4030400@op5.se>	 <855e4dcf0905220335n367a065fidc65567119c0a5a3@mail.gmail.com>	 <4A16822A.2060404@viscovery.net> <855e4dcf0905220436h1b6fa632q7804c98bf09b324c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Avery Pennarun <apenwarr@gmail.com>, git@vger.kernel.org
To: Tim Uckun <timuckun@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 22 14:30:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M7TtJ-0007NY-Ea
	for gcvg-git-2@gmane.org; Fri, 22 May 2009 14:30:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752497AbZEVMaQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 May 2009 08:30:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751590AbZEVMaP
	(ORCPT <rfc822;git-outgoing>); Fri, 22 May 2009 08:30:15 -0400
Received: from na3sys009aog106.obsmtp.com ([74.125.149.77]:40242 "HELO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751258AbZEVMaO (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 May 2009 08:30:14 -0400
X-Greylist: delayed 465 seconds by postgrey-1.27 at vger.kernel.org; Fri, 22 May 2009 08:30:14 EDT
Received: from source ([209.85.218.160]) by na3sys009aob106.postini.com ([74.125.148.12]) with SMTP
	ID DSNKShaa1rDtCSvcKyOjrBjHkI1+LStDpW2Y@postini.com; Fri, 22 May 2009 05:30:16 PDT
Received: by mail-bw0-f160.google.com with SMTP id 4so1818563bwz.18
        for <git@vger.kernel.org>; Fri, 22 May 2009 05:30:14 -0700 (PDT)
Received: by 10.86.53.8 with SMTP id b8mr3110365fga.32.1242994948148;
        Fri, 22 May 2009 05:22:28 -0700 (PDT)
Received: from clix.int.op5.se ([212.112.163.94])
        by mx.google.com with ESMTPS id e20sm859830fga.0.2009.05.22.05.22.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 22 May 2009 05:22:27 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <855e4dcf0905220436h1b6fa632q7804c98bf09b324c@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119729>

Tim Uckun wrote:
>> Did test_new contain ignored files?
> 
> No.  I put the entire transcript in the first email.

No you did not. You used 'ls' where you should have used 'ls -a' to also
show the "hidden" directory entries (.gitignore and .git)

> I did not tell
> git to ignore anything and there were no .git directories in the test
> folder.
> 

But the upstream project could well have told git to ignore stuff, and
since .gitignore files are transmitted on clone they would have been
sent along to you.

>> In this case, when you checkout the
>> branch that does not have test_new, only the tracked files are removed;
>> the ignored (i.e untracked) files remain. Therefore, after the checkout
>> you still have a test_new directory.
>>
> 
> As far as I can tell all the files are tracked after I do a commit.
> 

"git ls-tree -r --name-only HEAD" will show you all the tracked files.
You'll almost certainly want to pipe it through less or some such.

Try "git ls-tree -r --name-only | grep gitignore" to see all the
.gitignore files.

> I can understand why it put the original test directory back when I
> changed to the master branch but I don't understand why it's missing a
> subdirectory.

Because that subdirectory was never tracked by git. If it had been, it
would have been there when you switched branches.

>  I don't think the test_new directory should be in the
> master branch at all but I guess I can kind of sort of see why git
> might not remove it. What I can't understand at all is why it's
> missing subdirectories.
> 
> I hate to say this but I tried the exact same thing with mercurial in
> the last half hour and it did exactly what I thought it should do. The
> master had the test directory but not the test_new and the branch had
> the test_new directory but not the test. No subdirectories were
> missing out of either one.

Naturally, since mercurial (rightly) ignores .gitignore files and the
.git/ directory. With mercurial though, you're not only tracking the
history of the files, but also the history of the object databases of
all the git repositories you've cloned and that live in subdirectories
of your master-project. Whether or not that's an actual problem for you
is something you'll have to decide for yourself. If you want to keep
that exceptionally odd configuration, please remember to never run
"git repack -a" in the subdirectories originating from github clones,
or mercurial will think files have gone missing.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Register now for Nordic Meet on Nagios, June 3-4 in Stockholm
 http://nordicmeetonnagios.op5.org/

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
