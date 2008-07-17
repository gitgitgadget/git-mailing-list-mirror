From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] t/test-lib.sh: Let test_must_fail fail on signals
 only
Date: Wed, 16 Jul 2008 23:31:41 -0700
Message-ID: <7vlk01komq.fsf@gitster.siamese.dyndns.org>
References: <1215877672-17049-1-git-send-email-s-beyer@gmx.net>
 <20080716051829.GB4030@segfault.peff.net>
 <7v4p6qwezy.fsf@gitster.siamese.dyndns.org>
 <20080717051833.GA3100@sigio.intra.peff.net>
 <7v3am9m5ne.fsf@gitster.siamese.dyndns.org>
 <20080717060143.GA3338@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stephan Beyer <s-beyer@gmx.net>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jul 17 08:32:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJN2p-0000Gl-Fi
	for gcvg-git-2@gmane.org; Thu, 17 Jul 2008 08:32:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752534AbYGQGbw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2008 02:31:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752298AbYGQGbw
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 02:31:52 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:45390 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751864AbYGQGbv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2008 02:31:51 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A9402267EE;
	Thu, 17 Jul 2008 02:31:48 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id BD8B5267EB; Thu, 17 Jul 2008 02:31:43 -0400 (EDT)
In-Reply-To: <20080717060143.GA3338@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 17 Jul 2008 02:01:43 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 08C6EBAC-53CA-11DD-97C6-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88806>

Jeff King <peff@peff.net> writes:

>> I would however agree that when we do mean 255 we should probably write
>> 255, not (-1).  It is easier to document things that way.
>
> I started to fix the callsites that Stephan mentioned, but it really is
> convenient to be able to 'return error("foo")' (or even return
> func_that_calls_error(), and tracking down deep calls is time consuming
> and error prone). So maybe we should just enhance the change from
> 2488df84 and special case "-1" into "1"?

Didn't the patch to testsuite that triggered this thread talk about "small
negative integer" not "-1"?  I suspect there might be other negative
return values from cmd_foo(), although I haven't checked.

Is it that somebody do not want 255 exit value, or anything that has 7th
bit set?  2488df8 (builtin run_command: do not exit with -1., 2007-11-13)
suggests otherwise at least for Windows runtime, so what we currently have
that does extra truncation ourselves might be sufficient.
