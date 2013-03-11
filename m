From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] Make help behaviour more consistent
Date: Sun, 10 Mar 2013 20:03:42 -0700
Message-ID: <7v1ubmd4dt.fsf@alter.siamese.dyndns.org>
References: <1362937729-9050-1-git-send-email-kevin@bracey.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Kevin Bracey <kevin@bracey.fi>
X-From: git-owner@vger.kernel.org Mon Mar 11 04:04:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UEt2A-0001T7-91
	for gcvg-git-2@plane.gmane.org; Mon, 11 Mar 2013 04:04:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753663Ab3CKDDw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Mar 2013 23:03:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47661 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753546Ab3CKDDv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Mar 2013 23:03:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6F138C749;
	Sun, 10 Mar 2013 23:03:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=h9MCTwVO9nr7kTPnlESnAiod4Tc=; b=xTVCox
	1V+zaLsbEHxvEeSVzcgFBn7fXI2yih8p3AeAtBoYKSBo/NmzqyvGhmzs+WjIVJev
	d0/i7IGopQ+2Om43/0MhslEKFbFELsfQd1k59bO2xtvZcmQrwKTICFrc8VLCUzgt
	XPQ/Pg3q3rg4QzdE90/GDpZNYpGN53aNffIXE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jmlM3x4RJKDNtqgRNrWyd4p+91Ctfgx6
	Mp06innIbs5IxOr8xu7TIcPFc0DBJuP2/7eRGGWOMD+KkAD5TUrLvztqWPejOqdX
	BxWqkFK6wUR83p+bOJq7nnZB7D9moQ2Q+h6A4ixOHB/2SY2rPYRPA8kIl9KahwYR
	FkUDL+yj+I8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6404CC748;
	Sun, 10 Mar 2013 23:03:45 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B80C2C73D; Sun, 10 Mar 2013
 23:03:44 -0400 (EDT)
In-Reply-To: <1362937729-9050-1-git-send-email-kevin@bracey.fi> (Kevin
 Bracey's message of "Sun, 10 Mar 2013 19:48:49 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 493495CC-89F8-11E2-A77A-26A52E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217848>

Kevin Bracey <kevin@bracey.fi> writes:

> Previously, the command "help" and the option "-h" behaved differently
> depending on whether a command was specified or not. Old user interface:
>
> Commands with no defaults show usage: "git"           "git CMD"
> To specifically request usage:        "git help"      "git CMD -h"
> To get a manual page:                 "git help git"  "git help CMD"
>
> Two significant usability flaws here:
>  - If using man, "man git" to side-step "git help" is obvious. But if
>    trying to use help.format=web, how to get the root html page? My
>    technique was "git help XXX" and click the "git(1) suite" link at the
>    bottom. "git help git" is non-obvious and apparently undocumented
>    (it's not mentioned by "git", "git help", or "git help help"...).
>
>  - Because git itself didn't support -h (and thus actually printed less
>    if you specified it), the general availability of -h for commands was
>    non-obvious. I didn't know about it until I started this patch.

Hmm, I feel more confused than convinced after reading the above
three times.  Perhaps that is because I am too used to the way how
"git" potty itself behaves, especially the part that "git help git"
is the way to ask "git" (the first token on the command line) to
give me "help" about "git" (the second) itself.

Having said that, I would agree that "git -h" that shows a "unknown
option" error message that lists the supported command line options
(just like how it reacts to "git -x") is less friendly than "git"
that knows "-h" to show the short help text, and that part of the
patch is a definite improvement.  But other than that I do not see
any "significant usablity flow" in it.

The patch seems to do a lot more than just teaching "git" to react
to "-h" to give a short usage, instead of doing the generic "I do
not know -h option" thing.  I am not sure what merit these other
changes of this patch have.

In the introductory part, you list three possibilities, but there is
the fourth "git help help" to ask "git" to give me "help" about
"help".  Depending on where one comes from, that may also seem just
as odd as "git help git" (again, I personally find neither is odd,
though). Would this change help with that "usability flaw" as well?

Undecided...
