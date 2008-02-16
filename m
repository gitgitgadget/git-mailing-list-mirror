From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/6] config: add 'git_config_string' to refactor string
	config variables.
Date: Sat, 16 Feb 2008 06:53:10 -0500
Message-ID: <20080216115310.GA11318@sigill.intra.peff.net>
References: <20080216060024.385fa360.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio Hamano <junkio@cox.net>,
	Pierre Habouzit <madcoder@debian.org>,
	Martin Koegler <mkoegler@auto.tuwien.ac.at>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Sat Feb 16 12:53:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQLc5-0002OW-RT
	for gcvg-git-2@gmane.org; Sat, 16 Feb 2008 12:53:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753968AbYBPLxP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Feb 2008 06:53:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753896AbYBPLxP
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Feb 2008 06:53:15 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2293 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753900AbYBPLxO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Feb 2008 06:53:14 -0500
Received: (qmail 7661 invoked by uid 111); 16 Feb 2008 11:53:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Sat, 16 Feb 2008 06:53:11 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 16 Feb 2008 06:53:10 -0500
Content-Disposition: inline
In-Reply-To: <20080216060024.385fa360.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74039>

On Sat, Feb 16, 2008 at 06:00:24AM +0100, Christian Couder wrote:

> +int git_config_string(const char **dest, const char *var, const char *value)
> +{
> +	if (!value)
> +		return config_error_nonbool(var);
> +	*dest = xstrdup(value);
> +	return 0;
> +}

I'm not sure I see the point in using a 'const char *' as the
destination. The string isn't inherently const, since it is allocated on
the heap; callers are free to use it as they please (and are responsible
for freeing it; while constness doesn't impact calling free() at a
language level, I think that stylistically it is uncommon for a
heap-allocated string to be stored as 'const').

-Peff
