From: bob <kranki@mac.com>
Subject: Re: git packs
Date: Mon, 12 Nov 2007 09:15:56 -0500
Message-ID: <904628F9-EE34-4C4B-A114-82159AFF0260@mac.com>
References: <F6DD8DCD-416B-4DDF-B384-7213C9ED5565@mac.com> <alpine.LFD.0.9999.0711100011150.21255@xanadu.home> <FC175E4F-D9BE-42CC-B0BB-561B2EDCD941@mac.com> <alpine.LFD.0.999.0711092211250.15101@woody.linux-foundation.org> <B20E1D71-BCDB-4189-952F-3B809A342870@mac.com> <alpine.LFD.0.9999.0711102331270.21255@xanadu.home> <B298202C-3D54-498D-A348-0338914FBA46@mac.com> <alpine.LFD.0.9999.0711112307070.21255@xanadu.home>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Mon Nov 12 15:16:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ira5Y-0004As-00
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 15:16:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753255AbXKLOQR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 09:16:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752772AbXKLOQQ
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 09:16:16 -0500
Received: from smtpoutm.mac.com ([17.148.16.70]:56679 "EHLO smtpoutm.mac.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752660AbXKLOQP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 09:16:15 -0500
Received: from mac.com (asmtp008-s [10.150.69.71])
	by smtpoutm.mac.com (Xserve/smtpout007/MantshX 4.0) with ESMTP id lACEG3er020036;
	Mon, 12 Nov 2007 06:16:03 -0800 (PST)
Received: from [192.168.2.23] (c-66-176-54-4.hsd1.fl.comcast.net [66.176.54.4])
	(authenticated bits=0)
	by mac.com (Xserve/asmtp008/MantshX 4.0) with ESMTP id lACEFxoq010976
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Mon, 12 Nov 2007 06:16:01 -0800 (PST)
In-Reply-To: <alpine.LFD.0.9999.0711112307070.21255@xanadu.home>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64624>


On Nov 11, 2007, at 11:21 PM, Nicolas Pitre wrote:

> On Sun, 11 Nov 2007, bob wrote:
>
>> I applied the patch and these commands:
>>
>> cd rmwHtmlOld
>> rm -fr .git
>> git init
>> git config core.compression 0
>> git add .
>
> Note that I did "git config core.compression 0" simply to disable
> zlib compression altogether when creating the test repo just so it  
> gets
> created faster.  even then, auto-generating and cloning a 8GB test
> repository isn't particularly quick.
	I wasn't sure why you used that, but figured that I should put it
	in, because you did.  And you are very correct that these tests
	can take a very long time.
>
>> I then got the same error as before, "Bus error".  Rats!
>
> Do you get that with a 32-bit or 64-bit build of Git?
	On that machine, I changed the config.mak to generate nothing
	but a 64-bit build.  And activity monitor shows it as 64-bit
	when I am running it. Also, off_t is 64 bit on regular
	MacOSX and as a 64-bit program supported by the
	latest MacOSX.
>
>> Then I modified your script since I do not have seq or
>> your test-genrandom.
>
> test-genrandom is built with Git.  It is just not installed anywhere.
>
>> I substituted:
>>
>> dd count=XX  if=/dev/random of=file_$i
>>
>> where XX is adjusted to meet dd's requirements.  Also,
>
> Again I used test-genrandom instead of /dev/random or /dev/urandom
> simply because the former is much faster.
	I didn't know that it existed, since I am not that familiar with the
	internals and source directory for git.
>
>> I found after searching for a while, that the following
>> works just like your seq command:
>>
>> xyzzy="1 2 3 4"
>> for i in $xyzzy
>> do
>> ...
>> done
>>
>> Your script then ran flawlessly.
>
> However 'seq -w 1 2 63' should be replaced  with "01 03 05 07 09 11 13
> 15" and so on up to 63, and 'seq -w 2 2 64' is "02 04 06 08 10 12 16"
> and so on.
	That I missed but the files added up to quite a bit over 8gigs,
	because my count calculation was off.  So, I thought that it
	was adequate for the testing.  Based on above, it was
	quite a few files less as well.
>
>> I looked through index-pack.c some more, but it is
>> very hard to figure it out without doing a lot of research
>> since there doesn't seem to be anything that describes
>> the layout of a pack.  The link towards the end of the user's
>> manual doesn't work for me.
>
> Look at Documentation/technical/pack-format.txt in the Git source  
> tree.
Thanks.
>
>> The difference between your test and my data is that
>> instead of having a few large files, I have 11,500 files
>> of varying sizes.  On average though, the file size is
>> about 370k.
>
> Are you saying that the test repo with big files works for you but not
> your own data set?
	That is correct, but you are probably correct that this is a separate
	problem, because it is only occurring on the 64-bit side.  The 32-bit
	side is running without error.
>
> Would you please recap what your problem is?
	With more testing last night, I believe that the problem on the 32-bit
	side has been fixed.  But the 'Bus error' on 64-bit side persists.  I
	agree that I was combining it and probably shouldn't have.
> With my one line patch you should not get the "serious inflate
> inconsistency" error anymore.  The bus error must be another issue.
I no longer do on the 32-bit side.
>
>
> Nicolas



I am going to wait on the 64-bit problem until MacOSX 10.5 (Leopard)
settles down a bit.  It has a few bugs in it.  I will submit the  
crashreporter
issue to Apple. Currently, I don't have the time to commit a lot to  
git right
now.

As Apple comes out with new subreleases, I will retry my data.
If it doesn't get resolved after a subrelease or two, then I dig  
deeper and
hopefully have more time to devote to it at that point.

Thank you, I do appreciate your help and your patience.
