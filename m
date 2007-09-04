From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] Rework strbuf API and semantics.
Date: Tue, 04 Sep 2007 15:34:44 +0200
Message-ID: <46DD5EF4.3090309@op5.se>
References: <buobqcjrycl.fsf@dhapc248.dev.necel.com> <11888956802504-git-send-email-madcoder@debian.org> <Pine.LNX.4.64.0709041209280.28586@racer.site> <20070904115317.GA3381@artemis.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 04 15:34:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISYYP-0007aN-KQ
	for gcvg-git@gmane.org; Tue, 04 Sep 2007 15:34:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753222AbXIDNet (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Sep 2007 09:34:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752901AbXIDNet
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Sep 2007 09:34:49 -0400
Received: from mail.op5.se ([193.201.96.20]:33764 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752776AbXIDNes (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2007 09:34:48 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id E1578194459;
	Tue,  4 Sep 2007 15:34:46 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id POiN9eEPPAZC; Tue,  4 Sep 2007 15:34:46 +0200 (CEST)
Received: from nox.op5.se (unknown [192.168.1.178])
	by mail.op5.se (Postfix) with ESMTP id 128BB194454;
	Tue,  4 Sep 2007 15:34:46 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
In-Reply-To: <20070904115317.GA3381@artemis.corp>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57565>

Pierre Habouzit wrote:
> On Tue, Sep 04, 2007 at 11:11:45AM +0000, Johannes Schindelin wrote:
>> Hi,
>>
>> On Tue, 4 Sep 2007, Pierre Habouzit wrote:
>>
>> - IMHO the same goes for strbuf_free() instead of strbuf_wipe(), and
> 
>   Well, I don't like strbuf_free, because it's opposed to
> strbuf_alloc/new whatever, that would be functions that create and
> release a struct strbuf * (meaning allocating the struct shell as well).
> Here you only free the internal buffer, not the shell, so _free() would
> be a very bad name.
> 
>   In my own coding rules, I have _new/_delete and _init/_wipe functions,
> the former acts on pointers, the latter on the structs. Hence the
> naming. Though, looking at git's code, it seems that the usual name for
> this operation is _release. So would you go for strbuf_release ?
> 

release is indeed better. To me, "wipe" means zeroing out (possibly after
an optional number of passes writing trash to the memory area) rather than
actually freeing any memory.

> 
>> - it would be nice to split this patch into
>>
>> 	- the API change (with _minimal_ changes to anything outside of 
>> 	  strbuf.[ch]), and
>>
>> 	- the cleanups in the rest of the code.
> 
>   I'll try to do that, but it's quite hard to achieve knowing that in
> many places of the current state of master, there are embeded NUL's
> (accounted in ->len). I'll try to see what I can split, but it's
> unlikely I'll be able to have an intermediate _working_ state (I mean
> that would pass the testsuite) with the new API/semantics _and_ without
> touching a lot less of the rest of the code.
> 

Always having a compilable/operational tree is pretty nice primarily due
to bisect. If the code turns from working to non-working in between,
make sure to jot it down in the commit message.

It might even be better to add the embedded NUL handling code in the
first patch, modify the callers in the second, and remove the embedded
NUL handling in a third.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
