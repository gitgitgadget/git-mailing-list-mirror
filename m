From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Documentation/git-blame.txt: --follow is a NO-OP
Date: Wed, 19 Sep 2012 14:27:15 -0400
Message-ID: <20120919182715.GF11699@sigill.intra.peff.net>
References: <20120906151317.GB7407@sigill.intra.peff.net>
 <1348022905-10048-1-git-send-email-n1xim.email@gmail.com>
 <7v627aiq47.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Drew Northup <n1xim.email@gmail.com>,
	gitList <git@vger.kernel.org>, Matthieu.Moy@imag.fr,
	andy@aeruder.net, chriscool@tuxfamily.org,
	dmellor@whistlingcat.com, dpmcgee@gmail.com, fonseca@diku.dk,
	freku045@student.liu.se, kevin@sb.org, marius@trolltech.com,
	namhyung@gmail.com, rene.scharfe@lsrfire.ath.cx, s-beyer@gmx.net,
	trast@inf.ethz.ch
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 19 20:27:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEOzf-0006ay-CA
	for gcvg-git-2@plane.gmane.org; Wed, 19 Sep 2012 20:27:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754989Ab2ISS1T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2012 14:27:19 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:49812 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753781Ab2ISS1S (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2012 14:27:18 -0400
Received: (qmail 3153 invoked by uid 107); 19 Sep 2012 18:27:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 19 Sep 2012 14:27:43 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 19 Sep 2012 14:27:15 -0400
Content-Disposition: inline
In-Reply-To: <7v627aiq47.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205971>

On Tue, Sep 18, 2012 at 09:38:32PM -0700, Junio C Hamano wrote:

> That is a totally wrong message to send.  You failed to teach the
> reader that there is no need to do anything special to tell the
> command to follow per-line origin across renames.
> 
> So if anything, I would phrase it this way instead:
> 
>     --follow::
>           This option is accepted but silently ignored.  "git blame"
> 	  follows per-line origin across renames without any special
> 	  options, and there is no reason to use this option.

I think that is much better than Drew's text. But I really wonder if the
right solution is to simply disallow --follow. It does not do anything,
and it is not documented. There is no special reason to think that it
would do anything, except by people who try it. So perhaps that is the
right time to say "no, this is not a valid option".

Like this (totally untested) patch:

diff --git a/builtin/blame.c b/builtin/blame.c
index 0e102bf..412d6dd 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -2365,6 +2365,10 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 			ctx.argv[0] = "--children";
 			reverse = 1;
 		}
+		else if (!strcmp(ctx.argv[0], "--follow")) {
+			error("unknown option `--follow`");
+			usage_with_options(blame_opt_usage, options);
+		}
 		parse_revision_opt(&revs, &ctx, options, blame_opt_usage);
 	}
 parse_done:

-Peff
