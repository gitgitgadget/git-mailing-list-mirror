From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Comments pack protocol description in "Git Community Book"
	(second round)
Date: Tue, 9 Jun 2009 07:28:52 -0700
Message-ID: <20090609142852.GL16497@spearce.org>
References: <200905122329.15379.jnareb@gmail.com> <200906062338.02451.jnareb@gmail.com> <20090607200617.GA16497@spearce.org> <200906091139.58509.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Scott Chacon <schacon@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Andreas Ericsson <ae@op5.se>, Tony Finch <dot@dotat.at>,
	Johannes Sixt <j6t@kdbg.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 09 16:29:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ME2Jw-0000Oq-6S
	for gcvg-git-2@gmane.org; Tue, 09 Jun 2009 16:29:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752413AbZFIO2v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2009 10:28:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751927AbZFIO2u
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jun 2009 10:28:50 -0400
Received: from george.spearce.org ([209.20.77.23]:44330 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751079AbZFIO2u (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jun 2009 10:28:50 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id AAB99381FD; Tue,  9 Jun 2009 14:28:52 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <200906091139.58509.jnareb@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121175>

Jakub Narebski <jnareb@gmail.com> wrote:
> On Sun, 7 June 2009, Shawn O. Pearce wrote:
> > 
> > I've run into problems with hosting sites like GitHub and Gitoriuous
> > not correctly honoring some ssh invokes, because they use the forced
> > command execution model and were handling only one case that could
> > be presented to them.
> 
> Can you offer some details?  Or is it out of scope of git pack protocol
> description, and more about correctly implementing SSH protocol and
> remote command invocation in it?

For URI user@site:project.git the following should all succeed:

  1) ssh user@site "git-receive-pack project.git"
  2) ssh user@site "git receive-pack project.git"

  3) ssh user@site "git-receive-pack 'project.git'"
  4) ssh user@site "git receive-pack 'project.git'"

Note that the command name can be dash or dashless, and the project
name can be wrapped in single quotes, or not wrapped in single
quotes.  C Git tends to create form 3 by default.  JGit also tries
to use form 3 by default, but I've heard some reports from users
saying it produced one of the other forms.

For ssh://user@site/project.git the following should succeed:
 
  1) ssh user@site "git-receive-pack /project.git"
  2) ssh user@site "git receive-pack /project.git"

  3) ssh user@site "git-receive-pack '/project.git'"
  4) ssh user@site "git receive-pack '/project.git'"

If you are a site like GitHub, where '/' means nothing to you
because all repositories are scoped by user, the extra leading '/'
appears here simply because of the style of URI used, and the '/'
should be dropped before evaluating the path.

GitHub had a problem with ssh:// URIs, its fixed now.  I think
Gitorious had a problem with the command name, but that's fuzzy
in my memory.

-- 
Shawn.
