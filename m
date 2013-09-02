From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] revision: add --except option
Date: Mon, 02 Sep 2013 08:25:37 +0200
Message-ID: <52242F61.3090404@viscovery.net>
References: <1377838805-7693-1-git-send-email-felipe.contreras@gmail.com> <7vhae7k7t1.fsf@alter.siamese.dyndns.org> <5220503F.2080608@viscovery.net> <CAMP44s0D98tggTjQsMn+-03KgSsbrh3nxYfLofpC1gfnJpEPyw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	=?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 02 08:25:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGNa8-0000e3-Eb
	for gcvg-git-2@plane.gmane.org; Mon, 02 Sep 2013 08:25:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754914Ab3IBGZo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Sep 2013 02:25:44 -0400
Received: from so.liwest.at ([212.33.55.13]:36623 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753713Ab3IBGZo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Sep 2013 02:25:44 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.80.1)
	(envelope-from <j.sixt@viscovery.net>)
	id 1VGNZx-00053S-IZ; Mon, 02 Sep 2013 08:25:38 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 335271660F;
	Mon,  2 Sep 2013 08:25:37 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130801 Thunderbird/17.0.8
In-Reply-To: <CAMP44s0D98tggTjQsMn+-03KgSsbrh3nxYfLofpC1gfnJpEPyw@mail.gmail.com>
X-Enigmail-Version: 1.5.2
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233608>

Am 8/31/2013 21:27, schrieb Felipe Contreras:
> On Fri, Aug 30, 2013 at 2:56 AM, Johannes Sixt <j.sixt@viscovery.net> wrote:
>> Am 8/30/2013 8:32, schrieb Junio C Hamano:
>>> If you have a history where
>>>
>>>  - branches "master" and "maint" point at commit A;
>>>  - branch "next" points at commit B that is a descendant of A; and
>>>  - there are tags X and Y pointing at commits that are ahead of B
>>>    or behind A
>>>
>>> i.e.
>>>
>>>       ----X----A----B----Y
>>>
>>> what are the desired semantics for these?
>>
>> I think the simplest were that --except trumps everything and means
>> "whatever else I say, do as if I did not mention the following".
> 
> Actually, my patch is almost there, I attach the necessary changed
> below to make everything work. I've added debug prints to show what
> it's actually doing:
> 
>>>  (1) --branches --except maint
>>
>> => master next
> 
> => master next
> 
>>>  (2) --all --not --branches --except maint
>>
>> => X Y --not master next
> 
> => ^master ^next X Y HEAD
> 
>>>  (3) ^master next --except maint
>>
>> => ^master next
> 
> => ^master next
> 
>> (4) Y next --except master next --not --branches
>>
>> this => Y --not maint
>> or this => Y --not maint master next
> 
> => Y
> 
> Remember that maint (or rather ^maint) is after --except.

Sure, but why is it not in the result? maint is not even mentioned under
--except. Confused...

Ah, are you treating the union of master, next, and --branches as --except
and ignore --not?

-- Hannes
