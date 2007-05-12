From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Document subproject feature
Date: Sat, 12 May 2007 13:42:58 -0700
Message-ID: <7vlkftwz71.fsf@assigned-by-dhcp.cox.net>
References: <20070512005844.GA24184@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: apw@us.ibm.com (Amos Waterland)
X-From: git-owner@vger.kernel.org Sat May 12 22:43:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmyQm-0006Za-FW
	for gcvg-git@gmane.org; Sat, 12 May 2007 22:43:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752324AbXELUnA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 12 May 2007 16:43:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753607AbXELUnA
	(ORCPT <rfc822;git-outgoing>); Sat, 12 May 2007 16:43:00 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:64937 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752324AbXELUm7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 May 2007 16:42:59 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070512204259.UYTE1318.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Sat, 12 May 2007 16:42:59 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id yLix1W00A1kojtg0000000; Sat, 12 May 2007 16:42:58 -0400
In-Reply-To: <20070512005844.GA24184@us.ibm.com> (Amos Waterland's message of
	"Fri, 11 May 2007 20:58:44 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47092>

apw@us.ibm.com (Amos Waterland) writes:

> Add a section to the user manual about the new subproject support.
> Show how to make a subproject.
>
> Signed-off-by: Amos Waterland <apw@us.ibm.com>

I like the idea of having new things described in the
user manual for the new release, but with a few reservations...

> diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
> index 13db969..27d601f 100644
> --- a/Documentation/user-manual.txt
> +++ b/Documentation/user-manual.txt
> @@ -1,4 +1,4 @@
> -Git User's Manual (for version 1.5.1 or newer)
> +Git User's Manual (for version 1.5.2 or newer)
>  ______________________________________________

Another option is to leave this as is, and make a note on the
subproject and gitattributes section that they apply only to
1.5.2 or later.  I am debating myself which one is better.

> +[[subprojects]]
> +Subprojects
> +-----------
> +
> +Some large development efforts, such as embedded Linux distributions,
> +are composed of a set of large projects, each with its own development
> +team, but all of which are combined to produce the project as a whole.
> +For example, there might be a firmware project, a hypervisor project,
> +a kernel project, and a userspace project.  Note that while each
> +project is conceptually independent, there are many cases in which a
> +change to the hypervisor necessitates a change to the kernel, for
> +example.
>
> +In this case it is nice to be able to reason about the state of the
> +entire project, but also not inconvenience each development team with
> +checking out a gigantic repository that represents the entire project.

The above makes it sound as if the primary use case is to
artificially split a project that is otherwise a coherent whole,
only because split makes each piece smaller and more manageable
to handle.  While that use case is also in scope, I do not think
that is the primary one.  The above description sends a wrong
message, IMHO.

The intent of the current design of the subproject support is
more to keep track of 'subprojects' that are _not_ under your
control.  For example, an embeddd Linux appliance developer does
not control the kernel project, nor glibc, nor busybox.  He just
integrates the work by these other projects, which do not
particularly care during their own development about how _he_ is
fitting things together.

The developer however is in total control of how to fit these
pieces together, along with his own userspace, to build his
product.  He uses the subproject feature to bind these external
projects into his own project, and freeze the HEAD version for
these subprojects to match the appliance's own needs ("we will
use this version of kernel together with that version of the
out-of-tree driver").  The "embedded distribution" example you
gave matches this use case better.
