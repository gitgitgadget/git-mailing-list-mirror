From: Holger Hellmuth <hellmuth@ira.uka.de>
Subject: Re: Bug? Git checkout fails with a wrong error message
Date: Fri, 13 Jan 2012 13:50:53 +0100
Message-ID: <4F1028AD.9080701@ira.uka.de>
References: <loom.20120112T193624-86@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Yves Goergen <nospam.list@unclassified.de>
X-From: git-owner@vger.kernel.org Fri Jan 13 13:50:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rlgar-0000M4-DL
	for gcvg-git-2@lo.gmane.org; Fri, 13 Jan 2012 13:50:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758004Ab2AMMus (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jan 2012 07:50:48 -0500
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:34270 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752910Ab2AMMur (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Jan 2012 07:50:47 -0500
Received: from irams1.ira.uni-karlsruhe.de ([141.3.10.5])
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	id 1Rlgad-0004RX-Kr; Fri, 13 Jan 2012 13:50:45 +0100
Received: from i20s141.iaks.uni-karlsruhe.de ([141.3.32.141] helo=[172.16.22.120])
	by irams1.ira.uni-karlsruhe.de with esmtpsa port 25 
	id 1Rlgac-0001LQ-5W; Fri, 13 Jan 2012 13:50:39 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.9.2.24) Gecko/20111101 SUSE/3.1.16 Thunderbird/3.1.16
In-Reply-To: <loom.20120112T193624-86@post.gmane.org>
X-ATIS-AV: ClamAV (irams1.ira.uni-karlsruhe.de)
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-AV: Kaspersky (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1326459045.967136000
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188510>

On 12.01.2012 19:44, Yves Goergen wrote:
> Hi,

Important information missing: What version of git are you using? Should 
the version number begin with 1.6 or even lower you will get the advice 
to update your version to something non-ancient. Lots of bug-fixes 
happened in-between.

> I am using Git alone for my local software project in Visual Studio 2010. I've
> been on the master branch most of the time. Recently I created a new branch to
> do a larger refactoring of one of the dialogue windows. I did the following
> modifications:
>
> * Rename Form1 to Form1a (including all depending files)
> * Add new Form1
>
> I checked this change into the branch, say form-refactoring. Interestingly, Git
> didn't notice that I renamed the file Form1.cs into Form1a.cs and created a
> brand new, totally different Form1.cs, but instead it noticed a new Form1a.cs

I assume .cs is a C source file for visual studio, not a generated file, 
right ?

> file and found a whole lot of differences between the previous and new Form1.cs
> files. This will of course lead to totally garbaged diffs, but I don't care in
> this case as long as all files are handled correctly in the end.

git does not record renames like cvs/svn do. It operates on snapshots 
and infers renames through comparisions. So if the next commit has a 
file missing and the same or similar file contents under some different 
path, it reports it as a rename. You can try -M with git log or git diff 
so that git expends more effort to detect renames+edits. Or you could 
avoid doing renames and edits of the same file in the same commit.

But apart from the cosmetic inconvenience of a non-sensical diff this 
commit wasn't more difficult or special as any other commit. git doesn't 
care if a commit changes one line or a thousand. So I don't this 
renaming in itself did somehow confuse git.

> Then I switched back to master to do some other small changes. Nothing
> conflicting. Until now, everything worked fine.
 >
> Today, I wanted to switch back to my branch form-refactoring to continue that
> work. But all I get is the following message:
>
> -----
> git.exe checkout    form-refactoring
>
> Aborting
> error: The following untracked working tree files would be overwritten by
> checkout:
> Form1.Designer.cs
> Please move or remove them before you can switch branches.
> -----

You didn't mention that filename before (please assume people not 
accustomed to the ways of Visual Studio 2010). Is that another file you 
renamed and created new in the form-refactoring branch?

What does git diff -- Form1.Designer.cs' say?
What does 'git diff form-refactoring -- Form1.Designer.cs' say?

> What is that supposed to be? The mentioned file is not untracked. Neither in the
> master branch, nor in the form-refactoring branch. It is part of both branches,
> but one is not a descendent of the other (because it was recreated on the
> form-refactoring branch, if that matters). What would happen if I delete it, is
> it gone for good then? I don't trust Git to bring back the correct file if I

You can copy the file to somewhere outside of git and do 'git checkout 
-- Form1.Designer.cs'. A comparision of the two files should show you 
that git still has the files recorded.

> Right now, I cannot continue with my work because I cannot switch branches. Is
> there an easy solution to this? Is my Git repository broken, all by standard
> operations?

The easy solution is: Make a backup of the repository, then 'git 
checkout -f form-refactoring'. My uneducated guess is that the problem 
has to do with an old git version and white space or filenames with 
different case on a case-insensitive file system or some other problem 
that leads to a misinterpretation. But as I said, uneducated guess!
