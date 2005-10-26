From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] Avoid using dc in git-count-objects
Date: Wed, 26 Oct 2005 11:23:17 +0200
Message-ID: <435F4B05.4010702@op5.se>
References: <Pine.LNX.4.63.0510260120260.28994@wbgn013.biozentrum.uni-wuerzburg.de> <7vd5ltcf05.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Oct 26 11:23:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EUhVB-0003NX-UX
	for gcvg-git@gmane.org; Wed, 26 Oct 2005 11:23:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932605AbVJZJXS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 26 Oct 2005 05:23:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932606AbVJZJXS
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Oct 2005 05:23:18 -0400
Received: from linux-server1.op5.se ([193.201.96.2]:54148 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S932605AbVJZJXS
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Oct 2005 05:23:18 -0400
Received: from [192.168.1.19] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP id 6A6A46BD01
	for <git@vger.kernel.org>; Wed, 26 Oct 2005 11:23:17 +0200 (CEST)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
In-Reply-To: <7vd5ltcf05.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10661>

Junio C Hamano wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> 
>>Using dc is not really necessary, since expr understands summing 32 bit 
>>signed integers. Which means that git-count-objects will now fail when 2 
>>GB of unpacked objects have accumulated.
> 
> 
> Sorry, but I am not very happy about this patch.  "local"
> bashism aside, doesn't this spawn expr for every unpacked
> object?
> 

I'd be more worried about the fact that the kilobytes count is way off 
as it is. du (at least from coreutils-5.2.1) rounds up to nearest 
kilobyte *for each file* when printing kb-count.

Try these:
    du -skc .git/objects/?? | grep total
    du -skc .git/objects/??/* | grep total
    du -sbc .git/objects/?? | grep total
    du -sbc .git/objects/??/* | grep total

which will all yield different values.

I have no idea which of those values people expect to get back, so it 
might be correct right now, although I doubt it.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
