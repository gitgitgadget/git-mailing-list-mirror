From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] C implementation of the 'git' program.
Date: Fri, 11 Nov 2005 13:04:54 +0100
Message-ID: <437488E6.2050100@op5.se>
References: <20051110182631.3C5615BF90@nox.op5.se>	<m3lkzv4qnz.fsf@harinath.blr.novell.com> <7vveyzskdk.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Nov 11 13:07:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EaXf4-0002QX-4R
	for gcvg-git@gmane.org; Fri, 11 Nov 2005 13:05:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750738AbVKKME4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 Nov 2005 07:04:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750747AbVKKME4
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Nov 2005 07:04:56 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:173 "EHLO smtp-gw1.op5.se")
	by vger.kernel.org with ESMTP id S1750738AbVKKMEz (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Nov 2005 07:04:55 -0500
Received: from [192.168.1.19] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP id 8F8F36BD20
	for <git@vger.kernel.org>; Fri, 11 Nov 2005 13:04:54 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
In-Reply-To: <7vveyzskdk.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11591>

Junio C Hamano wrote:
> Raja R Harinath <rharinath@novell.com> writes:
> 
> 
>>This is bad, since it does the wrong thing for the correct way:
>>
>>  make prefix=/usr
>>  sudo make prefix=/usr install
>>
>>With your patch 'git' will be compiled as root.
> 
> 
> You are correct.
> 
> We should allow building as user and installing as root, with
> the installation step _not_ touching the build directory at all.

Sane point. This doesn't work without a ./configure script or some such 
though (something external to the Makefile that updates a config-file of 
some sort), as

make
(make finishes, user remembers he/she must use prefix= to install somewhere)
make prefix=/usr

wouldn't rebuild git so binaries produced would still try to use 
$HOME/bin for libdir. Granted, it's easy enough to do 'touch git.c' 
before rebuilding, but it's not exactly intuitive.

I'll hack up a configure-script if that's alright. It should be fairly 
short and just define the GIT_VERSION and GIT_LIBDIR macros.

I imagine this can be done through the config.mak file, included from 
221 in Makefile, supposing it's forcibly included rather than just if it 
exists, and we'll have the 'git:' target depend on it. I think this is 
the least intrusive change. OTOH, it might not be bad to move some of 
the uname_? logic to a shell-script (and have all targets depend on 
config.mak).

Thoughts? I've got a feeling I've overlooked something here.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
