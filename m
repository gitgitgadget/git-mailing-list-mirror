From: Junio C Hamano <gitster@pobox.com>
Subject: Re: File extension conflict when working with git and latex
Date: Fri, 21 Mar 2014 11:32:37 -0700
Message-ID: <xmqqr45vtnay.fsf@gitster.dls.corp.google.com>
References: <20140321161324.GC2965@fu.192.168.200.1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthias Beyer <mail@beyermatthias.de>
X-From: git-owner@vger.kernel.org Fri Mar 21 19:33:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WR4Fh-00033R-TM
	for gcvg-git-2@plane.gmane.org; Fri, 21 Mar 2014 19:33:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751240AbaCUSco (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2014 14:32:44 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56928 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751211AbaCUScn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2014 14:32:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0F05D772AE;
	Fri, 21 Mar 2014 14:32:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EyUUf52BZdMu5kZ6ppiLZwsUx/Y=; b=U25j4a
	NcNXlicOpCGyjJSK5sHobhbZC2efI9+wufkAcqYRtI/gZo4VgA2dVbRbbWlhigFl
	HyyaHa69Olvc3XV9oOfckcPs6XX7CUD6Z3Y+x+az5VHYC3q0desuaIDonm5E1XEv
	KUyRYpvOiMgiLYSV2nTybJiTj1umFcQbAYht4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NKHWheSAsNF4wtZVYMrZ6otctcVvuJn9
	baJgTeV8JN+JIWw1glocuNF9MbX+KsrFm3qHPzhkKjklSiGinP1h5rIx8dL8pWsY
	MpnS6vfa8Y9/Gg9QEGX36jv5FyvsHBIqPMLrvL4as9H8Tu2C4yqKL0Yvmr8EAxPT
	68T+Y5EAe3s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E846A772AC;
	Fri, 21 Mar 2014 14:32:40 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 27F79772A9;
	Fri, 21 Mar 2014 14:32:40 -0400 (EDT)
In-Reply-To: <20140321161324.GC2965@fu.192.168.200.1> (Matthias Beyer's
	message of "Fri, 21 Mar 2014 17:13:24 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 2F018582-B127-11E3-8806-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244717>

Matthias Beyer <mail@beyermatthias.de> writes:

> I know, I can fix this by fixing the clean task in my Makefile. But
> maybe someone somewhere on this world doesn't know the git internals
> as good as me (and, of course, my coworker). Is there _any chance
> at all_ that this gets mentioned somewhere, so others don't fall into
> this pit?

Surely, we are here to please ;-)  All of us want to make sure
newbies do not shoot themselves in the foot.

But the problem is what exactly should be mentioned.  With a fresh
wound with your LaTeX project still in your mind, you may be tempted
to special case ".idx", but other newbies may inflict the same kind
of hurt on themselves with different "find" patterns, e.g.

    $ find . -name '[0-9a-f]*[0-9a-f]' -type f -print | xargs rm -f

when they know their project creates hexadecimal-numbered temoprary
files, or whatever other pattern that match the files they do not
care about, that also happens to match whatever is in $GIT_DIR.  The
only common caution that helps us to make sure "others do not fall
into this pit" is "Files and directories in $GIT_DIR are used to
record your work; do not muck with them unless you know what you are
doing e.g. manually repairing a corrupt repository", but that is a
bit lame, isn't it?

It is tempting to suggest "git clean '*.idx'", but that is a good
fit in the Makefile only when you know everybody involved in the
project works in a checkout from Git, not from a tarball extract,
and does not apply to projects in general.
