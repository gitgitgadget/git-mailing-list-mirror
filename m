From: Jeff King <peff@peff.net>
Subject: Re: wishlist: git gui not listing untracked files in unstaged list
Date: Wed, 10 Mar 2010 17:12:28 -0500
Message-ID: <20100310221228.GA4223@sigill.intra.peff.net>
References: <loom.20100310T203316-38@post.gmane.org>
 <7vaaugrlqs.fsf@alter.siamese.dyndns.org>
 <20100310200728.GD21994@spearce.org>
 <loom.20100310T225229-469@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Patrick Higgins <patrick133t@yahoo.com>
X-From: git-owner@vger.kernel.org Wed Mar 10 23:12:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NpU90-0005u6-Eb
	for gcvg-git-2@lo.gmane.org; Wed, 10 Mar 2010 23:12:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932861Ab0CJWMc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Mar 2010 17:12:32 -0500
Received: from peff.net ([208.65.91.99]:59403 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932833Ab0CJWMb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Mar 2010 17:12:31 -0500
Received: (qmail 19948 invoked by uid 107); 10 Mar 2010 22:12:54 -0000
Received: from c-71-206-173-191.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.191)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Wed, 10 Mar 2010 17:12:54 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 10 Mar 2010 17:12:28 -0500
Content-Disposition: inline
In-Reply-To: <loom.20100310T225229-469@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141923>

On Wed, Mar 10, 2010 at 10:00:41PM +0000, Patrick Higgins wrote:

> Shawn O. Pearce <spearce <at> spearce.org> writes:
> 
> > Junio C Hamano <gitster <at> pobox.com> wrote:
> > I have no idea why the original poster isn't getting his ignore
> > list(s) to work.  I also have no idea why dropping the --others
> > flag from the ls-files command gets him a useful result.
> 
> I'm seeing a similar problem. For me, it's caused by defining
> core.excludesfile to "~/.gitexcludes". The git config documentation
> says that this will be expanded to my home directory. It appears that
> git gui doesn't do this and instead runs "git ls-files --others -z
> --exclude-from='~/.gitexcludes'"
> 
> That chokes with:
> 
> fatal: cannot use ~/.gitexcludes as an exclude file
> 
> Changing core.excludesfile to use a fully-qualified path instead of ~/
> fixes the problem for me.

This is an inconsistency in the way that tilde-expansion is handled. The
core.excludesfile config variable is expanded internally with the
"pathname" magic (git_config_pathname). But handing the filename
directly to ls-files --exclude-from does not do that expansion.

So either there is a bug in ls-files, which should expand from the
command line, or one in git-gui, which should be using "git config
--path core.excludesfile" to get the path.

-Peff
