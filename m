From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 0/7] Rework git core for native submodules
Date: Thu, 04 Apr 2013 15:13:31 -0700
Message-ID: <7vd2uagd10.fsf@alter.siamese.dyndns.org>
References: <1365100243-13676-1-git-send-email-artagnon@gmail.com>
 <CA+55aFz1D_dMtMHHMpiGi3KL=Y-m4DVxHVr=1ZX8zYWQ2TPvwA@mail.gmail.com>
 <CALkWK0nNjvV5VGvT_eaubFoOhMnJ-N8FECAayd5A2K3BzeRh6Q@mail.gmail.com>
 <CA+55aFyQwJfiYo06y1bRNpKT6wOquhG9a9M_4YvLG_UT3b34-w@mail.gmail.com>
 <515DEE86.3020301@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>, Heiko Voigt <hvoigt@hvoigt.net>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Fri Apr 05 00:14:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNsQ0-0000ma-4c
	for gcvg-git-2@plane.gmane.org; Fri, 05 Apr 2013 00:14:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765007Ab3DDWNe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Apr 2013 18:13:34 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44202 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760606Ab3DDWNe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Apr 2013 18:13:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 378B8133A1;
	Thu,  4 Apr 2013 22:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QPcLspPMumoPxbSubO6V2sDj4Ks=; b=eOhnyc
	98sEIptqIlkKuyivc3IOL9CUCOp8CPJYDdpgvlPUcrT7qonF+LaJTUvL1vBvT6jY
	KK4LTgmcxd8QIpLbSBFOU5UQs5jwzo/dVNoyIYth6lZJDcP0NAuKyEPIyCaKTX6Z
	0Gvj8NX1wFeuy0wqhLewLrge9jVf9s2hxuGVw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IQLfBjlhX3pQyLVmYmZb97EGeR1O6XPY
	9S2Z6eG6qJQ56QtQgZTjMebR4cbqirMiUbsHegAyCs4U2VdtuJIeapP9uB9gOBuT
	oIiOIXXzSfguIBYJkvfFllItXEJxicpiGBOh2lbEKAAaGRatc4Y0AGKEw/bzQjYA
	bD6hRm2qnTE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2ECBD1339F;
	Thu,  4 Apr 2013 22:13:33 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A50791339B; Thu,  4 Apr
 2013 22:13:32 +0000 (UTC)
In-Reply-To: <515DEE86.3020301@web.de> (Jens Lehmann's message of "Thu, 04
 Apr 2013 23:20:06 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E320CF7C-9D74-11E2-9D68-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220114>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> While starting to grok submodules I was wondering myself if the data
> stored in .gitmodules would better be stored in an extended gitlink
> object, but I learned soon that the scope of the data that has to be
> stored there was not clear at that time (and still isn't). So I'm
> not opposed per se to adding a special object containing all that
> information, but I strongly believe we are not even close to
> considering such a step (and won't be for quite some time and maybe
> never will).

I actually think the storage is more or less an orthogonal issue.

The format must be defined to be extensible (nobody is perfect and
if you wait for an exhaustive list of attributes that cover all use
cases including the ones that haven't even been invented yet, you
will get nowhere), and designed carefully to reduce the chance of
allowing the extended/optional bit to express the same thing in two
different ways to make sure the object name will not become
unnecessarily unstable, but you can start small, keep adding
optional fields, and be prepared to design an upgrade path when you
need to add new mandatory fields---that cannot be helped whether you
record the information about submodules in .gitmodules or a new
blob-ish object at the location where the submodule tree should
reside in the index and the tree.

However, the current .gitmodules design, even though it originally
was invented as a way to carry information other than what a single
commit object name from an otherwise unrelated project can express
without having to change anything in-core, has a few practical
merits.  The information _about_ submodules is stored separately
(i.e. in the .gitmodules file) from submodules themselves, and it
may be a good thing.

When you are changing information _about_ submodules (e.g. you may
be updating the recommended URL to fetch it from), you can use the
usual tools like "git diff" to see how it changed, just like changes
to any other file.  If the information _about_ a submodule A is
stored at path A, and at the same time you have a working tree that
corresponds to the root of the submodule A at that path, it gets
unclear what "git diff A" should report.  Should it report the
change in the submodule itself, or should it report the change in
the information _about_ the submodule?  By separating these two
concepts to two different places, .gitmodules design solves the
issue nicely.
