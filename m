From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [RFC PATCH] unpack-trees: add check_worktree flag to enable dry-run
 functionality
Date: Thu, 19 May 2011 20:21:52 +0200
Message-ID: <4DD55FC0.4000505@web.de>
References: <7vd3jm74gv.fsf@alter.siamese.dyndns.org> <4DD0043D.1050101@web.de> <7vfwofpvai.fsf@alter.siamese.dyndns.org> <4DD2CFD4.7060508@web.de> <7vpqnheygi.fsf@alter.siamese.dyndns.org> <4DD557AF.4030700@web.de> <7vei3u7e25.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 19 20:22:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QN7rV-0006vU-JP
	for gcvg-git-2@lo.gmane.org; Thu, 19 May 2011 20:22:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933946Ab1ESSV4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 May 2011 14:21:56 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:54886 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933927Ab1ESSVy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2011 14:21:54 -0400
Received: from smtp03.web.de  ( [172.20.0.65])
	by fmmailgate03.web.de (Postfix) with ESMTP id C273318F45717;
	Thu, 19 May 2011 20:21:52 +0200 (CEST)
Received: from [93.246.62.6] (helo=[192.168.178.43])
	by smtp03.web.de with asmtp (WEB.DE 4.110 #2)
	id 1QN7r6-0002cn-00; Thu, 19 May 2011 20:21:52 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.17) Gecko/20110414 Lightning/1.0b2 Thunderbird/3.1.10
In-Reply-To: <7vei3u7e25.fsf@alter.siamese.dyndns.org>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX190n69791mm7TVhqHE9lX2pLYC0R+NmsYjlETFb
	VMDRXGRqSbvTXpK3SAJts506P/joNEduV2bUjOIedQeGTCcZHW
	8dCZMz+o2XLX5uFeuq0A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173988>

Am 19.05.2011 20:14, schrieb Junio C Hamano:
> Jens Lehmann <Jens.Lehmann@web.de> writes:
> 
>>>> +	if (opts.update && dry_run)
>>>> +		opts.update = 0;
>>>
>>> ... this hunk must go, right?
>>
>> But this is the "don't update the work tree when -n is used together
>> with -u" part, so it is needed, no? With this patch applied first and
>> opts.check_worktree set to 1 inside that if() added there all tests
>> succeed.
> 
> I would say the natural way to do your "dry-run" would be to change the
> inner guts of unpack_trees() codepath that currently does
> 
> 	if (opts.update) {
> 		if (do something to the work tree and get non-zero on failure)
> 			die("... cannot update '%s'", path);
> 	}
> 
> with your "-n" work to
> 
> 	if (opts.update) {
>         	if (opts.dry_run) {
> 			if (would the work tree operation fail?)
> 				say("... update would fail because ... '%s'", path);
> 		} else {
> 			if (do something to the work tree and get non-zero on failure)
> 				die("... cannot update '%s'", path);
> 		}
> 	}
> 
> and that was why I thought you would want to keep the original value of
> opts.update. I wouldn't think of a good way to make the code that kicks
> in when both update and dry_run are set if you clear update that early in
> the codepath.

Ah, now I get it ... Thanks, will add a dry_run flag that keeps update
from changing anything.
