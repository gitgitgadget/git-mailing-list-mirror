From: Jeff King <peff@peff.net>
Subject: [PATCH v2 0/10] cleaning up check_repository_format_gently
Date: Fri, 11 Mar 2016 17:36:20 -0500
Message-ID: <20160311223620.GA7963@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: David Turner <dturner@twopensource.com>, pclouds@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 11 23:36:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aeVfY-0003Nl-QZ
	for gcvg-git-2@plane.gmane.org; Fri, 11 Mar 2016 23:36:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932356AbcCKWgZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Mar 2016 17:36:25 -0500
Received: from cloud.peff.net ([50.56.180.127]:58635 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752490AbcCKWgY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Mar 2016 17:36:24 -0500
Received: (qmail 20878 invoked by uid 102); 11 Mar 2016 22:36:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 11 Mar 2016 17:36:23 -0500
Received: (qmail 7398 invoked by uid 107); 11 Mar 2016 22:36:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 11 Mar 2016 17:36:38 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 11 Mar 2016 17:36:20 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288707>

This is a re-roll of:

  http://article.gmane.org/gmane.comp.version-control.git/288017

The changes from v1 are:

  - dropped original 10/10 that got rid of GIT_REPO_VERSION defines
    (David mentioned that he's going to be expanding their use, so the
    argument that they are not used does not make sense)

  - added new 10/10 marking messages for translation (suggested by Duy)

  - added int return value to new read_repository_format(); this is
    redundant with the error value returned in the struct, but allows a
    more idiomatic:

      if (read_repository_format(&format, file) < 0)
         ...

  - drop confusing comment from 06/10, in favor of a better explanation
    in the commit message

  - fixed newline regression from v1 when printing out unknown
    extensions. Note that because we switch from looping over warning()
    or die() to sticking errors into a strbuf (which the caller then
    feeds to warning/die), the format changed a bit.  Naively, it would
    become:

      warning: unknown extension: foo
      unknown:extension: bar

    but I turned it into the more pleasant:

      warning: unknown repository extensions found:
              foo
              bar

    I think it would be better still if warning() was smart enough to
    stick its prefix in front of all lines (like advise() does). But
    that's outside the scope of this series. And it probably doesn't
    matter much either way; this is not a message we'd expect anyone to
    see routinely.

  [01/10]: setup: document check_repository_format()
  [02/10]: wrap shared_repository global in get/set accessors
  [03/10]: lazily load core.sharedrepository
  [04/10]: check_repository_format_gently: stop using git_config_early
  [05/10]: config: drop git_config_early
  [06/10]: setup: refactor repo format reading and verification
  [07/10]: init: use setup.c's repo version verification
  [08/10]: setup: unify repository version callbacks
  [09/10]: setup: drop repository_format_version global
  [10/10]: verify_repository_format: mark messages for translation

-Peff
