From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: libgit2 - a true git library
Date: Fri, 31 Oct 2008 11:41:54 -0700
Message-ID: <20081031184154.GV14786@spearce.org>
References: <20081031170704.GU14786@spearce.org> <20081031174745.GA4058@artemis.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Scott Chacon <schacon@gmail.com>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Fri Oct 31 19:43:15 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kvyxg-0005CW-At
	for gcvg-git-2@gmane.org; Fri, 31 Oct 2008 19:43:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751351AbYJaSlz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2008 14:41:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751921AbYJaSlz
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 14:41:55 -0400
Received: from george.spearce.org ([209.20.77.23]:45111 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751041AbYJaSlz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2008 14:41:55 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 807C83835F; Fri, 31 Oct 2008 18:41:54 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20081031174745.GA4058@artemis.corp>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99619>

Pierre Habouzit <madcoder@debian.org> wrote:
> 
> I know this isn't actually helping a lot to define the real APIs, but we
> should really not repeat current git mistakes and have a really uniform
> APIs, meaning that first we must decide:

Agreed.

>   * proper namespacing (e.g. OBJ_* looks like failure to me, it's a way
>     too common prefix);

Fixed.  Its now GIT_OBJ_*.

>   * proper public "stuff" naming (I e.g. realy like types names -- not
>     struct or enum tags, that I don't really care -- ending with _t as
>     it helps navigating source.

Fixed, types now end in _t.

> And write that down _first_. It's not a lot of work, but it must be
> done. Working on a library really asks us to create something coherent
> for our users.

How about this?

http://www.spearce.org/projects/scm/libgit2/apidocs/CONVENTIONS
 
> Second, if we want this to be a successful stuff, we all agree we must
> let git be able to use it medium term. That means that when git-core is
> experimenting with new interfaces, it will probably need to hook into
> some more internal aspects of the library. This is a problem to solve
> elegantly, linking git against a static library won't please a lot of
> vendors and linux distributions, and exporting "private" symbols is a
> sure way to see them being abused.

Private symbols are a problem.  On some systems we can use link
editing to strip them out of the .so, but that isn't always going to
work everywhere.  I've outlined the idea of using double underscore
to name private functions, and we can link-edit out '*__*' if the
platform's linker supports it (e.g. GNU ld).
 
> Last but not least, I believe parts of git-core are currently easy to
> just take. For example, any code *I* wrote, I hereby give permission to
> relicense it in any of the following licenses: BSD-like, MIT-like,
> WTFPL.

Yea.  We could try to do that.  I don't know how far it will get us,
but if we have to "steal" code we can rip a good part from JGit.
Its BSD-like, but has that "icky Java smell" to it.  :-)

Before worrying about where we get implementation bits from I'm
more interested in trying to get a consistent view of what our
namespace looks like, and what our calling conventions are, so we
have some sort of benchmark to measure APIs against as we add them
to the implementation.

-- 
Shawn.
