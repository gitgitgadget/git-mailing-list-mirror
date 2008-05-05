From: Mark Hills <mark@pogo.org.uk>
Subject: Re: [PATCH] Be more careful with objects directory permissions on 
  clone
Date: Mon, 5 May 2008 11:25:15 +0100 (BST)
Message-ID: <alpine.BSO.1.10.0805051121090.32248@zrgural.vwaro.pbz>
References: <alpine.BSO.1.10.0805041234570.5819@zrgural.vwaro.pbz> <481ECCF0.6080308@viscovery.net> <alpine.BSO.1.10.0805051047260.7723@zrgural.vwaro.pbz> <481EDC4B.2010105@viscovery.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon May 05 12:26:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JsxtW-0002xG-Qw
	for gcvg-git-2@gmane.org; Mon, 05 May 2008 12:26:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753771AbYEEKZS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2008 06:25:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754690AbYEEKZR
	(ORCPT <rfc822;git-outgoing>); Mon, 5 May 2008 06:25:17 -0400
Received: from mailout.ijneb.com ([212.13.201.26]:32081 "EHLO
	metheny.ijneb.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752229AbYEEKZQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2008 06:25:16 -0400
Received: from localhost ([127.0.0.1] ident=mark)
	by metheny.ijneb.com with esmtp (Exim 4.69)
	(envelope-from <mark@pogo.org.uk>)
	id 1Jsxsh-0008UM-Vc; Mon, 05 May 2008 11:25:16 +0100
In-Reply-To: <481EDC4B.2010105@viscovery.net>
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: mark@pogo.org.uk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81265>

On Mon, 5 May 2008, Johannes Sixt wrote:

> Mark Hills schrieb:
>> On Mon, 5 May 2008, Johannes Sixt wrote:
>>
>>> Mark Hills schrieb:
>>>>          cd "$repo" &&
>>>> -        find objects -depth -print | cpio $cpio_quiet_flag -pumd$l
>>>> "$GIT_DIR/" || \
>>>> +        # Create dirs using umask and permissions and destination
>>>> +        find objects -type d -print | (cd "$GIT_DIR" && xargs mkdir
>>>> -p) &&
>>>> +        # Copy 0444 permissions on files
>>>> +        find objects -type f -print | cpio $cpio_quiet_flag -pumd$l
>>>> "$GIT_DIR/" || \
>>>
>>> Wouldn't that be better:
>>>
>>>     find objects ! -type d -print | cpio ...
>>>
>>> ?
>>
>> This was my first suggestion, unfortunately it shows up broken behaviour
>> in all but the latest version of cpio. It creates 0700 directory
>> permissions which is even worse.
>
> Sorry, I should have mentioned that I meant to keep the 'find | xargs
> mkdir' and replace only the second 'find | cpio'.

Ah, I see.

I tend to think that an inclusive match has less scope for future bad 
behaviour than an exclusive match. Have I missed the possiblity that there 
may be content in the objects directory which is not a directory or file?

Mark
