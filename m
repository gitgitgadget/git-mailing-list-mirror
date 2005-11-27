From: Andreas Ericsson <ae@op5.se>
Subject: Re: git-send-mail in sh
Date: Mon, 28 Nov 2005 00:34:03 +0100
Message-ID: <438A426B.7070607@op5.se>
References: <4386DD45.6030308@op5.se>	<7v7jaxou5b.fsf@assigned-by-dhcp.cox.net> <43874935.2080804@op5.se>	<7vwtiwmvfp.fsf@assigned-by-dhcp.cox.net> <4388E33A.8000004@op5.se> <7v4q5xbvip.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 28 00:36:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EgW2O-00057C-HK
	for gcvg-git@gmane.org; Mon, 28 Nov 2005 00:34:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751174AbVK0XeF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 Nov 2005 18:34:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751175AbVK0XeF
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Nov 2005 18:34:05 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:63654 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1751174AbVK0XeE
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Nov 2005 18:34:04 -0500
Received: from [192.168.1.19] (1-2-9-7a.gkp.gbg.bostream.se [82.182.116.44])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 91CD96BCBE; Mon, 28 Nov 2005 00:34:03 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v4q5xbvip.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12835>

Junio C Hamano wrote:
> Andreas Ericsson <ae@op5.se> writes:
> 
>>            # single commit
>>            com1="${com1##*^}"
>>            range="$com1^1..$com1"
>>            ;;
> 
> 
> I wonder if you meant "${com1%^}" here, to remove the trailing '^'.
> 

I did/do/done. :)

> 
>>        ?*^[0-9]|?*^[0-9][0-9])
>>            # series of commits, ranging back from <commit-ish>
>>            range="$com1..${com1%%^*}"
>>            ;;
>>        ^[0-9]|^[0-9][0-9])
>>            # series of commits, ranging back from HEAD
>>            range="HEAD$com1..HEAD"
>>            ;;
> 
> 
> N generation back in extended SHA1 notation uses a tilde '~',


I just noticed that after sending the original email. I've changed it to 
take tilde instead.

> Also limiting to between 0 and 99
> generations misinterprets "HEAD~123".
> 
> Although checking only the letter that follows the tilde is a
> digit mistakenly accepts something like "master~1-bad-one", that
> is already malformed and whatever comes downstream would barf,
> so that may be fine.  How about something like:
> 
> 	?*'~'[1-9]*)
>         	range="$com1..${com1%~*}" ;;
> 	'~'[1-9]*)
>         	range="HEAD$com1..HEAD" ;;
> 

Fine by me, although that 99 patches limit was sort of semi-intentional. 
Doing it this way makes case order matter since
	?*'~'[1-9]*

will also match

	<commit>~3..HEAD

I'll stick with your way though and put a comment there so people don't 
touch the ordering.


Thanks for the expr lesson btw.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
