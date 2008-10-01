From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] Builtin-commit: show on which branch a commit was added
Date: Wed, 01 Oct 2008 10:13:34 +0200
Message-ID: <48E3312E.4090601@op5.se>
References: <4C04A26E-5829-4A39-AD89-F5A68E606AA3@ai.rug.nl> <1220634785-55543-1-git-send-email-pdebie@ai.rug.nl> <7vzlmkpltb.fsf@gitster.siamese.dyndns.org> <20080921104238.GA9217@sigill.intra.peff.net> <A36A4B61-D223-4821-9969-FA76EAECD1EC@ai.rug.nl> <20080929224430.GA11545@sigill.intra.peff.net> <48E1C39F.4070906@op5.se> <836C204F-F5AF-4887-99C9-04E70FEEB998@wincent.com> <20080930070938.GA14757@sigill.intra.peff.net> <48E1F87D.2010906@op5.se> <20081001031400.GA24513@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Wincent Colaiuta <win@wincent.com>,
	Pieter de Bie <pdebie@ai.rug.nl>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailinglist <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Oct 01 10:15:01 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KkwrN-00081S-5F
	for gcvg-git-2@gmane.org; Wed, 01 Oct 2008 10:15:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751643AbYJAINq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2008 04:13:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751873AbYJAINp
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Oct 2008 04:13:45 -0400
Received: from mail.op5.se ([193.201.96.20]:59812 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751640AbYJAINo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Oct 2008 04:13:44 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 4FD911B8005F;
	Wed,  1 Oct 2008 10:05:05 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -3.607
X-Spam-Level: 
X-Spam-Status: No, score=-3.607 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, AWL=0.792, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wfbdvmGR01AF; Wed,  1 Oct 2008 10:05:01 +0200 (CEST)
Received: from clix.int.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id 9DC691B8004F;
	Wed,  1 Oct 2008 10:04:59 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <20081001031400.GA24513@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97211>

Jeff King wrote:
> On Tue, Sep 30, 2008 at 11:59:25AM +0200, Andreas Ericsson wrote:
> 
>> I agree. Obvious solution is to do
>>
>> subj_len = term_width - (strlen(cruft) + strlen(branch_name))
> 
> I think the difficulty is that the printing is sometimes done by our
> printf and sometimes by log_tree_commit, and there isn't a convenient
> way to hook into log_tree_commit to postprocess the formatted output.
> 
>> where strlen(cruft) is just 8 less if we drop 'commit ' from the
>> cases. See the patch I just sent though. I sort of like that one.
> 
> I like it much better than what is on next (and I thought your commit
> message summed up the issue nicely), but...
> 

Thanks. Feel free to recycle it :)

>> Another way would be to write
>> <branch>: Created <hash>: "subject line..."
> 
> I think I like this even better.

Me too, but I thought it up after I sent out the first patch. The nicest
part is that the info that's always present will always end up in the
same place, while my patch moves the branch-name around depending on
the length of the subject line.

Let's agree here and now that the subject should be last and that "commit "
should be dropped, at least for the normal cases.

> My only concern is that many programs
> say "program: some error", so you could potentially have a confusing
> branch name. But I personally have never used a branch name that would
> cause such confusion.
> 

A valid concern, certainly. We needn't use colons for the branch-name
though, but could instead use some other delimiter, like this:
[<branch>] Created <hash>: "subject line..."
although I do believe we're close to nitpicking this issue to death
now. It's not *that* important after all.

>> As <hash> will very, very rarely match anything the user would put
>> in his/her commit message themselves. Quoting the subject is probably
>> a nice touch, and it can make sense to put it last as it's the least
>> interesting of the things we print. Ah well. I'll just await commentary
>> on the patch I've already sent before I go ahead and do something like
>> that.
> 
> Here is a patch for that format on top of next (the patch between this
> and what is in master is even more simple, since we are mostly removing
> Pieter's helper function).
> 

I don't quite like the fact that you're removing the "detached" thingie.
I have coworkers that have been bitten by committing on detached head,
so I'd like to have some mention of it. I'll rework it to take that
into account. Otherwise, this looks good. Less code is always a good
thing, imo.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
