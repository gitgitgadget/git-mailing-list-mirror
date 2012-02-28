From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] commit: allow {--amend|-c foo} when {HEAD|foo} has empty
 message
Date: Tue, 28 Feb 2012 04:05:40 -0500
Message-ID: <20120228090540.GB5757@sigill.intra.peff.net>
References: <8529824c8569a8a0b4c4caf3a562750925758e74.1330419275.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Feb 28 10:05:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2J0J-0002O5-2u
	for gcvg-git-2@plane.gmane.org; Tue, 28 Feb 2012 10:05:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756893Ab2B1JFp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Feb 2012 04:05:45 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:59801
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756875Ab2B1JFn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Feb 2012 04:05:43 -0500
Received: (qmail 6581 invoked by uid 107); 28 Feb 2012 09:05:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 28 Feb 2012 04:05:46 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 Feb 2012 04:05:40 -0500
Content-Disposition: inline
In-Reply-To: <8529824c8569a8a0b4c4caf3a562750925758e74.1330419275.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191702>

On Tue, Feb 28, 2012 at 09:57:05AM +0100, Thomas Rast wrote:

> diff --git a/builtin/commit.c b/builtin/commit.c
> index 3714582..45a57af 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -690,7 +690,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
>  		hook_arg1 = "message";
>  	} else if (use_message) {
>  		buffer = strstr(use_message_buffer, "\n\n");
> -		if (!buffer || buffer[2] == '\0')
> +		if (!amend && !edit_message && (!buffer || buffer[2] == '\0'))
>  			die(_("commit has empty message"));

Hmm. So "buffer" used to never be NULL (because we would die if it is),
and now we might not die if we are doing an amend, no? And the next line
is:

>  		strbuf_add(&sb, buffer + 2, strlen(buffer + 2));

Doesn't this need to handle the case of NULL buffer (i.e., when it does
not already have "\n\n" in it)?

-Peff
