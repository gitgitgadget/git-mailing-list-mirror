From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] git-diff-* --color oddness
Date: Fri, 04 Jan 2008 01:37:46 -0800
Message-ID: <7vodc2kk2d.fsf@gitster.siamese.dyndns.org>
References: <20080104081429.GA30635@coredump.intra.peff.net>
	<7vabnmm1ww.fsf@gitster.siamese.dyndns.org>
	<20080104083252.GB3300@coredump.intra.peff.net>
	<7vsl1ekmg5.fsf@gitster.siamese.dyndns.org>
	<20080104085934.GA3706@coredump.intra.peff.net>
	<20080104092505.GA2320@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, win@wincent.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 04 10:38:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JAj0Y-0007Xn-PT
	for gcvg-git-2@gmane.org; Fri, 04 Jan 2008 10:38:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753266AbYADJh6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jan 2008 04:37:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753206AbYADJh6
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Jan 2008 04:37:58 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:52445 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752391AbYADJh5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jan 2008 04:37:57 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 34C5F4872;
	Fri,  4 Jan 2008 04:37:56 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id A10ED4871;
	Fri,  4 Jan 2008 04:37:52 -0500 (EST)
In-Reply-To: <20080104092505.GA2320@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 4 Jan 2008 04:25:05 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69573>

Jeff King <peff@peff.net> writes:

> On Fri, Jan 04, 2008 at 03:59:34AM -0500, Jeff King wrote:
>
>> OK. In that case, we need a way for the plumbing to tell the diff
>> machinery "don't ever try loading the ui config."
>
>> >  * funcname-pattern can go either way; that affects what appears
>> >    at the end of @@ context @@ lines, and would not have risk to
>> >    corrupt the patch for plumbing.
>
> I just sent a patch to put the funcname pattern in the "basic" config,
> and to get rid of the lazy config loading. So that fixes one call by the
> plumbing to read_config_if_needed.
>
> And it looks like the second call is already OK. We don't try parsing
> the config to get the external diff command unless ALLOW_EXTERNAL is
> set, which the plumbing already disallows (though I am still confused
> why it would need to be loaded lazily in the first place -- I wonder if
> read_config_if_needed is needed at all).

I think that was a premature optimization without benching.  It
is expected that most trees would not have attributes to define
custom low-level diff types, and without them we do not need to
parse the configuration to find out the external commands to be
used.
