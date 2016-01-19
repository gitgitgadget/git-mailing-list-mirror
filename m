From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] filter-branch: resolve $commit^{tree} in no-index case
Date: Tue, 19 Jan 2016 14:23:19 -0800
Message-ID: <xmqqr3hd8azs.fsf@gitster.mtv.corp.google.com>
References: <AF975DD2-988F-47A8-BFC3-3BBC27419305@wolfram.com>
	<xmqqbn8h9squ.fsf@gitster.mtv.corp.google.com>
	<xmqq7fj59rs2.fsf@gitster.mtv.corp.google.com>
	<20160119213705.GA28656@sigill.intra.peff.net>
	<xmqq37tt9r9g.fsf@gitster.mtv.corp.google.com>
	<20160119215100.GB28656@sigill.intra.peff.net>
	<20160119215928.GA6556@sigill.intra.peff.net>
	<20160119220722.GB6556@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, John Fultz <jfultz@wolfram.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 19 23:23:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLegQ-0004nk-RC
	for gcvg-git-2@plane.gmane.org; Tue, 19 Jan 2016 23:23:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933196AbcASWXX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2016 17:23:23 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:55602 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932702AbcASWXW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jan 2016 17:23:22 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9ECBA3DB70;
	Tue, 19 Jan 2016 17:23:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Dbw7VE3z6fZG4X+atcVghHLWED4=; b=OHw/m8
	oSm5vX0t7Yv5pTRJ6Ori7+Vx3cVF3636nSTDxLOZp3LtGdEuTJ9+wne4+K7l6hq9
	iV6vFn/Iid63crPvkhVSVh22HwjTZxGiQqkyRtTtvuM7nF71RLQk9J8r0pLZDtQ4
	qis0Ttzq0CI6AWj1nAdYxlbnnN7UW17+9K23Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=j7NDBc+h4meneROwN9xsvMI+WnuG7LeS
	zWmns8e6Yh0vCoYPZx8KFe4G8hIr80pz+s1QrKU1P3PVsQJMZOWOp42xHVEIlZEW
	UBJVCtirCt9EHV1z2iEOAM08MSoekVOKlwmdZLTVk/ULflW1ANJoh2hxfsumAEn3
	qvvYg5BsRfo=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 94E293DB6F;
	Tue, 19 Jan 2016 17:23:21 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 1DB373DB6E;
	Tue, 19 Jan 2016 17:23:21 -0500 (EST)
In-Reply-To: <20160119220722.GB6556@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 19 Jan 2016 17:07:22 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 3F3754FC-BEFB-11E5-895C-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284388>

Jeff King <peff@peff.net> writes:

> Actually, I ended up not including the part about doing that comparison.
> So the commit message isn't _wrong_, but it is incomplete. This
> paragraph:
>
>   However, the value of $tree here is technically
>   user-visible. The user can provide arbitrary shell code at
>   this stage, which could itself have a similar assumption to
>   what is in git_commit_non_empty_tree. So the conservative
>   choice to fix this regression is to take the 20% hit and
>   give the pre-348d4f2 behavior.
>
> should start with something like:
>
>   We could try to make git_commit_non_empty_tree more clever.
>
> to make it clear why we care about the user-visibility of the variable
> in the first place.
>
> Here is a re-roll with that fixup.

Thanks.  I failed to spot and realize that $tree is also part of
what we expose and end-user scripts may already be looking at when I
commented, and I agree with the reasoning behind this conservative
route.

Will queue.
