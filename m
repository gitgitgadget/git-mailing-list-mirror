From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] config includes, take 2
Date: Tue, 07 Feb 2012 10:03:26 -0800
Message-ID: <7vpqdq1pxt.fsf@alter.siamese.dyndns.org>
References: <20120206062713.GA9699@sigill.intra.peff.net>
 <CAJDDKr6A2UvB3D-Dapw7WCEzWfzLoLd0E8MSDjT0RtdxFeWZAQ@mail.gmail.com>
 <20120207051719.GA11598@sigill.intra.peff.net>
 <CAJDDKr5yiKvNnpVV29jFK1Z1yuUnA-=dn0yMB8iW9y53vRGDHQ@mail.gmail.com>
 <20120207173025.GA22225@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Aguilar <davvid@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 07 19:03:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RupOC-0001Yw-9X
	for gcvg-git-2@plane.gmane.org; Tue, 07 Feb 2012 19:03:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756137Ab2BGSD3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Feb 2012 13:03:29 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40085 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754724Ab2BGSD3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Feb 2012 13:03:29 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7FCEC6777;
	Tue,  7 Feb 2012 13:03:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6hq1Tc8Ux6yPnQUvZhYb9dP68Qs=; b=s5qRx5
	pGkryaEHaNIYAa9+yMeWj+36HiATXmYcinrFdo7iCPZ7s3rQ1OYwYuuHCw8E54bo
	reC9dqNwpvClpmIZHjZY2MiinQ9QDV1gWEKETbdJpDYs0G926nieBKaNc4fg6Aqx
	jrmywW3WqKwgOh12n0RYCqQF3rd8MmG3hL84w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JAjmO1JRk375PVkDqnptYcZXHF9DqGS8
	NczNWNyrM5N9ztGq+YWd/8ahtITyTGmzQWflB+Qf0omFFPek/hGTHvp2lROJo5JW
	neK6Oeb8nWldESo+P/haLuZpNNkr9GoKMM8fH6yFkZOsmGP/XiEACz7OFMVktzt2
	a1z3Z+Jt/k0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 760FF6776;
	Tue,  7 Feb 2012 13:03:28 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F2C4A6773; Tue,  7 Feb 2012
 13:03:27 -0500 (EST)
In-Reply-To: <20120207173025.GA22225@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 7 Feb 2012 12:30:25 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 095164D8-51B6-11E1-A8E6-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190190>

Jeff King <peff@peff.net> writes:

> So fundamentally, includes make the idea of "overwrite this value" much
> more complex.

I do not think it is anything new that include.path brings.  To give the
user a complete view of "what customization applies when working in this
repository?", and to allow the user to edit variables in the right file
among usual three places, the tool already needs to be aware of possible
places and give users a way to tell where the edit needs to go anyway.
include.path only adds one more thing for the tool to be aware of.

With your example, the editor can show

	git config -f .git/config --list

with "include.path=~/.gitident" listed as one of the key=value pairs
without showing key=value pairs included from that file.  Or it can show
user.name in effect is this value from .git/config, and optionally also
show that there are other definitions of user.name in ~/.gitconfig (which
we use as if we have "include.path=~/.gitconfig" at the top of .git/config
file) or ~/.gitident specified with include.path.

The tool needs to make it easy to jump to ~/.gitident; it needs to know
what include.path means.  The user can edit the value in ~/.gitident, or
after looking at ~/.gitident, choose to come back to .git/config and add
an overriding entry there.

> But isn't "git cola" a git-config editing program?

Yes, that is really the right "rhetorical" question to ask.  It needs to
know what it is editing, so it at least needs to be _aware_ of the
inclusion, where each item comes from, and how to edit contents of _one_
particular file.

And that issue is not something new that was introduced by include.path.
