From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] git branch -D: give a better error message when
	lockfile creation fails
Date: Sat, 26 Sep 2009 12:58:12 -0700
Message-ID: <20090926195812.GH14660@spearce.org>
References: <20090926033143.GA9917@coredump.intra.peff.net> <1253972051-31980-1-git-send-email-vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Sat Sep 26 21:58:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MrdPQ-0005PF-Bf
	for gcvg-git-2@lo.gmane.org; Sat, 26 Sep 2009 21:58:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752422AbZIZT6K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Sep 2009 15:58:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752371AbZIZT6J
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Sep 2009 15:58:09 -0400
Received: from george.spearce.org ([209.20.77.23]:43097 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752224AbZIZT6I (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Sep 2009 15:58:08 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id BE351381FF; Sat, 26 Sep 2009 19:58:12 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1253972051-31980-1-git-send-email-vmiklos@frugalware.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129172>

Miklos Vajna <vmiklos@frugalware.org> wrote:
> On Fri, Sep 25, 2009 at 11:31:43PM -0400, Jeff King <peff@peff.net> wrote:
> > afterwards). So probably you would need to first refactor
> > unable_to_lock_index_die() to handle just printing the error without
> > dying.
> 
> I removed the NORETURN macro as otherwise gcc would issue a warning, as
> it does not realise that unable_to_lock_index_die() never returns.

Please don't.  If you refactor the error message formatting into
a static function called from the two extern ones, you can still
centralize the formatting but also keep NORETURN on the method that
doesn't return.  The annotation is useful and should not be removed.
 
> -extern NORETURN void unable_to_lock_index_die(const char *path, int err);
> +extern int unable_to_lock_index(const char *path, int err, int noreturn);
> +extern void unable_to_lock_index_die(const char *path, int err);

-- 
Shawn.
