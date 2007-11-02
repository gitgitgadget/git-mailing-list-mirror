From: Andreas Ericsson <ae@op5.se>
Subject: Re: Newbie: report of first experience with git-rebase.
Date: Fri, 02 Nov 2007 11:13:20 +0100
Message-ID: <472AF840.1070609@op5.se>
References: <87d4uv3wh1.fsf@osv.gnss.ru>	<20071031195702.GB24332@atjola.homenet> <874pg73u6h.fsf@osv.gnss.ru>	<Pine.LNX.4.64.0710312111170.4362@racer.site>	<7vhck7gdzs.fsf@gitster.siamese.dyndns.org>	<87ve8m2mfn.fsf@osv.gnss.ru>	<Pine.LNX.4.64.0711011423440.4362@racer.site>	<20071101151016.GA26103@fieldses.org> <7v8x5hbtvv.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "J. Bruce Fields" <bfields@fieldses.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sergei Organov <osv@javad.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 02 11:13:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IntX5-0003IQ-O6
	for gcvg-git-2@gmane.org; Fri, 02 Nov 2007 11:13:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752917AbXKBKN1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2007 06:13:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752905AbXKBKN1
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Nov 2007 06:13:27 -0400
Received: from mail.op5.se ([193.201.96.20]:38486 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752894AbXKBKN0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2007 06:13:26 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id B61EF173071C;
	Fri,  2 Nov 2007 11:12:53 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lUuQKqGT9T38; Fri,  2 Nov 2007 11:12:52 +0100 (CET)
Received: from nox.op5.se (unknown [172.27.77.30])
	by mail.op5.se (Postfix) with ESMTP id 868E317306F2;
	Fri,  2 Nov 2007 11:12:51 +0100 (CET)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <7v8x5hbtvv.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63094>

Junio C Hamano wrote:
> "J. Bruce Fields" <bfields@fieldses.org> writes:
> 
>> On Thu, Nov 01, 2007 at 02:24:37PM +0000, Johannes Schindelin wrote:
>>> They are rare events.  In your case I guess that subtly different versions 
>>> were _actually_ applied (such as white space fixes),
>> That's actually pretty common, in my experience.
>>
>>> which is why such a rare event hit you.
>> I'm using git to track some changes I submitted to a project that's
>> mainly text, and that I only get release tarballs of.  On my most recent
>> rebase all my patches got applied, but the text also got re-wrapped and
>> re-indented at the same time.  So all but I think one or two of a dozen
>> patches ended up with a conflict resolution and then --skip.
>>
>> Which may not be a case git's really intended for--fair enough.  But
>> I've found it's pretty common in my kernel work too.  Either I'm
>> rebasing against changes I made myself, or else a maintainer took my
>> changes but fixed up some minor style problems along the way.
> 
> Ok, so I retract that "rare" comment.
> 
> Now, we have established that this is a real problem worth
> solving, what's next?

Make "git rebase --skip" skip patches regardless of tree and index state,
but still refuse to *start* with dirty tree or index. That way, there's
no risk of losing anything that can't be re-created unless the user asks
for it.

To be really anal, stash the current mess somewhere, re-apply the same
patch and diff the two states. If they're identical, do "git reset --hard"
and hop to next patch in rebase-series. If they're not, ask user to say
"--force-skip" instead.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
