From: Junio C Hamano <gitster@pobox.com>
Subject: Re: pre-commit hook and Aspell
Date: Fri, 30 Jul 2010 08:59:35 -0700
Message-ID: <7vd3u5rme0.fsf@alter.siamese.dyndns.org>
References: <4C529290.7040509@zbh.uni-hamburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stefan Bienert <bienert@zbh.uni-hamburg.de>
X-From: git-owner@vger.kernel.org Fri Jul 30 18:00:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oes06-0003ko-Ep
	for gcvg-git-2@lo.gmane.org; Fri, 30 Jul 2010 17:59:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752952Ab0G3P7o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jul 2010 11:59:44 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:48417 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752269Ab0G3P7n (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jul 2010 11:59:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 50C4FC7957;
	Fri, 30 Jul 2010 11:59:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TsKDSfVG/I2I4h1E9Fj/4/8pAgA=; b=aVPMGn
	L+pNfFoO0OO64qbxptUXAtKBA7FcRcuGzwGcO4a9/EGykSG1XIYb3CZ/fqoMug9t
	Fz6EOryew4dGh8b45t6+pMTfd53hTI2eDPtmMDMiaPMu50PLuvk0C7BjVmy5ioR6
	LOr66gyHaOT6aYJhxcZd4JwCeuabkUu6SvBOI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=s79aqaVrmmtYih2qVYisIiHCQ5nLbPVQ
	2bggNAlp+lqVzY5RMNwPZq/TK3WraEqRe9DZdxOV8hm7VAGqzArXc1pZdyMNCPoi
	HvTZUEW9WU/V7gBTUSxn4PqBZMlVGA43VXU38t+rPxnxycXSc+PYMMT+AuD1T5WG
	dJQImXVZvW8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 23496C7956;
	Fri, 30 Jul 2010 11:59:40 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7ECA0C7955; Fri, 30 Jul
 2010 11:59:37 -0400 (EDT)
In-Reply-To: <4C529290.7040509@zbh.uni-hamburg.de> (Stefan Bienert's message
 of "Fri\, 30 Jul 2010 10\:51\:28 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 75DC315C-9BF3-11DF-9CEC-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152249>

Stefan Bienert <bienert@zbh.uni-hamburg.de> writes:

> Here is my script (cut down to a minimalist version resembling the problem):
>
> # SNIP
> #!/bin/sh
>
> for my_p in $(git status --porcelain | awk '{ if ($0 ~ /\.(tex|sty)$/) {
> print $2 } }')

A tangent; perhaps "git status --porcelain '*.tex' '*.sty'" would help you
lose the pipe and awk.

> do
>     aspell -c -l en_GB -p $(pwd)/${my_cdup}share/dict/aspell.corb.pws
> $my_p || exit 1

Not quite sure what my-cdup is here, but probably you would want to have
something like this at the top of the script?

	#!/bin/sh
	"cd .."
