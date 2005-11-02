From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH 2/4] Library code for user-relative paths.
Date: Wed, 02 Nov 2005 09:40:32 +0100
Message-ID: <43687B80.1020600@op5.se>
References: <20051101225921.2C6035BA82@nox.op5.se> <7vk6fr6h3j.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Nov 02 09:41:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EXEAf-0006Tj-2H
	for gcvg-git@gmane.org; Wed, 02 Nov 2005 09:40:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932642AbVKBIke (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 Nov 2005 03:40:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932653AbVKBIke
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Nov 2005 03:40:34 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:18304 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S932642AbVKBIkd
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 2 Nov 2005 03:40:33 -0500
Received: from [192.168.1.19] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP id C97516BD00
	for <git@vger.kernel.org>; Wed,  2 Nov 2005 09:40:32 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
In-Reply-To: <7vk6fr6h3j.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11010>

Junio C Hamano wrote:
> Andreas Ericsson <ae@op5.se> writes:
> 
> 
>>+			if((slash = strchr(dir, '/'))) {
>>+				*slash = '\0';
>>+				pw = getpwnam(dir);
>>+				*slash = '/';
> 
> 
> Should you be writing into *slash when dir and path are const
> char *?  I know strchr returns "char *" and the compiler would
> not complain but this sounds somewhat yucky.
> 

True. Although path isn't, strictly speaking, const char *, so perhaps 
that's what needs fixing. It's only ever called with path coming from 
argv, which isn't const. I can't really imagine anywhere where the 
repo-path might be const char * now that I think of it.

> 
>>+		if(slash && *slash + 1)
> 
> 
> I think you mean "if (slash && slash[1])" here.  While we are at
> it, please have a SP betweeen if and open parenthesis.
> 

Actually *(slash + 1), but it amounts to the same thing I suppose. ;)

I looked around for indentation guide-lines but didn't found any, and 
the current code isn't exactly consistent about it. Perhaps it needs adding?

> 
>>+			dir = slash + 1;
>>+		else
>>+			dir = current_dir();
>>+	}
>>+
>>+	/* ~foo/path/to/repo is now path/to/repo and we're in foo's homedir */
>>+	if(chdir(dir) < 0)
>>+		return NULL;
> 
> 
> Hmm.  It's not wrong, but "dir = current_dir()" immediately
> followed by "chdir(dir)" does not feel right.
> 

It could be "return current_dir();" immediately, I suppose. Would that 
be satisfactory?

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
