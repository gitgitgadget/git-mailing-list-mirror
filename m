From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 2/2] spawn pager via run_command interface
Date: Tue, 22 Jul 2008 09:48:09 +0200
Message-ID: <488590B9.1080804@viscovery.net>
References: <7vy73ur6pz.fsf@gitster.siamese.dyndns.org> <7vtzeir68z.fsf@gitster.siamese.dyndns.org> <20080722044157.GA20787@sigill.intra.peff.net> <20080722053921.GA4983@glandium.org> <20080722060643.GA25023@sigill.intra.peff.net> <20080722061807.GA6714@glandium.org> <20080722064603.GA25221@sigill.intra.peff.net> <20080722071009.GA3610@sigill.intra.peff.net> <20080722071246.GA3584@sigill.intra.peff.net> <20080722071411.GB3584@sigill.intra.peff.net> <20080722071630.GA3669@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Mike Hommey <mh@glandium.org>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org, David Bremner <bremner@unb.ca>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jul 22 09:49:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLCcU-0005pi-BZ
	for gcvg-git-2@gmane.org; Tue, 22 Jul 2008 09:49:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751998AbYGVHsM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2008 03:48:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752010AbYGVHsM
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 03:48:12 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:22466 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752039AbYGVHsL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2008 03:48:11 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1KLCbR-0003fH-DV; Tue, 22 Jul 2008 09:48:09 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 2500C6D9; Tue, 22 Jul 2008 09:48:09 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <20080722071630.GA3669@sigill.intra.peff.net>
X-Spam-Score: 1.2 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_95=3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89464>

Jeff King schrieb:
> On Tue, Jul 22, 2008 at 03:14:12AM -0400, Jeff King wrote:
> 
>>  static struct child_process pager_process = {
>>  	.argv = pager_argv,
>> -	.in = -1
>> +	.in = -1,
>> +#ifndef __MINGW32__
>> +	.preexec_cb = pager_preexec,
>> +#endif
> 
> I couldn't recall if this initializer style is portable enough for us.
> It was already there wrapped in ifdefs, but perhaps it was only ok
> because the mingw version always uses the same compiler?

Yes, that's because on mingw we know that we use gcc. This really must be
changed for portability.

BTW, you could remove the #ifndef __MINGW32__ around both the definition
and the use of pager_preexec. We have everything on mingw to compile and
link this function.

-- Hannes
