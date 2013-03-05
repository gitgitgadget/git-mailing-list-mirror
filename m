From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: [PATCH/RFC] Changing submodule foreach --recursive to be
 depth-first, --parent option to execute command in supermodule as well
Date: Tue, 5 Mar 2013 08:59:02 +0100
Message-ID: <20130305075901.GB4677@sandbox-ub>
References: <CA+aSAWuoxZkSnRybhefnFr9ngs3tHmt6hAH4o0ebjYKvjJ-vpw@mail.gmail.com>
 <51351CF5.7010308@web.de>
 <7vhakqwz1e.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Eric Cousineau <eacousineau@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 05 08:59:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UCmmg-0000aW-3e
	for gcvg-git-2@plane.gmane.org; Tue, 05 Mar 2013 08:59:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751974Ab3CEH7M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Mar 2013 02:59:12 -0500
Received: from smtprelay05.ispgateway.de ([80.67.31.99]:42455 "EHLO
	smtprelay05.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751590Ab3CEH7M (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Mar 2013 02:59:12 -0500
Received: from [77.21.76.82] (helo=localhost)
	by smtprelay05.ispgateway.de with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1UCmm7-0004Dh-8Y; Tue, 05 Mar 2013 08:59:03 +0100
Content-Disposition: inline
In-Reply-To: <7vhakqwz1e.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217434>

On Mon, Mar 04, 2013 at 03:00:45PM -0800, Junio C Hamano wrote:
> So if you want a single boolean to toggle between the current
> behaviour and the other one, it would be --post-order.  But you may
> at least want to consider pros and cons of allowing users to give
> two separate commands, one for the pre-order visitation (which is
> the current "command") and the other for the post-order
> visitation. Being able to run both might turn out to be useful.

I second that. Having a --post-order=<command/script> switch will give
us much more flexibility. For ease of use we could allow --post-order
without command to switch the meaning of the main command.

So a final solution would have these switches:

git submodule foreach ... [--pre-order[=<command>]] [--post-order[=<command>]] [<command>]

If only --pre-order without argument is given the command will be
executed pre-order. If only --post-order the command will be executed
post-order. If both are given its an error and so on...

There are some combinations we would need to catch as errors but this
design should allow a step by step implementation:

	1. just the --post-order switch
	2. --post-order with argument switch
	3. --pre-order (including argument) for symmetry of usage

Cheers Heiko
