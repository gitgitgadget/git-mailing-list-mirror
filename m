From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] gitk: refresh the index before running diff-files
Date: Sun, 30 Sep 2012 10:05:27 +1000
Message-ID: <20120930000527.GB4852@bloggs.ozlabs.ibm.com>
References: <CAEkqydxRy3ukSWyQ53Tiosq+DMWWLG=AVuZk+Jm79Y5SaRmeDw@mail.gmail.com>
 <20120928202330.GA5770@sigill.intra.peff.net>
 <20120928205054.GA5985@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Scott Batchelor <scott.batchelor@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Sep 30 02:05:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TI72f-0006YG-62
	for gcvg-git-2@plane.gmane.org; Sun, 30 Sep 2012 02:05:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751988Ab2I3AFS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Sep 2012 20:05:18 -0400
Received: from ozlabs.org ([203.10.76.45]:52160 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751965Ab2I3AFR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Sep 2012 20:05:17 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id C11C22C00D6; Sun, 30 Sep 2012 10:05:14 +1000 (EST)
Content-Disposition: inline
In-Reply-To: <20120928205054.GA5985@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206661>

On Fri, Sep 28, 2012 at 04:50:54PM -0400, Jeff King wrote:

> +proc refresh_index {} {
> +    global need_index_refresh
> +    if { $need_index_refresh } {
> +	exec sh -c "git update-index --refresh >/dev/null 2>&1 || true"
> +	set need_index_refresh false
> +    }
> +}

Unfortunately this will wait for the git update-index command to
complete, making the GUI unresponsive while it executes, and that can
take minutes on a large repository (e.g. the linux kernel) on a
machine with a slow disk and a cold disk cache.  We will need to make
the git update-index execute asynchronously.

Paul.
