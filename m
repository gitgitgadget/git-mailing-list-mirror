From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Remove restriction on notes ref base
Date: Tue, 02 Nov 2010 10:41:10 -0700
Message-ID: <7vsjzj1v49.fsf@alter.siamese.dyndns.org>
References: <1288657003-17802-1-git-send-email-kroot@google.com>
 <20101102065208.GA4280@burratino> <201011020948.22677.johan@herland.net>
 <AANLkTinN1UXSmkxOg59pT_xVd2eWS0Ms2sgAweLv7hbg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johan Herland <johan@herland.net>, Kenny Root <kroot@google.com>,
	git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Nov 02 18:42:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDKsK-0005EE-NN
	for gcvg-git-2@lo.gmane.org; Tue, 02 Nov 2010 18:42:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754464Ab0KBRmT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Nov 2010 13:42:19 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:49720 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754443Ab0KBRmS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Nov 2010 13:42:18 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 30F21278B;
	Tue,  2 Nov 2010 13:42:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0fuHCYxbjl8byqCdoK1BlYVXBQw=; b=XP5UJN
	Ny6HLYSauiAXwZ+m6d8tMphh9qYA9AOOtipHIiYcvR0x5A+XLO4qqVXNLxJ4/LBa
	anYVZmexkrk+UxHQ4aX4NrKpJihkgnblVPZ4FHbkTSRv3qmcRYeasX77jtfDJNeY
	KxfBMaZik6bvgHdIW1yebFBWpoJfV3wA+Pnvg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rvpiBAZiYIWKEApYSPL4kXCMoKd3mcng
	cuOk7NwKWsCY2dEsejma+UDTC9DP4P+OiF9wpyHZZJf7BBIWGW+8IY2Dk+fX39vO
	Fu1Qgm4ABD8LaIgmAMf7IOnzKi9YHQQ0nBc2M94ssque3NG2ijwqpD9i9PHffmzR
	d1xDTrB2bz4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A9B582773;
	Tue,  2 Nov 2010 13:42:07 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 09CBB2717; Tue,  2 Nov
 2010 13:41:12 -0400 (EDT)
In-Reply-To: <AANLkTinN1UXSmkxOg59pT_xVd2eWS0Ms2sgAweLv7hbg@mail.gmail.com>
 (Shawn Pearce's message of "Tue\, 2 Nov 2010 07\:11\:45 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8353415E-E6A8-11DF-9073-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160543>

Shawn Pearce <spearce@spearce.org> writes:

> I didn't want to use refs/notes/bad-commits because its not really an
> annotation you would be looking at with git log.

Why not?  Within a repository with bad commits, you would want an option
to have them applied to bad commits you still have, no?

I am still torn with this patch, and I say "still" for a reason.  Even
though notes are implemented as commits, they are not commits on a part of
normal histories, and restriction of them within refs/notes hierarchy at
least is a safety measure (it is easy to loosen a restriction later, but
it is hard to let people loose first and then later restrict).  While a
purist in me says that GIT_NOTES_REF and command line option _should_
enforce the same restriction, keeping the more obscure GIT_NOTES_REF
interface a bit looser gives us an escape hatch.

As to remote interface, refs/remotes/$remotes/ hierarchy corresponds to
the local refs/heads/ interface, so I do not think we will change the
default mapping we document (and have "clone" prepare) to place notes
obtained from elsewhere in refs/remotes/ hierarchy (we do not do that for
tags neither), so I think Johan's point is an independent issue.
