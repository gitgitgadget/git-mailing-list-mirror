From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 1/4] Extract some utilities from git-svn to allow
 extracting Git::SVN.
Date: Wed, 25 Jul 2012 21:24:18 +0000
Message-ID: <20120725212418.GA17494@dcvr.yhbt.net>
References: <1343196066-81319-1-git-send-email-schwern@pobox.com>
 <1343196066-81319-2-git-send-email-schwern@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, robbat2@gentoo.org,
	bwalton@artsci.utoronto.ca, Jonathan Nieder <jrnieder@gmail.com>
To: "Michael G. Schwern" <schwern@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 25 23:24:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Su94D-0005Mq-23
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jul 2012 23:24:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752440Ab2GYVYU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jul 2012 17:24:20 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:39502 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751081Ab2GYVYT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2012 17:24:19 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 74FC11F439;
	Wed, 25 Jul 2012 21:24:18 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1343196066-81319-2-git-send-email-schwern@pobox.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202200>

"Michael G. Schwern" <schwern@pobox.com> wrote:
> From: "Michael G. Schwern" <schwern@pobox.com>
> 
> Put them in a new module called Git::SVN::Utils.  Yeah, not terribly
> original and it will be a dumping ground.  But its better than having
> them in the main git-svn program.  At least they can be documented
> and tested.
> 
> * fatal() is used by many classes.
> * Change the $can_compress lexical into a function.
> 
> This should be enough to extract Git::SVN.

Please keep Jonathan Cc:-ed, he's been very helpful with this series
(and very helpful in general :)

This series is mostly alright by me, a few minor comments inline.

> --- /dev/null
> +++ b/t/Git-SVN/00compile.t
> +
> +use Test::More tests => 1;

> +++ b/t/Git-SVN/Utils/fatal.t
> @@ -0,0 +1,34 @@
> +
> +use Test::More 'no_plan';

Didn't we agree to use done_testing()?   Perhaps (as you suggested) with
a private copy of Test::More?  It's probably easier to start using
done_testing() earlier rather than later.

> +BEGIN {
> +    # Override exit at BEGIN time before Git::SVN::Utils is loaded
> +    # so it will see our local exit later.
> +    *CORE::GLOBAL::exit = sub(;$) {
> +        return @_ ? CORE::exit($_[0]) : CORE::exit();
> +    };
> +}

For new code related to git-svn, please match the existing indentation
style (tabs) prevalent in git-svn.  Most of the Perl found in git also
uses tabs for indentation.
