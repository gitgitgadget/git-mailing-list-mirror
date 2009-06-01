From: "Neal Kreitzinger" <neal@rsss.com>
Subject: Re: git log missing last line of output
Date: Mon, 1 Jun 2009 15:50:27 -0500
Message-ID: <h01enr$71i$1@ger.gmane.org>
References: <gvhrtf$vpr$1@ger.gmane.org> <4A1D5F70.4030101@drmicha.warpmail.net> <gvjsc9$f40$1@ger.gmane.org> <200905272106.31036.j6t@kdbg.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 01 22:47:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBEPc-0003UR-Bx
	for gcvg-git-2@gmane.org; Mon, 01 Jun 2009 22:47:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755086AbZFAUrI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jun 2009 16:47:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754878AbZFAUrG
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Jun 2009 16:47:06 -0400
Received: from main.gmane.org ([80.91.229.2]:51026 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754324AbZFAUrG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jun 2009 16:47:06 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1MBEPQ-0006VB-As
	for git@vger.kernel.org; Mon, 01 Jun 2009 20:47:04 +0000
Received: from 216.60.24.100 ([216.60.24.100])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 01 Jun 2009 20:47:04 +0000
Received: from neal by 216.60.24.100 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 01 Jun 2009 20:47:04 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 216.60.24.100
X-Newsreader: Microsoft Outlook Express 6.00.2900.5512
X-RFC2646: Format=Flowed; Original
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.5579
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120480>

Here is the summary I wrote up for my teammates:

Problem:  Git log does not display the last line of output.



Solution:

Linux uses a command called 'less' to control the pagination of command line 
output.  'less' is an enhanced version of the command 'more'.  For some 
reason, it is not compatible with SmarTerm when running the 'git log' 
command which causes the last line of output to be truncated.  Git log works 
fine when executed on the desktop command line using VNC.



Git has the option '--no-pager' to overcome incompatibility issues.  Since I 
do not know if the pager is having problems with any commands besides 'git 
log', I will focus on 'git log' only.  The command 'git --no-pager log' can 
be executed in lieu of 'git log' to display the log correctly.  A git alias 
can be setup to create a shorter command to accomplish this.  I've created 
the command 'git logr' as a system alias on the git testbox so you can use 
that command instead of 'git log'.  A system alias applies to all logins and 
repos on the system.



Add alias:

(Login root)

$ git config --system alias.logr '!git --no-pager log'

Note:  if you add an alias with the same name as a git command then git will 
ignore the alias.  If you create the above with the name 'log' then git will 
not run it even though the entry is in the config file.



View alias:

(Login user)

$ git config --system --list



Remove alias:

(Login root)

$ git config --system --unset alias.logr



Location:  /etc/gitconfig



Aliases can also be created to apply only to certain user logins or only to 
certain repos:



A global alias applies only to a specific user login and takes precedence 
over a system alias of the same name.

"global config file" location:

/home/userlogin/.gitconfig

command option:

"git config --global".  Run the option from the user login it applies to.



A file alias applies only to a specific repo and takes precedence over a 
global alias or a system alias of the same name.

"file config file" location:

/specific-repo/.git/config

command option:

"git config --file".  This is the default option so a plain "git config" is 
the same as "git config --file".  Run the option while in the pwd of the 
repo that it applies to.


v/r,
Neal

"Johannes Sixt" <j6t@kdbg.org> wrote in message 
news:200905272106.31036.j6t@kdbg.org...
> Please use "Reply to all" so that Cc list remains.
>
> On Mittwoch, 27. Mai 2009, Neal Kreitzinger wrote:
>> $ git log
>> commit 73170498d68a0011b37d7ee095bf88b8dcb6fbb5
>> Author: tstuser1 <tstuser1@tstuser.com>
>> Date:   Wed May 27 11:48:30 2009 -0500
>>
>>     2nd commit after initial commit
>>
>> commit 9f9ed5663d180caefd0bcaff4578fdb2c542bf17
>> Author: tstuser1 <tstuser1@tstuser.com>
>> Date:   Wed May 27 11:14:38 2009 -0500
>>
>>     1st commit after initial commit
>>
>> commit bee2e0fa066aaa9fed99c15c2ab58744a34fda48
>> Author: tstuser1 <tstuser1@tstuser.com>
>> Date:   Wed May 27 11:13:13 2009 -0500
>>
>> $
>> ***NOTE THAT LAST LINE OF OUTPUT IS MISSING ABOVE (SHOULD BE THE TITLE 
>> LINE
>> OF THE INITIAL COMMIT -- BUT ITS NOT THERE)***
>
> Please try
>
>   git --no-pager log
>
> Do you see the line? Yes? Then your pager and your terminal do not 
> cooperate
> correctly.
>
> -- Hannes 
