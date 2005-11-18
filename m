From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add test case for git-config-set
Date: Fri, 18 Nov 2005 11:57:14 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0511181148520.8037@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0511172249410.18285@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vd5kypjv2.fsf@assigned-by-dhcp.cox.net> <7vsltuo49q.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 18 11:58:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ed3vj-0006Wu-AB
	for gcvg-git@gmane.org; Fri, 18 Nov 2005 11:57:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161039AbVKRK5Q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Nov 2005 05:57:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161044AbVKRK5Q
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Nov 2005 05:57:16 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:27557 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1161039AbVKRK5Q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Nov 2005 05:57:16 -0500
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 13805140050; Fri, 18 Nov 2005 11:57:15 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id E17C09F351; Fri, 18 Nov 2005 11:57:14 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id C21739F34B; Fri, 18 Nov 2005 11:57:14 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id B95B8140050; Fri, 18 Nov 2005 11:57:14 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vsltuo49q.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12224>

Hi,

On Thu, 17 Nov 2005, Junio C Hamano wrote:

> Junio C Hamano <junkio@cox.net> writes:
> 
> > 	git-config-set section.key
> >
> > confusingly enough is --unset (we probably would want to require
> > an explicit command line noise-word "--unset" in this case).

As mentioned in my previous mail, this will go.

> A revised suggestion is:
> 
> 	;# remove all
> 	git-config-set --unset section.key

No. Just remove one unique entry. If people insist it is a good idea to 
throw away all multivars, I'll think about it. But I am not convinced. 
Your use case of a multivar does not fit what I think multivars are useful 
for.

IMHO, multiple key/value pairs are only sensible when they provide a sort 
of subkey, like Linus did in his example:

	[proxy]
		command=ssh for kernel.org
		command=rsh for myprivate.machine

See, there is a subkey, namely "for kernel.org", which can nicely be 
expressed as a regex.

IMOHO, your example

	[diff]
		twohead = resolve
		twohead = recursive

would look much better in this way

	[diff]
		twohead = recursive resolve

Several reasons:

	- it is easier to read
	- it does the job
	- it is clear from the beginning, which one precedes the other
	  (for me it was not at all clear that the last entry wins...)

> 	;# remove values that match rx and then append zero or more values
> 	git-config-set --remove rx section.key [value...]

As I said. *If*, then these must be two operations, for your security. But 
I still don't see a sensible use case of removing all key/value pairs for 
a certain key (and possibly a regex for the values).

Rather, if you have a sensible setup, you'll want to set/replace/unset 
exactly one entry.

> 	;# append one or more values (equivalent to specifying --remove
>         ;# with rx that never matches anything).  To reduce
>         ;# confusion, we always require at least one value here.
> 	git-config-set section.key value [value...]

I think it is less error prone to add them one by one, else you have to 
check the values for uniqueness, too.

> I think (aside from "*-set" now becomes confusing), showing the
> value of the specified key to stdout with
> 
> 	git-config-set section.key
> 
> would be a nice addition to complete the suite; has anybody
> noticed that git-var is cumbersome to use for this?

Good point! This will be in my next version.

Ciao,
Dscho
