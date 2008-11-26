From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] Add / command in add --patch (feature request)
Date: Wed, 26 Nov 2008 17:38:58 -0500
Message-ID: <20081126223858.GB10786@coredump.intra.peff.net>
References: <492DB6C8.7010205@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: William Pursell <bill.pursell@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 26 23:40:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5T3V-0003fj-R6
	for gcvg-git-2@gmane.org; Wed, 26 Nov 2008 23:40:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752167AbYKZWjF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Nov 2008 17:39:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752121AbYKZWjE
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Nov 2008 17:39:04 -0500
Received: from peff.net ([208.65.91.99]:4738 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752028AbYKZWjD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Nov 2008 17:39:03 -0500
Received: (qmail 21208 invoked by uid 111); 26 Nov 2008 22:38:59 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 26 Nov 2008 17:38:59 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 26 Nov 2008 17:38:58 -0500
Content-Disposition: inline
In-Reply-To: <492DB6C8.7010205@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101780>

On Wed, Nov 26, 2008 at 08:51:20PM +0000, William Pursell wrote:

> This is naive, and it is easy for an invalid
> search string to cause a perl error.
> [...]
> +			if( $text !~ $search_s ) {

Yeah, a bad regex will cause the whole program to barf. Maybe wrap it in
an eval, like this?

  my $r = eval { $text !~ $search_s };
  if ($@) {
    print STDERR "error in search string: $@\n";
    next;
  }
  if ($r) {
    ...

Or similar (I didn't look at the code closely enough to know if "next"
is the right thing there).

-Peff
