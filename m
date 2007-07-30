From: Eric Wong <normalperson@yhbt.net>
Subject: Re: (Resend)[PATCH] git-svn: Translate invalid characters in refname
Date: Mon, 30 Jul 2007 12:29:30 -0700
Message-ID: <20070730192929.GB9764@hand.yhbt.net>
References: <f8k9q5$927$1@sea.gmane.org> <7v6442kxvu.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robert Ewald <robert.ewald@nov.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 30 21:29:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFaw1-0002pk-CB
	for gcvg-git@gmane.org; Mon, 30 Jul 2007 21:29:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762598AbXG3T3c (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Jul 2007 15:29:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761525AbXG3T3c
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jul 2007 15:29:32 -0400
Received: from hand.yhbt.net ([66.150.188.102]:50567 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763076AbXG3T3b (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2007 15:29:31 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id A5E082DC08D;
	Mon, 30 Jul 2007 12:29:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7v6442kxvu.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54254>

Junio C Hamano <gitster@pobox.com> wrote:
> Robert Ewald <robert.ewald@nov.com> writes:
> 
> > +sub refname {
> > +        my ($refname) = "refs/remotes/$_[0]->{ref_id}" ;
> > +
> > +        # It cannot end with a slash /, we'll throw up on this because
> > +        # SVN can't have directories with a slash in their name, either:
> > +        if ($refname =~ m{/$}) {
> > +                die "ref: '$refname' ends with a trailing slash, this is ",
> > +                    "not permitted by git nor Subversion\n";
> > +        }
> > +
> > +        # It cannot have ASCII control character space, tilde ~, caret ^,
> > +        # colon :, question-mark ?, asterisk *, space, or open bracket [
> > +        # anywhere.
> > +        #
> > +        # Additionally, % must be escaped because it is used for escaping
> > +        # and we want our escaped refname to be reversible
> > +        $refname =~ s{([ \%~\^:\?\*\[\t])}{uc sprintf('%%%02x',ord($1))}eg;
> 
> uc of sprintf()?  You meant "%%%02X"?

Ah, I wasn't sure if X was portable enough, but then again this sprintf
is in Perl.

> Other than that, looks sane to me.  I presume that SVN branches
> whose name would be mangled with this patch would not have been
> successfully imported with older git-svn anyway, so this won't
> introduce any regressions?

Seems alright to me, I haven't had a chance to look at it too hard.  I'm
out of town and haven't been following the mailing list lately.

Acked-by: Eric Wong <normalperson@yhbt.net>

-- 
Eric Wong
