From: Roberto Nibali <ratz@drugphish.ch>
Subject: Re: No merge strategy handled the merge (git version 1.1.GIT)
Date: Mon, 30 Jan 2006 00:42:37 +0100
Message-ID: <43DD52ED.7090503@drugphish.ch>
References: <43DB4D16.6050807@drugphish.ch> <20060129120344.GB4815@c165.ib.student.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 30 00:42:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F3MC4-0006z0-ME
	for gcvg-git@gmane.org; Mon, 30 Jan 2006 00:42:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932087AbWA2Xml (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Jan 2006 18:42:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932089AbWA2Xml
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jan 2006 18:42:41 -0500
Received: from drugphish.ch ([69.55.226.176]:27292 "EHLO www.drugphish.ch")
	by vger.kernel.org with ESMTP id S932087AbWA2Xmj (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 Jan 2006 18:42:39 -0500
Received: from [172.23.2.3] (adsl-dyn-83-173-208-107.cybernet.ch [83.173.208.107])
	by www.drugphish.ch (Postfix) with ESMTP id 60163406C023;
	Mon, 30 Jan 2006 00:42:38 +0100 (CET)
User-Agent: Thunderbird 1.5 (X11/20051201)
To: Fredrik Kuivinen <freku045@student.liu.se>
In-Reply-To: <20060129120344.GB4815@c165.ib.student.liu.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15250>

>>     raise ProgramError(progStr, e.strerror)
>> ProgramError: merge -L HEAD/net/ipv4/ipvs/ip_vs_ctl.c -L 
>> orig/net/ipv4/ipvs/ip_vs_ctl.c -L 
>> 3ee68c4af3fd7228c1be63254b9f884614f9ebb2/net/ipv4/ipvs/ip_vs_ctl.c 
>> .merge_file_uofMwv .merge_file_hcesLs .merge_file_TwtEqw: No such file 
>> or directory
>> No merge strategy handled the merge.
>>
> 
> The problem is that merge(1), which is used for file-level merges,
> couldn't be found. Is it installed on your system? If you use Linux,
> it is usually found in the "rcs" package in your favorite
> distribution.

That's it, I've installed it now.

> This have came up a couple of times now, we should probably make this
> error message a bit less cryptic. I will send a patch in a separate
> mail.

Thanks.

> If your repository is in the state that the failed git-pull left it
> in, then the following actions should merge your changes with Linus'
> tree.
> 
> 1. Install merge(1)
> 2. Run 'git reset --hard' (NOTE: Be careful with this command. It will
>    revert any uncommitted changes you may have in your working directory!)
> 3. Run 'git pull'

This worked. And as you've mentioned, I lost the uncommitted changes.

>> Oh, btw, how is git branch -D supposed to work? Isn't there some code 
>> missing?
> 
> Could you be a bit more specific? Do you mean that there is code
> missing in git-branch.sh? What happens when you run 'git branch -D
> <some branch>'? It seems to work fine here.

Well, I was trying to understand git a bit better, so I started reading 
the source code and just found that -D wasn't documented on my system, 
even after a

git clone rsync://git.kernel.org/pub/scm/git/git.git/ GIT_HEAD

I'm talking about following excerpt which I've looked at for 2 minutes:

#!/bin/sh

USAGE='[-d <branch>] | [[-f] <branch> [start-point]]'
LONG_USAGE='If no arguments, show available branches and mark current 
branch with a star.
If one argument, create a new branch <branchname> based off of current HEAD.
If two arguments, create a new branch <branchname> based off of 
<start-point>.'

SUBDIRECTORY_OK='Yes'
. git-sh-setup

headref=$(git-symbolic-ref HEAD | sed -e 's|^refs/heads/||')

delete_branch () {
     option="$1"
     shift
     for branch_name
     do
         case ",$headref," in
         ",$branch_name,")
             die "Cannot delete the branch you are on." ;;
         ,,)
             die "What branch are you on anyway?" ;;
         esac
         branch=$(cat "$GIT_DIR/refs/heads/$branch_name") &&
             branch=$(git-rev-parse --verify "$branch^0") ||
                 die "Seriously, what branch are you talking about?"
         case "$option" in
         -D)
             ;;
[...]

This is slightly confusing, since I didn't see the shift after 
delete_branch so it looked like a noop. On top of that "-D" did/does not 
seem to be documented. Skimming over your patch you've sent later to 
this list, it appears you've fixed the documentation.

Best regards,
Roberto Nibali, ratz
-- 
echo 
'[q]sa[ln0=aln256%Pln256/snlbx]sb3135071790101768542287578439snlbxq' | dc
