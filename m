From: Jeff King <peff@peff.net>
Subject: Re: Export from bzr / Import to git results in a deleted file
 re-appearing
Date: Thu, 12 Jul 2012 17:01:38 -0400
Message-ID: <20120712210138.GA15283@sigill.intra.peff.net>
References: <87ehogrham.fsf@bitburger.home.felix>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Felix Natter <fnatter@gmx.net>
X-From: git-owner@vger.kernel.org Thu Jul 12 23:02:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SpQWO-0002Bn-N6
	for gcvg-git-2@plane.gmane.org; Thu, 12 Jul 2012 23:02:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933906Ab2GLVBt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jul 2012 17:01:49 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:58199
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932897Ab2GLVBm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jul 2012 17:01:42 -0400
Received: (qmail 25071 invoked by uid 107); 12 Jul 2012 21:01:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 12 Jul 2012 17:01:40 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 12 Jul 2012 17:01:38 -0400
Content-Disposition: inline
In-Reply-To: <87ehogrham.fsf@bitburger.home.felix>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201381>

On Thu, Jul 12, 2012 at 08:00:17PM +0200, Felix Natter wrote:

> I am trying to move freeplane's repository (GPL-project) from bzr to
> git, but when I do this:
> 
> $ mkdir freeplane-git1
> $ cd freeplane-git1
> $ git init .
> $ bzr fast-export --export-marks=../marks.bzr ../trunk/ | git fast-import --export-marks=../marks.git
> $ git checkout
> 
> then there are no errors, but the resulting working index is broken:
>  freeplane-git1/freeplane_plugin_formula/src/org/freeplane/plugin/formula
>  contains SpreadSheetUtils.java which belongs to package
>  'org.freeplane.plugin.spreadsheet' and which is no longer in the bzr
>  trunk that I imported!

If you run only the bzr half of your command and inspect the output, you
will see that the file in question is mentioned twice.  Once in a commit
on "refs/heads/master" that renames into it from another file:

  R freeplane_plugin_spreadsheet/src/org/freeplane/plugin/spreadsheet/SpreadSheetUtils.java
    freeplane_plugin_formula/src/org/freeplane/plugin/formula/SpreadSheetUtils.java

and another similar case creating a merge commit. But it is never
deleted. So from a cursory inspection, it looks like git is right to
include the file in the final output (but I didn't trace the complete
history graph, so it's possible that those commits are somehow not used
in the final result).

Which leads me to believe that the bug is in bzr.

-Peff
