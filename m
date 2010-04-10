From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/5] "status --ignored"
Date: Sat, 10 Apr 2010 11:27:39 -0700
Message-ID: <7v633zxiw4.fsf@alter.siamese.dyndns.org>
References: <20100410040959.GA11977@coredump.intra.peff.net>
 <1270885256-31589-1-git-send-email-gitster@pobox.com>
 <20100410074430.GA12567@coredump.intra.peff.net>
 <7vd3y7ycgu.fsf@alter.siamese.dyndns.org>
 <20100410084007.GA16843@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Eric Raymond <esr@snark.thyrsus.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Apr 10 20:27:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0fPR-0008QF-5v
	for gcvg-git-2@lo.gmane.org; Sat, 10 Apr 2010 20:27:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752164Ab0DJS1w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Apr 2010 14:27:52 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:59106 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752091Ab0DJS1v (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Apr 2010 14:27:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 771B8A96EB;
	Sat, 10 Apr 2010 14:27:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8wuuzZxKDrQ1rgqeEVFZieB/bIQ=; b=ZlUVkJ
	tEUjgsq60jxsawy8rL/S4pemVeJ0OLJyRWH0ij3L+9U8CNvrqKdYn7HQxfecIbNV
	SBFVy1p59AT1wj3/TXYCEhlScPzYqqfgqveBUkFSDJEay0RZ1R/pgk/BM+tjP8lz
	dXJ7HGJKCdxt24UXxHAlb7DB0GcylJvBNvci8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WV84q6XrPAzyuY6yi72U9bitChU2mNiB
	p/hFrV6WM9hqElCpvGUafRoZzvA3AWKtvMW0F2fIJJcS//Raam7tkCwqEk/GeI9V
	SKkmUfnqp7KQaD5QRpZvLCAbooXzj6R4b//0bT/Y0p4y71PhFGCfP4hv+TaiWgSv
	ImMhTWp4tEY=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id EC726A96EA;
	Sat, 10 Apr 2010 14:27:44 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 221B8A96E5; Sat, 10 Apr
 2010 14:27:40 -0400 (EDT)
In-Reply-To: <20100410084007.GA16843@coredump.intra.peff.net> (Jeff King's
 message of "Sat\, 10 Apr 2010 04\:40\:07 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C1C004C6-44CE-11DF-A089-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144572>

Jeff King <peff@peff.net> writes:

> ... But finding every file means
> we have to traverse areas that git otherwise wouldn't look at, which
> might mean going to disk to pull in all of the "foo/" directory
> structure (which is less likely to be cached, since the rest of git
> isn't touching it), even though it may not even be of interest to us.

Yes, that is why it is adequate for us use COLLECT_IGNORED in "git add"
and give "foo/ is outside---you as an intelligent human should be able to
infer that your foo/bar is also" without double traversal.

Eric's tool might want the same abbreviated information if it is just
relaying our output to an intelligent human.  Or it might want to get all
paths if it wants to operate on them itself.  Knowing VC I chose to
illustrate how to do the latter, but in the real implementation, we may
want --show-ignored=normal vs --show-ignored=expanded to support both
uses.
