From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] add status.relativePaths config variable
Date: Sat, 08 Dec 2007 00:14:34 -0800
Message-ID: <7v1w9xy55h.fsf@gitster.siamese.dyndns.org>
References: <20071207165703.GA8889@sigill.intra.peff.net>
	<Pine.LNX.4.64.0712071853500.27959@racer.site>
	<4759996B.2000300@gmail.com>
	<20071207204937.GA20111@coredump.intra.peff.net>
	<20071207212607.GA11504@coredump.intra.peff.net>
	<7vejdxy70p.fsf@gitster.siamese.dyndns.org>
	<20071208075538.GA4812@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Thomas Harning <harningt@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Dec 08 09:15:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0uqD-0007pn-R6
	for gcvg-git-2@gmane.org; Sat, 08 Dec 2007 09:15:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755537AbXLHIO4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Dec 2007 03:14:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755498AbXLHIO4
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Dec 2007 03:14:56 -0500
Received: from a-sasl-quonix.pobox.com ([208.72.237.25]:60676 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755437AbXLHIOz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Dec 2007 03:14:55 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 653D84223;
	Sat,  8 Dec 2007 03:14:49 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id ED7394222;
	Sat,  8 Dec 2007 03:14:41 -0500 (EST)
In-Reply-To: <20071208075538.GA4812@coredump.intra.peff.net> (Jeff King's
	message of "Sat, 8 Dec 2007 02:55:38 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67525>

Jeff King <peff@peff.net> writes:

> On Fri, Dec 07, 2007 at 11:34:14PM -0800, Junio C Hamano wrote:
> ...
>> I have been wondering ever since receiving this patch if this is a good
>> interface change.  Was there a problem if instead:
>> 
>> 	- The implementation of wt_status_prepare(&s) stays as before;
>> 
>> 	- run_status(), after calling wt_status_prepare(&s), notices the
>>           configuration variable, and sets s.prefix conditionally;
>
> That would work fine. My reasoning was: the point of wt_status_prepare
> is to initialize the wt_status object.

Yes, just like diffopts and revs.  They initialize the object to a plain
vanilla defaults, and the caller uses other methods (either direct
assignments to members or by calling helper functions such as
diff_opt_parse() and setup_revisions()) to fill in specialized values.

And s.prefix is very much special case.  That's the reasoning behind my
suggestion.

> ..., which is a little silly, since as a side effect we will do a find
> on all untracked files).

Ah, that is probably the side effect of direct rewrite from shell script
to C.  We should drop that and replace with what Alex did recently to
git-commit --no-edit codepath.

> I am fine with either; your call. Documentation patch is below.

Thanks.  Will take it.
