From: Junio C Hamano <junkio@cox.net>
Subject: Re: git 0.99.9: Subversion importer breaks RPM generation (rpmbuild bug)
Date: Mon, 31 Oct 2005 11:31:03 -0800
Message-ID: <7v4q6xfpqg.fsf@assigned-by-dhcp.cox.net>
References: <43652934.8000308@zytor.com>
	<7vy84ajl4c.fsf@assigned-by-dhcp.cox.net>
	<20051031064105.GV8041@shell0.pdx.osdl.net>
	<43663EEA.5050102@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 31 20:33:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EWfNw-0003xp-7j
	for gcvg-git@gmane.org; Mon, 31 Oct 2005 20:32:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932164AbVJaTbG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 31 Oct 2005 14:31:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932166AbVJaTbG
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Oct 2005 14:31:06 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:51639 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S932164AbVJaTbF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Oct 2005 14:31:05 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051031193042.PFHX9394.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 31 Oct 2005 14:30:42 -0500
To: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10874>

"H. Peter Anvin" <hpa@zytor.com> writes:

> Chris Wright wrote:
>> It's fine for FC3.  Certain irony that git now effectively requires
>> subversion.  I'm all for splitting these out, but have no time until
>> later in the week.  BTW, mind pushing the tag?
>
> The git-core RPM definitiely needs to be split.  Doubly ironic that it's 
> called "core".

BTW, did that "require 5.008" change make the resulting package
RPM happy on RH-EL4?

I agree that it is an extremely good thing to split the binary
packages into separate ones so that the system administrators
can pick and choose only the bits that are needed.  Here is a
strawman:

git-tla-import, git-cvs-import, git-svn-import, ...::
	Importers, one per foreign SCMs.

git-docs::
	Generated documentation from Documentation hierarchy.

git-core::
        All the rest, plus man pages.  We could separate out
	commit walkers if we wanted to, but I do not think that
	is necessary.

Having said that, I consider this purely binary packaging issue.
I.e. I do not think you are advocating for splitting the source
tree.

I do not know much about how things are done in the RPM world,
but is there a concept of "the upstream" vs "packaging
maintainer" there?  IOW, are the majority of RPM binary packages
done by the upstream maintainer?

I am currently generating i386 RPMs and i386 debs myself but I
am not particularly proud of the current setup.  I do not have
an RPM based machine that I can install the result myself to
test (which is what started this thread).  Since I am not a
Debian developer (and I do not particularly wish to become one
myself), the debs I generate will not be official anyway.
Personally I'd be happier if I can just lose rpm and deb targets
from the "upstream" Makefile (git-core.spec file and debian/
subdirectory as well while we are at it), ask "packaging
maintainers" to pull from kernel.org/ tree and do RPMs and Debs
outside.

On the other hand, having the basic support for packagers in the
upstream might be easier for port maintainers.  I honestly do
not know.

One thing we could do without breaking much of the current
arrangement is to have a team of people to help porting for
major packaging formats (RPMs and Debs mostly but I know we have
OpenBSD and Darwin people here too), and ask them to feed me the
updates to rpm/deb/whatever target in the Makefile as needed.
Especially before a major release I could ask them to test
things out and generate binary packages, perhaps taken out of
the tip of the master branch, or even another "for-porters"
branch for this purpose.
