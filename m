From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 0/6] reuse deltas found by bitmaps
Date: Wed, 26 Mar 2014 10:33:41 -0700
Message-ID: <xmqq7g7gkgp6.fsf@gitster.dls.corp.google.com>
References: <20140326072215.GA31739@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ben Maurer <bmaurer@fb.com>,
	Siddharth Agarwal <sid0@fb.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 26 18:33:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSri2-0004fH-A2
	for gcvg-git-2@plane.gmane.org; Wed, 26 Mar 2014 18:33:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755445AbaCZRdp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Mar 2014 13:33:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41773 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754217AbaCZRdo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Mar 2014 13:33:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4FB2873445;
	Wed, 26 Mar 2014 13:33:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=s0aMHObGukOh4jBJGIi+HzyP5xM=; b=RrLqFQ
	LitrxZRXtFuWK/P20wiTg1R3ZKVgN00c6ofh16B24aJrQSpNoPySrNpQX4ZN0iRl
	1hxkk8zsDbK9p683KvzSXM0HuUc2cC1cOt+48VluVsuRd9y0F9kwY3XE6TwnyPdc
	4zD0MrSr9g+Ar+1p2cRUgHItghixF2vQroqiM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=C1oPTEFk1zYZUamtRSg+wEMQ/8Fq5UUp
	hT2sTf3F6pgeATfWkVjCw9CeeBsv0W4ELgp+buexIwEJhVW7MQFI7ZvNeix4Fuh9
	R0EX4o2MOT4TsXmJOx55gsCQYcia2l3iGxJkukFoASWyNsIzSUTlMVu4lLdqnxil
	xtGRRMC0N0E=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3B44F73444;
	Wed, 26 Mar 2014 13:33:44 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 999B673441;
	Wed, 26 Mar 2014 13:33:43 -0400 (EDT)
In-Reply-To: <20140326072215.GA31739@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 26 Mar 2014 03:22:16 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: C72209A2-B50C-11E3-A4C4-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245199>

Jeff King <peff@peff.net> writes:

>   2. When considering whether a delta can be reused, check the bitmaps
>      to see if the client has the base. If so, allow reuse.
> ...
> The implementation I'm including here is the one I've shown before,
> which does (2). Part of the reason that I'm reposting it before looking
> further into these options is that I've written a t/perf script that can
> help with the analysis.

Conceptually, that feels like a natural extension for the "thin
pack" transfer.  I wouldn't foresee a correctness issue, as long as
the fetcher runs "index-pack --fix-thin" at their end.
