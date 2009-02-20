From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Expand explanation of the use of + in git push refspecs.
Date: Thu, 19 Feb 2009 21:04:11 -0800
Message-ID: <7viqn5k8c4.fsf@gitster.siamese.dyndns.org>
References: <20090219180258.2C7983360A6@rincewind>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, srabbelier@gmail.com
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Fri Feb 20 06:05:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaNaF-0000Vk-Bo
	for gcvg-git-2@gmane.org; Fri, 20 Feb 2009 06:05:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751094AbZBTFE0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2009 00:04:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751086AbZBTFE0
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Feb 2009 00:04:26 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:39188 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751044AbZBTFEZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2009 00:04:25 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 6B6D09B8D4;
	Fri, 20 Feb 2009 00:04:22 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id DD4719B8D1; Fri,
 20 Feb 2009 00:04:13 -0500 (EST)
In-Reply-To: <20090219180258.2C7983360A6@rincewind> (Marc Branchaud's message
 of "Thu, 19 Feb 2009 12:39:47 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: EFCC0A54-FF0B-11DD-94AA-B26E209B64D9-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110790>

Marc Branchaud <marcnarc@xiplink.com> writes:

> Signed-off-by: Marc Branchaud <marcnarc@xiplink.com>
> ---
>  Documentation/git-push.txt |   40 ++++++++++++++++++++++++++++++++--------
>  1 files changed, 32 insertions(+), 8 deletions(-)
>
> diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
> index 7d1eced..4cb13a1 100644
> --- a/Documentation/git-push.txt
> +++ b/Documentation/git-push.txt
> @@ -50,20 +50,21 @@ updated.
>  +
>  The object referenced by <src> is used to fast forward the ref <dst>
>  on the remote side. If the optional leading plus `{plus}` is used, the
> -remote ref is updated even if it does not result in a fast forward
> -update.
> +remote ref is *overwritten* with the local ref.  (The use of `{plus}`
> +is recommended only for private, unshared repositories.)  See EXAMPLES
> +below for details.

I am of two minds with this.  The understanding of the concept of
fast-forwardness is necessary not just to understand push but also to
understand merge, and if glossary is missing the definition, we should add
one there.  What exactly happens when the <dst> is updated is the same
regardless of ff or non-ff in that the old 40 hexdecimal object name is
gone and replaced with the new one, and it does not feel right to say "if
ff, we update if non-ff you can force to overwrite."  Either way, you
overwrite and there is no trace of the old one.  So we would want to say
something like:

    The name of the object referenced by <src> is used to update the ref
    <dst> on the remote side, but by default this is only allowed if the
    update is fast-forward.  By having the optional leading plus, you can
    tell git to update the ref <dst> even when the update is not a
    fast-forward.

> -The special refspec `:` (or `+:` to allow non-fast forward updates)
> -directs git to push "matching" branches: for every branch that exists on
> -the local side, the remote side is updated if a branch of the same name
> -already exists on the remote side.  This is the default operation mode
> -if no explicit refspec is found (that is neither on the command line
> -nor in any Push line of the corresponding remotes file---see below).
> +The special refspec `:` (or `{plus}:` to allow overwriting) directs git to
> +push "matching" branches: for every branch that exists on the local
> +side, the remote side is updated if a branch of the same name already
> +exists on the remote side.  This is the default operation mode if no
> +explicit refspec is found (that is neither on the command line nor in
> +any Push line of the corresponding remotes file---see below).

I think {plus} change is a good one, but rewording non-ff to overwrite is
not.

Please don't wrap a full paragraph, only to change a few sentences.
AsciiDoc wraps lines for output just fine; it took me a few extra minutes
to make sure there is no other changes.
