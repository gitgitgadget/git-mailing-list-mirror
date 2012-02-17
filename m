From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/8] config-include fixes
Date: Thu, 16 Feb 2012 22:17:23 -0500
Message-ID: <20120217031723.GA5738@sigill.intra.peff.net>
References: <7v4nuuea7r.fsf@alter.siamese.dyndns.org>
 <20120214214729.GA24711@sigill.intra.peff.net>
 <7vmx8l5aw3.fsf@alter.siamese.dyndns.org>
 <20120214220953.GC24802@sigill.intra.peff.net>
 <20120216080102.GA11793@sigill.intra.peff.net>
 <7v1upuzgfr.fsf@alter.siamese.dyndns.org>
 <20120217001438.GD4756@sigill.intra.peff.net>
 <7vty2quq9r.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 17 04:17:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RyEKC-0002ei-36
	for gcvg-git-2@plane.gmane.org; Fri, 17 Feb 2012 04:17:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752708Ab2BQDR1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Feb 2012 22:17:27 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:38901
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752037Ab2BQDR0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Feb 2012 22:17:26 -0500
Received: (qmail 3292 invoked by uid 107); 17 Feb 2012 03:24:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 16 Feb 2012 22:24:37 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Feb 2012 22:17:23 -0500
Content-Disposition: inline
In-Reply-To: <7vty2quq9r.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190933>

On Thu, Feb 16, 2012 at 06:50:40PM -0800, Junio C Hamano wrote:

> I'll push out the re-roll that follows your outline above in 'pu'; I think
> I got all the conflict resolved correctly, but please eyeball the result.

Will do.

Since you are re-rolling, these are the documentation fixes I had
squashed in based on your earlier review (though come to think of it,
the new patches should now also describe `git_config_with_options`).

---
diff --git a/Documentation/technical/api-config.txt b/Documentation/technical/api-config.txt
index f428c5c..01f64d1 100644
--- a/Documentation/technical/api-config.txt
+++ b/Documentation/technical/api-config.txt
@@ -11,9 +11,9 @@ General Usage
 Config files are parsed linearly, and each variable found is passed to a
 caller-provided callback function. The callback function is responsible
 for any actions to be taken on the config option, and is free to ignore
-some options (it is not uncommon for the configuration to be parsed
+some options. It is not uncommon for the configuration to be parsed
 several times during the run of a git program, with different callbacks
-picking out different variables useful to themselves).
+picking out different variables useful to themselves.
 
 A config callback function takes three parameters:
 
@@ -47,11 +47,12 @@ will first feed the user-wide one to the callback, and then the
 repo-specific one; by overwriting, the higher-priority repo-specific
 value is left at the end).
 
-There is a special version of `git_config` called `git_config_early`
-that takes an additional parameter to specify the repository config.
-This should be used early in a git program when the repository location
-has not yet been determined (and calling the usual lazy-evaluation
-lookup rules would yield an incorrect location).
+There is a special version of `git_config` called `git_config_early`.
+This version takes an additional parameter to specify the repository
+config, instead of having it looked up via `git_path`. This is useful
+early in a git program before the repository has been found. Unless
+you're working with early setup code, you probably don't want to use
+this.
 
 Reading Specific Files
 ----------------------
