From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add git-submodule command
Date: Sat, 26 May 2007 11:42:01 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0705261136590.4648@racer.site>
References: <8c5c35580705251501u6346c27by1d133efc3d157bf2@mail.gmail.com>
 <11801386283399-git-send-email-hjemli@gmail.com> <7v1wh4ped4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Lars Hjemli <hjemli@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat May 26 12:42:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hrtj9-0007r2-Kz
	for gcvg-git@gmane.org; Sat, 26 May 2007 12:42:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750828AbXEZKmL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 26 May 2007 06:42:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750851AbXEZKmL
	(ORCPT <rfc822;git-outgoing>); Sat, 26 May 2007 06:42:11 -0400
Received: from mail.gmx.net ([213.165.64.20]:40835 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750828AbXEZKmJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 May 2007 06:42:09 -0400
Received: (qmail invoked by alias); 26 May 2007 10:42:08 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp031) with SMTP; 26 May 2007 12:42:08 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19KAQQh38JKYQMlbMvhOLdLmTTtZ2SxYfjJJjiq4I
	BAwR/Va8xuEs4A
X-X-Sender: gene099@racer.site
In-Reply-To: <7v1wh4ped4.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48468>

Hi,

On Fri, 25 May 2007, Junio C Hamano wrote:

> Lars Hjemli <hjemli@gmail.com> writes:
> 
> > +
> > +#
> > +# Run clone + checkout on missing submodules
> > +#
> > +# $@ = requested paths (default to all)
> > +#
> > +modules_init()
> > +{
> > +	git ls-files --stage -- $@ | grep -e '^160000 ' |
> 
> Did you mean "$@", i.e. inside double-quotes?
> 
> Because this pattern would appear a lot in superproject support,
> it might be a good idea to give a new option, --subprojects, to
> git-ls-files to limit its output to 160000 entries, but that is
> a minor detail.

I think that makes sense. It would also help the next one:

> 
> > +	while read mode sha1 stage path
> > +	do
> 
> We would need to undo the shell-safety "quoted" output of paths
> here.  I suspect it would be much easier to code this in Perl or
> Python, do the "grep -e" part above in the script, when we start
> caring about unwrapping c-quoting of path (or "ls-files -z").

I would prefer this to be in shell... so to be easier make it a builtin 
later, when the script has evolved into a stable state. By introducing 
--subprojects to git-ls-files, you can roll your own quoting just for 
git-submodule, as needed.

> But that is a minor detail we could fix up later.

I agree. It makes for a nice incremental patch.

> > +		test -d "$path/.git" && continue
> > +
> > +		if test -d "$path"
> > +		then
> > +			rmdir "$path" 2>/dev/null ||
> > +			die "Directory '$path' exist, but not as a submodule"
> > +		fi
> 
> Could the currently checked-out $path be a symlink to another
> directory, and what does the code do in such a case?

I am not quite sure if you should allow that... So, IMHO this is stuff to 
discuss after the initial revision (and after we have a test case, so we 
can play around with symlinks safely).

Ciao,
Dscho
