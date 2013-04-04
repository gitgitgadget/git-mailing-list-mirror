From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/3] diffcore-pickaxe: remove unnecessary call to
 get_textconv()
Date: Thu, 04 Apr 2013 15:51:51 -0700
Message-ID: <7vppy9gb94.fsf@alter.siamese.dyndns.org>
References: <7vr4iqi2uw.fsf@alter.siamese.dyndns.org>
 <ed31727421dc3000e943e62a8d82ac1af6589733.1365105971.git.simon@ruderich.org>
 <7vvc82ggy3.fsf@alter.siamese.dyndns.org>
 <20130404211110.GB25811@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Simon Ruderich <simon@ruderich.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 05 00:52:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNt15-0007xK-RR
	for gcvg-git-2@plane.gmane.org; Fri, 05 Apr 2013 00:52:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765073Ab3DDWvz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Apr 2013 18:51:55 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63800 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763085Ab3DDWvy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Apr 2013 18:51:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9A1C513054;
	Thu,  4 Apr 2013 22:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JIPzn8oBA3xm8SIQzwIKwWPnzmk=; b=pyWoIn
	PJT+GM0lIuAA8OrWP7nSIIHc9+8NH532m7PTzb6k/jwS4MJDHAMGmLK4L+IFRFMS
	M55F0vz3NKWKB/t2tJRegufWx8IDiO+BiUpkYCCJN4KDbeGzXsNPFVMM7HbdWFZl
	Fvzi10AOI4lXNTTkW6nksoi9L1JCgyDucTzJ8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JDiJwgbdgbny+oLFdQ3SGy7tXQYmK8O4
	9651v+OZASguYf2B8lF2Pxe6c6grGfJBW9ld+DvYGM+FQit1hytqt24qc7IjCA4N
	P5EpsFtb/UFp1OvWgN7iSjxnKFD04Ll2ijjod0F2SkrGsc4bAGHe5QHGXceoVfAZ
	Hi2jdkjczoA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 89FA413052;
	Thu,  4 Apr 2013 22:51:53 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0FDD313051; Thu,  4 Apr
 2013 22:51:52 +0000 (UTC)
In-Reply-To: <20130404211110.GB25811@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 4 Apr 2013 17:11:10 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3E442F84-9D7A-11E2-81BA-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220120>

Jeff King <peff@peff.net> writes:

> But I do not think fill_one is the right interface for it. The reason
> has_changes calls get_textconv separately is that we do not want to fill
> the buffer (which may be expensive) if we can avoid it. So the correct
> sequence is: ...
> If you turned fill_one into "fill_both_sides" then you could share
> the code between diff_grep/pickaxe and do it in the right order in the
> helper.

Yeah, I think that is a good way to refactor.  A patch later in the
series will be killing fill_one() anyway ;-)
