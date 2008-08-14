From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH 2] count-objects: add human-readable size option
Date: Thu, 14 Aug 2008 20:51:31 +0200
Message-ID: <20080814185131.GA14858@steel.home>
References: <1218657910-22096-1-git-send-email-marcus@griep.us> <1218687684-11671-1-git-send-email-marcus@griep.us> <20080814064524.GA4379@blimp.local> <48A43B2A.7010702@griep.us>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Pierre Habouzit <madcoder@debian.org>
To: Marcus Griep <marcus@griep.us>
X-From: git-owner@vger.kernel.org Thu Aug 14 20:52:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KThw8-00086e-MO
	for gcvg-git-2@gmane.org; Thu, 14 Aug 2008 20:52:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755401AbYHNSvg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Aug 2008 14:51:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755166AbYHNSvg
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Aug 2008 14:51:36 -0400
Received: from mo-p05-ob.rzone.de ([81.169.146.180]:63384 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752534AbYHNSvg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Aug 2008 14:51:36 -0400
X-RZG-CLASS-ID: mo05
X-RZG-AUTH: :YSxENQjhO8RswxTRIGdg2r84hO89yw==
Received: from tigra.home (Fa869.f.strato-dslnet.de [195.4.168.105])
	by post.webmailer.de (fruni mo18) (RZmta 16.47)
	with ESMTP id 506c7dk7EIPs6M ; Thu, 14 Aug 2008 20:51:32 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id C2EA0277AE;
	Thu, 14 Aug 2008 20:51:31 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 9672156D2A; Thu, 14 Aug 2008 20:51:31 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <48A43B2A.7010702@griep.us>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92386>

Marcus Griep, Thu, Aug 14, 2008 16:03:22 +0200:
> Alex Riesen wrote:
> > GNU ls and du use "-h", with du using -H for SI units.
> 
> git's parse options plays interference here and injects the usage
> and exits if it finds the '-h' option.  Is there a way to get around
> that?

AFAICS - no. I'd suggest removing "-h" from the unconditionally
reserved list of options (untested patch attached). "--help" is well
known (which could be a reason why coreutils uses just it).

On somewhat similar note, how about be a bit _less_ user-friendly in
the text messages? IOW, make things like "something didn't work,
please try doing 'git something-else'" configurable (ok, active by
default, by deactivatable). These take an awful lot of screen space.
The builtin fetch, checkout, add (the most often used commands) are
the chattiest. The text in commit buffer takes almost half of screen,
too.

--

diff --git a/parse-options.c b/parse-options.c
index fd08bb4..7f85cd7 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -267,8 +267,6 @@ int parse_options_step(struct parse_opt_ctx_t *ctx,
 
 		if (arg[1] != '-') {
 			ctx->opt = arg + 1;
-			if (*ctx->opt == 'h')
-				return parse_options_usage(usagestr, options);
 			switch (parse_short_opt(ctx, options)) {
 			case -1:
 				return parse_options_usage(usagestr, options);
@@ -278,8 +276,6 @@ int parse_options_step(struct parse_opt_ctx_t *ctx,
 			if (ctx->opt)
 				check_typos(arg + 1, options);
 			while (ctx->opt) {
-				if (*ctx->opt == 'h')
-					return parse_options_usage(usagestr, options);
 				switch (parse_short_opt(ctx, options)) {
 				case -1:
 					return parse_options_usage(usagestr, options);
