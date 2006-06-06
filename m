From: Dennis Stosberg <dennis@stosberg.net>
Subject: Re: [PATCH] git-format-patch: add --output-directory long option again
Date: Tue, 6 Jun 2006 20:22:07 +0200
Message-ID: <20060606182206.G36caaa7f@leonov.stosberg.net>
References: <20060606141946.G59b8a1fd@leonov.stosberg.net> <7vwtbuthgw.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 06 20:22:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FngC1-0003pu-24
	for gcvg-git@gmane.org; Tue, 06 Jun 2006 20:22:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750789AbWFFSWO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Jun 2006 14:22:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750796AbWFFSWN
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jun 2006 14:22:13 -0400
Received: from ncs.stosberg.net ([89.110.145.104]:21391 "EHLO ncs.stosberg.net")
	by vger.kernel.org with ESMTP id S1750789AbWFFSWN (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Jun 2006 14:22:13 -0400
Received: from leonov.stosberg.net (p213.54.78.77.tisdip.tiscali.de [213.54.78.77])
	by ncs.stosberg.net (Postfix) with ESMTP id EFC90AEBA005;
	Tue,  6 Jun 2006 20:22:01 +0200 (CEST)
Received: by leonov.stosberg.net (Postfix, from userid 500)
	id B4CC5108247; Tue,  6 Jun 2006 20:22:07 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vwtbuthgw.fsf@assigned-by-dhcp.cox.net>
OpenPGP: id=1B2F2863BA13A814C3B133DACC2811F494951CAB; url=http://stosberg.net/dennis.asc
User-Agent: mutt-ng/devel-r802 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21392>

Junio C Hamano wrote:

> > +	if (output_directory && !stdout) {
> > +		if (mkdir(output_directory, 0777) < 0 && errno != EEXIST)
> > +			die("Could not create directory %s",
> > +			    output_directory);
> > +	}
> > +
> 
> This code couldn't have been tested -- you meant to say
> "use_stdout" here, not "stdout".

Sorry.  My version compiled and ran cleanly, but I was blinded by my
goal: I wanted the directory to be _not_ created and checked that,
but I didn't make sure, that the directory really existed in the
other case, since Git didn't produce an error.
 
> How about this instead?
> [...]
> +	if (output_directory) {
> +		if (use_stdout)
> +			die("standard output, or directory, which one?");

Looks good.  This piece changes behaviour; it no longer matches the
docs.

Regards,
Dennis

---
 Documentation/git-format-patch.txt |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 493cac2..4ca0014 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -40,8 +40,7 @@ OPTIONS
 -------
 -o|--output-directory <dir>::
 	Use <dir> to store the resulting files, instead of the
-	current working directory. This option is ignored if
-	--stdout is specified.
+	current working directory.
 
 -n|--numbered::
 	Name output in '[PATCH n/m]' format.
