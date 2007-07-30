From: Junio C Hamano <gitster@pobox.com>
Subject: Re: (Resend)[PATCH] git-svn: Translate invalid characters in refname
Date: Mon, 30 Jul 2007 03:07:49 -0700
Message-ID: <7v6442kxvu.fsf@assigned-by-dhcp.cox.net>
References: <f8k9q5$927$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
To: Robert Ewald <robert.ewald@nov.com>
X-From: git-owner@vger.kernel.org Mon Jul 30 12:07:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFSAM-0005q7-6f
	for gcvg-git@gmane.org; Mon, 30 Jul 2007 12:07:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752359AbXG3KHv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Jul 2007 06:07:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752394AbXG3KHv
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jul 2007 06:07:51 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:52917 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752283AbXG3KHu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2007 06:07:50 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070730100750.RLMD1428.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Mon, 30 Jul 2007 06:07:50 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Vm7p1X00B1kojtg0000000; Mon, 30 Jul 2007 06:07:50 -0400
In-Reply-To: <f8k9q5$927$1@sea.gmane.org> (Robert Ewald's message of "Mon, 30
	Jul 2007 11:08:21 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54219>

Robert Ewald <robert.ewald@nov.com> writes:

> +sub refname {
> +        my ($refname) = "refs/remotes/$_[0]->{ref_id}" ;
> +
> +        # It cannot end with a slash /, we'll throw up on this because
> +        # SVN can't have directories with a slash in their name, either:
> +        if ($refname =~ m{/$}) {
> +                die "ref: '$refname' ends with a trailing slash, this is ",
> +                    "not permitted by git nor Subversion\n";
> +        }
> +
> +        # It cannot have ASCII control character space, tilde ~, caret ^,
> +        # colon :, question-mark ?, asterisk *, space, or open bracket [
> +        # anywhere.
> +        #
> +        # Additionally, % must be escaped because it is used for escaping
> +        # and we want our escaped refname to be reversible
> +        $refname =~ s{([ \%~\^:\?\*\[\t])}{uc sprintf('%%%02x',ord($1))}eg;

uc of sprintf()?  You meant "%%%02X"?

Other than that, looks sane to me.  I presume that SVN branches
whose name would be mangled with this patch would not have been
successfully imported with older git-svn anyway, so this won't
introduce any regressions?

Eric?
