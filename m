From: Andreas Ericsson <ae@op5.se>
Subject: Re: Issue updating files during a checkout from a remote push
Date: Fri, 07 Nov 2008 09:21:55 +0100
Message-ID: <4913FAA3.3030608@op5.se>
References: <334B3AB1-125A-4163-BEBC-9A73C4F569B5@idibu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Steve Walker <steve@idibu.com>
X-From: git-owner@vger.kernel.org Fri Nov 07 09:23:18 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KyMcf-0006dU-WE
	for gcvg-git-2@gmane.org; Fri, 07 Nov 2008 09:23:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751132AbYKGIWD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Nov 2008 03:22:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751124AbYKGIWD
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Nov 2008 03:22:03 -0500
Received: from mail.op5.se ([193.201.96.20]:33393 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751121AbYKGIWA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Nov 2008 03:22:00 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 4BCE61B80005;
	Fri,  7 Nov 2008 09:15:42 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -3.399
X-Spam-Level: 
X-Spam-Status: No, score=-3.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599, FB_WORD1_END_DOLLAR=1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id leHvXoTuAmqe; Fri,  7 Nov 2008 09:15:40 +0100 (CET)
Received: from clix.int.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id 8A7151B8008E;
	Fri,  7 Nov 2008 09:15:39 +0100 (CET)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <334B3AB1-125A-4163-BEBC-9A73C4F569B5@idibu.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100295>

Steve Walker wrote:
> Hi there,
> 
> Hoping someone could point me in the right direction here.
> 
> The overall issue is that with files that have been pushed into our repo 
> on our server, when we then check out into local working copy the new 
> files appear, but the updated files dont update even though the output 
> suggests it has. The flow I'm doing:
> 
> 1. The file I'm testing an update to is this:
> 
> -rw-r--r--   1 root    www-data       0 2008-11-06 16:13 
> steve-git-test3.txt
> 
> 2. On my local box I change file, add it, commit, then push it from my 
> local box to our server repo:
> 
> StevePoota:public_html steve$ vi steve-git-test3.txt
> StevePoota:public_html steve$ git add steve-git-test3.txt
> StevePoota:public_html steve$ git commit
> Created commit e29b724: testing only
>  1 files changed, 1 insertions(+), 0 deletions(-)
> StevePoota:public_html steve$ git push 
> ssh://idibu.com/home/beta_idibu/public_html master:master
> Counting objects: 5, done.
> Compressing objects: 100% (2/2), done.
> Writing objects: 100% (3/3), 272 bytes, done.
> Total 3 (delta 1), reused 0 (delta 0)
> To ssh://idibu.com/home/beta_idibu/public_html
>    a28332a..e29b724  master -> master
> 
> 3. It all looks good, on my server if i do a 'git log' I can see in the 
> latest update:
> 
> oneworld:/home/beta_idibu/public_html# git log
> commit e29b7246beab458d6a7b53cb245a5596adc8c198
> Author: Steve <steve@StevePoota.local>
> Date:   Thu Nov 6 17:55:21 2008 +0100
> 
>     testing only
> 
> 4. So I check out:
> 
> oneworld:/home/beta_idibu/public_html# git checkout master
> M    .gitignore
> M    steve-git-test.txt
> M    steve-git-test2.txt
> M    steve-git-test3.txt
> Already on branch "master"
> oneworld:/home/beta_idibu/public_html#
> 
> and its telling me that file has been modified
> 
> but checking my file it hasnt changed by date stamp, and looking insie 
> the file my changes arent there :((
> 
> -rw-r--r--   1 root    www-data       0 2008-11-06 16:13 
> steve-git-test3.txt
> 
> I'm stumped. I tried 777'ing that file temporarily in case git couldnt 
> write to that file on checkout. What is strange is that when I add new 
> files to the system it works - for example this file I'm testing no was 
> originally added to the server via an external push.
> 
> If anyone could give me some help I'd be very grateful.
> 

git reset --hard master

Note that it's definitely not a good idea to push into a non-bare repo
where you modify the worktree, as the workflow requires that you simply
clobber them (or work on a separate branch and then merge with master,
but then you'll have to know *why* things happen and how to fix them).

You'd probably be better off pushing to another repository and fetching
from that other repo into the non-bare one you're using now.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
