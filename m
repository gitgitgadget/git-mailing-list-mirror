From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] Change "refs/" references to symbolic constants
Date: Wed, 03 Oct 2007 13:30:12 +0200
Message-ID: <47037D44.8040404@op5.se>
References: <20071002155800.GA6828@coredump.intra.peff.net> <200710021916.44388.andyparkins@gmail.com> <20071002191104.GA7901@coredump.intra.peff.net> <7vsl4tjo28.fsf@gitster.siamese.dyndns.org> <20071002204848.GA8284@coredump.intra.peff.net> <7vr6kdhwsg.fsf@gitster.siamese.dyndns.org> <20071003025853.GA11440@coredump.intra.peff.net> <Pine.LNX.4.64.0710030503520.28395@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Oct 03 13:40:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Id2aY-00078V-V9
	for gcvg-git-2@gmane.org; Wed, 03 Oct 2007 13:40:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755531AbXJCLkV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2007 07:40:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755523AbXJCLkU
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Oct 2007 07:40:20 -0400
Received: from mail.op5.se ([193.201.96.20]:33997 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755492AbXJCLkR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2007 07:40:17 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 054531946BB;
	Wed,  3 Oct 2007 13:40:15 +0200 (CEST)
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ursdO7aSwCP1; Wed,  3 Oct 2007 13:40:14 +0200 (CEST)
Received: from nox.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id C9B031946BA;
	Wed,  3 Oct 2007 13:40:13 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <Pine.LNX.4.64.0710030503520.28395@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59826>

Johannes Schindelin wrote:
> Hi,
> 
> On Tue, 2 Oct 2007, Jeff King wrote:
> 
>> On Tue, Oct 02, 2007 at 05:22:23PM -0700, Junio C Hamano wrote:
>>
>>>>   strbuf_init(&url);
>>>>   strbuf_addf(&url, "%s/objects/pack/pack-%s.idx", repo->base, hex);
>>> Ugh, this typically calls snprintf() twice doesn't it?
>> Yes, it probably does. However, I think it is considerably easier to
>> read and more maintainable. Are you "ugh"ing because of the performance
>> impact (which should be negligible unless this is in a tight loop) or
>> because of the portability problems associated with va_copy?
> 
> I wonder, I wonder, if
> 
> 	strbuf_addstr(&url, repo->base);
> 	strbuf_addstr(&url, "/objects/pack/pack-");
> 	strbuf_addstr(&url, hex);
> 	strbuf_addstr(&url, ".idx");
> 
> would make anybody else but me happy...

strbuf_addstr_many(&url, repo->base, "/objects/pack/pack-", hex, ".idx", NULL);

is what I'd prefer. It's not overly complicated, requires no *printf(), and doesn't
introduce any new portability issues (va_arg() is C89).

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
