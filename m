From: Jeff King <peff@peff.net>
Subject: [PATCH v2 0/12] implement @{push} shorthand
Date: Fri, 1 May 2015 18:44:15 -0400
Message-ID: <20150501224414.GA25551@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 02 00:44:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YoJfS-0004cf-0A
	for gcvg-git-2@plane.gmane.org; Sat, 02 May 2015 00:44:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751298AbbEAWoR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 May 2015 18:44:17 -0400
Received: from cloud.peff.net ([50.56.180.127]:53091 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751294AbbEAWoR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 May 2015 18:44:17 -0400
Received: (qmail 23088 invoked by uid 102); 1 May 2015 22:44:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 01 May 2015 17:44:17 -0500
Received: (qmail 20915 invoked by uid 107); 1 May 2015 22:44:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 01 May 2015 18:44:47 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 01 May 2015 18:44:15 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268185>

This is a re-roll of the series at:

  http://thread.gmane.org/gmane.comp.version-control.git/266532

There were some minor fixes in response to review, but the main change
here is support for "git for-each-ref --format=%(push)". To do that, I
pulled the push logic into remote.[ch], where it can be used from both
sha1_name.c and for-each-ref.c. This is a better place for it to reside,
anyway, and may help in the future unifying it with the other remote
code that is used by `git push`.

In an effort to reuse as much of the @{upstream} code as possible, I did
similar refactoring for that side; we now have branch_get_upstream().
Even though the logic for getting @{upstream} isn't nearly as
complicated as for @{push}, I think several call-sites are improved by
using the new helper.

  [01/12]: remote.c: drop default_remote_name variable
  [02/12]: remote.c: drop "remote" pointer from "struct branch"
  [03/12]: remote.c: hoist branch.*.remote lookup out of remote_get_1
  [04/12]: remote.c: provide per-branch pushremote name
  [05/12]: remote.c: introduce branch_get_upstream helper
  [06/12]: remote.c: report specific errors from branch_get_upstream
  [07/12]: remote.c: add branch_get_push
  [08/12]: sha1_name: refactor upstream_mark
  [09/12]: sha1_name: refactor interpret_upstream_mark
  [10/12]: sha1_name: implement @{push} shorthand
  [11/12]: for-each-ref: use skip_prefix instead of starts_with
  [12/12]: for-each-ref: accept "%(push)" format

-Peff
