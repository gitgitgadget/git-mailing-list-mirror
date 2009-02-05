From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Comments on "Understanding Version Control" by Eric S. Raymond
Date: Wed, 04 Feb 2009 22:24:57 -0800
Message-ID: <7vmyd1ieo6.fsf@gitster.siamese.dyndns.org>
References: <200902021948.54700.jnareb@gmail.com>
 <20090202202424.GG14762@mit.edu> <200902040304.05028.jnareb@gmail.com>
 <20090204235436.GA8945@mit.edu> <7v4oz9lpes.fsf@gitster.siamese.dyndns.org>
 <20090205024333.GH8945@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	"Eric S. Raymond" <esr@thyrsus.com>
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Thu Feb 05 07:26:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUxh8-0004I2-0j
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 07:26:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753982AbZBEGZJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2009 01:25:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753612AbZBEGZI
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Feb 2009 01:25:08 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:54915 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752675AbZBEGZH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2009 01:25:07 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id B7FF92A77B;
	Thu,  5 Feb 2009 01:25:05 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 436E32A761; Thu, 
 5 Feb 2009 01:24:59 -0500 (EST)
In-Reply-To: <20090205024333.GH8945@mit.edu> (Theodore Tso's message of "Wed,
 4 Feb 2009 21:43:33 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: BA770594-F34D-11DD-BA49-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108502>

Theodore Tso <tytso@mit.edu> writes:

> Careful; that's actually an argument for recording the directory
> rename.

I do not think so.  More precisely, I can see people could make that
argument, but I think that argument is weak.

Suppose the original project's implementor only knew about innodb
interface, so he had the "database interface" directory and innodb access
method file in the source tree, perhaps at <db/inno.c>.

I forked the project, and added gdbm support at <db/gdbm.c>.

You also forked the project without knowing what I was working on, and you
started working on refining the innodb support.

All the while, the development community started discussing how the source
tree should be organized to support multiple backends, and you learned
that the plan is to have one directory per larger backend, while keeping
single file ones in <db/*.c>.  Specifically, you learned that innodb
related code will be stored in <innodb/*.c>, and there may be other
<somedb/*.c> and <someotherdb/*.c> groups added, but you are not
interested in anything but enhancing innodb support.

You rename "scm mv db innodb" and then add <innodb/enhanced.c>, or perhaps
you may have done it the other way, i.e. added <db/enhanced.c> and then
renamed "scm mv db innodb".

Suppose you would want to merge my changes, but the upstream's plan hasn't
happened yet.  Neither of us merged from the upstream in the meantime.

Recording your "scm mv db innodb" as "the user's intention to rename
directory" does not help when you want to merge with me to handle the new
file <db/gdbm.c> I added.  You not only need to record the "intent to
rename db to innodb", but need to know that the validity of that "intent
to rename" is contingent on the absense of anything unrelated to innodb in
db/ directory, in order to merge the two branches correctly.  Otherwise
you will end up moving my <db/gdbm.c> to <innodb/gdbm.c>.  The correct
outcome in this case would probably be to leave it as it is.

> In other cases, maybe the right thing *is* to drop the new file in the
> original directory.  So as the Hg and Bzr apologists might say, if the
> SCM actually records whether the user intention was a *directory*
> rename, versus a series of *file* rename/moves, then it becomes
> obvious what the right thing to do.

See how that argument is flawed?  The point of my example is that the line
between your example (1) and (2) in the previous message is blurry.
