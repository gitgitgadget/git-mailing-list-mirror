From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Add support for GIT_ONE_FILESYSTEM
Date: Mon, 15 Mar 2010 22:33:06 -0400
Message-ID: <20100316023306.GA14253@coredump.intra.peff.net>
References: <20100315214003.GB11157@pixar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Lars Damerow <lars@pixar.com>
X-From: git-owner@vger.kernel.org Tue Mar 16 03:33:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrMb1-0005zP-LJ
	for gcvg-git-2@lo.gmane.org; Tue, 16 Mar 2010 03:33:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937410Ab0CPCdW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Mar 2010 22:33:22 -0400
Received: from peff.net ([208.65.91.99]:39690 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937358Ab0CPCdV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Mar 2010 22:33:21 -0400
Received: (qmail 2561 invoked by uid 107); 16 Mar 2010 02:33:46 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 15 Mar 2010 22:33:46 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 15 Mar 2010 22:33:06 -0400
Content-Disposition: inline
In-Reply-To: <20100315214003.GB11157@pixar.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142292>

On Mon, Mar 15, 2010 at 02:40:03PM -0700, Lars Damerow wrote:

> +		if (getenv("GIT_ONE_FILESYSTEM") != NULL) {

Should this really trigger for GIT_ONE_FILESYSTEM=0? We already have
git_env_bool, which will handle 0/1, true/false, etc. Probably you
should use it here.

I am not a big fan of the environment variable name, either, but I don't
have another good suggestion. It is closely related to
GIT_CEILING_DIRECTORIES (in fact, you could probably solve the same
problem with GIT_CEILING_DIRECTORIES, but I think your solution is much
nicer in that it lets the user get away with being less verbose).

> +			if (stat("..", &buf))
> +				die_errno("failed to stat '..'");
> +			if (buf.st_dev != current_device)
> +				die("refusing to cross filesystem boundary '%s/..'", cwd);
> +		}

I agree with Sverre that this message isn't descriptive enough, but I
like the suggestion you posted elsewhere in the thread.

-Peff
