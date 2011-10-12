From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH]: reverse bisect v 2.0
Date: Tue, 11 Oct 2011 21:57:13 -0700
Message-ID: <7vr52ibydy.fsf@alter.siamese.dyndns.org>
References: <20110929142027.GA4936@zelva.suse.cz>
 <20111004103056.GB11236@sigill.intra.peff.net>
 <7vfwj8dbn0.fsf@alter.siamese.dyndns.org>
 <201110050034.46334.chriscool@tuxfamily.org>
 <7v62k4ban7.fsf@alter.siamese.dyndns.org>
 <CAH5451kUf=vPfgOOusmJjfbiyueX9VByJLzZ9WbyqLd0z78wxA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Jeff King <peff@peff.net>, Michal Vyskocil <mvyskocil@suse.cz>,
	git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>
To: Andrew Ardill <andrew.ardill@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 12 06:57:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RDqsc-00031X-JZ
	for gcvg-git-2@lo.gmane.org; Wed, 12 Oct 2011 06:57:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752309Ab1JLE5R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Oct 2011 00:57:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55230 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752169Ab1JLE5Q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Oct 2011 00:57:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E1E0A3013;
	Wed, 12 Oct 2011 00:57:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3zVkoWXmlbZghW0FtzZ/7rYG0p4=; b=HXcGFg
	k75vb7Hx9nuNIVQVk8Y+tbzYW41mfmwFMz4KAUB8FlEgv0JHfc/Ptj/xaHYiI5Z+
	ppK9KI9MjO/O7ST7Th0JFWC2njWbGiMcqcbgzrayp8A1rGhmYQkvPnNMmS+Ac5v5
	udD0COtfotiRKq/UkSKPkn0JVCF25SAp2UVbg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XjUoHECWz08+5Df2QwdzswFMDxw1OMIW
	OJ8AoRv/owB3r5A51UC9MkWDdQPCdsZas9UzMMRG7az883JK2mx9BLChSxDX+/yc
	I6kIUbTBSDhPBEIM6CMiSovlN8viOR8ljZl2Gz36v+fltFKJElzkSr6jZzyanX2A
	dLYP0tqlgWg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D81203012;
	Wed, 12 Oct 2011 00:57:15 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 431A1300E; Wed, 12 Oct 2011
 00:57:15 -0400 (EDT)
In-Reply-To: <CAH5451kUf=vPfgOOusmJjfbiyueX9VByJLzZ9WbyqLd0z78wxA@mail.gmail.com> (Andrew
 Ardill's message of "Fri, 7 Oct 2011 12:57:30 +1100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A7751EAA-F48E-11E0-9602-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183355>

Andrew Ardill <andrew.ardill@gmail.com> writes:

> Examples.
> Search for a feature add:
>    $ git bisect start --introduced='feature: git frotz says xyzzy' v0.99 master
>    Bisecting: 171 revisions left to test after this (roughly 8 steps)
>    $ ... build and then test ...
>    $ git bisect tested
>    Does this snapshot have 'feature: git frotz says xyzzy' [y/n]? yes
> # already added, look backwards
>
> Search for a feature regression:
>    $ git bisect start --removed='feature: git frotz says xyzzy' v0.99 master
>    Bisecting: 171 revisions left to test after this (roughly 8 steps)
>    $ ... build and then test ...
>    $ git bisect tested
>    Does this snapshot have 'feature: git frotz says xyzzy' [y/n]? yes
> # not removed yet, look forwards

With an obvious addition of non-interactive short-cut subcommands "git
bisect yes" and "git bisect no", I think --removed= is a much better
wording than --used-to= I suggested in the discussion.

I however am still worried about the flipping of the mapping between
<good,bad> and <yes,no> this design requires. What are we going to do to
the labels of low-level machinery (i.e $GIT_DIR/refs/bisect/bad and
$GIT/refs/bisect/good)? They appear in "bisect visualize" and I was hoping
that it would be simpler in the code if we do not have to change them in
such a way that depends on this introduced/removed switch, and that was
the reason why I was trying to see if we can solve this without the
switchable mapping between <good,bad> and <yes,no>.

More specifically, I was hoping that we can rename "good" to "old" and
"bad" to "new" unconditionally and be done with it. We would ask the user
"What did the code used to do in the olden days?" and "Does this version
behave the same as it used to?". The possible answers the user can give
are "git bisect old" (it behaves the same as the older versions) and "git
bisect new" (it behaves the same as the newer versions). Then we do not
have to worry about having to flip the meaning of <yes> and <no> at the UI
level.
