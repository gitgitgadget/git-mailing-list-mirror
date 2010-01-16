From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] grep --no-index: allow use of "git grep" outside a git
 repository
Date: Fri, 15 Jan 2010 20:15:49 -0800
Message-ID: <7vpr5ait1m.fsf@alter.siamese.dyndns.org>
References: <201001131713.05505.agruen@suse.de>
 <7vfx69k0bu.fsf@alter.siamese.dyndns.org>
 <20100115223259.6117@nanako3.lavabit.com>
 <7vska71br0.fsf@alter.siamese.dyndns.org>
 <7vzl4fum3r.fsf_-_@alter.siamese.dyndns.org>
 <20100115210854.GA21540@coredump.intra.peff.net>
 <7vwrzin9jt.fsf@alter.siamese.dyndns.org>
 <20100116011512.GA27082@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Nanako Shiraishi <nanako3@lavabit.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jan 16 05:17:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NW060-0007sK-AD
	for gcvg-git-2@lo.gmane.org; Sat, 16 Jan 2010 05:17:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932227Ab0APEQG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2010 23:16:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752208Ab0APEQE
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jan 2010 23:16:04 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:51226 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751962Ab0APEQD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2010 23:16:03 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 25572915ED;
	Fri, 15 Jan 2010 23:15:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qb9coZidBGJPLPHJRfUSaRwPV+Q=; b=miegM6
	ofUKicAj4HgHrXW8HFYzTcrq52wonT0/wtbnu7YsFzJIVbw4WEJPR5egZiMxC6KV
	JVTfyP4UWxjDZmBwJtXyOFzxWIM+JYiJmiV06FlDu/SewTHntc0V75w3DcePa1iC
	Slf4mSYvjpMeINCIGkWzrNUlP+6m3gX74mWvE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=V0XgetDvkHSCp8oCpiCVrvFNshn45Mel
	IHwaw/eC2XtYIzi7iENN4vbd48Oddss5VH+CgNx41TsZNMu8P+5Aj01TIZrJqgE0
	pSyVqhunKX3T+MoTWBXq00Z6x0JITZu/heT6tp2WZid2+BsTJUdkwqP+o5rBA364
	NLfUfE/XLBU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E8C5C915EC;
	Fri, 15 Jan 2010 23:15:54 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 21E7A915EB; Fri, 15 Jan
 2010 23:15:50 -0500 (EST)
In-Reply-To: <20100116011512.GA27082@coredump.intra.peff.net> (Jeff King's
 message of "Fri\, 15 Jan 2010 20\:15\:12 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D7225AA0-0255-11DF-BE73-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137197>

Jeff King <peff@peff.net> writes:

>>     git grep --all-match -e Junio -e Dscho
>
> That one is a little harder (though it is not something I do very often,
> and I had to actually read the docs to find what --all-match does):
>
>   grep Junio `grep -l Dscho *`
>
> which of course has problems with exotic filenames.

Also it doesn't find lines that match Dscho in the result ;-)

Realistically, this most often is used when grepping in the log, e.g.

    git log --all-match --author=peff --grep=test

I actually wish "log" to somehow default to --all-match mode at least when
using the --author option.  "Change by Jeff, or about test by anybody" is
rarely what I would want to look for.
