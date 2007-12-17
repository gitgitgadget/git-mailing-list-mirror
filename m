From: Andreas Ericsson <ae@op5.se>
Subject: Re: [RFH] convert shortlog to use parse_options
Date: Mon, 17 Dec 2007 10:38:40 +0100
Message-ID: <476643A0.6020700@op5.se>
References: <20071213091055.GA5674@coredump.intra.peff.net>	<20071213093536.GC12398@artemis.madism.org>	<7vbq8u4ho8.fsf@gitster.siamese.dyndns.org>	<20071213180347.GE1224@artemis.madism.org>	<1197570521.28742.0.camel@hinata.boston.redhat.com>	<1197571656.28742.13.camel@hinata.boston.redhat.com>	<20071214040803.GA10169@sigill.intra.peff.net>	<7vir31vmsn.fsf@gitster.siamese.dyndns.org>	<20071214083943.GA24475@artemis.madism.org>	<7v63z1qakt.fsf@gitster.siamese.dyndns.org>	<20071215110311.GA11321@artemis.madism.org>	<7vir2xeq76.fsf@gitster.siamese.dyndns.org> <47662715.9070200@op5.se> <7v3au1eopr.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Pierre Habouzit <madcoder@debian.org>, Jeff King <peff@peff.net>,
	=?ISO-8859-15?Q?Kristian_H=F8gsberg?= <krh@redhat.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 17 10:39:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4CRM-0005tB-Qw
	for gcvg-git-2@gmane.org; Mon, 17 Dec 2007 10:39:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762879AbXLQJir (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2007 04:38:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762619AbXLQJir
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 04:38:47 -0500
Received: from mail.op5.se ([193.201.96.20]:49353 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755809AbXLQJiq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2007 04:38:46 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 27A051F0803F;
	Mon, 17 Dec 2007 10:38:45 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XNKro95Qmb0X; Mon, 17 Dec 2007 10:38:44 +0100 (CET)
Received: from nox.op5.se (unknown [172.27.78.26])
	by mail.op5.se (Postfix) with ESMTP id AF4871F08038;
	Mon, 17 Dec 2007 10:38:43 +0100 (CET)
User-Agent: Thunderbird 2.0.0.9 (X11/20071115)
In-Reply-To: <7v3au1eopr.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68529>

Junio C Hamano wrote:
> Andreas Ericsson <ae@op5.se> writes:
> 
>> Junio C Hamano wrote:
>>
>>> ...  The
>>> "must stick" restriction feels Ok on paper but in practice it looks
>>> rather draconian and very user unfriendly.
>> Usually, optional arguments warrant adding a second parameter. This can
>> often even improve usability, as it's never unclear or ambiguous what's
>> happening. For the 'git tag -l' case, I'd use something like
>> 'git tag -l --match="regex"' or some such,...
> 
> That is essentially arguing for POSIXly correct "do not allow optional
> option-arguments" (utility syntax guidelines #7).  That position might
> be politically correct, but I am already discussing beyond that:
> usability.
> 
> For "git tag -l", the fix was rather simple, as the option would either
> have taken a zero pattern (list all) or a single pattern (list matching
> this pattern), and the command itself did not take any extra arguments,
> so that was what I did in the patch.  Compare your POSIXly correct
> version:
> 
>         git tag -l			(ok)
>         git tag -l pattern		(not ok)
> 	git tag -l --match=pattern	(ok)
> 
> with the traditional (and fixed):
> 
>         git tag -l			(ok)
>         git tag -l pattern		(ok)
> 	git tag -l pattern garbage	(not ok)
> 
> Which one is easier for the user?


git tag -l pattern, although I suspect newcomers often write it as
"git tag -l | grep pattern" anyways.

If -l was a short-hand for "git tag list", and "list" was a subcommand
to git tag, the whole business would be explainable. The fact that
"git tag" lists all tag but doesn't take a patter, while "git tag -l"
does exactly the same thing, but *does* take an (optional) pattern
means the --match functionality could just as well be written as
"git tag -m pattern" (and let '-m' imply '-l', which is sensible).
"-l" can then be deprecated, as its syntax doesn't match that of
the other way to list tags.

Otoh, I don't care all that deeply about it. It's just nicer to explain
the UI if there are no optional arguments, primarily because it involves
exceptions, and secondarily because many programs follow the posixly
correct thing of "no optional arguments", so they're a definitive
minority in the program argument jungle.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
