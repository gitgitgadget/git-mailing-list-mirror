From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] git-daemon: --inetd implies --syslog
Date: Mon, 14 Nov 2005 22:23:58 +0100
Message-ID: <4379006E.8020607@op5.se>
References: <20051114164101.58A495BF92@nox.op5.se> <7vlkzrx84p.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Nov 14 22:26:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eblo6-0006Z9-1P
	for gcvg-git@gmane.org; Mon, 14 Nov 2005 22:24:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932140AbVKNVYB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Nov 2005 16:24:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932142AbVKNVYB
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Nov 2005 16:24:01 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:11461 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S932140AbVKNVYA
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Nov 2005 16:24:00 -0500
Received: from [192.168.1.19] (1-2-9-7a.gkp.gbg.bostream.se [82.182.116.44])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 372C46BD01; Mon, 14 Nov 2005 22:23:59 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vlkzrx84p.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11850>

Junio C Hamano wrote:
> exon@op5.se (Andreas Ericsson) writes:
> 
> 
>>Otherwise nothing is logged anywhere, which is a Bad Thing.
>>
>>Signed-off-by: Andreas Ericsson <ae@op5.se>
> 
> 
> Thanks; I am OK with what you are trying to do with this change,
> except that:
> 
>  - I suspect closing stderr is still needed (the "workaround"
>    was about inetd connection sending output to both fd 1 and 2
>    to the client, which would corrupt the protocol conversation
>    when exec'ed program writes anything to its standard error
>    stream).
> 

That shouldn't be a problem because;
1) handle() dupes the connected socket to stdin and stdout, but not stderr.

2) A program sending output to stderr() fails (well, *should* be either 
failing or silent), so it's most likely not sane to continue doing 
things anyway. This assumes that no client prints anything to stderr 
that can be interpreted as "real" protocol data, ofcourse.

>  - I would have preferred the removal of needless else as a
>    separate cleanup patch (this is minor).
> 

Sorry. I think I missed that part when I glanced at the diff output.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
