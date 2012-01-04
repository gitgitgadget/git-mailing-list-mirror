From: Erik Blake <erik@icefield.yk.ca>
Subject: Re: Warning from AV software about kill.exe
Date: Wed, 04 Jan 2012 10:15:29 +0100
Message-ID: <4F0418B1.5050403@icefield.yk.ca>
References: <4EF2E08C.3050502@icefield.yk.ca> <87mxalkn9q.fsf@thomas.inf.ethz.ch> <878vm4lb9q.fsf@fox.patthoyts.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Wed Jan 04 10:55:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RiNZA-0000Bp-2d
	for gcvg-git-2@lo.gmane.org; Wed, 04 Jan 2012 10:55:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754970Ab2ADJzX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jan 2012 04:55:23 -0500
Received: from bosmailout20.eigbox.net ([66.96.188.20]:38158 "EHLO
	bosmailout20.eigbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753229Ab2ADJzV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jan 2012 04:55:21 -0500
X-Greylist: delayed 2384 seconds by postgrey-1.27 at vger.kernel.org; Wed, 04 Jan 2012 04:55:21 EST
Received: from bosmailscan01.eigbox.net ([10.20.15.1])
	by bosmailout20.eigbox.net with esmtp (Exim)
	id 1RiMwZ-0001Oh-IP
	for git@vger.kernel.org; Wed, 04 Jan 2012 04:15:35 -0500
Received: from bosimpout01.eigbox.net ([10.20.55.1])
	by bosmailscan01.eigbox.net with esmtp (Exim)
	id 1RiMwY-0004EZ-Mu; Wed, 04 Jan 2012 04:15:34 -0500
Received: from bosauthsmtp04.eigbox.net ([10.20.18.4])
	by bosimpout01.eigbox.net with NO UCE
	id HMFa1i00205GATN01MFatV; Wed, 04 Jan 2012 04:15:34 -0500
X-EN-OrigOutIP: 10.20.18.4
X-EN-IMPSID: HMFa1i00205GATN01MFatV
Received: from [77.40.181.154] (helo=[192.168.10.117])
	by bosauthsmtp04.eigbox.net with esmtpa (Exim)
	id 1RiMwY-0002ab-KG; Wed, 04 Jan 2012 04:15:34 -0500
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:8.0) Gecko/20111105 Thunderbird/8.0
In-Reply-To: <878vm4lb9q.fsf@fox.patthoyts.tk>
X-EN-UserInfo: 20c972d92b49a3da013d5f179c4005f2:fb4e807829017c6d805c060c7025d0c2
X-EN-AuthUser: erik@icefield.yk.ca
X-EN-OrigIP: 77.40.181.154
X-EN-OrigHost: unknown
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187916>

Another way to implement this (on Windows) would be for the git programs 
to tag themselves with a mutex. Then the "kill" program can determine 
which git programs are running and send them user-defined windows 
messages to shut themselves down. Alternatively, you could send the 
programs the standard windows WM_CLOSE message, but the OS or an AV 
program might still be troubled by that behaviour.

This is how we implement this type of behaviour in our windows programs. 
It does not raise the ire of the OS or AV since you do not have one 
process trying to shut down another. It also bypasses all issues with 
process privileges etc.

Erik

On 2011-12-22 19:19, Pat Thoyts wrote:
> Thomas Rast<trast@student.ethz.ch>  writes:
>
>> Erik Blake<erik@icefield.yk.ca>  writes:
>>
>>> I'm running git under Win7 64. As I selected "Repository|Visualize all
>>> branch history" in the git gui, my AV software (Trustport) trapped the
>>> bin\kill.exe program for "trying to modify system global settings
>>> (time, timezone, registry quota, etc.)"
>>>
>>> Does anyone know the details of this process and what it's function
>>> is? First time I've seen it, though I'm a relatively new user.
>> 'kill' is a standard unix utility that sends signals to processes, in
>> particular signals that cause the processes to exit or be killed
>> forcibly by the kernel, hence the name.  (I don't know how the windows
>> equivalent works under the hood, but presumably it's something similar.)
>>
>> git-gui and gitk use kill to terminate background worker processes that
>> are no longer needed because you closed the window their output would
>> have been displayed in, etc.
> You might try replacing the command in the tcl scripts with 'exec
> taskkill /f /pid $pid' and see if that avoids the error. taskkill is
> present on XP and above as part of the OS distribution so shouldn't
> suffer any AV complaints.
>
