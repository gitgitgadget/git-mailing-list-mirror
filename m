From: Andreas Ericsson <ae@op5.se>
Subject: Re: diffcore-rename performance mode
Date: Tue, 25 Sep 2007 21:10:06 +0200
Message-ID: <46F95D0E.5090000@op5.se>
References: <20070918082321.GA9883@coredump.intra.peff.net> <7vsl5cwe6p.fsf@gitster.siamese.dyndns.org> <20070918085413.GA11751@coredump.intra.peff.net> <20070925163843.GA22987@coredump.intra.peff.net> <20070925190640.GA4613@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Sep 25 21:10:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IaFnc-0004im-Nh
	for gcvg-git-2@gmane.org; Tue, 25 Sep 2007 21:10:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753236AbXIYTKP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Sep 2007 15:10:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753024AbXIYTKP
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Sep 2007 15:10:15 -0400
Received: from mail.op5.se ([193.201.96.20]:44254 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752584AbXIYTKN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Sep 2007 15:10:13 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 3A266194485;
	Tue, 25 Sep 2007 21:10:08 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MQHaefeKV19q; Tue, 25 Sep 2007 21:10:07 +0200 (CEST)
Received: from nox.op5.se (unknown [172.27.77.30])
	by mail.op5.se (Postfix) with ESMTP id 8CC851943F7;
	Tue, 25 Sep 2007 21:10:07 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <20070925190640.GA4613@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59153>

Jeff King wrote:
> On Tue, Sep 25, 2007 at 12:38:43PM -0400, Jeff King wrote:
> 
>> [...]
>>
>> What is most confusing is why the 'somefree' case performs so badly,
>> since we should just be using the cnt_data. I'll see if gprof can shed
> 
> OK, I found the problem. estimate_similarity calls
> diff_populate_filespec each time, even if we already have the cnt_data,
> which leads to recomputing the blob contents from deltas. Oops.
> 
> Fixing this, the correct numbers are:
> 
>                  | stock | nofree | old somefree | fixed somefree
> -----------------|-----------------------------------------------
> user time (s)    | 76.78 | 16.96  | 46.26        | 16.99
> peak memory (Kb) | 52300 | 66796  | 59156        | 57328
> 
> So now we're at a 4.5x speedup for about 10% extra memory usage. Patch
> will follow.
> 

Nice work :)

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
