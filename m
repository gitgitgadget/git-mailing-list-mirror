From: Jeff King <peff@peff.net>
Subject: Re: [announce+patch] git-forest 20080402
Date: Thu, 3 Apr 2008 06:14:18 -0400
Message-ID: <20080403101418.GC6673@coredump.intra.peff.net>
References: <1207169895-25949-1-git-send-email-jengelh@computergmbh.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, jnareb@gmail.com, kzak@redhat.com
To: Jan Engelhardt <jengelh@computergmbh.de>
X-From: git-owner@vger.kernel.org Thu Apr 03 12:15:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JhMTK-00011z-M8
	for gcvg-git-2@gmane.org; Thu, 03 Apr 2008 12:15:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752224AbYDCKOW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Apr 2008 06:14:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752111AbYDCKOW
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Apr 2008 06:14:22 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2154 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751791AbYDCKOV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Apr 2008 06:14:21 -0400
Received: (qmail 8962 invoked by uid 111); 3 Apr 2008 10:14:19 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 03 Apr 2008 06:14:19 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 03 Apr 2008 06:14:18 -0400
Content-Disposition: inline
In-Reply-To: <1207169895-25949-1-git-send-email-jengelh@computergmbh.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78742>

On Wed, Apr 02, 2008 at 10:58:14PM +0200, Jan Engelhardt wrote:

> N.B.: This was a ridiculous command to get it right...
> can't this be done easier?
> `git-format-patch -C -M --stat=72 --summary -p --thread -n HEAD^..HEAD &&
> git-send-email --suppress-from --no-chain --compose --to git@xxx 00*`

Most of the time you don't need -C -M (unless you are actually renaming
stuff). If you always want it, try:

  git config --global diff.renames copies

format-patch already defaults to "--stat --summary -p" if you give it no
format options. The default stat is 80, I believe; for format-patch it
should probably be bumped to 72 anyway. format-patch will also default
to ..HEAD if just given HEAD^.

So you should be able to do:

  git format-patch --thread -n HEAD^

For your send-email invocation, doing:

  git config --global sendemail.suppressfrom true
  git config --global sendemail.chainreplyto false
  # the --global makes the others user-wide; this
  # one should just be specific to your git repo
  git config sendemail.to git@vger.kernel.org

should allow:

  git sendemail --compose 00*

though if you are just sending a single patch, it is common to put the
cover letter material (if it is short) after the '---' but before the
diffstat.

HTH,
-Peff
