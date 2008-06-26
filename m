From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] cmd_reset: don't trash uncommitted changes unless told
 to
Date: Thu, 26 Jun 2008 07:31:53 +0200
Message-ID: <486329C9.8020801@op5.se>
References: <20080624222105.GA24549@dervierte> <1214346098-24584-1-git-send-email-stevenrwalter@gmail.com> <7vwskea2ik.fsf@gitster.siamese.dyndns.org> <48620C1A.6000509@panasas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Steven Walter <stevenrwalter@gmail.com>, git@vger.kernel.org,
	jeske@google.com
To: Boaz Harrosh <bharrosh@panasas.com>
X-From: git-owner@vger.kernel.org Thu Jun 26 07:32:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBk6I-0000w1-7f
	for gcvg-git-2@gmane.org; Thu, 26 Jun 2008 07:32:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752300AbYFZFb6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jun 2008 01:31:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752258AbYFZFb6
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jun 2008 01:31:58 -0400
Received: from mail.op5.se ([193.201.96.20]:56055 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751519AbYFZFb5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jun 2008 01:31:57 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id CA0011B80087;
	Thu, 26 Jun 2008 07:29:56 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jdqtYjrfiIFv; Thu, 26 Jun 2008 07:29:56 +0200 (CEST)
Received: from clix.int.op5.se (unknown [172.27.78.26])
	by mail.op5.se (Postfix) with ESMTP id C78391B80082;
	Thu, 26 Jun 2008 07:29:55 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
In-Reply-To: <48620C1A.6000509@panasas.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86395>

Boaz Harrosh wrote:
> Junio C Hamano wrote:
>> Steven Walter <stevenrwalter@gmail.com> writes:
>>
>>> @@ -225,6 +243,10 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
>>>  	if (reset_type == HARD && is_bare_repository())
>>>  		die("hard reset makes no sense in a bare repository");
>>>  
>>> +        if (reset_type == HARD && !force && index_is_dirty()) {
>>> +                die("Uncommitted changes; re-run with -f to trash them");
>>> +        }
>>> +
>> Please don't.  With your change, does the testsuite even pass?
>>
>> "reset --hard" has *ALWAYS* meant to be destructive --- discarding
>> potential local cruft is the whole point of the operation.
>>
> 
> I was under the impression that --hard means working-directory-also
> as opposed to tree-and-index-only. Nothing to do with 
> destructive-discarding. If it is then something is missing.
> I need 2 distinct functions. You combine to functions under
> one command.
> 
>> Learn the lingo, and get over it.
>>
> 
> I did lern the lingo and got bitten. I wanted to do one thing
> also got the other one.
> 
> there is:
> git-reset --clean - destructive-discarding any local changes
> git-reset --hard - move tree index and working directory to new head
> 
> How can I separate between them, Please
> 

There is a "--hard" after one of them. It reads like this:

git reset --hard  ;# move current branch to random point in history
                   # discarding working tree and index state

git reset --mixed ;# move current branch to random point in history
                   # discard the index but keep the working tree

git reset --soft  ;# move current branch to random point in history,
                   # leaving index and working tree intact

It's under OPTIONS in the man-page. --mixed is default.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
