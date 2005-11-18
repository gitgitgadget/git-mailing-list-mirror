From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 5/5] git-daemon support for user-relative paths.
Date: Fri, 18 Nov 2005 12:41:32 -0800
Message-ID: <437E3C7C.6000303@zytor.com>
References: <20051117193714.428785C7FA@nox.op5.se> <7voe4ird8v.fsf@assigned-by-dhcp.cox.net> <437DAA66.6070301@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 18 23:37:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by deer.gmane.org with esmtp (Exim 3.35 #1 (Debian))
	id 1EdD42-0006mV-00
	for <gcvg-git@gmane.org>; Fri, 18 Nov 2005 21:42:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161204AbVKRUmI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Nov 2005 15:42:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161198AbVKRUmI
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Nov 2005 15:42:08 -0500
Received: from terminus.zytor.com ([192.83.249.54]:37250 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1161195AbVKRUlu
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Nov 2005 15:41:50 -0500
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id jAIKfbn8012464
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 18 Nov 2005 12:41:37 -0800
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: <437DAA66.6070301@op5.se>
X-Virus-Scanned: ClamAV version 0.87.1, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12276>

Andreas Ericsson wrote:
> 
> It's already there but in a different format. Adding "if (!strict)" to 
> the previously unconditional 'chdir(".git");' won't change that.
> 
> Like I said, I made sure everything that worked before works now too.
> 
>> Under strict-path, I think not doing any DWIM like this is fine,
>> but otherwise I suspect changing this would break existing
>> remotes/origin file people may have.  In addition enter_repo()
>> as posted does its own DWIM to chdir to ".git" unconditionally
>> as I pointed out...
> 
> DWIM? That's an acronym I don't know.
> 

DWIM = "Do What I Mean", i.e. program trying to be clever.  A (usually) 
good thing for usability, a very bad thing for security.

In particular, DWIM is bad for security when you have a flow like:

	user input -> security check -> DWIM

... which lets the user subvert the security check by knowing how the 
DWIM will mangle the input.  What's worse, programmers like yourself 
frequently say "oh, it's okay, though, I know what the DWIM does and it 
can't break the security checks I do."

Well, then someone comes along and changes either the security checks 
(e.g. add a blacklist), or the DWIM, or both.  Security hole opens.

Therefore, the flow must *ALWAYS* be:

	user input -> DWIM -> security check


Your patch re-introduces the incorrect flow.

	-hpa
