From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] mergetool: respect autocrlf by using checkout-index
Date: Fri, 23 Jan 2009 09:20:10 -0800
Message-ID: <7v1vuuvt11.fsf@gitster.siamese.dyndns.org>
References: <20090121210348.GD9088@mit.edu>
 <1232578668-2203-1-git-send-email-charles@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Hannu Koivisto <azure@iki.fi>,
	Theodore Tso <tytso@mit.edu>
To: Charles Bailey <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Fri Jan 23 18:21:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQPiz-0002fT-Np
	for gcvg-git-2@gmane.org; Fri, 23 Jan 2009 18:21:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752381AbZAWRUV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2009 12:20:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751745AbZAWRUV
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jan 2009 12:20:21 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:44040 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751102AbZAWRUV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2009 12:20:21 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id D122293CC1;
	Fri, 23 Jan 2009 12:20:18 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 941EE93CBB; Fri,
 23 Jan 2009 12:20:12 -0500 (EST)
In-Reply-To: <1232578668-2203-1-git-send-email-charles@hashpling.org>
 (Charles Bailey's message of "Wed, 21 Jan 2009 22:57:48 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 1B87D664-E972-11DD-965C-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106891>

Charles Bailey <charles@hashpling.org> writes:

> Previously, git mergetool used cat-file which does not perform git to
> worktree conversion. This changes mergetool to use git checkout-index
> instead which means that the temporary files used for mergetool use the
> correct line endings for the platform.
>
> Signed-off-by: Charles Bailey <charles@hashpling.org>

Sounds like the right thing to do and from a cursory review it looks Ok to
me.

But I do not use mergetool myself, so an Ack from Ted and a Thanks from
whoever reported the breakage would be encouraging ;-).

> +checkout_staged_file () {
> +    tmpfile=$(expr "$(git checkout-index --temp --stage="$1" "$2")" : '\([^	]*\)	')
> +
> +    if test $? -eq 0 -a -n "$tmpfile" ; then
> +	mv -- "$tmpfile" "$3"

The original redirects into the final destination but this moves.  This
will lose the perm bits of the original and obey the perm bits
checkout-index gives you.  It will also behave differently when the path
is a symlink.  These two differences _may_ well be improvements and/or
bugfixes, but if that is the case please describe them as such.
