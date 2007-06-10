From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] Introduce optional "keywords" on tag objects
Date: Sun, 10 Jun 2007 14:43:46 -0700
Message-ID: <7vabv77ael.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0706072348110.4046@racer.site>
	<200706101350.00271.johan@herland.net>
	<Pine.LNX.4.64.0706101937250.4059@racer.site>
	<200706102104.48440.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Sun Jun 10 23:43:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxVCT-00077C-MK
	for gcvg-git@gmane.org; Sun, 10 Jun 2007 23:43:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754135AbXFJVns (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jun 2007 17:43:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754661AbXFJVns
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jun 2007 17:43:48 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:55061 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754135AbXFJVnr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2007 17:43:47 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070610214346.PZVL25947.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Sun, 10 Jun 2007 17:43:46 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 9xjm1X00T1kojtg0000000; Sun, 10 Jun 2007 17:43:47 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49775>

Johan Herland <johan@herland.net> writes:

> For now, I couldn't find a good reason why the set of allowed characters
> for keywords should be smaller than for the tag name.

The set of allowed tag names excludes shell metacharacters,
primarily to help scripting.  I think keywords can share the
same reasoning to exclude them.

It also excludes '^', '~' and ':', because tag names can be used
in revision range expressions (i.e. prefix '^' is the "exclude
from the resulting set" operation, postfix "~<number>" is the
"Nth generation ancestor" operation) and general SHA-1
expression (i.e. infix ':' is the "find in the tree-ish the
object at path" operation).  These reasons would not apply to 
keywords.

Having said all of that, I suspect it is premature to talk about
keywords, as it is unclear what their intended use is.  What
kind of operations are useful on them?  

It does not count that "git cat-file tag" would show "keywords
blah" on the header instead of in body.  It is not a compelling
enough reason to introduce a new header type. grep would work
just fine for such a use.

On the other hand, for example, if (the syntax is totally made
up) we make '::keywords=foo::' expand to set of all tags that
have the specified keyword 'foo', and it turns out to be useful
to be able to say "git show ::keywords=foo::" instead of listing
individual tags, that kind of use case may make it a good reason
to add such a new header type.
