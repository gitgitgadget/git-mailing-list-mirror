From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 06/13] format-patch: use default email for generating
 message ids
Date: Sun, 20 May 2012 19:58:04 -0700
Message-ID: <7vzk928clf.fsf@alter.siamese.dyndns.org>
References: <20120518230528.GA30510@sigill.intra.peff.net>
 <20120518231347.GF30031@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Angus Hammond <angusgh@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon May 21 04:58:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWIp3-0006ur-JN
	for gcvg-git-2@plane.gmane.org; Mon, 21 May 2012 04:58:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752581Ab2EUC6I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 May 2012 22:58:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59338 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752174Ab2EUC6H (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2012 22:58:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C4857893B;
	Sun, 20 May 2012 22:58:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=DBilQ6tai8cRyaFFkh5pd1Wfg8Y=; b=q+5E8GZyn9SUjtGLfGo0
	KNoJIEiUEeyzjEjZt+x1xz9UOzV+tHUv0ovSTt03XE1dA0yrpKat0FMvzVnkcLMF
	BnmClKxtlDkg4l7ye/cEEm0oFst23yl6VtPNEiPMj9adt+Koi08azGMS8DLRl+vr
	NAw19oEQ72hJM9pLdl+GjMw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=aPJhJ7QUcRyT/QYD1x9+gozgwRPhPdkapk+wqCy7Ht/rtf
	tJ9rqcedaSRnBZfL8lbByidN+V8+3bDDlVIbuoc3fR3n9+vlCgCf/iS80QXHsj/I
	LW7qTSsdjnVGrKw67Dc/x3Du+GzMfe0PkbgecFy/GMdciw3PlTEXGzOytAwjw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B99868938;
	Sun, 20 May 2012 22:58:06 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5049A8936; Sun, 20 May 2012
 22:58:06 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CA0AFC44-A2F0-11E1-836C-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198079>

Jeff King <peff@peff.net> writes:

> We try to generate a sane message id for cover letters and
> threading by appending some changing bits to the front of
> the user's email address. The current code parses the email
> out of the results of git_committer_info, but we can do this
> much more easily by just calling ident_default_email
> ourselves.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> Technically this is a regression if you really wanted:
>
>   GIT_COMMITTER_EMAIL=some.addr@example.com \
>   git format-patch --thread=deep
>
> to make your environment variable part of the message-ids. I don't think
> it matters, but I can adjust it if we care.

Is it because you no longer explicitly ask for "committer" and get generic
"who am I" bit from the ident infrastructure?

I wouldn't be surprised if some automated "commit email notification
reacting to push" bot in post-receive hook is using the environment
variable to affect the message ID.  I would doubt that would break the
message as long as the message ID generated from this codepath stays
valid, though, so I wouldn't worry about complaints along the lines of
"you started using names different from what you used to use".  As long as
we don't die due to "Hey bot, you do not seem to have a valid e-mail
address!", I don't think we need to worry about it.
