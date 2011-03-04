From: Colin Guthrie <gmane@colin.guthr.ie>
Subject: Re: [BUG] git-am silently applying patches incorrectly
Date: Fri, 04 Mar 2011 16:41:29 +0000
Message-ID: <4D711639.4070706@colin.guthr.ie>
References: <4D70EBC3.3010400@colin.guthr.ie> <1299255471.22002.15.camel@drew-northup.unet.maine.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Drew Northup <drew.northup@maine.edu>
X-From: git-owner@vger.kernel.org Fri Mar 04 17:41:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PvY4R-0005gH-Fd
	for gcvg-git-2@lo.gmane.org; Fri, 04 Mar 2011 17:41:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759809Ab1CDQle (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Mar 2011 11:41:34 -0500
Received: from brent.tribalogic.net ([78.86.109.144]:39542 "EHLO
	summit.brent.tribalogic.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751790Ab1CDQld (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Mar 2011 11:41:33 -0500
Received: from localhost (summit.brent.tribalogic.net [127.0.0.1])
	by summit.brent.tribalogic.net (Postfix) with ESMTP id B4DBBD8709;
	Fri,  4 Mar 2011 16:41:30 +0000 (GMT)
X-Virus-Scanned: amavisd-new at brent.tribalogic.net
Received: from summit.brent.tribalogic.net ([127.0.0.1])
	by localhost (summit.brent.tribalogic.net [127.0.0.1]) (amavisd-new, port 10025)
	with LMTP id 7IY9u-F1PrOh; Fri,  4 Mar 2011 16:41:29 +0000 (GMT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.14) Gecko/20110301 Mageia/3.1.8-1.mga1 (1) Thunderbird/3.1.8
In-Reply-To: <1299255471.22002.15.camel@drew-northup.unet.maine.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168447>

'Twas brillig, and Drew Northup at 04/03/11 16:17 did gyre and gimble:
> 
> On Fri, 2011-03-04 at 13:40 +0000, Colin Guthrie wrote:
>> Hi,
>>
>> We recently found a bug in git-am 1.7.4.1 while working on PulseAudio.
>>
>> It seems that it mis-applied a patch and did so silently without
>> generating any warnings. It is reproducible and has been confirmed on
>> different distros.
>>
>> I make reference to the bug here:
>> http://thread.gmane.org/gmane.comp.audio.pulseaudio.general/8840/focus=8857
>>
>> In order to reproduce:
>>
>> git clone http://git.0pointer.de/repos/pulseaudio.git
>> git co -b misapply 0ce3017b7407ab1c4094f7ce271bb68319a7eba7
>> git am 0002-alsa-mixer-add-required-any-and-required-for-enum-op.patch
>>
>> (I've attached the patch here for convenience).
> 
>> For reference, applying the patch manually with patch works fine and
>> does not result in an error:
>>
>> $ cat 0002-alsa-mixer-add-required-any-and-required-for-enum-op.patch |
>> patch -p1
>> patching file src/modules/alsa/alsa-mixer.c
>> Hunk #1 succeeded at 1121 (offset 103 lines).
>> Hunk #2 succeeded at 1325 (offset 103 lines).
>> Hunk #3 succeeded at 1356 (offset 103 lines).
>> Hunk #4 succeeded at 1613 (offset 103 lines).
>> Hunk #5 succeeded at 1640 (offset 103 lines).
>> Hunk #6 succeeded at 1913 (offset 103 lines).
>> Hunk #7 succeeded at 1997 (offset 105 lines).
>> Hunk #8 succeeded at 2242 (offset 106 lines).
>> Hunk #9 succeeded at 2261 (offset 106 lines).
>> Hunk #10 succeeded at 2312 (offset 106 lines).
>> patching file src/modules/alsa/alsa-mixer.h
>> Hunk #1 succeeded at 112 (offset 1 line).
>> Hunk #2 succeeded at 133 (offset 1 line).
>> Hunk #3 succeeded at 169 (offset 1 line).
>> patching file src/modules/alsa/mixer/paths/analog-output.conf.common
> 
> Did you try removing the first line from the patch mbox file?
> It seems to work just fine if you do that. 

Do you mean the line:

>From ae83e51c82a747332494bf10c245281e49343fe3 Mon Sep 17 00:00:00 2001

?

If so, I removed that line and it still failed to apply correctly with
git am.

> If you just send the output of "git format-patch" untouched as an
> attachment you can expect problems.

Wow! I've never heard of this before... So you're saying it's actually
invalid to do a git format-patch and then a git am on the files it
generates?

If that's the case, then I need to rethink a whole lot of things,
including the way several distros deal with patch management in their
package VCSs.... I'm quite shocked by this! Can you point me to
somewhere in the docs that discusses this?


I'd like to point out that "patch" is able to apply the exact same patch
fine as noted above. To me this seems like a very serious bug in the way
that git-am deals with the application of the patch, but perhaps I'm
missing something.....


Col



-- 

Colin Guthrie
gmane(at)colin.guthr.ie
http://colin.guthr.ie/

Day Job:
  Tribalogic Limited [http://www.tribalogic.net/]
Open Source:
  Mageia Contributor [http://www.mageia.org/]
  PulseAudio Hacker [http://www.pulseaudio.org/]
  Trac Hacker [http://trac.edgewall.org/]
