From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv2 2/2] git-patch-id: do not trip over "no newline" markers
Date: Thu, 17 Feb 2011 23:16:09 -0500
Message-ID: <20110218041609.GA12348@sigill.intra.peff.net>
References: <d27aa07556df763b34b980d3706320216094d592.1297928549.git.git@drmicha.warpmail.net>
 <536855b39d0ab5bb657ee6117a7e7c6bb0de0027.1297928549.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Feb 18 05:16:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqHlS-0001dN-B2
	for gcvg-git-2@lo.gmane.org; Fri, 18 Feb 2011 05:16:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752111Ab1BREQO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Feb 2011 23:16:14 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:40004 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751683Ab1BREQN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Feb 2011 23:16:13 -0500
Received: (qmail 27275 invoked by uid 111); 18 Feb 2011 04:16:12 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Fri, 18 Feb 2011 04:16:12 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 17 Feb 2011 23:16:09 -0500
Content-Disposition: inline
In-Reply-To: <536855b39d0ab5bb657ee6117a7e7c6bb0de0027.1297928549.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167163>

On Thu, Feb 17, 2011 at 08:44:42AM +0100, Michael J Gruber wrote:

> --- a/builtin/patch-id.c
> +++ b/builtin/patch-id.c
> @@ -73,6 +73,8 @@ int get_one_patchid(unsigned char *next_sha1, git_SHA_CTX *ctx)
>  			p += 7;
>  		else if (!memcmp(line, "From ", 5))
>  			p += 5;
> +		else if (!memcmp(line, "\\ ", 2) && strlen(line)>=12)
> +			continue;

Wow, that's pretty obscure. I wonder if the test should be factored out
into line_is_no_newline_at_end_of_file() (or surely there is some more
sensible name), and used by both apply and patch-id. Along with a nice
comment (which I see apply already has) describing what in the world the
magic number 12 means.

-Peff
