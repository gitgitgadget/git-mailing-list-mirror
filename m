From: "Paul Lotz" <plotz@lsst.org>
Subject: RE: difftool sends malformed path to exernal tool on Windows
Date: Mon, 3 Mar 2014 16:24:15 -0700
Message-ID: <00bc01cf3737$b1474280$13d5c780$@lsst.org>
References: <011301cf2c2d$90442810$b0cc7830$@lsst.org>	<20140221103821.GA21414@gmail.com>	<000801cf317f$ac1be2b0$0453a810$@lsst.org> <CAJDDKr751=c2AOBfjbg2_im6UCBvwWSVjJ7QX8=76vXMsLSw4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 8BIT
Cc: "'Git Mailing List'" <git@vger.kernel.org>
To: "'David Aguilar'" <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 04 00:24:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKcDe-00046B-OU
	for gcvg-git-2@plane.gmane.org; Tue, 04 Mar 2014 00:24:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755618AbaCCXYR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2014 18:24:17 -0500
Received: from mail.lsstcorp.org ([140.252.15.63]:1519 "EHLO mail.lsst.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755597AbaCCXYQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Mar 2014 18:24:16 -0500
Received: from PaulLaptop ([140.252.119.210]) by mail.lsst.org with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 3 Mar 2014 16:24:15 -0700
In-Reply-To: <CAJDDKr751=c2AOBfjbg2_im6UCBvwWSVjJ7QX8=76vXMsLSw4g@mail.gmail.com>
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQKjFvigrE20EroY6kKNjpOQ6fvyewFLrX1WAgzPQL4CYaLXiZj6cEcg
Content-Language: en-us
X-OriginalArrivalTime: 03 Mar 2014 23:24:15.0394 (UTC) FILETIME=[B1465820:01CF3737]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243308>

David,

OK, I did as you suggested, and the results were revealing.

First, I replaced "echo" with "cat".  Result: The contents of both files appeared in the Git Bash Window.

Then I tried calling LVCompare from the Git Bash and Windows Command Prompt windows with variations on the paths.

Here are the most relevant results:
First from the Windows Command Prompt:
1) This command works:
C:\LSST_TS\SystemSW\M2AADT>"C:\Program Files (x86)\National Instruments\Shared\L
abVIEW Compare\LVCompare.exe" C:\Users\Paul\AppData\Local\Temp\Typedefs_TestStat
us_Before.ctl C:\LSST_TS\SystemSW\M2AADT\Typedefs\TestStatus.ctl
[General note:
I saved a copy of the temp file and replaced the hex string with the string 'Before' to make the file stick around.  The paths are otherwise the same.]

2) C:\LSST_TS\SystemSW\M2AADT>"C:\Program Files (x86)\National Instruments\Shared\L
abVIEW Compare\LVCompare.exe" C:\Users\Paul\AppData\Local\Temp\Typedefs_TestStat
us_Before.ctl Typedefs\TestStatus.ctl

Result: Error message with reference to C:\Program Files (x86)\National Instruments\Shared\L
abVIEW Compare\supportVIs\_prolvcmp.llb\Typedefs\TestStatus.ctl

Observation: The second path has to be the full path, not the relative path we get back using "echo".

>From the Git Bash window:
1) I tried the command that worked in the Windows Command Prompt:
"C:\Program Files (x86)\National Instruments\Shared\L
abVIEW Compare\LVCompare.exe" C:\Users\Paul\AppData\Local\Temp\Typedefs_TestStat
us_Before.ctl C:\LSST_TS\SystemSW\M2AADT\Typedefs\TestStatus.ctl

Result: Error message with reference to C:\UsersPaulAppDataLocalTempTypedefs_TestStatus_Before.ctl

2) So I tried a variation with forward slashes instead in the parameters:
"C:\Program Files (x86)\National Instruments\Shared\L
abVIEW Compare\LVCompare.exe" C:/Users/Paul/AppData/Local/Temp/Typedefs_TestStat
us_Before.ctl C:/LSST_TS/SystemSW/M2AADT/Typedefs/TestStatus.ctl

Result: Error message with reference to C:\/Users/Paul/AppData/Local/Temp/Typedefs_TestStatus_Before.ctl
[Note: This is the familiar problem we saw using the Git difftool command.]

3) So I tried forward slashes even in the LVCompare.exe path:
"C:/Program Files (x86)/National Instruments\Shared\L
abVIEW Compare\LVCompare.exe" C:/Users/Paul/AppData/Local/Temp/Typedefs_TestStat
us_Before.ctl C:/LSST_TS/SystemSW/M2AADT/Typedefs/TestStatus.ctl

Result: Error message with reference to C:\/Users/Paul/AppData/Local/Temp/Typedefs_TestStatus_Before.ctl

[No difference.]

Paul

-----Original Message-----
From: David Aguilar [mailto:davvid@gmail.com] 
Sent: Sunday, March 2, 2014 5:35 PM
To: Paul Lotz
Cc: Git Mailing List
Subject: Re: difftool sends malformed path to exernal tool on Windows

On Mon, Feb 24, 2014 at 8:44 AM, Paul Lotz <plotz@lsst.org> wrote:
> David,
>
> Thanks for the helpful reply.
>
> As you suggested, I modified the .gitconfig file to have:
> [difftool "test"]
>         cmd = echo \"$LOCAL\" \"$REMOTE\"
>
> and ran
> $ git difftool -t test
>
> An example of the the resulting console output is:
> C:/Users/Paul/AppData/Local/Temp/I8L2Bc_WriteTestParameters.vi 
> Commands/StartAutomatedTest/WriteTestParameters.vi

Hmm. That's interesting.

The next test: replace "echo" with "cat".

Are the contents of both files printed?

If so, then the next thing to try is running:

LVCompare.exe [same paths printed by echo]

and then seeing if it does the right thing.

Could it be that LVCompare.exe is getting tripped up by the forward slashes?

I'm not familiar enough with how msysgit mangles paths before launching programs. It may be that the C:/foo/bar/baz path is getting manged (that's my current guess), but I really don't know.

Another tip I've read online is that launching git via "cmd.exe" may avoid the path mangling. Sorry I'm not more helpful in this area.

Another workaround you can do is to place a shell script wrapper around LVCompare.exe that replaces C:\/ with / and then launches the real LVCompare.exe; that's a workaround, but it could work.

I hope that helps shed some light on what may be going on.
--
David
