From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] t1506: more test for @{upstream} syntax
Date: Thu, 28 Jan 2010 03:52:18 -0500
Message-ID: <20100128085218.GE9071@coredump.intra.peff.net>
References: <1263980322-4142-1-git-send-email-gitster@pobox.com>
 <1263980322-4142-2-git-send-email-gitster@pobox.com>
 <20100126130745.GB28179@coredump.intra.peff.net>
 <7vockgzliv.fsf@alter.siamese.dyndns.org>
 <20100127102417.GD6262@coredump.intra.peff.net>
 <7viqanqt5s.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 28 09:52:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NaQ73-0004yh-If
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jan 2010 09:52:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755950Ab0A1IwY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jan 2010 03:52:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755931Ab0A1IwY
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jan 2010 03:52:24 -0500
Received: from peff.net ([208.65.91.99]:41657 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753192Ab0A1IwY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jan 2010 03:52:24 -0500
Received: (qmail 20503 invoked by uid 107); 28 Jan 2010 08:52:24 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 28 Jan 2010 03:52:24 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 28 Jan 2010 03:52:18 -0500
Content-Disposition: inline
In-Reply-To: <7viqanqt5s.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138229>

On Wed, Jan 27, 2010 at 10:50:07AM -0800, Junio C Hamano wrote:

> > A minor nit, but wouldn't:
> >
> >   int approxidate_careful(const char *str, unsigned long *out);
> >
> > returning an error code be the more usual pattern for a function with
> > error-plus-output (your approxidate wrapper would have to be a function then,
> > not a macro)?
> 
> I don't have strong preference either way; the one in the patch was
> modelled after setup_git_directory_gently(&nongit_ok), and slightly easier
> to work with for existing callers that don't care enough.

Looks like you have already pushed out the original patch, so let's not
worry about it.

> >> +test_expect_success '@{30.years.ago} shows old' '
> >> +	check_at @{30.years.ago} one
> >
> > Side note: I chose this because we needed to go back from the current
> > time beyond where test_tick would place the commit. Which means this
> > test has a 2035 bug. :)
> 
> Can't we use an absolute date, given that test_tick gives fixed timestamp
> sequence to pretend as if we were still in 2005 when we are running these
> tests?
> [...]
> --- a/t/t0101-at-syntax.sh
> +++ b/t/t0101-at-syntax.sh
> @@ -26,8 +26,8 @@ test_expect_success '@{now} shows current' '
>  	check_at @{now} two
>  '
>  
> -test_expect_success '@{30.years.ago} shows old' '
> -	check_at @{30.years.ago} one
> +test_expect_success '@{2001-09-17} (before the first commit) shows old' '
> +	check_at @{2001-09-17} one
>  '
>  
>  test_expect_success 'silly approxidates work' '

Yes, I don't know why I was so concerned with using a relative
approxidate when an absolute one would suffice. However, we should make
a matching change in the silly approxidate entry, too. Like this:

-- >8 --
Subject: [PATCH] t0101: use absolute date

The original version used relative approxidates, which don't
reproduce as reliably as absolute ones. Commit 6c647a fixed
this for one case, but missed the "silly" case.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t0101-at-syntax.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t0101-at-syntax.sh b/t/t0101-at-syntax.sh
index 5e298c5..a1998b5 100755
--- a/t/t0101-at-syntax.sh
+++ b/t/t0101-at-syntax.sh
@@ -31,7 +31,7 @@ test_expect_success '@{2001-09-17} (before the first commit) shows old' '
 '
 
 test_expect_success 'silly approxidates work' '
-	check_at @{3.hot.dogs.and.30.years.ago} one
+	check_at @{3.hot.dogs.on.2001-09-17} one
 '
 
 test_expect_success 'notice misspelled upstream' '
