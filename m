From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] date.c: Parse timezone with colon as separator
Date: Tue, 6 Sep 2011 16:24:40 -0400
Message-ID: <20110906202440.GD14554@sigill.intra.peff.net>
References: <1315320996-1997-1-git-send-email-lihaitao@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: Haitao Li <lihaitao@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 06 22:24:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R12CO-000341-S2
	for gcvg-git-2@lo.gmane.org; Tue, 06 Sep 2011 22:24:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755060Ab1IFUYo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Sep 2011 16:24:44 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:53491
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754907Ab1IFUYm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Sep 2011 16:24:42 -0400
Received: (qmail 28786 invoked by uid 107); 6 Sep 2011 20:25:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 06 Sep 2011 16:25:31 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 06 Sep 2011 16:24:40 -0400
Content-Disposition: inline
In-Reply-To: <1315320996-1997-1-git-send-email-lihaitao@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180831>

On Tue, Sep 06, 2011 at 10:56:36PM +0800, Haitao Li wrote:

> Timezone designators including additional separator (`:`) are ignored.
> Actually zone designators in below formats are all valid according to
> ISO8601:2004, section 4.3.2:
>     [+-]hh, [+-]hhmm, [+-]hh:mm

That seems like a sensible list to support, given that it is part of
iso8601 (though I was a little surprised after reading your subject
line, which would probably be better as "support iso8601 timezone
formats").

> ---
>  date.c |   14 ++++++++++----
>  1 files changed, 10 insertions(+), 4 deletions(-)

We should probably have new tests, too. I was going to suggest squashing
in the ones below, but your patch doesn't seem to work with the first
one:

diff --git a/t/t0006-date.sh b/t/t0006-date.sh
index f87abb5..9b326cd 100755
--- a/t/t0006-date.sh
+++ b/t/t0006-date.sh
@@ -40,6 +40,8 @@ check_parse 2008-02 bad
 check_parse 2008-02-14 bad
 check_parse '2008-02-14 20:30:45' '2008-02-14 20:30:45 +0000'
 check_parse '2008-02-14 20:30:45 -0500' '2008-02-14 20:30:45 -0500'
+check_parse '2008-02-14 20:30:45 -05' '2008-02-14 20:30:45 -0500'
+check_parse '2008-02-14 20:30:45 -05:00' '2008-02-14 20:30:45 -0500'
 check_parse '2008-02-14 20:30:45' '2008-02-14 20:30:45 -0500' EST5
 
 check_approxidate() {

If I am reading your commit message correctly, that should work, right?

-Peff
