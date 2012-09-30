From: hesco@greens.org (Hugh Esco)
Subject: Re: bug report, v1.7.12.1 -- Documentation/git-bundle.xml:130: parser error
Date: Sun, 30 Sep 2012 11:29:39 -0700 (PDT)
Message-ID: <20120930182939.30C058059E@mail.greens.org>
References: <20120930180209.GA13596@sigill.intra.peff.net>
Reply-To: hesco@campaignfoundations.com
Cc: git@vger.kernel.org, hesco@yourmessagedelivered.com
To: gitster@pobox.com, peff@peff.net
X-From: git-owner@vger.kernel.org Sun Sep 30 20:36:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TIONQ-0004jm-Bq
	for gcvg-git-2@plane.gmane.org; Sun, 30 Sep 2012 20:36:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751220Ab2I3Sfs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Sep 2012 14:35:48 -0400
Received: from mail.greens.org ([207.111.216.211]:33539 "EHLO mail.greens.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751098Ab2I3Sfs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Sep 2012 14:35:48 -0400
X-Greylist: delayed 369 seconds by postgrey-1.27 at vger.kernel.org; Sun, 30 Sep 2012 14:35:48 EDT
Received: by mail.greens.org (Postfix, from userid 2012)
	id 30C058059E; Sun, 30 Sep 2012 11:29:39 -0700 (PDT)
In-Reply-To: <20120930180209.GA13596@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206693>

Your are correct.  That is apparently the issue:

git@pbx:~$ asciidoc --version
asciidoc 8.2.7

This server is still running Debian Lenny.
Not sure when I will be able to rebuild it.  

My apologies for spamming your bug reporting list 
with all of that.  I now have source installs of git 
and gitolite installed and presumably working on this 
server and promise not to bother you further with 
that issue.

-- Hugh Esco

Date: Sun, 30 Sep 2012 14:02:09 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: hesco@yourmessagedelivered.com, git@vger.kernel.org
Subject: Re: bug report, v1.7.12.1 -- Documentation/git-bundle.xml:130:
 parser error

On Sun, Sep 30, 2012 at 12:34:18AM -0700, Junio C Hamano wrote:

> I suspect that a tilde inside literal `` environment is mishandled
> in your versions of the documentation toolchain.  Either you would
> need to upgrade some tool in the toolchain, or we would need patches
> to the source that would look like:
> 
> 	-such as `master~1` cannot be packaged,...
>         +such as `master{tilde}1` cannot be packaged,...
> 
> to work around this problem if the version of the problematic tool
> you are using is widespread.

That would not work, as commit 6cf378f turned off no-inline-literal, and
modern asciidoc would not expand that "{tilde}" at all. My guess is that
Hugh is using a version of asciidoc older than 8.4.1, which was the
first version to understand inline literals.

This came up already once before:

  http://thread.gmane.org/gmane.comp.version-control.git/198733

where the culprit was older third-party RPMs on RHEL5. It can be worked
around by upgrading asciidoc, or using "make quick-install-doc" to pull
the pre-built versions.

-Peff
