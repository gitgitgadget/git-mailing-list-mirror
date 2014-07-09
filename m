From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] tag: support configuring --sort via .gitconfig
Date: Wed, 9 Jul 2014 17:58:16 -0400
Message-ID: <20140709215816.GE25854@sigill.intra.peff.net>
References: <1404940860-4004-1-git-send-email-jacob.e.keller@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jacob Keller <jacob.e.keller@intel.com>
X-From: git-owner@vger.kernel.org Wed Jul 09 23:58:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4zsc-0002PC-76
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jul 2014 23:58:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752594AbaGIV6S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jul 2014 17:58:18 -0400
Received: from cloud.peff.net ([50.56.180.127]:59005 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751424AbaGIV6S (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2014 17:58:18 -0400
Received: (qmail 11119 invoked by uid 102); 9 Jul 2014 21:58:18 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 09 Jul 2014 16:58:18 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 09 Jul 2014 17:58:16 -0400
Content-Disposition: inline
In-Reply-To: <1404940860-4004-1-git-send-email-jacob.e.keller@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253160>

On Wed, Jul 09, 2014 at 02:21:00PM -0700, Jacob Keller wrote:

> Add support for configuring default sort ordering for git tags. Command
> line option will override this configured value, using the exact same
> syntax.

This makes sense, and was something I was expecting to add once tag and
branch both learned for-each-ref's sorting code. I don't think there
will be any compatibility problems in adding it now, though; the
ultimate interface will be the same (it will just know about more types
of sorting).

> +tag.sort::
> +	This variable is used to control the sort ordering of tags when
> +	displayed via linkgit:git-tag[5]. The current supported types are
> +	"refname" for lexicographic order (default) or "version:refname" or
> +	"v:refname" for tag names treated as versions. You may prepend a "-" to
> +	reverse the sort ordering.

Your link to git-tag[5] should be to git-tag[1], I think. The final
number is the manpage section.

I was going to complain that this is duplicating the sort documentation
from git-tag, but I see you actually moved it from the --sort option to
here, and refer back from there to here.

I think I'd prefer it the other way around (and explain this as "behave
as if --sort=<value> had been given"). As the sort options grow, it
seems likely that we will grow a new section in the git-tag manpage (and
eventually probably feed that content from an include that works for all
of for-each-ref, branch, and tag).

> +static char *configured_tag_sort;

When dealing with a config option that also has a command-line version,
we usually forgo this separate storage for the configured value.
Instead, we just set "sort" directly from the config callback (which may
require making it a global so the callback can access it), and then let
the command-line parser overwrite it.

-Peff
