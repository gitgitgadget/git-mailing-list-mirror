From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/6] add -u: only show pathless 'add -u' warning when
 changes exist outside cwd
Date: Wed, 20 Mar 2013 01:06:49 -0400
Message-ID: <20130320050648.GB1839@sigill.intra.peff.net>
References: <1362786889-28688-1-git-send-email-gitster@pobox.com>
 <20130319224400.GA19014@google.com>
 <20130319225050.GE19014@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 20 06:07:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIBFC-0000lU-Ok
	for gcvg-git-2@plane.gmane.org; Wed, 20 Mar 2013 06:07:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754032Ab3CTFGz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Mar 2013 01:06:55 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:59292 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753515Ab3CTFGy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Mar 2013 01:06:54 -0400
Received: (qmail 4834 invoked by uid 107); 20 Mar 2013 05:08:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 20 Mar 2013 01:08:38 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Mar 2013 01:06:49 -0400
Content-Disposition: inline
In-Reply-To: <20130319225050.GE19014@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218570>

On Tue, Mar 19, 2013 at 03:50:50PM -0700, Jonathan Nieder wrote:

> This is the interesting one.
> [...]
>  * summarized Peff's review with an Ack.  I hope that's ok.

Yeah, OK with me. I certainly agree with the intent, and I think your
reasoning on the performance change is valid.

I don't see anything wrong in the patch itself, except for one minor
nit:

> @@ -121,17 +140,30 @@ static void update_callback(struct diff_queue_struct *q,
>  	}
>  }
>  
> +#define ADD_CACHE_IMPLICIT_DOT 32
>  int add_files_to_cache(const char *prefix, const char **pathspec, int flags)
>  {
>  	struct update_callback_data data;
>  	struct rev_info rev;

Should this be defined in cache.h with the other flags? I realize it's
mostly private to builtin/add.c, but without even a comment in cache.h
saying "/* 32 is reserved */", we run the risk of another commit
adding a new flag with the same number.

-Peff
