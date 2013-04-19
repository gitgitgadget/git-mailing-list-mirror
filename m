From: Alexander Tomlinson <alex@aivor.com>
Subject: Re: is git-p4 compatible with p4/linux?
Date: Thu, 18 Apr 2013 20:34:40 -0500
Message-ID: <14D98038-C656-47B9-ABF2-CC12914F0C75@aivor.com>
References: <7BF81DF9-941D-400B-8304-6DA5F5C82D4F@aivor.com> <20130419000947.GB9048@padd.com>
Mime-Version: 1.0 (Mac OS X Mail 6.3 \(1503\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Fri Apr 19 03:35:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UT0E9-0002Ya-Ou
	for gcvg-git-2@plane.gmane.org; Fri, 19 Apr 2013 03:35:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967739Ab3DSBer (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Apr 2013 21:34:47 -0400
Received: from smtp-out2.electric.net ([72.35.23.36]:64578 "EHLO
	smtp-out2.electric.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967641Ab3DSBeq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Apr 2013 21:34:46 -0400
Received: from 1UT0Dp-0000LT-T8 by bean.electric.net with emc1-ok (Exim 4.77)
	(envelope-from <alex@aivor.com>)
	id 1UT0Dp-0000Li-V7; Thu, 18 Apr 2013 18:34:41 -0700
Received: by emcmailer; Thu, 18 Apr 2013 18:34:41 -0700
Received: from [10.86.10.83] (helo=fuseout2c)
	by bean.electric.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77)
	(envelope-from <alex@aivor.com>)
	id 1UT0Dp-0000LT-T8; Thu, 18 Apr 2013 18:34:41 -0700
Received: from mailanyone.net
	by fuseout2c with esmtpsa (TLSv1:AES128-SHA:128)
	(MailAnyone extSMTP aivort)
	id 1UT0Do-0006Mx-3k; Thu, 18 Apr 2013 18:34:40 -0700
In-Reply-To: <20130419000947.GB9048@padd.com>
X-Mailer: Apple Mail (2.1503)
X-Outbound-IP: 10.86.10.83
X-Env-From: alex@aivor.com
X-PolicySMART: 1102869
X-Virus-Status: Scanned by VirusSMART (c)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221723>


On Apr 18, 2013, at 7:09 PM, Pete Wyckoff <pw@padd.com> wrote:

> alex@aivor.com wrote on Tue, 16 Apr 2013 23:31 -0500:
>> git-p4.py (1.8.2.1.418.gaec3f77) has at least two behaviors that
>> seem to be incompatible with the version of p4 that I recently
>> downloaded from perforce.com (P4/LINUX26X86_64/2013.1/610569).
>> 
>> TLDR: Is git-p4 written for an old version of p4 CLI with different
>> behavior?  Or for a windows or mac release of p4?  Or am I missing
>> something?
> 
> I had not done any testing beyond p4 12.2 (linux).  But running
> the unit tests through 13.1 just now, they all pass.
> 
>    $ p4 -V
>    Perforce - The Fast Software Configuration Management System.
>    Copyright 1995-2013 Perforce Software.  All rights reserved.
>    This product includes software developed by the OpenSSL Project
>    for use in the OpenSSL Toolkit (http://www.openssl.org/)
>    See 'p4 help legal' for full OpenSSL license information
>    Version of OpenSSL Libraries: OpenSSL 1.0.1c 10 May 2012
>    Rev. P4/LINUX26X86_64/2013.1/610569 (2013/03/19).
> 
> I'm using python 2.7.3.
> 
>> First issue
>> -----------
>> 
>> git-p4 assumes the output of 'p4 print' adds a newline to the
>> target.  To work around this, git-p4.py strips the last char from
>> symlinks as shown in the following snippet:
>> 
>>    if type_base =3D=3D "symlink":
>>        git_mode =3D "120000"
>>        # p4 print on a symlink contains "target\n"; remove the newline
>>        data =3D ''.join(contents)
>>        contents =3D [data[:-1]]
>> 
>> But my 'p4 print' does not output the newline:
>> 
>>    $ ls -l pcre
>>    lrwxrwxrwx 1 user group 12 Apr 16 10:27 pcre -> ../libs/pcre
>> 
>>    $ p4 print -q pcre | od -t x1a
>>    0000000  2e  2e  2f  6c  69  62  73  2f  70  63  72  65
>>             .   .   /   l   i   b   s   /   p   c   r   e
>>    0000014
>> 
>> If I use 'git p4 clone' the above file shows up in git as a
>> symlink to '../libs/pcr'.  I had another symlink whose target had
>> a strlen of 1 and the 'git p4 clone' failed b/c after stripping
>> the last char the result was an empty string.
> 
> There wasn't an explict test for symlinks, but I threw
> one together quickly and it seems to work.  Can you show
> a bit more information about anything that potentially might
> be odd with your install?
> 
>    arf-git-test$ ls -l symlink
>    lrwxrwxrwx 1 pw pw 14 Apr 18 20:02 symlink -> symlink-target
> 
>    $ p4 fstat symlink
>    ... depotFile //depot/symlink
>    ... clientFile /run/shm/trash directory.t9802-git-p4-filetype/cli/symlink
>    ... isMapped 
>    ... headAction add
>    ... headType symlink
>    ... headTime 1366329740
>    ... headRev 1
>    ... headChange 6
>    ... headModTime 1366329740
>    ... haveRev 1
> 
>    $ p4 print -q symlink | od -t x1a
>    0000000  73  79  6d  6c  69  6e  6b  2d  74  61  72  67  65  74  0a
> 	      s   y   m   l   i   n   k   -   t   a   r   g   e   t  nl
>    0000017
> 
> No idea why I get an "nl" but you do not.  If you run _without_
> the "| od ...", then the shell prompt ends up on the same line
> as the output?  Any interesting shell or shell settings?
> 

Yes.  The shell prompt is on the same line as the output:

$ PS1="FOOBAR$"
FOOBAR$p4 print -q pcre
../libs/pcreFOOBAR$

Perhaps it is a configuration item on the server and/or client.   It seems we
are running the same version of p4.  But just to be sure, check yours against
mine:

$ cksum $(which p4)
3254530484 2420552 /usr/bin/p4

If yours if different, can you email a copy of your p4 executable to me
so I can check if it works differently than mine?

I will also check with coworkers here to see how their client behaves.

>> Second issue
>> ------------
>> 
>> git-p4 uses 'p4 print -q -o o FILE' to print a file to stdout.
>> At least that is how I interpret this snippet:
>> 
>>    text = p4_read_pipe(['print', '-q', '-o', '-', file['depotFile']])
>> 
>> However, p4/Linux prints to stdout by default and '-o -' will save
>> the output in a file named '-'.
>> 
>> My git and p4 versions:
>> 
>>    $ git --version
>>    git version 1.8.2.1.418.gaec3f77
>> 
>>    $ p4 -V
>>    Perforce - The Fast Software Configuration Management System.
>>    Copyright 1995-2013 Perforce Software.  All rights reserved.
>>    This product includes software developed by the OpenSSL Project
>>    for use in the OpenSSL Toolkit (http://www.openssl.org/)
>>    See 'p4 help legal' for full OpenSSL license information
>>    Version of OpenSSL Libraries: OpenSSL 1.0.1c 10 May 2012
>>    Rev. P4/LINUX26X86_64/2013.1/610569 (2013/03/19).
> 
> This code only happens on utf16 files.  But running it by hand,
> I cannot reproduce the different behavior:
> 
>    $ p4 print -q //depot/f-ascii
>    three
>    line
>    text
> 
>    $ p4 print -o - -q //depot/f-ascii
>    three
>    line
> 
>    $ ls ./-
>    ls: cannot access ./-: No such file or directory
> 
> I'm again confused.  Any hints you can give would be helpful.

This "second issue" is a non-issue.  It seems "-o -" does send to
stdout for files.  For symlinks, it creates a symlink named "-".
Example:

$ ls -l pcre
lrwxrwxrwx 1 atomlinson atomlinson 12 Apr 18 17:17 pcre -> ../libs/pcre/
$ ls -l ./- ./xxx
/bin/ls: cannot access ./-: No such file or directory
/bin/ls: cannot access ./xxx: No such file or directory
$ p4 print -q -o - pcre
$ p4 print -q -o xxx pcre
$ ls -l ./- ./xxx
lrwxrwxrwx 1 atomlinson atomlinson 12 Apr 18 20:25 ./- -> ../libs/pcre/
lrwxrwxrwx 1 atomlinson atomlinson 12 Apr 18 20:25 ./xxx -> ../libs/pcre/


> 
> 		-- Pete
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Thanks,
Alex
