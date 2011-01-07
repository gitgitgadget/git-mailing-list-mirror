From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: concurrent fetches to update same mirror
Date: Fri, 07 Jan 2011 09:50:28 -0500
Message-ID: <4D272834.9060001@xiplink.com>
References: <ig2kjt$f2u$1@dough.gmane.org> <20110105204738.GA7629@sigill.intra.peff.net> <AANLkTini61q+NtDr6oytTcfA6QNGN74L60exdLrNmakd@mail.gmail.com> <20110105205324.GA7808@sigill.intra.peff.net> <20110105211313.GB7808@sigill.intra.peff.net> <7vbp3vc4k4.fsf@alter.siamese.dyndns.org> <20110106234512.GA17231@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Shawn Pearce <spearce@spearce.org>,
	Neal Kreitzinger <neal@rsss.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 07 15:50:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PbDeX-00082q-Ai
	for gcvg-git-2@lo.gmane.org; Fri, 07 Jan 2011 15:50:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753826Ab1AGOup (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jan 2011 09:50:45 -0500
Received: from smtp162.iad.emailsrvr.com ([207.97.245.162]:56385 "EHLO
	smtp162.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753811Ab1AGOuo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jan 2011 09:50:44 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp46.relay.iad1a.emailsrvr.com (SMTP Server) with ESMTP id D7DF9E8B51;
	Fri,  7 Jan 2011 09:50:43 -0500 (EST)
X-Virus-Scanned: OK
Received: by smtp46.relay.iad1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 6D666E8AD3;
	Fri,  7 Jan 2011 09:50:41 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101208 Thunderbird/3.1.7
In-Reply-To: <20110106234512.GA17231@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164715>

On 11-01-06 06:45 PM, Jeff King wrote:
> On Wed, Jan 05, 2011 at 03:29:47PM -0800, Junio C Hamano wrote:
> 
>> Jeff King <peff@peff.net> writes:
>>
>>> Interestingly, in the case of ref _creation_, not update, like this:
>>>
>>>   mkdir repo && cd repo && git init
>>>   git remote add origin some-remote-repo-that-takes-a-few-seconds
>>>   xterm -e 'git fetch -v; read' & xterm -e 'git fetch -v; read'
>>>
>>> then both will happily update, the second one overwriting the results of
>>> the first. It seems in the case of locking a ref which previously didn't
>>> exist, we don't enforce that it still doesn't exist.
>>
>> We probably should, especially when there is no --force or +prefix is
>> involved.
> 
> Hmph. So I created the test below to try to exercise this, expecting to
> see at least one failure: according to the above example, we aren't
> actually checking "null sha1 means ref must not exist", so we should get
> an erroneous success for that case. And there is the added complication
> that the null sha1 may also mean "don't care what the old one was". So
> even if I changed the code, we would get erroneous failures the other
> way.
> 
> But much to my surprise, it actually passes with stock git. Which means
> I need to dig a little further to see exactly what is going on.

I should point out that the repository where I saw this issue is running git
1.7.1.

		M.
