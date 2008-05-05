From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Be more careful with objects directory permissions on
   clone
Date: Mon, 05 May 2008 12:42:00 +0200
Message-ID: <481EE478.9000704@viscovery.net>
References: <alpine.BSO.1.10.0805041234570.5819@zrgural.vwaro.pbz> <481ECCF0.6080308@viscovery.net> <alpine.BSO.1.10.0805051047260.7723@zrgural.vwaro.pbz> <481EDC4B.2010105@viscovery.net> <alpine.BSO.1.10.0805051121090.32248@zrgural.vwaro.pbz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Mark Hills <mark@pogo.org.uk>
X-From: git-owner@vger.kernel.org Mon May 05 12:43:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jsy9p-0007tE-OM
	for gcvg-git-2@gmane.org; Mon, 05 May 2008 12:42:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752899AbYEEKmJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2008 06:42:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752118AbYEEKmJ
	(ORCPT <rfc822;git-outgoing>); Mon, 5 May 2008 06:42:09 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:50835 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752838AbYEEKmI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2008 06:42:08 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Jsy8y-00072d-Fx; Mon, 05 May 2008 12:42:05 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 41D426D9; Mon,  5 May 2008 12:42:04 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <alpine.BSO.1.10.0805051121090.32248@zrgural.vwaro.pbz>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81267>

Mark Hills schrieb:
> On Mon, 5 May 2008, Johannes Sixt wrote:
> 
>> Mark Hills schrieb:
>>> On Mon, 5 May 2008, Johannes Sixt wrote:
>>>
>>>> Mark Hills schrieb:
>>>>>          cd "$repo" &&
>>>>> -        find objects -depth -print | cpio $cpio_quiet_flag -pumd$l
>>>>> "$GIT_DIR/" || \
>>>>> +        # Create dirs using umask and permissions and destination
>>>>> +        find objects -type d -print | (cd "$GIT_DIR" && xargs mkdir
>>>>> -p) &&
>>>>> +        # Copy 0444 permissions on files
>>>>> +        find objects -type f -print | cpio $cpio_quiet_flag -pumd$l
>>>>> "$GIT_DIR/" || \
>>>>
>>>> Wouldn't that be better:
>>>>
>>>>     find objects ! -type d -print | cpio ...
>>>>
>>>> ?
>>>
>>> This was my first suggestion, unfortunately it shows up broken behaviour
>>> in all but the latest version of cpio. It creates 0700 directory
>>> permissions which is even worse.
>>
>> Sorry, I should have mentioned that I meant to keep the 'find | xargs
>> mkdir' and replace only the second 'find | cpio'.
> 
> Ah, I see.
> 
> I tend to think that an inclusive match has less scope for future bad
> behaviour than an exclusive match. Have I missed the possiblity that
> there may be content in the objects directory which is not a directory
> or file?

Theoretically, you could have symbolic links to loose objects or packs.

Generally, you shouldn't change the behavior of a program more than necessary.

-- Hannes
