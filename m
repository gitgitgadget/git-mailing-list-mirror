From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [updated PATCH] Same default as cvsimport when using
 --use-log-author
Date: Sun, 27 Apr 2008 13:47:07 -0700
Message-ID: <7vbq3vf2k4.fsf@gitster.siamese.dyndns.org>
References: <20080427173246.10023.5687.stgit@aristoteles.cuci.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
To: "Stephen R. van den Berg" <srb@cuci.nl>
X-From: git-owner@vger.kernel.org Sun Apr 27 22:48:06 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqDn3-0004O4-Ct
	for gcvg-git-2@gmane.org; Sun, 27 Apr 2008 22:48:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761527AbYD0UrR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Apr 2008 16:47:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758361AbYD0UrR
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Apr 2008 16:47:17 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:64428 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752130AbYD0UrQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Apr 2008 16:47:16 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 8CD8D339C;
	Sun, 27 Apr 2008 16:47:13 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id D4053339A; Sun, 27 Apr 2008 16:47:09 -0400 (EDT)
In-Reply-To: <20080427173246.10023.5687.stgit@aristoteles.cuci.nl> (Stephen
 R. van den Berg's message of "Sun, 27 Apr 2008 19:32:46 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80486>

"Stephen R. van den Berg" <srb@cuci.nl> writes:

> git-svn supports an experimental option --use-log-author which currently
> results in:
>
> Author: foobaruser <unknown>

I have a question about this.  Is the "<unknown> coming from...

> This patches harmonises the result with cvsimport, and makes
> git-svn --use-log-author produce:
>
> Author: foobaruser <foobaruser>
> ...
> diff --git a/git-svn.perl b/git-svn.perl
> index b151049..846e739 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -2434,6 +2434,9 @@ sub make_log_entry {
>  		} else {
>  			($name, $email) = ($name_field, 'unknown');
>  		}

... this 'unknown' we see here?

> +	        if (!defined $email) {
> +		    $email = $name;
> +	        }
>  	}

I would think not -- if that is the case, the codepath you added as a fix
would not trigger.  Which means in some other cases, the 'unknown' we see
above in the context also still happens.  Is it a good thing?  Maybe we
would also want to make it consistently do "somebody <somebody>" instead,
by doing...

	} else {
		$name = $name_field;
	}
        if (!defined $email) {
	    $email = $name;
        }
