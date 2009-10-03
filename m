From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Fix '--relative-date'
Date: Sat, 3 Oct 2009 06:06:15 -0400
Message-ID: <20091003100615.GC17873@coredump.intra.peff.net>
References: <1254543618-3772-1-git-send-email-j416@1616.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Johan Sageryd <j416@1616.se>
X-From: git-owner@vger.kernel.org Sat Oct 03 12:06:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mu1VU-0003Gp-6m
	for gcvg-git-2@lo.gmane.org; Sat, 03 Oct 2009 12:06:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754430AbZJCKGT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Oct 2009 06:06:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751390AbZJCKGS
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Oct 2009 06:06:18 -0400
Received: from peff.net ([208.65.91.99]:49067 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751349AbZJCKGS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Oct 2009 06:06:18 -0400
Received: (qmail 2843 invoked by uid 107); 3 Oct 2009 10:09:48 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 03 Oct 2009 06:09:48 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 03 Oct 2009 06:06:15 -0400
Content-Disposition: inline
In-Reply-To: <1254543618-3772-1-git-send-email-j416@1616.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129482>

On Sat, Oct 03, 2009 at 01:20:18PM +0900, Johan Sageryd wrote:

> This fixes '--relative-date' so that it does not give '0 year, 12
> months', for the interval 360 <= diff < 365.

Thanks. I think this was a regression introduced recently when we fixed
the rounding on how years are printed (it used to just say "1 year"
because we were close, but now we always round down, so our boundary for
"1 year" must match exactly).

I've picked up your patch in my tree with the following test squashed
in:

diff --git a/t/t0006-date.sh b/t/t0006-date.sh
index a4d8fa8..75b02af 100755
--- a/t/t0006-date.sh
+++ b/t/t0006-date.sh
@@ -24,6 +24,7 @@ check_show 13000000 '5 months ago'
 check_show 37500000 '1 year, 2 months ago'
 check_show 55188000 '1 year, 9 months ago'
 check_show 630000000 '20 years ago'
+check_show 31449600 '12 months ago'
 
 check_parse() {
 	echo "$1 -> $2" >expect

-Peff
