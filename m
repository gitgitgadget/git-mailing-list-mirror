From: Junio C Hamano <gitster@pobox.com>
Subject: Re: regression: "96b9e0e3 config: treat user and xdg config
 permission problems as errors" busted git-daemon
Date: Thu, 11 Apr 2013 15:20:46 -0700
Message-ID: <7vip3shfpd.fsf@alter.siamese.dyndns.org>
References: <1365572015.4658.51.camel@marge.simpson.net>
 <20130410135605.GB4694@odin.tremily.us>
 <1365651583.19620.8.camel@marge.simpson.net>
 <20130411054207.GE27795@sigill.intra.peff.net>
 <7vwqs9jd0t.fsf@alter.siamese.dyndns.org>
 <20130411172424.GC1255@sigill.intra.peff.net>
 <20130411181103.GJ27070@google.com>
 <20130411181439.GA2820@sigill.intra.peff.net>
 <7vwqs8hmh1.fsf@alter.siamese.dyndns.org>
 <20130411200330.GA15667@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
	Mike Galbraith <bitbucket@online.de>, git <git@vger.kernel.org>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Fri Apr 12 00:20:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQPrT-000742-QJ
	for gcvg-git-2@plane.gmane.org; Fri, 12 Apr 2013 00:20:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754858Ab3DKWUu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Apr 2013 18:20:50 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38825 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754775Ab3DKWUt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Apr 2013 18:20:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AA79515416;
	Thu, 11 Apr 2013 22:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4EDsULKlbcldNNcUgAO579aTl7c=; b=YBHLkv
	WlCRDJ+8sSoFIix0Azlv2R8k6ChzhodF/hpdxUMksrPDvpCbal9pIdt/tc/njM18
	hfrArshdODy/XuflvTnUDsTWC1MJ2/4mAaqRfXrtuPoAwimjGAtjs5bcGHDXI4dx
	JSQ+aWagCbtbHHgaE9486F6dtC56NYtbPxbGQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wAvgRwEv51r9NrIWI7JLExAtbD1R4P6L
	fCViZ5NZpJVQ8wGJTmicEpbTtlrr4CPvrkX7tSsCGrpX4HzjvSN0M563FBtWuJZt
	5AeDMYrikM0Xnt1tYJQYaxXjh7nKNDHbxEzdjLgT3v97dShg06LiFkjWyJg2gd6W
	ZYcc+swOahM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9E5B815415;
	Thu, 11 Apr 2013 22:20:48 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 215A915411; Thu, 11 Apr
 2013 22:20:48 +0000 (UTC)
In-Reply-To: <20130411200330.GA15667@odin.tremily.us> (W. Trevor King's
 message of "Thu, 11 Apr 2013 16:03:30 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0F930C1A-A2F6-11E2-B074-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220936>

"W. Trevor King" <wking@tremily.us> writes:

> As one of the less experienced folks tripped up by this issue, I think
> that setting HOME explicitly before invoking the daemon is simple
> enough (which is why I just fixed my invocation and didn't post to the
> list).

Sounds like we need a documentation update somewhere.

> The difficulty was figuring out why the daemon was dying in
> the first place (which involved bisection for me as well).  Maybe
> there could be an additional note about HOME to flesh out:
>
>   fatal: unable to access '/root/.config/git/config': Permission denied
>
> when there's an EACCES error for the per-user config?

Doesn't access_or_die() say

    die_errno(_("unable to access '%s'"), path);

already?  I am puzzled...
