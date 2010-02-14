From: Jeff King <peff@peff.net>
Subject: Re: cvsimport error when modulename is '.'
Date: Sun, 14 Feb 2010 02:07:58 -0500
Message-ID: <20100214070757.GA22000@coredump.intra.peff.net>
References: <201002132251.42070.daniel.subs@internode.on.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Daniel Black <daniel.subs@internode.on.net>
X-From: git-owner@vger.kernel.org Sun Feb 14 08:08:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NgYaH-0007Qt-7b
	for gcvg-git-2@lo.gmane.org; Sun, 14 Feb 2010 08:08:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755514Ab0BNHH4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Feb 2010 02:07:56 -0500
Received: from peff.net ([208.65.91.99]:44946 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753348Ab0BNHHz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Feb 2010 02:07:55 -0500
Received: (qmail 31267 invoked by uid 107); 14 Feb 2010 07:08:05 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 14 Feb 2010 02:08:05 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 14 Feb 2010 02:07:58 -0500
Content-Disposition: inline
In-Reply-To: <201002132251.42070.daniel.subs@internode.on.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139891>

On Sat, Feb 13, 2010 at 10:51:42PM +1100, Daniel Black wrote:

> git  cvsimport -A ../authcvs-conv -k -m -v -d:pserver:anonymous@opendkim.cvs.sourceforge.net:/cvsroot/opendkim .
>
> this results in ...
>
> Initialized empty Git repository in /home/dan/software_projects/opendkim-import4/.git/
> Running cvsps...
> connect error: Network is unreachable
> cvs rlog: Logging .
> NOTICE: used alternate strip path /cvsroot/opendkim/.c
> WARNING: file /cvsroot/opendkim/BRANCHES doesn't match strip_path /cvsroot/opendkim/.c. ignoring
> WARNING: file /cvsroot/opendkim/FEATURES doesn't match strip_path /cvsroot/opendkim/.c. ignoring

These messages are not coming from git-cvsimport, but rather from cvsps,
which cvsimport uses to generate whole patchsets from the CVS data. Just
running "cvsps ." results in similar errors, and I don't see an obvious
way to do what you want. So probably it would require a patch to cvsps
to fix.

If this is a one-shot import, you can try a few different things.

As a hack, if you can move files in the CVS repository (and if you
can't, try using cvssuck or similar to pull them locally, and then do
the import from there), then move everything to a submodule "foo", and
import that module.

Alternatively, you might check out some of the alternative importers
like parsecvs or cvs2git. I don't know if they would handle this
situation better.

And as a super-hacky alternative, you could import each module
separately and then stich them all together using git-filter-branch.

-Peff
