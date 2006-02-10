From: Andreas Ericsson <ae@op5.se>
Subject: Re: Resetting paths
Date: Fri, 10 Feb 2006 12:44:48 +0100
Message-ID: <43EC7CB0.5040804@op5.se>
References: <7vlkwjzv0w.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 10 12:45:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F7Wi5-0005bP-F6
	for gcvg-git@gmane.org; Fri, 10 Feb 2006 12:45:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751000AbWBJLov (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Feb 2006 06:44:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750998AbWBJLou
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Feb 2006 06:44:50 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:55217 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1750796AbWBJLou
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Feb 2006 06:44:50 -0500
Received: from [192.168.1.20] (host-213.88.215.14.addr.se.sn.net [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 41B996BD12; Fri, 10 Feb 2006 12:44:49 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vlkwjzv0w.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15873>

Junio C Hamano wrote:
> 
> While I worked on parts of the system that deals with the cached
> lstat() information, I needed a way to debug that, so I hacked
> ls-files -t option to show entries marked as "always matches the
> index" with lowercase tag letters.  This was primarily debugging
> aid hack.
> 
> Then I committed the whole thing with "git commit -a" by
> mistake.  In order to rewind the HEAD to pre-commit state, I can
> say "git reset --soft HEAD^", but after doing that, now I want
> to unupdate the index so that ls-files.c matches the pre-commit
> HEAD.
> 
> 
> Have people found themselves in similar need like this?  This
> could take different forms.
> 

Sometimes, yes.

>  * you did "git update-index" on a wrong path.  This is my
>    example and the above voodoo is a recipe for recovery.
> 
>  * you did "git add" on a wrong path and you want to remove it.
>    This is easier than the above:
> 
> 	git update-index --force-remove path
> 
>  * you did the above recovery from "git add" on a wrong path,
>    and you want to add it again.  The same voodoo would work in
>    this case as well.
> 
> 	git ls-tree HEAD path | git update-index --index-info
> 
> We could add "git reset path..." to reduce typing for the above,
> but I am wondering if it is worth it.
> 

How about "git update-index --undo path...", possibly with "git reset 
path..." as a shorthand. Support for temporary indexes already exist, so 
it should be a simple (and atomic) operation of copying it out with the 
paths mentioned skipped, and then overwriting the current index. I'm not 
sure how well it would perform on very large repositories, but having a 
snappish command to undo a blunder is usually welcome even if it takes 
half a minute or more to run.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
