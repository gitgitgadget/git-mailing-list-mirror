From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Apr 2013, #05; Mon, 15)
Date: Thu, 18 Apr 2013 15:10:29 -0700
Message-ID: <7vobdb4hii.fsf@alter.siamese.dyndns.org>
References: <7vk3o1f5kb.fsf@alter.siamese.dyndns.org>
	<7vwqs1dnxp.fsf@alter.siamese.dyndns.org>
	<20130417201056.GA2914@sigill.intra.peff.net>
	<7va9owd3d1.fsf@alter.siamese.dyndns.org>
	<20130418172714.GA24690@sigill.intra.peff.net>
	<7vd2tr6833.fsf@alter.siamese.dyndns.org>
	<20130418180017.GA5714@sigill.intra.peff.net>
	<7v61zj66wu.fsf@alter.siamese.dyndns.org>
	<20130418203035.GB24690@sigill.intra.peff.net>
	<7vvc7j4j0u.fsf@alter.siamese.dyndns.org>
	<20130418214427.GA10119@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 19 00:10:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USx2L-0005Nm-0y
	for gcvg-git-2@plane.gmane.org; Fri, 19 Apr 2013 00:10:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936488Ab3DRWKd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Apr 2013 18:10:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46573 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936231Ab3DRWKc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Apr 2013 18:10:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A901E17E1F;
	Thu, 18 Apr 2013 22:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4GmOaKGHIYs+cmWhW4LNXvgJeMw=; b=kt24oL
	w3HCcZ3Zvg8FSJkWECn07VHMkxF9I8/uyvpTQ8qGyodrjnlYLKMgm5bGYJYBr/Zv
	+alPmQyEQk8nCFDTxfnjVXpEHieOXuCNvNACMpF1f/zS7rsK8ILKgYG8g32HelhR
	ER3BibbP7O2AkycvJAwYyNV5HHNYSqbj6BHTw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cCls9lwirwGshWhF/LwBZtKnmffC3T6k
	9C/b509POLiQeQqJUNmDBPuIVkp9TOg9++JEgznYzLM3mPrYlIbHSnmRIYzfbUwe
	JxoPYjFXFzfNDCRlhvXStACZZ9NF4Lzy+ODfIAWI6i/5jf95awW6uGrnjMWqRdqg
	bKQVASDS46s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A0E4217E1E;
	Thu, 18 Apr 2013 22:10:31 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 158A517E19;
	Thu, 18 Apr 2013 22:10:30 +0000 (UTC)
In-Reply-To: <20130418214427.GA10119@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 18 Apr 2013 17:44:27 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C8AC7E74-A874-11E2-B6EC-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221697>

Jeff King <peff@peff.net> writes:

> I am expecting a reaction more like "Hmm, I never thought about it
> before. Does that make sense to me or not? Let me think about which
> paths it pertains to and decide".

Let's step back and re-review the main text.

It currently says:

    In Git 2.0, 'git add <pathspec>...' will also update the
    index for paths removed from the working tree that match
    the given pathspec. If you want to 'add' only changed
    or newly created paths, say 'git add --no-all <pathspec>...'
    instead.

This was written for the old "we may want to warn" logic that did
not even check if we would be omitting a removal.  The new logic
will show the text _only_ when the difference matters, we have an
opportunity to tighten it a lot, for example:

    You ran 'git add' with neither '-A (--all)' or '--no-all', whose
    behaviour will change in Git 2.0 with respect to paths you
    removed from your working tree.

    * 'git add --no-all <pathspec>', which is the current default,
      ignores paths you removed from your working tree.

    * 'git add --all <pathspec>' will let you also record the
      removals.

    The removed paths (e.g. '%s') are ignored with this version of Git.
    Run 'git status' to remind yourself what paths you have removed
    from your working tree.

or something?
