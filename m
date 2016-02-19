From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv13 5/7] git submodule update: have a dedicated helper for
 cloning
Date: Fri, 19 Feb 2016 07:03:11 -0500
Message-ID: <20160219120310.GB10204@sigill.intra.peff.net>
References: <1455838398-12379-1-git-send-email-sbeller@google.com>
 <1455838398-12379-6-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: gitster@pobox.com, git@vger.kernel.org, jrnieder@gmail.com,
	Jens.Lehmann@web.de
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Feb 19 13:03:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWjmO-0000OD-D5
	for gcvg-git-2@plane.gmane.org; Fri, 19 Feb 2016 13:03:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1428012AbcBSMDQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Feb 2016 07:03:16 -0500
Received: from cloud.peff.net ([50.56.180.127]:45357 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1427031AbcBSMDN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2016 07:03:13 -0500
Received: (qmail 23004 invoked by uid 102); 19 Feb 2016 12:03:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 19 Feb 2016 07:03:13 -0500
Received: (qmail 27283 invoked by uid 107); 19 Feb 2016 12:03:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 19 Feb 2016 07:03:19 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 19 Feb 2016 07:03:11 -0500
Content-Disposition: inline
In-Reply-To: <1455838398-12379-6-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286710>

On Thu, Feb 18, 2016 at 03:33:16PM -0800, Stefan Beller wrote:

> +	if (needs_cloning) {
> +		cp->git_cmd = 1;
> +		cp->no_stdin = 1;
> +		cp->stdout_to_stderr = 1;
> +		cp->err = -1;
> +		argv_array_push(&cp->args, "submodule--helper");
> +		argv_array_push(&cp->args, "clone");
> +		if (pp->quiet)
> +			argv_array_push(&cp->args, "--quiet");
> +
> +		if (pp->prefix)
> +			argv_array_pushl(&cp->args, "--prefix", pp->prefix, NULL);
> +
> +		argv_array_pushl(&cp->args, "--path", sub->path, NULL);
> +		argv_array_pushl(&cp->args, "--name", sub->name, NULL);
> +		argv_array_pushl(&cp->args, "--url", strdup(url), NULL);

No need to strdup() here; argv_array handles its own memory, so this
just leaks (and if we were keeping it, it should be xstrdup(), of
course).

-Peff
