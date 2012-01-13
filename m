From: Holger Hellmuth <hellmuth@ira.uka.de>
Subject: Re: Bug? Git checkout fails with a wrong error message
Date: Fri, 13 Jan 2012 20:28:44 +0100
Message-ID: <4F1085EC.9010708@ira.uka.de>
References: <loom.20120112T193624-86@post.gmane.org> <4F1028AD.9080701@ira.uka.de> <4F106DDF.4040408@unclassified.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	=?UTF-8?B?Q2FybG9zIE1h?= =?UTF-8?B?cnTDrW4gTmlldG8=?= 
	<cmn@elego.de>
To: Yves Goergen <nospam.list@unclassified.de>
X-From: git-owner@vger.kernel.org Fri Jan 13 20:29:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RlmoD-0007wT-Sf
	for gcvg-git-2@lo.gmane.org; Fri, 13 Jan 2012 20:29:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758812Ab2AMT3A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jan 2012 14:29:00 -0500
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:46411 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753346Ab2AMT3A (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Jan 2012 14:29:00 -0500
Received: from irams1.ira.uni-karlsruhe.de ([141.3.10.5])
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	id 1Rlmnd-0003Iq-Vq; Fri, 13 Jan 2012 20:28:59 +0100
Received: from i20s141.iaks.uni-karlsruhe.de ([141.3.32.141] helo=[172.16.22.120])
	by irams1.ira.uni-karlsruhe.de with esmtpsa port 25 
	id 1Rlmnd-0001Yg-NG; Fri, 13 Jan 2012 20:28:29 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.9.2.24) Gecko/20111101 SUSE/3.1.16 Thunderbird/3.1.16
In-Reply-To: <4F106DDF.4040408@unclassified.de>
X-ATIS-AV: ClamAV (irams1.ira.uni-karlsruhe.de)
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-AV: Kaspersky (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1326482939.120579000
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188532>

Added Peff and Carlos to the CC so they see this part of the thread too.

On 13.01.2012 18:46, Yves Goergen wrote:
> On 13.01.2012 13:50 CE(S)T, Holger Hellmuth wrote:
>> Important information missing: What version of git are you using? Should
>> the version number begin with 1.6 or even lower you will get the advice
>> to update your version to something non-ancient. Lots of bug-fixes
>> happened in-between.
>
> The first bug happened with msysGit 1.7.6 and 1.7.8, the second one
> (reported now) with 1.7.8. That update didn't change a thing.
>
>> I assume .cs is a C source file for visual studio, not a generated file,
>> right ?
>
> .cs is C# code and .Designer.cs files are used internally by the Visual
> Studio designer. They're not supposed to be edited by the programmer and
> contain lots of stuff that changes all the time. So they are generated
> and presented in a different way.

Is it possible that Visual Studio changes them while you are comitting?

>> git does not record renames like cvs/svn do. It operates on snapshots
>> and infers renames through comparisions. So if the next commit has a
>> file missing and the same or similar file contents under some different
>> path, it reports it as a rename. You can try -M with git log or git diff
>> so that git expends more effort to detect renames+edits. Or you could
>> avoid doing renames and edits of the same file in the same commit.
>
> I renamed the file and created a new one with the same name. Is it so
> simple to crash the Git repository?

Who said anything about crash? git simply doesn't care whether a change 
is because of a rename. It isn't special or different to any change you 
can make to a file


>>> -----
>>> git.exe checkout    form-refactoring
>>>
>>> Aborting
>>> error: The following untracked working tree files would be overwritten by
>>> checkout:
>>> Form1.Designer.cs
>>> Please move or remove them before you can switch branches.
>>> -----
>>
>> You didn't mention that filename before (please assume people not
>> accustomed to the ways of Visual Studio 2010). Is that another file you
>> renamed and created new in the form-refactoring branch?
>
> Form1.cs, Form1.Designer.cs and Form1.resx all belong together and are
> renamed atomically. If I rename "Form1" in the project, actually these 3
> files are renamed on disk.

As an aside, if .Designer.cs is generated automatically from Form1.cs it 
shouldn't be tracked at all. Maybe tortoise git has a global gitignore 
with a line "*.Designer.cs" in it to account for that fact. Maybe this 
lead to the error message?

>> What does git diff -- Form1.Designer.cs' say?
>
> Nothing.
>
>> What does 'git diff form-refactoring -- Form1.Designer.cs' say?
>
> All lines deleted.

Really all lines? That would indicate that you don't have a file 
Form1.Designer.cs (or an empty one) in your working directory in branch 
master. In case there is no file (as seen by git) the output of diff 
should compare with /dev/null aka the void aka <I don't know how this 
prints on the windows side>. Also notice the line "deleted file mode ..."

 > git diff master -- zumf
diff --git a/zumf b/zumf
deleted file mode 100644
index 925eccd..0000000
--- a/zumf
+++ /dev/null
@@ -1 +0,0 @@

Or did you just mean "all the shown lines in the diff were fronted by a 
minus sign"? Which would just indicate that the file in form-refactoring 
is a superset of the one in master.

(As you can see, actual reproduction of command line output is very 
helpful to avoid ambiguity and can give further hints)
