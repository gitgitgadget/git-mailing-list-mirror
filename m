From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Confusing git pull error message
Date: Sun, 13 Sep 2009 15:11:25 -0700
Message-ID: <7veiqamr5e.fsf@alter.siamese.dyndns.org>
References: <43d8ce650909121301i4450489dhf475ff6894394a5f@mail.gmail.com>
 <20090912211119.GA30966@coredump.intra.peff.net>
 <7v1vmar353.fsf@alter.siamese.dyndns.org>
 <20090913204231.GA8654@coredump.intra.peff.net>
 <7vfxaqpnpa.fsf@alter.siamese.dyndns.org>
 <20090913213609.GA6993@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John Tapsell <johnflux@gmail.com>, Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Sep 14 00:12:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmxJ3-0002Zg-5b
	for gcvg-git-2@lo.gmane.org; Mon, 14 Sep 2009 00:12:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751429AbZIMWLd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Sep 2009 18:11:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751352AbZIMWLc
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Sep 2009 18:11:32 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:34258 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751150AbZIMWLb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Sep 2009 18:11:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 07A1931EF6;
	Sun, 13 Sep 2009 18:11:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=W53518QgJGyWAQ2GpNTBSJ8ZP48=; b=ml7XRd
	kiYeyEIstaDX+ALMfhv/uu+FVAD2gE1O6TW3MfXSk3/785YF5ZIY7A4gFq6D+ZNq
	UJuPWazDygMHt7+F8heBLT7yUYnff2wCWgevaz/ZbRz+qL7VPUFOVBLMlguTI0Ra
	tnJrUzTY9T+SjiBkTftfKnWDwWV/Pzg6Moqls=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eAHuDBwddpieHslClrf9alYKmn3NJQnJ
	ic/7R33npGS3XiNdP81amTFMJVsMO3euNiibVOQOcZ0p2CODwTrDl8NDyalcxty6
	IJtZZlg9uyLxpDdxu/qufRl9t+QF248aza2boJE1Sxn2y+8j01+YxjYO8/e5F45I
	GDHdhn+11do=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D46F831EF2;
	Sun, 13 Sep 2009 18:11:30 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 10D9D31EF0; Sun, 13 Sep
 2009 18:11:26 -0400 (EDT)
In-Reply-To: <20090913213609.GA6993@sigill.intra.peff.net> (Jeff King's
 message of "Sun\, 13 Sep 2009 17\:36\:09 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 63E705C2-A0B2-11DE-8F4F-A13518FFA523-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128422>

Jeff King <peff@peff.net> writes:

>> I think saying "does not exist" will repeat the same mistake of
>> overguessing you are trying to rectify.
>
> You are right, of course. I think your wording makes sense, then
> (otherwise we get stuck with "well, we didn't fetch it. Maybe because it
> didn't exist. Or maybe because your configuration didn't include it.").

Yeah, the saddest part of this whole story is that the message given by
the very original was succinct and accurate.

   echo >&2 "Warning: No merge candidate found because value of config option
    \"branch.${curr_branch}.merge\" does not match any remote branch fetched."
   echo >&2 "No changes."

Then we piled up different messages for various cases, and it went
downhill from there.

 - First, 8fc293c (Make git-pull complain and give advice when there is
   nothing to merge with, 2007-10-02) made the message say essentially the
   same thing, but with a lot more verbosity, covering only one _common_
   case.

 - Then 441ed41 ("git pull --tags": error out with a better message.,
   2007-12-28) added a special case for --tags.  The description before
   8fc293c would have still been correct without this change.  This was
   necessary because 8fc293c talked only about the "I am on branch and
   there is no configuration" case.

 - Then 61e6108 (git-pull.sh: better warning message for "git pull" on
   detached head., 2009-04-08) added another special case, again because
   the "helpful" instruction given by 8fc293c did not make any sense in
   the detached HEAD case.

It definitely is worth to further cover cases the message by 8fc293c did
not consider, as this thread suggested, but at the same time, I think the
advice mechanism should be used to bring back a succinct and to-the-point
message, close to the original one, e.g.

	Warning: Not merging anything, as no default merge candidate ref
	was fetched from the remote.

so that people who know what they are doing can squelch potentially
misleading "helpful" advices and diagnose/think for their own.
