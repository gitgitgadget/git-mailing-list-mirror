From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 09/16] prune: factor out loose-object directory traversal
Date: Fri, 03 Oct 2014 15:19:29 -0700
Message-ID: <xmqqoatskd8u.fsf@gitster.dls.corp.google.com>
References: <20141003202045.GA15205@peff.net>
	<20141003202943.GI16293@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Oct 04 00:19:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XaBCQ-0006W2-94
	for gcvg-git-2@plane.gmane.org; Sat, 04 Oct 2014 00:19:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932264AbaJCWTe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Oct 2014 18:19:34 -0400
Received: from smtp.pobox.com ([208.72.237.35]:53134 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756890AbaJCWTb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Oct 2014 18:19:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CEBE43F7A7;
	Fri,  3 Oct 2014 18:19:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=aeONlRVQYuU2crlXInQFm7FYRrY=; b=vYFAh0
	ABOYRLbU7GtTcfEWQnbXL7bilfbwl0XeaCYG8kftcXpJIK2mfxhnmchbwJAHmRww
	BkLH0AZ9bH2q6oyq054zCv7BjiIFS2pVnz1TN9PZg/cP9TmyqQKLk3DY5PJ/ORI7
	guluXsATS2UGC/Sh4yXsZPEOW9Y2BkhmYWpJg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Jy/T0Il2y2GPOV3m9Bm4uSjUWApWkLne
	ZACogLT6uFEaGDGTvFGXT2dQhSHd1FOYrUyvWHGmeMkAKE+T843LQGPQq9FEPS4b
	hWlK8e3Al0bJ1PG/SijhekSFUhZqhoj1PjZgbCqSfdBKBcFiXYb2qDP8QS/NYDu+
	b1yHnVo0l0A=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C5D863F7A5;
	Fri,  3 Oct 2014 18:19:30 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 4A5433F7A3;
	Fri,  3 Oct 2014 18:19:30 -0400 (EDT)
In-Reply-To: <20141003202943.GI16293@peff.net> (Jeff King's message of "Fri, 3
	Oct 2014 16:29:43 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 583FC1FC-4B4B-11E4-B255-9E3FC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257875>

Jeff King <peff@peff.net> writes:

> Prune has to walk $GIT_DIR/objects/?? in order to find the
> set of loose objects to prune. Other parts of the code
> (e.g., count-objects) want to do the same. Let's factor it
> out into a reusable for_each-style function.

Doesn't fsck also look at these as well?  I recall that we also have
a "sort by inum" trick employed there.  Would it also be applicable
to these two callers?
