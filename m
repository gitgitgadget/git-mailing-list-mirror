From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Improve sed portability
Date: Thu, 12 Jun 2008 09:46:38 +0200
Message-ID: <4850D45E.8000802@viscovery.net>
References: <1213189759-11565-1-git-send-email-chris.ridd@isode.com>            <484FDB5D.7060606@viscovery.net> <484FEF71.2030909@isode.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: no To-header on input <"unlisted-recipients:;"@eudaptics.com>,
	git@vger.kernel.org
To: Chris Ridd <chris.ridd@isode.com>
X-From: git-owner@vger.kernel.org Thu Jun 12 09:47:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6hX4-0007q9-6a
	for gcvg-git-2@gmane.org; Thu, 12 Jun 2008 09:47:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754047AbYFLHqp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2008 03:46:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753878AbYFLHqp
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jun 2008 03:46:45 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:61883 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753482AbYFLHqo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2008 03:46:44 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1K6hW5-00064z-Ii; Thu, 12 Jun 2008 09:46:41 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 199CA69F; Thu, 12 Jun 2008 09:46:39 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <484FEF71.2030909@isode.com>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84732>

Chris Ridd schrieb:
> Johannes Sixt wrote:
>> Chris Ridd schrieb:
>>> @@ -73,7 +73,7 @@ resolve_relative_url ()
>>>  module_name()
>>>  {
>>>      # Do we have "submodule.<something>.path = $1" defined in
>>> .gitmodules file?
>>> -    re=$(printf '%s' "$1" | sed -e 's/[].[^$\\*]/\\&/g')
>>> +    re=$(printf "%s\n" "$1" | sed -e 's/[].[^$\\*]/\\&/g')
>>
>> You change sq into dq. Is this not dangerous? Shouldn't backslash-en be
>> hidden from the shell so that printf can interpret it?
> 
> It is necessary to use double quotes. This:
> 
>     printf '%s\n' foobar
> 
> prints a literal \, a literal n, and no newline:
> 
>     foobar\n
> 
> Not desirable :-(

On both Linux and AIX 4.3 I see:

$  printf 'x\ny'; echo z
x
yz

The printf turns the \n into LF.

I mentioned this in the first place because I don't know what various
shells do with \n when they see "%s\n". But one way or the other, the \n
will be turned into LF, either by the shell or by printf. So it's not a
big deal.

> Of course, using a plain old:
> 
>     echo "$1"
> 
> should work well too. Why is printf being used here and not echo, anyway?

Because the "$1" could contain character sequences that some 'echo'
implementations mangle.

-- Hannes
