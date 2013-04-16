From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 1/3] usage: refactor die-recursion checks
Date: Tue, 16 Apr 2013 16:13:56 +0200
Message-ID: <516D5CA4.7000500@viscovery.net>
References: <20130415230651.GA16670@sigill.intra.peff.net> <20130415230802.GA11267@sigill.intra.peff.net> <CA+sFfMes99EepY4FCW32s1L3ywv_gyFb76=Y=35rvPbc2K1BWA@mail.gmail.com> <20130416004228.GA14995@sigill.intra.peff.net> <CA+sFfMdzTNjH10FKxhvJy+7hZg+0=1Wrqy9k8KaPoJg1DuDpmg@mail.gmail.com> <20130416025024.GA20932@sigill.intra.peff.net> <516CFB56.1090805@viscovery.net> <20130416130154.GA17976@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Brandon Casey <drafnel@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 16 16:14:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1US6e8-0001yO-DR
	for gcvg-git-2@plane.gmane.org; Tue, 16 Apr 2013 16:14:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935486Ab3DPOOD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Apr 2013 10:14:03 -0400
Received: from so.liwest.at ([212.33.55.14]:36525 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935444Ab3DPOOA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Apr 2013 10:14:00 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.77)
	(envelope-from <j.sixt@viscovery.net>)
	id 1US6dx-0005Yw-59; Tue, 16 Apr 2013 16:13:57 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id DB5D21660F;
	Tue, 16 Apr 2013 16:13:56 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
In-Reply-To: <20130416130154.GA17976@sigill.intra.peff.net>
X-Enigmail-Version: 1.5.1
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221418>

Am 4/16/2013 15:01, schrieb Jeff King:
> On Tue, Apr 16, 2013 at 09:18:46AM +0200, Johannes Sixt wrote:
> 
>>> Yeah, that seems sane; my biggest worry was that it would create
>>> headaches for Windows folks, who would have to emulate pthread_key. But
>>> it seems like we already added support in 9ba604a.
>>
>> pthread_key is not a problem, but pthread_once is. It's certainly
>> solvable, but do we really have to?
> 
> I'm not clear on what you are suggesting. That we protect only the main
> thread from recursion, or that we drop the check entirely? Or that we
> implement thread-local storage for this case without using pthread_once?

Anything(*) that does not require pthread_once. A pthread_once
implementation on Windows would be tricky and voluminous and and on top of
it very likely to be done differently for gcc and MSVC. I don't like to go
there if we can avoid it.

(*) That includes doing nothing, but does not include ripping out the
recursion check, as it protects us from crashes.

-- Hannes
