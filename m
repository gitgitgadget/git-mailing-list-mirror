From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] Unconfuse git clone when two branches at are HEAD.
Date: Mon, 09 Sep 2013 07:44:04 -0700
Message-ID: <xmqqr4cy5a2z.fsf@gitster.dls.corp.google.com>
References: <20130906155204.GE12966@inner.h.apk.li>
	<6649DD0E3B6B4CE59D330217786B6B05@PhilipOakley>
	<xmqqfvthyfui.fsf@gitster.dls.corp.google.com>
	<94A71512041A4F9BB402474DB385E310@PhilipOakley>
	<xmqqwqmsvdfh.fsf@gitster.dls.corp.google.com>
	<531DBE1FF66D4356AEE6AEE5C2FE9389@PhilipOakley>
	<xmqqk3ir6wu3.fsf@gitster.dls.corp.google.com>
	<5425F66B510F423EA685BCEF40EF8FA7@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Andreas Krey" <a.krey@gmx.de>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Philip Oakley" <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Mon Sep 09 16:44:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJ2hW-0000YT-F5
	for gcvg-git-2@plane.gmane.org; Mon, 09 Sep 2013 16:44:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752965Ab3IIOoN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Sep 2013 10:44:13 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33602 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751506Ab3IIOoL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Sep 2013 10:44:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CD90C3EDF3;
	Mon,  9 Sep 2013 14:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=A8IMY8ouNknv9a2BSbvSBC6F0zQ=; b=cfBB/C
	VBiKXYdyU9ArSWrkxc7CAb/W5shloE0htBEcclpxQ6wIBhrIbM4nAlYePkj3YeNa
	Uj7dLYdeg00LY79L9IGuJcJHQ1x75mMLXuW3itGTV2L7p2qQ4e3f1/8ROmaeEgVQ
	b1yPD3EJZ6WNO4FpaFYhlRN4KX31u0r+jvXIk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TIXTJvQDIMzGMEb+yUYsVNUMDrb4Lpf/
	J//PgSzznie50BzUhHjKj2thloor0wdGJG1KlTed4ngyaEv4Yomc4PzclxBjtdYU
	Z0o1ZO1zU4JBcg18FRf/QHwJRupvJTGTf53IUnxrXbdzMRQh9GNShw6bxPE6zkq5
	63pggIBEDHw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1F2573EDF0;
	Mon,  9 Sep 2013 14:44:09 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 11D0C3EDEB;
	Mon,  9 Sep 2013 14:44:07 +0000 (UTC)
In-Reply-To: <5425F66B510F423EA685BCEF40EF8FA7@PhilipOakley> (Philip Oakley's
	message of "Sun, 8 Sep 2013 22:00:24 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 483D07DA-195E-11E3-9DDF-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234345>

"Philip Oakley" <philipoakley@iee.org> writes:

> One is to extend the ref format such that
>  <sha1> refs/heads/Test:HEAD
> would be considered a valid indicator of a symref relationship
> (i.e. using the typical 'colon' style). It would be appended after the
> regular refs, so all the existing refs are still transported.
>
> The point is that while it produces an error, it doesn't stop the
> cloning, and the error message
> "error: * Ignoring funny ref 'refs/remotes/origin/Test:HEAD' locally"
> gives a pretty clear statement of intent to those with older versions
> of git.

Cute.  If it does not stop any of these:

        git ls-remote such.bundle
	git clone such.bundle
        git fetch such.bundle
	git fetch such.bundle master ;# if 'master' branch is in it
        git ls-remote such.bundle
        git ls-remote such.bundle master ;# if 'master' branch is in it

even if some of them may give error messages, I think that may be a
workable escape hatch.

> Another alternative is to add an additional name space (e.g.)
>   <sha1> refs/remotes/origin/HEAD/Test
> which would simply be an extra directory layer that reflects where the
> HEAD should have been. Though this namespace example has the D/F
> conflict.

I'd rather not go this route.  Allowing refs/heads/master and local
branches that forked from it in refs/heads/master/{a,b,c,...} could
be a potentially useful future enhancement, and this approach will
close the door for it.
