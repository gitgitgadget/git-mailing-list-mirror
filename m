From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] commit: use a priority queue in merge base functions
Date: Thu, 30 Aug 2012 15:16:38 -0700
Message-ID: <7vy5kwowjd.fsf@alter.siamese.dyndns.org>
References: <20120829110812.GA14069@sigill.intra.peff.net>
 <20120829111147.GB14734@sigill.intra.peff.net>
 <7vtxvlwt7o.fsf@alter.siamese.dyndns.org>
 <20120829205332.GA16064@sigill.intra.peff.net>
 <20120829205525.GA28696@sigill.intra.peff.net>
 <20120829210032.GA29179@sigill.intra.peff.net>
 <20120829210540.GA31756@sigill.intra.peff.net>
 <20120830125421.GA5687@sigill.intra.peff.net>
 <20120830130327.GB5687@sigill.intra.peff.net>
 <7vy5kws5jn.fsf@alter.siamese.dyndns.org>
 <20120830214802.GB18636@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 31 00:17:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T7D32-0008Aa-Lm
	for gcvg-git-2@plane.gmane.org; Fri, 31 Aug 2012 00:17:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752182Ab2H3WQp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Aug 2012 18:16:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46497 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751563Ab2H3WQl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Aug 2012 18:16:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BEDDC9C7D;
	Thu, 30 Aug 2012 18:16:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=E+Mcfx9xRM6UCbwIJzJN5wtZJ9c=; b=QfszdE
	knfDltf5pDPSBaT+AtOOwE5T+2sbcIRTpfEycpqGkvZP2B98CzvWIWJE1GIfhLRq
	8rsO4usXBGdwfRKCOD31CPU8N0t57QG84ppRQkdBizcT1i9Con8JNpJNrXmy4oiz
	tJJaNfaitlqwaYUnFW38Uqvqc9F8/YcoVqad4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZAJDlHcrn7SMrzVAKJzxVipy41ZXyQW2
	xJPWtVDA0s6Ux7giE0w13klNrLIcYGevEFop26nGGtsQ/fo/cu+eb8m7SLdoLx6Z
	1kTpG1XGgLu0aVPtorrk4eyEjmmHhAHyo8zDDkl9NMgzhmxfow80ogiCY/MkEAVp
	A6KzdadGO4I=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AE1E79C7C;
	Thu, 30 Aug 2012 18:16:40 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 13BC69C7B; Thu, 30 Aug 2012
 18:16:39 -0400 (EDT)
In-Reply-To: <20120830214802.GB18636@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 30 Aug 2012 17:48:03 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5F300E8C-F2F0-11E1-A850-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204570>

Jeff King <peff@peff.net> writes:

> So the issue is that when you do a recursive merge with multiple bases,
> the order in which you visit the recursive bases is going to impact the
> exact conflicts you see.

Yeah, that explains it.

> So the test is not broken or racy, which is good. It is just testing
> something that is somewhat of an implementation detail. We could switch
> it to use test_tick, and then adjust the expected output to look for the
> expected conflict that git happens to generate in that case. But that is
> no better than the current behavior.

True.

> But I'm not sure there is a way to test what it wants to test (that we
> hit a conflict that involves one of the recursive merge bases) without
> relying on the implementation detail. So I'm inclined to just leave it
> in place.

OK.
