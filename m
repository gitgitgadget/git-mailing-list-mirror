From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] cvsimport: new -R option: generate revision-to-commit
 mapping
Date: Sun, 31 Jan 2010 08:24:49 -0500
Message-ID: <20100131132449.GA29470@coredump.intra.peff.net>
References: <bc341e101001310443x18e02281i2e4d18334ead700b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Aaron Crane <git@aaroncrane.co.uk>
X-From: git-owner@vger.kernel.org Sun Jan 31 14:27:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NbZqI-0004zo-5Q
	for gcvg-git-2@lo.gmane.org; Sun, 31 Jan 2010 14:27:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753556Ab0AaNYy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Jan 2010 08:24:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753484Ab0AaNYx
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Jan 2010 08:24:53 -0500
Received: from peff.net ([208.65.91.99]:55791 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753425Ab0AaNYx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jan 2010 08:24:53 -0500
Received: (qmail 4070 invoked by uid 107); 31 Jan 2010 13:24:54 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 31 Jan 2010 08:24:54 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 31 Jan 2010 08:24:49 -0500
Content-Disposition: inline
In-Reply-To: <bc341e101001310443x18e02281i2e4d18334ead700b@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138544>

On Sun, Jan 31, 2010 at 12:43:44PM +0000, Aaron Crane wrote:

> Signed-off-by: Aaron Crane <git@aaroncrane.co.uk>
> ---

Please put a bit of the rationale into the commit message. Even a
sentence or two can help later on when somebody is reading the output of
"git log".

>  Documentation/git-cvsimport.txt |   15 ++++++++++++++-
>  git-cvsimport.perl              |   20 ++++++++++++++++----
>  2 files changed, 30 insertions(+), 5 deletions(-)

A basic test would be nice. You should be able to just use your new "-R"
during the import in t9600, and then check that it generated the correct
mapping.

> +-R <revision-to-commit-file>::
> +	Generate a file containing a mapping from CVS revision numbers to
> +	newly-created Git commit IDs.  The generated file will contain one
> +	line for each (filename, revision) pair found by 'cvsps'; each line
> +	will look like

Is mentioning 'cvsps' right here?  cvsps doesn't know about git commit
id's.

> +open my $revision_map, '>', $opt_R
> +    or die "Can't open -R file $opt_R: $!\n"
> +	if defined $opt_R;

You need to use munge_user_filename here to handle relative paths. See
commit f6fdbb6.

Also, should you perhaps be appending to the file instead of truncating
it? Remember that cvsimport can be used incrementally. I wonder if it
would be better to simply have "-R" without an argument to append the
revision map to a file .git/cvs-revisions or something. And then the
user can easily pull it from there after the import.

-Peff
