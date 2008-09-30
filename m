From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] Builtin-commit: show on which branch a commit was added
Date: Tue, 30 Sep 2008 11:59:25 +0200
Message-ID: <48E1F87D.2010906@op5.se>
References: <4C04A26E-5829-4A39-AD89-F5A68E606AA3@ai.rug.nl> <1220634785-55543-1-git-send-email-pdebie@ai.rug.nl> <7vzlmkpltb.fsf@gitster.siamese.dyndns.org> <20080921104238.GA9217@sigill.intra.peff.net> <A36A4B61-D223-4821-9969-FA76EAECD1EC@ai.rug.nl> <20080929224430.GA11545@sigill.intra.peff.net> <48E1C39F.4070906@op5.se> <836C204F-F5AF-4887-99C9-04E70FEEB998@wincent.com> <20080930070938.GA14757@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Wincent Colaiuta <win@wincent.com>,
	Pieter de Bie <pdebie@ai.rug.nl>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailinglist <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Sep 30 12:00:48 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kkc25-0005Xx-39
	for gcvg-git-2@gmane.org; Tue, 30 Sep 2008 12:00:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752438AbYI3J7d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Sep 2008 05:59:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752444AbYI3J7c
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Sep 2008 05:59:32 -0400
Received: from mail.op5.se ([193.201.96.20]:51957 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752420AbYI3J7b (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Sep 2008 05:59:31 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 760291B80048;
	Tue, 30 Sep 2008 11:50:46 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[AWL=0.000, BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lgkG3WK84dbj; Tue, 30 Sep 2008 11:50:44 +0200 (CEST)
Received: from clix.int.op5.se (unknown [172.27.78.22])
	by mail.op5.se (Postfix) with ESMTP id 1126D24B0004;
	Tue, 30 Sep 2008 11:50:43 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <20080930070938.GA14757@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97087>

Jeff King wrote:
> On Tue, Sep 30, 2008 at 08:37:00AM +0200, Wincent Colaiuta wrote:
> 
>> As far as long-line-wrapping goes, I don't really think this is a problem 
>> for Git to solve (by truncation or any other means); it's more of a user 
>> behaviour thing where one would hope that users would get into the habit 
>> of using concise subject lines and branch names.
> 
> How concise must we be? I wrap my commit messages at 60 characters,
> which I consider quite conservative. But
> 
>   Created commit abcd1234 on jk/my-topic-branch:
> 
> takes up over half of an 80-column terminal. Is that a long branch name?
> Browsing "git log --grep=Merge.branch --pretty=format:%s origin/next"
> suggests it's not terribly out of line (at least by Junio's standards).
> 
> Dropping "commit " will help some. But given how much width is still
> used, and the fact that this message is really just to say "yes, I
> confirm that we just created the commit you asked for", I think
> truncating (with dots) to keep it within 80 characters is reasonable.
> 

I agree. Obvious solution is to do

subj_len = term_width - (strlen(cruft) + strlen(branch_name))

where strlen(cruft) is just 8 less if we drop 'commit ' from the
cases. See the patch I just sent though. I sort of like that one.

Another way would be to write
<branch>: Created <hash>: "subject line..."

As <hash> will very, very rarely match anything the user would put
in his/her commit message themselves. Quoting the subject is probably
a nice touch, and it can make sense to put it last as it's the least
interesting of the things we print. Ah well. I'll just await commentary
on the patch I've already sent before I go ahead and do something like
that.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
