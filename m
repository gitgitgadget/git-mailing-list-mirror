From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] tag: support configuring --sort via .gitconfig
Date: Thu, 10 Jul 2014 00:00:19 -0400
Message-ID: <20140710040019.GC28401@sigill.intra.peff.net>
References: <1404945412-10197-1-git-send-email-jacob.e.keller@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jacob Keller <jacob.e.keller@intel.com>
X-From: git-owner@vger.kernel.org Thu Jul 10 06:00:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X55XQ-000349-Iu
	for gcvg-git-2@plane.gmane.org; Thu, 10 Jul 2014 06:00:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750725AbaGJEAW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2014 00:00:22 -0400
Received: from cloud.peff.net ([50.56.180.127]:59159 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750701AbaGJEAV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2014 00:00:21 -0400
Received: (qmail 28808 invoked by uid 102); 10 Jul 2014 04:00:21 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 09 Jul 2014 23:00:21 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 10 Jul 2014 00:00:19 -0400
Content-Disposition: inline
In-Reply-To: <1404945412-10197-1-git-send-email-jacob.e.keller@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253171>

On Wed, Jul 09, 2014 at 03:36:51PM -0700, Jacob Keller wrote:

> Add support for configuring default sort ordering for git tags. Command
> line option will override this configured value, using the exact same
> syntax.

Thanks, this version looks pretty good to me. A few minor comments:

> +	if (!strcmp(var, "tag.sort")) {
> +		tag_sort = parse_sort_string(value);
> +	}

Our style is to usually avoid braces for a one-liner. However, I think
would actually make sense to "return 0" from this conditional.

> +test_expect_success 'configured lexical sort' '
> +	git config tag.sort "v:refname" &&
> +	git tag -l "foo*" >actual &&
> [...]

Please use:

  test_config tag.sort "v:refname"

here, which will clean up the config value after the test ends (and thus
not pollute any later tests).

Though you will need to add an extra "test_config" to the following
test:

> +test_expect_success 'option override configured sort' '
> +	git tag -l --sort=-refname "foo*" >actual &&
> [...]

I think that's a good thing, though (it makes it more clear in the
second test what is being tested, rather than relying on the state left
by the previous test).

-Peff
