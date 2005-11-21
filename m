From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH 5/5] git-daemon support for user-relative paths.
Date: Mon, 21 Nov 2005 12:10:48 +0100
Message-ID: <4381AB38.7090209@op5.se>
References: <20051117193714.428785C7FA@nox.op5.se>	<7voe4ird8v.fsf@assigned-by-dhcp.cox.net> <437DAA66.6070301@op5.se>	<7voe4hfssj.fsf@assigned-by-dhcp.cox.net> <437E67AC.2010400@op5.se> <7vfypquz88.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 21 12:13:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ee9ZV-0005y3-4h
	for gcvg-git@gmane.org; Mon, 21 Nov 2005 12:10:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932261AbVKULKu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 Nov 2005 06:10:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932262AbVKULKu
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Nov 2005 06:10:50 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:56704 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S932261AbVKULKt
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Nov 2005 06:10:49 -0500
Received: from [192.168.1.19] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 4FFE96BCFF; Mon, 21 Nov 2005 12:10:48 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vfypquz88.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12437>

Junio C Hamano wrote:
> Andreas Ericsson <ae@op5.se> writes:
> 
> 
>>I'll run the clone/fetch/push test-suite again tomorrow, with this 
>>applied. It looks good though.
> 
> 
> Sorry, but there was a thinko in my butchered version of
> enter_repo().  While allowing only absolute path was good for
> the version with your daemon.c change, it was not with the
> current one that runs upload-pack with "." as repo.  In either
> case we _do_ chdir() to it after validating the path, so I am
> wondering if it is a good idea to keep sending "." as repo when
> executing upload-pack with this patch as well.

It might be, and it's good since it prevents the otherwise possible race 
that occurs when git-upload-pack chdir()'s again.

>  This does not
> make any practical difference, but I think it makes the intent
> clearer -- "we are already there so do not try going anywhere
> else".
> 

So enter_repo allows "." (exactly and without chdir()) and all paths 
starting with '/' if strict?

> So I am thinking about applying something like this patch
> on top of the last part of your patch.
> 
>  - Do validation only on canonicalized paths;
>  - Run upload-pack with "." as repo, not full path;
>  - allow trailing slash under --strict-paths i.e. "git://host/my/repo.git/"
> 
> What do you think?
> 

Apart from comments and indentation it's more or less exactly what I 
have in my revised git-daemon patch (although without what you mentioned 
in your own reply to this mail).

Do you want the revised one from me or will you apply the original with 
this on top?

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
