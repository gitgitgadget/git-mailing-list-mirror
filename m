From: Junio C Hamano <junkio@cox.net>
Subject: Re: 2 build issues
Date: Mon, 14 Aug 2006 15:10:27 -0700
Message-ID: <7vd5b3dl4c.fsf@assigned-by-dhcp.cox.net>
References: <20060814121156.84bc6e34.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 15 00:10:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCkdk-0001Hd-Av
	for gcvg-git@gmane.org; Tue, 15 Aug 2006 00:10:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965000AbWHNWK3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Aug 2006 18:10:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965003AbWHNWK3
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Aug 2006 18:10:29 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:30162 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S965000AbWHNWK2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Aug 2006 18:10:28 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060814221027.DECP12581.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 14 Aug 2006 18:10:27 -0400
To: "Randy.Dunlap" <rdunlap@xenotime.net>
In-Reply-To: <20060814121156.84bc6e34.rdunlap@xenotime.net> (Randy Dunlap's
	message of "Mon, 14 Aug 2006 12:11:56 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25415>

"Randy.Dunlap" <rdunlap@xenotime.net> writes:

> xmlto -m callouts.xsl man git-add.xml
> I/O error : Attempt to load network entity http://docbook.sourceforge.net/release/xsl/current/manpages/docbook.xsl
> warning: failed to load external entity "http://docbook.sourceforge.net/release/xsl/current/manpages/docbook.xsl"
> compilation error: file /tmp/xmlto-xsl.l27115 line 4 element import
> xsl:import : unable to load http://docbook.sourceforge.net/release/xsl/current/manpages/docbook.xsl
> make[1]: *** [git-add.1] Error 1
> rm git-add.xml
> make[1]: Leaving directory `/home/rddunlap/builds/git-snapshot-20060814/Documentation'
> make: *** [doc] Error 2

Sorry, I am not docbook expert -- help from the list please?
I seem to be using:

                        (home)		(kernel.org)
	asciidoc	7.1.2		7.0.2
        xmlto		0.0.18		0.0.18

> make -C templates install
> make[1]: Entering directory `/home/rddunlap/builds/git-snapshot-20060814/templates'
> : no custom templates yet
> install -d -m755 '/usr/local/share/git-core/templates/'
> (cd blt && tar cf - .) | \
> (cd '/usr/local/share/git-core/templates/' && tar xf -)
> tar: This does not look like a tar archive
> tar: Skipping to next header
> tar: Archive contains obsolescent base-64 headers
> tar: Error exit delayed from previous errors
> make[1]: *** [install] Error 2
> make[1]: Leaving directory `/home/rddunlap/builds/git-snapshot-20060814/templates'
> make: *** [install] Error 

Hmph.  I suspect (cd blt && tar cf - .) is failing silently.
When built, "make -C templates" creates templates/blt directory
and leaves templates/boilerplates.made file.  Do you have them?

Ah, another possibility.  Does your "cd" say anything
unnecessary even when running scripts, not interactively?  For
example, do you have CDPATH set and _exported_ to the
environment?  CDPATH might be a useful shell variable for
interactive session, but you never want to export it to affect
unsuspecting shell scripts you invoke directly or indirectly.

I see many documents floating on the web that call CDPATH "an
environment variable".  It is a disease X-<.
