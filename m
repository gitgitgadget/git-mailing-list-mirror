From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 1/2] t/test-lib.sh: Let test_must_fail fail on signals
 only
Date: Thu, 17 Jul 2008 09:22:05 +0200
Message-ID: <487EF31D.8090007@viscovery.net>
References: <1215877672-17049-1-git-send-email-s-beyer@gmx.net> <20080716051829.GB4030@segfault.peff.net> <7v4p6qwezy.fsf@gitster.siamese.dyndns.org> <20080717051833.GA3100@sigio.intra.peff.net> <7v3am9m5ne.fsf@gitster.siamese.dyndns.org> <20080717060143.GA3338@sigill.intra.peff.net> <7vlk01komq.fsf@gitster.siamese.dyndns.org> <20080717063856.GA10450@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Stephan Beyer <s-beyer@gmx.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jul 17 09:23:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJNpW-0004rp-0e
	for gcvg-git-2@gmane.org; Thu, 17 Jul 2008 09:23:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752788AbYGQHWK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2008 03:22:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752722AbYGQHWK
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 03:22:10 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:60605 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751060AbYGQHWJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2008 03:22:09 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1KJNoU-0007d5-4S; Thu, 17 Jul 2008 09:22:06 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id AAF446B7; Thu, 17 Jul 2008 09:22:05 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <20080717063856.GA10450@sigill.intra.peff.net>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88809>

Jeff King schrieb:
> On Wed, Jul 16, 2008 at 11:31:41PM -0700, Junio C Hamano wrote:
>> Is it that somebody do not want 255 exit value, or anything that has 7th
>> bit set?  2488df8 (builtin run_command: do not exit with -1., 2007-11-13)
>> suggests otherwise at least for Windows runtime, so what we currently have
>> that does extra truncation ourselves might be sufficient.
> 
> Johannes will have to answer that; however, the truncation there does
> leave the extra 7th bit. Maybe & 0x7f would be more appropriate?

I never found out the real reason why -1 would not be recognized as
"failure"; the conclusion of my debugging session was that MSYS bash has
an issue, and I chose to append '& 0xff' because the documentation of
WEXITSTATUS() says that it can receive only 8 bits of the exit() code. The
intention of 2488df8 was to keep as much information as possible. But if
that extra information hurts, we should better truncate to 7 bits.

The source code of Windows's C runtime suggests that any value that fits
in 4 bytes can be supplied to exit() and can be received by cwait()
(Windows's version of waitpid()); but I haven't looked at how MSYS
implements waitpit() and whether it can receive that much information.

-- Hannes
