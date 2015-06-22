From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Add list-all-objects command
Date: Mon, 22 Jun 2015 04:38:22 -0400
Message-ID: <20150622083822.GB12259@peff.net>
References: <1434705059-2793-1-git-send-email-charles@hashpling.org>
 <1434914431-7745-1-git-send-email-charles@hashpling.org>
 <1434914431-7745-2-git-send-email-charles@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Charles Bailey <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Mon Jun 22 10:38:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z6xFO-0001VR-5R
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jun 2015 10:38:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932902AbbFVIi0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2015 04:38:26 -0400
Received: from cloud.peff.net ([50.56.180.127]:49709 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932980AbbFVIiZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jun 2015 04:38:25 -0400
Received: (qmail 9591 invoked by uid 102); 22 Jun 2015 08:38:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 22 Jun 2015 03:38:25 -0500
Received: (qmail 6662 invoked by uid 107); 22 Jun 2015 08:38:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 22 Jun 2015 04:38:25 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 22 Jun 2015 04:38:22 -0400
Content-Disposition: inline
In-Reply-To: <1434914431-7745-2-git-send-email-charles@hashpling.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272319>

On Sun, Jun 21, 2015 at 08:20:31PM +0100, Charles Bailey wrote:

> +OPTIONS
> +-------
> +
> +-v::
> +--verbose::
> +	Output in the followin format instead of just printing object ids:
> +	<sha1> SP <type> SP <size>

s/followin/&g/

> +int cmd_list_all_objects(int argc, const char **argv, const char *prefix)
> +{
> +	struct packed_git *p;
> +
> +	argc = parse_options(argc, argv, prefix, builtin_filter_objects_options,
> +			     NULL, 0);
> +
> +	for_each_loose_object(check_loose_object, NULL, 0);
> +
> +	prepare_packed_git();
> +	for (p = packed_git; p; p = p->next) {
> +		open_pack_index(p);
> +	}

Yikes. The fact that you need to do this means that
for_each_packed_object is buggy, IMHO. I'll send a patch.

-Peff
