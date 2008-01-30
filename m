From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/7] Use 'printf %s $x' notation in t5401
Date: Tue, 29 Jan 2008 22:40:37 -0800
Message-ID: <7vlk67izoa.fsf@gitster.siamese.dyndns.org>
References: <20080130062156.GA15838@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Jan 30 07:41:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JK6db-00053p-Vx
	for gcvg-git-2@gmane.org; Wed, 30 Jan 2008 07:41:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752900AbYA3GlE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jan 2008 01:41:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752383AbYA3GlE
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jan 2008 01:41:04 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:52635 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751142AbYA3GlB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jan 2008 01:41:01 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 2DD6E2E18;
	Wed, 30 Jan 2008 01:40:59 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 900B72E0A;
	Wed, 30 Jan 2008 01:40:54 -0500 (EST)
In-Reply-To: <20080130062156.GA15838@spearce.org> (Shawn O. Pearce's message
	of "Wed, 30 Jan 2008 01:21:56 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72038>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> We only care about getting what should be an empty string and
> sending it to a file, without a trailing LF, so the empty string
> translates into a 0 byte file.  Earlier when I originally wrote
> these lines Mac OS X allowed the format string of printf to be
> the empty string, but more recent versions appear to have been
> 'improved' with error messages if the format is not given.

That sounds like a bug to me.

> diff --git a/t/t5401-update-hooks.sh b/t/t5401-update-hooks.sh
> index 3eea306..9734fc5 100755
> --- a/t/t5401-update-hooks.sh
> +++ b/t/t5401-update-hooks.sh
> @@ -25,7 +25,7 @@ test_expect_success setup '
>  
>  cat >victim/.git/hooks/pre-receive <<'EOF'
>  #!/bin/sh
> -printf "$@" >>$GIT_DIR/pre-receive.args
> +printf %s "$@" >>$GIT_DIR/pre-receive.args

Do you really mean this? "printf %s 1 2 3" writes "123" without
terminating LF.  You seem to check only for size but to be
reusable you might want to use something like:

	printf '%s\n' "$@"

Likewise for post-receive.args.
