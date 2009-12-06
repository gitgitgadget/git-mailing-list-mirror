From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Allow --quiet option to git remote, particularly for
 `git remote update`
Date: Sun, 6 Dec 2009 09:50:00 -0500
Message-ID: <20091206145000.GC26440@coredump.intra.peff.net>
References: <1260057623-28960-1-git-send-email-alex@chmrr.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Alex Vandiver <alex@chmrr.net>
X-From: git-owner@vger.kernel.org Sun Dec 06 15:50:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHIRE-0003MX-Ag
	for gcvg-git-2@lo.gmane.org; Sun, 06 Dec 2009 15:50:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933765AbZLFOt5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Dec 2009 09:49:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933759AbZLFOt4
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Dec 2009 09:49:56 -0500
Received: from peff.net ([208.65.91.99]:34024 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933737AbZLFOtz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Dec 2009 09:49:55 -0500
Received: (qmail 30335 invoked by uid 107); 6 Dec 2009 14:54:31 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 06 Dec 2009 09:54:31 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 06 Dec 2009 09:50:00 -0500
Content-Disposition: inline
In-Reply-To: <1260057623-28960-1-git-send-email-alex@chmrr.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134664>

On Sat, Dec 05, 2009 at 07:00:23PM -0500, Alex Vandiver wrote:

> @@ -84,9 +84,12 @@ static int opt_parse_track(const struct option *opt, const char *arg, int not)
>  static int fetch_remote(const char *name)
>  {
>  	const char *argv[] = { "fetch", name, NULL, NULL };
> -	if (verbose) {
> +	if (verbosity > 0) {
>  		argv[1] = "-v";
>  		argv[2] = name;
> +	} else if (verbosity < 0) {
> +		argv[1] = "-q";
> +		argv[2] = name;
>  	}
>  	printf("Updating %s\n", name);

Should --quiet also affect this "Updating %s" line?

Actually, I have often wished for a way to shut up this line but keep
fetch at its normal verbosity.  Fetch very sanely says nothing if there
is nothing to update, but you still get this "Updating" junk line, even
if nothing is transferred. But that would probably need an extra
"--quiet-remote" option to handle separately from what we pass to fetch.

-Peff
