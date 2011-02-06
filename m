From: Rafael Kitover <rkitover@io.com>
Subject: Re: ignoring file modes completely
Date: Sun, 06 Feb 2011 11:14:30 -0500
Organization: CPAN
Message-ID: <4D4EC8E6.2090200@io.com>
References: <4D4D6BC2.90101@io.com> <1296921829.5467.1.camel@localhost.localdomain> <4D4D7636.7090608@io.com> <4D4D81C9.5080002@op5.se> <4D4DA4C1.5050501@io.com> <4D4E9EAC.4030508@drmicha.warpmail.net> <4D4EC3FD.5010000@io.com>
Reply-To: rkitover@io.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 06 17:15:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pm7GU-0000ID-Kq
	for gcvg-git-2@lo.gmane.org; Sun, 06 Feb 2011 17:15:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753198Ab1BFQO7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Feb 2011 11:14:59 -0500
Received: from smtp.prismnet.com ([209.198.128.91]:56266 "EHLO
	smtp.prismnet.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753189Ab1BFQO5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Feb 2011 11:14:57 -0500
Received: from [127.0.0.1] (c-76-98-235-160.hsd1.pa.comcast.net [76.98.235.160])
	(authenticated bits=0)
	by smtp.prismnet.com (8.14.4/8.14.4) with ESMTP id p16GEsc4033387
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Sun, 6 Feb 2011 10:14:55 -0600 (CST)
	(envelope-from rkitover@io.com)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <4D4EC3FD.5010000@io.com>
X-Spam-Status: No, score=0.0 required=10.0 tests=RDNS_DYNAMIC
	autolearn=disabled version=3.2.5
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on smtp.prismnet.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166152>

On 2/6/2011 10:53 AM, Rafael Kitover wrote:
> On 2/6/2011 8:14 AM, Michael J Gruber wrote:
>> Rafael Kitover venit, vidit, dixit 05.02.2011 20:28:
>>> On 2/5/2011 11:58 AM, Andreas Ericsson wrote:
>>>> On 02/05/2011 05:09 PM, Rafael Kitover wrote:
>>>>> On 2/5/2011 11:03 AM, Jared Hance wrote:
>>>>>> On Sat, 2011-02-05 at 10:24 -0500, Rafael Kitover wrote:
>>>>>>> Hello,
>>>>>>>
>>>>>>> I found the core.filemode option, which ignores executable bits,
>>>>>>> but I
>>>>>>> need an option to ignore all mode differences, and such an option
>>>>>>> does
>>>>>>> not seem to exist.
>>>>>>
>>>>>> The only mode tracked by Git is the executable bit, so this shouldn't
>>>>>> even be an issue. Are you sure the executable bit isn't the problem?
>>>>>>
>>>>> $ git config --global core.filemode
>>>>> false
>>>>>
>>>>> Output of "git diff HEAD" :
>>>>>
>>>>> diff --git a/Makefile.PL b/Makefile.PL
>>>>> old mode 100755
>>>>> new mode 100644
>>>>> diff --git a/t/02ads.t b/t/02ads.t
>>>>> old mode 100755
>>>>> new mode 100644
>>>>> diff --git a/t/02cxn.t b/t/02cxn.t
>>>>> old mode 100755
>>>>> new mode 100644
>>>>> diff --git a/t/04os.t b/t/04os.t
>>>>> old mode 100755
>>>>> new mode 100644
>>>>
>>>> Those are all executable bit diffs.
>>>>
>>>
>>> Ok, but I have core.filemode set to "false" as I showed, why does this
>>> happen then?
>>
>> I can't confirm this on linux with current git. What are your versions?
>> Do you have a minimal example (starting from git init)?
>
> This is msysGit:
>
> $ git --version
> git version 1.7.3.1
>
> I can't replicate this with just "git init" and a file, it seems to
> happen when I use "git cpan-init" in Cygwin then look at the repo in
> msysGit.

Actually, I can replicate this in Cygwin git:

$ git --version
git version 1.7.3.3

$ cd ~/src
$ mkdir test-repo
$ cd test-repo
$ git init
$ touch README
$ git add README
$ git commit -a -m'test commit'
$ git diff HEAD
$ chmod +x README
$ git diff HEAD
diff --git a/README b/README
old mode 100644
new mode 100755
$ git config --global core.filemode
false

The way the executable bit works seems to be different between Cygwin 
and msys, but in either case core.filemode seems to not be working properly.
