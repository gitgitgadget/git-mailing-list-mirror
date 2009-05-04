From: Andreas Ericsson <ae@op5.se>
Subject: Re: Why Git is so fast
Date: Mon, 04 May 2009 10:01:57 +0200
Message-ID: <49FEA0F5.2050800@op5.se>
References: <46a038f90904270155i6c802fceoffc73eb5ab57130e@mail.gmail.com>	 <m3ocugod96.fsf@localhost.localdomain>	 <m3fxfqnxn5.fsf_-_@localhost.localdomain>	 <alpine.LFD.2.00.0904301401120.6741@xanadu.home> <81b0412b0904301216j7ef73870y775cf6d89b5aa71e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Nicolas Pitre <nico@cam.org>, Jakub Narebski <jnareb@gmail.com>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 04 10:02:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M0t7y-0005rf-Q1
	for gcvg-git-2@gmane.org; Mon, 04 May 2009 10:02:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753788AbZEDICE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 May 2009 04:02:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753020AbZEDICD
	(ORCPT <rfc822;git-outgoing>); Mon, 4 May 2009 04:02:03 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:30312 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752863AbZEDICB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 May 2009 04:02:01 -0400
Received: by fg-out-1718.google.com with SMTP id 16so1122967fgg.17
        for <git@vger.kernel.org>; Mon, 04 May 2009 01:01:59 -0700 (PDT)
Received: by 10.86.29.8 with SMTP id c8mr5469061fgc.7.1241424119272;
        Mon, 04 May 2009 01:01:59 -0700 (PDT)
Received: from clix.int.op5.se ([212.112.174.166])
        by mx.google.com with ESMTPS id l19sm5619376fgb.12.2009.05.04.01.01.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 04 May 2009 01:01:58 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <81b0412b0904301216j7ef73870y775cf6d89b5aa71e@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118220>

Alex Riesen wrote:
> 2009/4/30 Nicolas Pitre <nico@cam.org>:
>> Yet, this point is misleading because when people gives to Git the
>> reputation of being faster, this is certainly from comparison of
>> operations performed on the same source tree.  Who cares about scenarios
>> for which the tool was not designed?  Those "enterprise configuration
>> management repositories" are not what Git was designed for indeed, but
> 
> Especially when no sane developer will put in his repository the toolchain
> (pre-compiled. For all supported platforms!), all the supporting tools
> (like grep,
> find, etc.Pre-compiled _and_ source), the in-house framework (pre-compiled
> and source, again), firmware (pre-compiled and put in the repository weekly),
> and operating system code (pre-compiled, with firmware-specific drivers,
> updated, you guessed it, weekly), and well, there is the project itself (Java or
> C++, and documentation in .doc and .xls)...

Well, git could actually handle that just fine if the toolchain was in a
submodule or even in a separate repository that developers never had to
worry about. Then you'd design a little tool that said "re-create build 8149"
and it would pull the tools used to do that, and the code and the artwork,
and then set to work. It'd be an overnight (or over-weekend) job, but no
man-hours would be spent on it. That's how I'd do it anyways, probably
with the "build" repository as a master repo with "tools", "code" and
"artwork" as submodules to it.

> Now, what kind of self-hating idiot will design a system for that kind of abuse?

Noone, naturally, but one might design a system where each folder
in the repository root is considered a repository in its own right,
and then get that more or less for free.

The problem with git for such scenarios is that you have to think
*before* creating the repository, or play silly buggers when importing
which makes it hard to see how the pieces fit together afterwards.

A tool that could take a repository from a different scm, create a
master repository and several submodule repositories from it would
probably solve many of the issues gaming companies have if they want
to switch to using git. Not least because it would open their eyes
to how that sort of separation can be done in git, and why it's
useful. The binary repos can then turn off delta-compression (and
zlib compression) for all its blobs using a .gitattributes file,
and things would be several orders of magnitudes faster.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Register now for Nordic Meet on Nagios, June 3-4 in Stockholm
 http://nordicmeetonnagios.op5.org/

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
