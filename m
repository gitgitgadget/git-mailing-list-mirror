From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH v8 7/7] fast-import: add (non-)relative-marks feature
Date: Fri, 4 Dec 2009 13:09:17 -0500 (EST)
Message-ID: <alpine.LNX.2.00.0912041258280.14365@iabervon.org>
References: <1259946420-8845-1-git-send-email-srabbelier@gmail.com> <1259946420-8845-2-git-send-email-srabbelier@gmail.com> <1259946420-8845-3-git-send-email-srabbelier@gmail.com> <1259946420-8845-4-git-send-email-srabbelier@gmail.com>
 <1259946420-8845-5-git-send-email-srabbelier@gmail.com> <1259946420-8845-6-git-send-email-srabbelier@gmail.com> <1259946420-8845-7-git-send-email-srabbelier@gmail.com> <1259946420-8845-8-git-send-email-srabbelier@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git List <git@vger.kernel.org>,
	vcs-fast-import-devs@lists.launchpad.net
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 04 19:09:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NGcap-0003eU-UE
	for gcvg-git-2@lo.gmane.org; Fri, 04 Dec 2009 19:09:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932358AbZLDSJM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Dec 2009 13:09:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932329AbZLDSJM
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Dec 2009 13:09:12 -0500
Received: from iabervon.org ([66.92.72.58]:47780 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932320AbZLDSJL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Dec 2009 13:09:11 -0500
Received: (qmail 14694 invoked by uid 1000); 4 Dec 2009 18:09:17 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 4 Dec 2009 18:09:17 -0000
In-Reply-To: <1259946420-8845-8-git-send-email-srabbelier@gmail.com>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134560>

On Fri, 4 Dec 2009, Sverre Rabbelier wrote:

> After specifying 'feature relative-marks' the paths specified with
> 'feature import-marks' and 'feature export-marks' are relative to an
> internal directory in the current repository.
> 
> In git-fast-import this means that the paths are relative to the
> '.git/info/fast-import' directory. However, other importers may use a
> different location.
> 
> Add 'feature non-relative-marks' to disable this behavior, this way
> it is possible to, for example, specify the import-marks location as
> relative, and the export-marks location as non-relative.
> 
> Also add tests to verify this behavior.
> 
> Cc: Daniel Barkalow <barkalow@iabervon.org>
> Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
> ---
> 
> 	As requested by Daniel, it is now possible to have the marks be
> 	relative to a constant directory. We might want to consider making
> 	this the default at some point.
> 
> 	This patch opens the way for remote-helpers to use the marks feature
> 	without poluting the work tree, which I think is very important.

I think it would be better to make relative paths be the only available 
method, in part because we don't want to polute the work tree, but more 
because otherwise scripts aren't transferrable. That is, if you have an 
absolute path, you can't send the same script to two different importers 
(because they'd have to write their marks to the same location). And 
there's no way for the program constructing a script to determine a good 
absolute location if the script may be run on a different host than it's 
generated on (think of getting a Linux user getting a script attached to a 
bug report from a native Windows user; there are no absolute paths that 
are valid on both of these).

(However, it probably does make sense to permit absolute paths in the 
command line, since whoever's writing the command line is presumably aware 
of any local conventions)

	-Daniel
*This .sig left intentionally blank*
