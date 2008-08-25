From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fix "git log -i --grep"
Date: Sun, 24 Aug 2008 23:27:24 -0700
Message-ID: <7vzln1hann.fsf@gitster.siamese.dyndns.org>
References: <g8jbvd$18k$1@ger.gmane.org>
 <20080821200255.GB27705@coredump.intra.peff.net> <48AE786C.20201@fastmail.fm>
 <20080822165047.GA3339@sigill.intra.peff.net>
 <7vzln492pc.fsf@gitster.siamese.dyndns.org>
 <20080825013837.GA17201@coredump.intra.peff.net>
 <7vmyj1isot.fsf@gitster.siamese.dyndns.org>
 <20080825061504.GA9313@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Aug 25 08:28:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXVZ6-0002JN-Bk
	for gcvg-git-2@gmane.org; Mon, 25 Aug 2008 08:28:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751573AbYHYG1a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2008 02:27:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751528AbYHYG1a
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Aug 2008 02:27:30 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:64290 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751441AbYHYG1a (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Aug 2008 02:27:30 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 0353F6EC7E;
	Mon, 25 Aug 2008 02:27:29 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 6910F6EC7D; Mon, 25 Aug 2008 02:27:26 -0400 (EDT)
In-Reply-To: <20080825061504.GA9313@coredump.intra.peff.net> (Jeff King's
 message of "Mon, 25 Aug 2008 02:15:05 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E41C3424-726E-11DD-BE5F-B29498D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93603>

Jeff King <peff@peff.net> writes:

> I worked up this patch, and it is below. However, I think it may not be
> a good idea, because...
>
>> The only issue I still have, which I suspect your fix has made it easier
>> to address, is to complain if sub-options to grep like -i and -E are given
>> without --grep.  That's not something v1.5.6 series did, though.
>
> This is trivial with my first patch, but not with the second. With
> grep_filter kept as a pointer, we know that if the pointer is non-NULL
> but there are no patterns, then the user asked for grep options but
> never --grep.

Hmm, that's true --- instead you would need to introduce a new flag in
rev_info that records if you saw any grep sub-options, if we want to check
this condition.

> I guess this might be a helpful thing for some users, but I wonder if it
> is being too unpredictable for script usage. I.e., a script like:
>
>   git log -E `for i in "$@"; do echo --author=$i`

Ok, that's true, so let's not worry about making "log -i without --grep"
an error.

> Anyway, the non-allocating patch is below. Aside from the test case, it
> deletes more lines than it adds, which is always nice.

Yeah, thanks.
