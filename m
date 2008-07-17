From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] t/test-lib.sh: Let test_must_fail fail on signals
 only
Date: Thu, 17 Jul 2008 00:25:44 -0700
Message-ID: <7vabghkm4n.fsf@gitster.siamese.dyndns.org>
References: <1215877672-17049-1-git-send-email-s-beyer@gmx.net>
 <20080716051829.GB4030@segfault.peff.net>
 <7v4p6qwezy.fsf@gitster.siamese.dyndns.org>
 <20080717051833.GA3100@sigio.intra.peff.net>
 <7v3am9m5ne.fsf@gitster.siamese.dyndns.org>
 <20080717060143.GA3338@sigill.intra.peff.net>
 <7vlk01komq.fsf@gitster.siamese.dyndns.org>
 <20080717063856.GA10450@sigill.intra.peff.net>
 <487EF31D.8090007@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Stephan Beyer <s-beyer@gmx.net>,
	git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Jul 17 09:26:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJNtA-0005r2-66
	for gcvg-git-2@gmane.org; Thu, 17 Jul 2008 09:26:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751864AbYGQHZ6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2008 03:25:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751555AbYGQHZ5
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 03:25:57 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:54838 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751121AbYGQHZ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2008 03:25:57 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 1C4822F6C0;
	Thu, 17 Jul 2008 03:25:54 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 9A1322F6BF; Thu, 17 Jul 2008 03:25:46 -0400 (EDT)
In-Reply-To: <487EF31D.8090007@viscovery.net> (Johannes Sixt's message of
 "Thu, 17 Jul 2008 09:22:05 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 97349716-53D1-11DD-80D5-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88810>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Jeff King schrieb:
>> On Wed, Jul 16, 2008 at 11:31:41PM -0700, Junio C Hamano wrote:
>>> Is it that somebody do not want 255 exit value, or anything that has 7th
>>> bit set?  2488df8 (builtin run_command: do not exit with -1., 2007-11-13)
>>> suggests otherwise at least for Windows runtime, so what we currently have
>>> that does extra truncation ourselves might be sufficient.
>> 
>> Johannes will have to answer that; however, the truncation there does
>> leave the extra 7th bit. Maybe & 0x7f would be more appropriate?
>
> I never found out the real reason why -1 would not be recognized as
> "failure"; the conclusion of my debugging session was that MSYS bash has
> an issue, and I chose to append '& 0xff' because the documentation of
> WEXITSTATUS() says that it can receive only 8 bits of the exit() code. The
> intention of 2488df8 was to keep as much information as possible. But if
> that extra information hurts, we should better truncate to 7 bits.
>
> The source code of Windows's C runtime suggests that any value that fits
> in 4 bytes can be supplied to exit() and can be received by cwait()
> (Windows's version of waitpid()); but I haven't looked at how MSYS
> implements waitpit() and whether it can receive that much information.

Well, POSIX cannot do that much anyway, but does allow 8-bit, so I'd say
the current code is fine.
