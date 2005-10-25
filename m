From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] git_progname
Date: Tue, 25 Oct 2005 13:12:07 +0200
Message-ID: <435E1307.3090209@op5.se>
References: <435ABB99.5020908@op5.se> <7vll0l6pn7.fsf@assigned-by-dhcp.cox.net> <435B5AE0.1060400@op5.se> <7v1x2cyplw.fsf@assigned-by-dhcp.cox.net> <435DF6DA.6010205@op5.se> <20051025093150.GB30889@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Oct 25 13:14:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EUMjd-0007iQ-CS
	for gcvg-git@gmane.org; Tue, 25 Oct 2005 13:12:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932131AbVJYLMJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Oct 2005 07:12:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932132AbVJYLMJ
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Oct 2005 07:12:09 -0400
Received: from linux-server1.op5.se ([193.201.96.2]:5348 "EHLO smtp-gw1.op5.se")
	by vger.kernel.org with ESMTP id S932131AbVJYLMI (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Oct 2005 07:12:08 -0400
Received: from [192.168.1.19] (1-2-9-7a.gkp.gbg.bostream.se [82.182.116.44])
	by smtp-gw1.op5.se (Postfix) with ESMTP id 51A7D6BD00
	for <git@vger.kernel.org>; Tue, 25 Oct 2005 13:12:07 +0200 (CEST)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
In-Reply-To: <20051025093150.GB30889@pasky.or.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10581>

Petr Baudis wrote:
> Could you please also trim the mails you are replying to a bit?
> 

Aye.

> Dear diary, on Tue, Oct 25, 2005 at 11:11:54AM CEST, I got a letter
> where Andreas Ericsson <ae@op5.se> told me that...
> 
>>grep -l "int main" *.c | xargs -- sed -i '/^#include/i#include "main.h"'
> 
> 
> Urgh. Now this is ugly. What about making it a bit more intrusive while
> quite more saner?
> 

I'm not sure what you're referring to. The one-liner is a one-liner. 
It's sort of supposed to be ugly.

Including main.h is a fairly sane option for common initialization code.

> 
> Also, when you already solve this for non-__GLIBC__ systems, I doubt
> that there is any win in keeping the __GLIBC__-specific hack, except
> that most developers won't see any bugs in the generic solution since
> they are using glibc.
> 

True. I'll rework it if someone thinks it's worth it.

> 
> Someone said that converting main()s to git_main()s would help the
> libification effort,


I had some thoughts along those lines as well, especially for reading 
configuration files.

> but I suspect that you actually want to set the
> progname to whatever you call when you call its git_main().
> 

This I don't understand. Do you mean "set the progname to whatever you 
call" as in "set the progname to whatever the program author calls the 
program" or as in "set the progname to whatever it's called as from the 
command-line"?

> We can make it go into the init section, but that won't be too portable
> either.
> 
> So I'd say just add setup_progname("foo") at the start of your main().
> 

Set the progname to whatever the author calls it then.

If so, I'd put
const char *git_progname = GIT_PROGNAME;
anywhere in the main() file and expanding the %.o: rule to include 
-DGIT_PROGNAME=\"git-$*\"

This would bark if there's a program that doesn't have it that's linked 
against something that uses it, which the setup_progname() approach 
wouldn't do.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
