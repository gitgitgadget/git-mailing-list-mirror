From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Fix notes handling in rev-list
Date: Thu, 19 Jul 2012 10:20:18 -0700
Message-ID: <7vr4s7vfal.fsf@alter.siamese.dyndns.org>
References: <20120325005504.GA27651@sigill.intra.peff.net>
 <1342463409-6919-1-git-send-email-jukka.lehtniemi@gmail.com>
 <20120717034640.GB20945@sigill.intra.peff.net>
 <7vvchnx7tc.fsf@alter.siamese.dyndns.org>
 <20120718072104.GB12942@sigill.intra.peff.net>
 <7vhat4wv6h.fsf@alter.siamese.dyndns.org>
 <20120719113535.GA29774@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jukka Lehtniemi <jukka.lehtniemi@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jul 19 19:20:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SruOq-0006tn-4e
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jul 2012 19:20:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751711Ab2GSRUX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jul 2012 13:20:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53655 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751337Ab2GSRUV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jul 2012 13:20:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6018B76DF;
	Thu, 19 Jul 2012 13:20:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3oZHQG5/4VOGi6uElLetPvJWWZQ=; b=OdB0qN
	wk9ztsfczh+vkg4NIRgCtTmUfO6ZioMGc5jnWdh5QtCmOIrcNz/WyAQLj978F4jd
	tl+M7FZuAcrT+39SVjZtt4KMIOOFGzYgJmhcgnnIzngsfdOMRJ3hCaD8hSHHVkXm
	wdeH5nhsTX2D6wJChBYCTxhAFkuXkSASPwlFc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fUAFetVEzSc+nnQpOqUY3bc/n+1nvSk2
	B6jBHVX8vsdF0/Hg4gvTm2hqLqt3wNJMTNfviXiQ63Jl6noER0NztB3RM+8YnCZk
	n4orokIrj4IOnJH3Wjm4hA15NC9s3Op4X+XWcmXZjz2bwLmXO/4h19fI8oUeBIxB
	QHwr1uBqzYA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4C89476DE;
	Thu, 19 Jul 2012 13:20:20 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B06B876DD; Thu, 19 Jul 2012
 13:20:19 -0400 (EDT)
In-Reply-To: <20120719113535.GA29774@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 19 Jul 2012 07:35:35 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 03EB545A-D1C6-11E1-A50A-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201742>

Jeff King <peff@peff.net> writes:

> Unlike elements of the commit object itself, like --parents or
> --timestamp, notes do not really gain any efficiency by being printed as
> part of the traversal. So modulo the cost of piping the list of commits,
> it would not really be any more efficient than "git rev-list | git notes
> list --stdin" (except that the latter does not take a --stdin argument,
> but could easily do so). And the latter is way more flexible.

Yeah, I prefer that (not that I think we need either badly).

> So for plumbing, I think this is the wrong direction, anyway. The real
> value of this patch is that the pretty-printed code path would work more
> like git-log (especially the "%N" format, which lets callers make their
> own micro-format for specifying all the bits they are interested in).

Yeah, but at that point the obvious question becomes "why you aren't
using 'git log' in the first place".

> Maybe the best thing is to simply disallow --notes when not using a
> pretty-printed format.

Yeah, or simply ignore it.
