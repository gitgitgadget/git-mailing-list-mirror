From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: t0300-credentials: poll failed: invalid argument
Date: Mon, 29 Aug 2011 13:28:05 -0400
Message-ID: <01E9C05C-A19D-45B0-B15D-DA6B911C11A9@silverinsanity.com>
References: <5C993C44-D045-4344-95C1-94D3E6DB0316@silverinsanity.com> <20110829171411.GB756@sigill.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v1244.3)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Aug 29 19:28:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qy5dB-0001KE-Ne
	for gcvg-git-2@lo.gmane.org; Mon, 29 Aug 2011 19:28:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754496Ab1H2R2J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Aug 2011 13:28:09 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:53628 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754355Ab1H2R2I convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Aug 2011 13:28:08 -0400
Received: by silverinsanity.com (Postfix, from userid 5001)
	id ABB9B1FFC166; Mon, 29 Aug 2011 17:28:02 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.5 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [10.10.10.10] (cpe-74-65-60-43.rochester.res.rr.com [74.65.60.43])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTPSA id E36C01FFC0EE;
	Mon, 29 Aug 2011 17:28:01 +0000 (UTC)
In-Reply-To: <20110829171411.GB756@sigill.intra.peff.net>
X-Mailer: Apple Mail (2.1244.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180325>


On Aug 29, 2011, at 1:14 PM, Jeff King wrote:

> On Sun, Aug 28, 2011 at 12:40:56AM -0400, Brian Gernhardt wrote:
> 
>> The only usage of poll I see in the credentials system is:
>> 
>> credentials-cache--daemon.c
>> 177:	if (poll(&pfd, 1, 1000 * wakeup) < 0) {
>> 
>> My guess is that (1000 * wakeup) is more than INT_MAX and is becoming
>> negative as the man page for poll seems to indicate that it will fail
>> if timeout < -1.
>> 
>> Does anyone familiar with the credentials daemon want to try to figure
>> out a reasonable fix?
> 
> Ugh, sorry, this is my fault. The check_expiration() function can return
> a totally bogus value before we actually get any credentials.
> 
> Does this patch fix it for you?

Yes it does!  Surprisingly enough, non-bogus parameters keeps poll from erroring with EINVAL.  Funny that.  ;-)

Many thanks,
~~ Brian
