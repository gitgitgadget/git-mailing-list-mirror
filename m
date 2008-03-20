From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Make git-merge and helpers Builtins
Date: Thu, 20 Mar 2008 10:02:03 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0803200927440.19665@iabervon.org>
References: <47E25925.4050703@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Bo Yang <techrazy.yang@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 20 15:03:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JcLM9-0001DV-5S
	for gcvg-git-2@gmane.org; Thu, 20 Mar 2008 15:02:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755112AbYCTOCI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2008 10:02:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755044AbYCTOCH
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Mar 2008 10:02:07 -0400
Received: from iabervon.org ([66.92.72.58]:56627 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755016AbYCTOCG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2008 10:02:06 -0400
Received: (qmail 16366 invoked by uid 1000); 20 Mar 2008 14:02:03 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 20 Mar 2008 14:02:03 -0000
In-Reply-To: <47E25925.4050703@gmail.com>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77658>

On Thu, 20 Mar 2008, Bo Yang wrote:

> Hi,
>   I have used Git for one year, and I join into this list for 3 or 4 monthes.
> Sometime, I post some questions here and followed some disscusions. I have
> noticed that, there is a potential project in this GSoC "make git-merge and
> helplers builtins". I think I am one of the suitable students for this project
> because I am familiar with shell script programming and c language. And I post
> this message here to hope I can discuss more with the community about this
> project.    I have git clone the Git's source code for some days. And with
> some insight into the code, I found that some of the merge related code is
> located in sh script:  git-merge-octopus.sh  git-merge-one-file.sh
> git-merge-resovle.sh git-merge.sh git-mergetool.sh . And others are located in
> c source code: builtin-merge-base.c builtin-merge-file.c builtin-merge-ours.c
> builtin-merge-recrusive.c and merge-file.c merge-tree.c merge-index.c
> merge-recursive.h for two simple declarations.
>   And git-mergetool.sh is itself an interactive shell process, I think there
> is no need to deal with it. So, the main work for this project is to change
> the other four scripts into c format. For deatails, instead of call the git
> merge-base in the shell, we make the final corresponding c code to call the
> functions in the builtin-merge-base.c. Could you please tell more about the
> work if I miss something?

I think the main interesting shell script is "git-merge.sh"; the others 
are helpers of various sorts.

>   Finally, I have some questions about the merge code. I found there are many
> merge related code and I can't understand them at a short time. So, pleaes
> help me if you can.
> 
>   1. git-merge-file is used to merge one file, but what are merge-octopus and
> merge-resovle?

They are different "merge strategies". When merging, you can use "-s 
<name>" to select a program that will be used to figure out what the 
result should be. Some of these strategies (ours, theirs, recursive) have 
been built in already. "merge-octopus" is used when you're merging more 
than two branches at the same time, and "merge-resolve" is the usual 
simple merge.

>   2. I see in builtin-merge-file.c and merge-file.c, there are both functions
> used to merge file. And finally, they both call the xdl_merge . Could you
> please tell me how differenct of these to methods? I ask this question because
> I think there are some redundant code in the git source. Forgive me if I am
> wrong, I have no hostility but want to know why things are like that.

builtin-merge-file has the command-line parsing code, while merge-file is 
called by C code. They could probably share the code around calling 
xdl_merge.

We often have duplicate functions from the point of view of functionality, 
where one is cmd_*(int argc, const char **argv, const char *prefix) and 
the other has arguments particular to the function; the cmd_*() one is 
used by the command line dispatcher.

There's also a certain amount of redundant code that's there for 
historical reasons. People tend to clean it up when they find it, but 
we've never had enough clarity in naming that somebody who needs a 
function to do some particular task will necessarily find an existing 
function for that task if there is one.

	-Daniel
*This .sig left intentionally blank*
