From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] push: detect local refspec errors early
Date: Wed, 05 Mar 2014 12:51:06 -0800
Message-ID: <xmqqsiqwfjyd.fsf@gitster.dls.corp.google.com>
References: <259061394012172@web5j.yandex.ru>
	<20140305190248.GB31252@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dmitry <wipedout@yandex.ru>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 05 21:51:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLImb-0002G5-Gv
	for gcvg-git-2@plane.gmane.org; Wed, 05 Mar 2014 21:51:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755911AbaCEUvL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2014 15:51:11 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46463 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754349AbaCEUvK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2014 15:51:10 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1654970B06;
	Wed,  5 Mar 2014 15:51:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yJJ4sNM90C/bYcNuTAghrVymU0A=; b=VI6Q/Y
	SSXfIqhGwRENyFY/cHv5yHwYpIzNIhlJ6B4Nr8NUZgoYpEIf0b4UkAc8LOaZyyIG
	5je/SUqDqKI8yP4MsddLFnZyo2ZwrQYw374/gTCPD6eI+u/whqUe2JV3G2MhvO92
	O7frQTjY9WmVI8gE4FdRTlHCmbuGh1rJ3EkGE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oLuqalzaWwaiTLQS74dpsqPcjwFklmKR
	uIr3Acp7CunXHQPr4RkRBM0qAOTUOswgAdnx7eaLAw/Hk2XgLV18DKQAbkYpB9w4
	Pucmo7ov1dEuQ1x3nmPAQVeI1MR7EC/YkYFs9djbKESwqmFD1S0cqQ3szJF/sZ9N
	xRZOgAYCEyM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BBCC470B03;
	Wed,  5 Mar 2014 15:51:09 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 35BE070AFF;
	Wed,  5 Mar 2014 15:51:08 -0500 (EST)
In-Reply-To: <20140305190248.GB31252@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 5 Mar 2014 14:02:48 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: E062AA5E-A4A7-11E3-82E7-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243478>

Jeff King <peff@peff.net> writes:

> We can't fully process the refspecs until we have talked to the other
> side, because they may involve matching refs from the remote; I don't
> think git even really looks at them until after we've connected.
>
> But I think there are some obvious cases, like a bogus left-hand side
> (i.e., what you have here) that cannot ever succeed, no matter what the
> other side has. We could sanity check the refspecs before doing anything
> else.

The user's wallclock time is more important than machine cycles,
checking things we could check before having the user do things is a
good principle to follow.

I wish that the solution did not have to involve doing the same
computation twice, but I do not think there is a clean way around
that in this codepath.

Thanks.
