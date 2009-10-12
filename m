From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-add--interactive: never skip files included in index
Date: Mon, 12 Oct 2009 16:42:14 -0700
Message-ID: <7vskdo5gdl.fsf@alter.siamese.dyndns.org>
References: <1255189906-16049-1-git-send-email-pav@iki.fi>
 <7viqelwyp1.fsf@alter.siamese.dyndns.org>
 <20091011191440.GA2532@coredump.intra.peff.net>
 <7vpr8tr2pe.fsf@alter.siamese.dyndns.org>
 <20091012014007.GA7674@coredump.intra.peff.net>
 <7v63alpbwx.fsf@alter.siamese.dyndns.org>
 <20091012051157.GA23007@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pauli Virtanen <pav@iki.fi>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Oct 13 01:43:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxUY9-0007dA-9A
	for gcvg-git-2@lo.gmane.org; Tue, 13 Oct 2009 01:43:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932645AbZJLXnF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2009 19:43:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932468AbZJLXnF
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Oct 2009 19:43:05 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:44038 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932428AbZJLXnD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2009 19:43:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6D80E56375;
	Mon, 12 Oct 2009 19:42:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=q3sTIl1UTdSkIpNrT3yfYziJM6k=; b=YQIq+x4wOCHPSWUv16qclIF
	zsFgIo1QuOZ7OL923TI3G4OZ2EBnMnmX/hs6X5DuqPyKuHzsmLN0zlCvSBU+UKEE
	YMCBNIapzcndpBTyiPLfw8A1OYRDHYqAnu8fXzIkY8mjPlrPhMa8qY4RYGo/73b+
	8wWCK+dTGOUCgHL78i0M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=JX444tY5gvnE2KpkWNadmxQvGV6HnNNODsgYku9Ve4N+h5j6F
	xxTQIM7Xs8eddwqHugnHhP0m9nziU1DxOTXP4DQ7U7UBebA/ESt4L1Ip6EzPRLpA
	dB1zjlo0ZK4VHLuj0QPn3Qm7lXbsJf3uMUps8ZAUr9ea13V9ZAKtnR2r7k=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4093056372;
	Mon, 12 Oct 2009 19:42:19 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7D4BD56370; Mon, 12 Oct
 2009 19:42:15 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E160C096-B788-11DE-A26A-E80E3AD9C332-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130096>

Jeff King <peff@peff.net> writes:

> Subject: [PATCH] ls-files: excludes should not impact tracked files
>
> In all parts of git, .gitignore and other exclude files
> impact only how we treat untracked files; they should have
> no effect on files listed in the index.
>
> This behavior was originally implemented very early on in
> 9ff768e, but only for --exclude-from. Later, commit 63d285c
> accidentally caused us to trigger the behavior for
> --exclude-per-directory.
>
> This patch totally ignores excludes for files found in the
> index. This means we are reversing the original intent of
> 9ff768e, while at the same time fixing the accidental
> behavior of 63d285c. This is a good thing, though, as the
> way that 9ff768e behaved does not really make sense with the
> way exclusions are used in modern git.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---

Makes sense; thanks.

> I also still think that Pauli's patch makes sense; there is no point in
> passing --exclude-standard there. It should be a no-op.

Yeah, that is also queued independent from this one.
