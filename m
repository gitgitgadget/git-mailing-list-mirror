From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] connect.c: add a way for git-daemon to pass an error
 back to client
Date: Sat, 01 Nov 2008 12:30:42 +0100
Message-ID: <490C3DE2.3010808@op5.se>
References: <b97024a40810311859t2e5a6102u31ad4480e7c75c03@mail.gmail.com> <alpine.DEB.1.00.0811010316340.22125@pacific.mpi-cbg.de.mpi-cbg.de> <alpine.LFD.2.00.0810312218300.13034@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Tom Preston-Werner <tom@github.com>, git@vger.kernel.org,
	gitster@pobox.com
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Sat Nov 01 12:33:23 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwEjE-0004Y2-Uh
	for gcvg-git-2@gmane.org; Sat, 01 Nov 2008 12:33:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751164AbYKALa5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Nov 2008 07:30:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750978AbYKALa5
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Nov 2008 07:30:57 -0400
Received: from mail.op5.se ([193.201.96.20]:41234 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750791AbYKALa4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Nov 2008 07:30:56 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 542B31B8010D;
	Sat,  1 Nov 2008 12:25:40 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0e19TUxpGpM6; Sat,  1 Nov 2008 12:25:38 +0100 (CET)
Received: from clix.int.op5.se (unknown [172.27.78.6])
	by mail.op5.se (Postfix) with ESMTP id 647141B800AF;
	Sat,  1 Nov 2008 12:25:34 +0100 (CET)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <alpine.LFD.2.00.0810312218300.13034@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99735>

Nicolas Pitre wrote:
> On Sat, 1 Nov 2008, Johannes Schindelin wrote:
> 
>> Hi,
>>
>> On Fri, 31 Oct 2008, Tom Preston-Werner wrote:
>>
>>> The current behavior of git-daemon is to simply close the connection on
>>> any error condition. This leaves the client without any information as
>>> to the cause of the failed fetch/push/etc.
>>>
>>> This patch allows get_remote_heads to accept a line prefixed with "ERR"
>>> that it can display to the user in an informative fashion. Once clients
>>> can understand this ERR line, git-daemon can be made to properly report
>>> "repository not found", "permission denied", or other errors.
>>>
>>> Example
>>>
>>> S: ERR No matching repository.
>>> C: fatal: remote error: No matching repository.
>> Makes sense to me.
> 
> Note that this behavior of not returning any reason for failure was 
> argued to be a security feature in the past, by Linus I think.
> 

By me actually. I wrote the patch for it. Showing "no matching repository"
means git-daemon can be used to disclose information about the remote
server's filesystem layout. While I understand that it's sometimes a useful
feature, please don't ever enable it by default.

That said, I like this patch, as it only works client-side and just enables
others to write code that let's the daemon (if configured to do so) ship a
more informative error message.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
