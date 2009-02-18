From: Gerfried Fuchs <rhonda@deb.at>
Subject: Re: [PATCH] git-svn: Allow using arguments to the editor.
Date: Wed, 18 Feb 2009 15:48:14 +0100
Message-ID: <20090218144814.GA23938@anguilla.debian.or.at>
References: <1234964869-11159-1-git-send-email-rhonda@deb.at> <200902181515.59625.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 18 16:18:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZoC7-0007cW-Su
	for gcvg-git-2@gmane.org; Wed, 18 Feb 2009 16:18:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752783AbZBRPQ6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2009 10:16:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752742AbZBRPQ6
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Feb 2009 10:16:58 -0500
Received: from anguilla.debian.or.at ([86.59.21.37]:41923 "EHLO
	anguilla.debian.or.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752203AbZBRPQ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2009 10:16:56 -0500
X-Greylist: delayed 1721 seconds by postgrey-1.27 at vger.kernel.org; Wed, 18 Feb 2009 10:16:56 EST
Received: by anguilla.debian.or.at (Postfix, from userid 1003)
	id 60E5C10FA12; Wed, 18 Feb 2009 15:48:14 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <200902181515.59625.trast@student.ethz.ch>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110552>

* Thomas Rast <trast@student.ethz.ch> [2009-02-18 15:15:53 CET]:
> Gerfried Fuchs wrote:
> > When setting the EDITOR or VISUAL environment variable, one might want
> > to hand over arguments (like e.g. for not backgrounding a GUI editor but
> > waiting for it to finish. This patch enables that posibility, before it
> > did look for a program with the content of the variable, including the
> > space as filename part. The change is in sync with regular behavior with
> > various other tools, git itself included.
> [...]
> > +		my (@editor) = split /\s+/, $editor;
> 
> This doesn't handle quoted spaces and such.  launch_editor() seems to
> pass the $EDITOR through 'sh -c' if there are any special characters
> inside, wouldn't that be appropriate for git-svn too?

 I'm not sure where quoted spaces and such are handled very much
differently. How would you quote it that wouldn't make tons of programs
fail? EDITOR='"/my space path/prog"' doesn't work in most applications
because they wouldn't strip the embedded quotes, neither does
EDITOR='/my\ space\ path/prog' work. EDITOR='/my space path/prog' might
work in some (current git-svn) but not in all.

 I was just following common practise with the suggestion, unfortunately
there isn't a real standard for the content of EDITOR and different
people expect different beavior. Most easy way to work around is of
course writing a wrapper script that does call your editor with the
options you want, some people though consider that inconvenient.
Personally I don't care too much either way but when applications
suggest setting options in EDITOR is proper it might be right to follow
that.

 I haven't looked into how git does it directly, but it offers that
posibility:
EDITOR="vim -c 'syn off'" git commit -a

 I wasn't able to figure out any way to use a space-embedded filename in
EDITOR for git - so why should git-svn behave differently here? But you
are right, this very example shows clearly that my approach is
incomplete because it can't handle the 'syn off' part.

 About just doing a system on the combined string
("$editor $commit_editmsg"): It might work somewhat safely if one uses
system($editor . " " . quotemeta($commit_editmsg)) instead. Thinking
about it, seems to make sense. If you want me to update the patch for
that approach just tell me. :)

 Thanks for the response. :)
Rhonda
