From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] git.c: Re-introduce sane error messages on missing commands.
Date: Wed, 28 Jun 2006 10:13:44 +0200
Message-ID: <44A23A38.3090206@op5.se>
References: <20060627083508.E912A5BBAB@nox.op5.se> <7vpsgu6wba.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 28 10:13:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FvVBH-00014o-Gq
	for gcvg-git@gmane.org; Wed, 28 Jun 2006 10:13:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423214AbWF1INr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Jun 2006 04:13:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423215AbWF1INr
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jun 2006 04:13:47 -0400
Received: from linux-server1.op5.se ([193.201.96.2]:35520 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1423214AbWF1INq
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jun 2006 04:13:46 -0400
Received: from [192.168.1.20] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 51C146BCC1; Wed, 28 Jun 2006 10:13:45 +0200 (CEST)
User-Agent: Mozilla Thunderbird 1.0.8-1.1.fc4 (X11/20060501)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vpsgu6wba.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22779>

Junio C Hamano wrote:
> Andreas Ericsson <ae@op5.se> writes:
> 
> 
>>Somewhere in the alias handling git turned hostile on fat fingers:
>>
>>	$ git showbranch
>>	Failed to run command '': Is a directory
> 
> 
> Does not happen here (nor on Cygwin 1.4.1.rc1).  Care to help
> reproducing it?
> 

Here's the complete procedure I used:

	$ git pull && make; # works ok
	$ make strip install; # works ok
	$ git showbranch
	Failed to run command '': Is a directory
	(confusion and puzzlement...)
	$ git checkout master; git reset --hard master; # works ok
	$ git pull; # gets nothing (I try stupid things first ;p)
	$ make clean install; # works ok
	$ git showbranch
	Failed to run command '': Is a directory
	$ git --version
	git version 1.4.1.rc1.g1ef9


It's reliably reproducible here. Notable though is that I have no 
.git/config in my git.git clone and no ~/.gitconfig (or ~/.gitrc or 
whatever), so the handle_alias() function never finds a config file to 
look for aliases in.

Either way, removing the variable "char git_command[MAX_PATH + 1];" from 
git.c:main() is correct since it's never used for anything but printing 
the (erroneous) error message above.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
