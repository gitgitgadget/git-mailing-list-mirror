From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Different diff strategies in add --interactive
Date: Mon, 10 Jun 2013 12:28:55 -0700
Message-ID: <7v38sphiiw.fsf@alter.siamese.dyndns.org>
References: <20130610142825.GI22905@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Mon Jun 10 21:29:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Um7m5-0007OM-Kr
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 21:29:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751638Ab3FJT27 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Jun 2013 15:28:59 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36611 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751034Ab3FJT26 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jun 2013 15:28:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 330D126065;
	Mon, 10 Jun 2013 19:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gcDOtYtUb+VrklByrD/KVqY31kw=; b=s9RtEA
	o0LOX98+YoXYIv5EUQI9ypKfhqf101nSlYwRfH9xgT9W24zCQ+fJpYby8YToeAYR
	u18cDw1d0KtKQ9fQtswpx6MW3VSmC6O0xBIuIgNIHNQcygg13BbROqKQgINlI8vH
	RiPB6OZHBxJi4R6xsIVNyyvMaUEgQCV7E5a+Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rkp+xsC0A5JNtkfNAge3t92oEimiBnAY
	KihcJXyWOohMYCvGLI2FqPXb8hjhqvVsE0EOb0SrIXPlh+EHe5YJcSHqe/R+YPYo
	99B6GzrM855naPXeJLbr5Ltui9EhsyqEeefjuVuByCrU+vXSiMHBusvLfFFJXi8Y
	i3fSUdv3Oy0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 102DF26064;
	Mon, 10 Jun 2013 19:28:58 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4E85F26061;
	Mon, 10 Jun 2013 19:28:57 +0000 (UTC)
In-Reply-To: <20130610142825.GI22905@serenity.lan> (John Keeping's message of
	"Mon, 10 Jun 2013 15:28:25 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FEA21C60-D203-11E2-98CD-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227364>

John Keeping <john@keeping.me.uk> writes:

> I think the first thing to do is read the "diff.algorithm" setting in
> git-add--interactive and pass its value to the underlying diff-index and
> diff-files commands, but should we also have a command line parameter to
> git-add to specify the diff algorithm in interactive mode?  And if so,
> can we simply add "--diff-algorithm" to git-add, or is that too
> confusing?

Making "git add--interactive" read from diff.algorithm is probably a
good idea, because the command itself definitely is a Porcelain.  We
would probably need a way to defeat the configured default for
completeness, either:

    git add -p --diff-algorithm=default
    git -c diff.algorithm=default add -p

but I suspect that a new option to "git add" that only takes effect
together with "-p" is probably an overkill, only in order to support
the former and not having to say the latter, but I can be persuaded
either way.

As long as "git add --diff-algorithm=foo" without "-i" or "-p"
option lets the user know it has no effect (error out, give warning
and continue, etc. whose details I do not deeply care), that is.
