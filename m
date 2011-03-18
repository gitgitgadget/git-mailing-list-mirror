From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] rev-list --min-parents,--max-parents: doc and test
 and completion
Date: Fri, 18 Mar 2011 15:48:02 -0400
Message-ID: <20110318194802.GB27825@sigill.intra.peff.net>
References: <cover.1300459016.git.git@drmicha.warpmail.net>
 <182c5ece22835559a9762e242adb701547cf6575.1300459017.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Mar 18 20:48:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0fef-00078N-0Y
	for gcvg-git-2@lo.gmane.org; Fri, 18 Mar 2011 20:48:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757410Ab1CRTsI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Mar 2011 15:48:08 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:41440
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755674Ab1CRTsG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Mar 2011 15:48:06 -0400
Received: (qmail 5502 invoked by uid 107); 18 Mar 2011 19:48:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 18 Mar 2011 15:48:40 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 18 Mar 2011 15:48:02 -0400
Content-Disposition: inline
In-Reply-To: <182c5ece22835559a9762e242adb701547cf6575.1300459017.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169351>

On Fri, Mar 18, 2011 at 03:50:25PM +0100, Michael J Gruber wrote:

> +--min-parents::
> +--max-parents::
> +
> +	Show only commits which have at least resp. at most that many
> +	commits, where `--max-parents=8` denotes infinity (i.e. no upper
> +	limit). In fact, 7 (or any negative number) does, but 8 is
> +	infinity sideways 8-)

I didn't quite parse this "resp." in the middle.

> ++
> +In particular, `--max-parents=1` is `--no-merges`, `--min-parents=2` is
> +`--merges` (only), `--max-parents=0` gives all root commits and
> +`--min-parents=3` all octopusses.

Spelling nit: the plural of octopus is "octopuses" (or "octopi" or
"octopodes", depending on which dictionary you consult).

I think it's good to equate --{no-,}merges with their
--{max,min}-parents counterparts here. We should probably do the same
for the reverse association, like:

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index fcc4c6c..f32509a 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -226,11 +226,13 @@ endif::git-rev-list[]
 
 --merges::
 
-	Print only merge commits.
+	Print only merge commits. This is equivalent to
+	`--min-parents=2`.
 
 --no-merges::
 
-	Do not print commits with more than one parent.
+	Do not print commits with more than one parent. This is
+	equivalent to `--max-parents=1`.
 
 --min-parents::
 --max-parents::

That way it is obvious that "--merges" cancels a previous --min-parents
on the command line (maybe the text should be "this is an alias for..."
to make it clear that doing it is exactly the same).

This provides a user-friendly form for the two common cases. Do we care
about the other cases, or adding a single multi-state flag like
--show-parents={all,merges,etc}? They other ones are rare enough and
particular enough that it is probably fine for people to just use
{min,max}-parents directly. So I would say what you have is good.

-Peff
