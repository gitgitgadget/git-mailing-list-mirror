From: tytso@mit.edu
Subject: Re: [PATCH] guilt: Make sure the commit time is increasing
Date: Sun, 4 Jul 2010 22:51:17 -0400
Message-ID: <20100705025117.GC6384@thunk.org>
References: <1278296639-25024-1-git-send-email-tytso@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: jeffpc@josefsipek.net
X-From: git-owner@vger.kernel.org Mon Jul 05 04:51:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OVbmK-0002zg-8T
	for gcvg-git-2@lo.gmane.org; Mon, 05 Jul 2010 04:51:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754608Ab0GECvU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Jul 2010 22:51:20 -0400
Received: from THUNK.ORG ([69.25.196.29]:51878 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753292Ab0GECvT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Jul 2010 22:51:19 -0400
Received: from root (helo=closure.thunk.org)
	by thunker.thunk.org with local-esmtp   (Exim 4.50 #1 (Debian))
	id 1OVbmA-0000l6-Qw; Sun, 04 Jul 2010 22:51:18 -0400
Received: from tytso by closure.thunk.org with local (Exim 4.71)
	(envelope-from <tytso@thunk.org>)
	id 1OVbm9-0006dS-O5; Sun, 04 Jul 2010 22:51:17 -0400
Content-Disposition: inline
In-Reply-To: <1278296639-25024-1-git-send-email-tytso@mit.edu>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150237>

On Sun, Jul 04, 2010 at 10:23:59PM -0400, Theodore Ts'o wrote:
> +		ct=$(git log -1 --pretty=%ct)
> +		if [ $ct -gt $(stat -c %Y "$p") ]; then
> +		    echo "Warning time went backwards, adjusting mod time of" \
> +			$(basename "$p")
> +		    touch -d @$(expr $ct + 60) "$p" || touch "$p"
                                                    ^^^^^^^^^^^^^

hmm, I just realized, this is strictly speaking not necessary.

"stat -c %Y" means that guilt only works if GNU coreutils is
installed, which means that "touch -d @secs-since-epoch" should also
work.

This will be a problem on legacy systems such as Solaris (unless their
path puts the GNU utilities head of their System V-style utilities),
but that's going to be true of guilt in general, it looks like.

      	    	    	     	      - Ted
