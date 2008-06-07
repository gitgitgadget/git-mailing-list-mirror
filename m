From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] 0002 This patch is to allow 12 different OS's to compile
 and run git.
Date: Fri, 6 Jun 2008 20:47:43 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0806062043350.19665@iabervon.org>
References: <Pine.LNX.4.64.0806061330180.18454@xenau.zenez.com> <87bq2ez72u.fsf@jeremyms.com> <Pine.LNX.4.64.0806061359080.18454@xenau.zenez.com> <7vmylyrwkg.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0806061718420.18454@xenau.zenez.com>
 <Pine.LNX.4.64.0806061822220.18454@xenau.zenez.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Harning <harningt@gmail.com>,
	Jeremy Maitin-Shepard <jbms@cmu.edu>,
	Git List <git@vger.kernel.org>
To: Boyd Lynn Gerber <gerberb@zenez.com>
X-From: git-owner@vger.kernel.org Sat Jun 07 02:48:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4mbn-0004BP-Ev
	for gcvg-git-2@gmane.org; Sat, 07 Jun 2008 02:48:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753155AbYFGArr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2008 20:47:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753163AbYFGArr
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jun 2008 20:47:47 -0400
Received: from iabervon.org ([66.92.72.58]:36578 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753075AbYFGArq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2008 20:47:46 -0400
Received: (qmail 1861 invoked by uid 1000); 7 Jun 2008 00:47:43 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 7 Jun 2008 00:47:43 -0000
In-Reply-To: <Pine.LNX.4.64.0806061822220.18454@xenau.zenez.com>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84160>

On Fri, 6 Jun 2008, Boyd Lynn Gerber wrote:

> From db0574a7f89bb90b6ce02cd44053f8cec2c454cc
> 
> This patch has patches to
> 
> Makefile
> git-compat-util.h
> progress.c
> 
> This patch allows some older OS's, SCO OpenServer 5.0.X, SCO UnixWare 7.1.4,
> and OpenServer 6.0.X to build and run git.  Applied suggestions from list.
> 
>         Developer's Certificate of Origin 1.1
> 
>         By making a contribution to this project, I certify that:
> 
>         (a) The contribution was created in whole or in part by me and I
>             have the right to submit it under the open source license
>             indicated in the file; or
> 
>         (b) The contribution is based upon previous work that, to the best
>             of my knowledge, is covered under an appropriate open source
>             license and I have the right under that license to submit that
>             work with modifications, whether created in whole or in part
>             by me, under the same open source license (unless I am
>             permitted to submit under a different license), as indicated
>             in the file; or
> 
>         (c) The contribution was provided directly to me by some other
>             person who certified (a), (b) or (c) and I have not modified
>             it.
> 
>         (d) I understand and agree that this project and the contribution
>             are public and that a record of the contribution (including all
>             personal information I submit with it, including my sign-off) is
>             maintained indefinitely and may be redistributed consistent with
>             this project or the open source license(s) involved.
> 
> Signed-off-by: Boyd Lynn Gerber <gerberb@zenez.com>
> 
> --
> Boyd Gerber <gerberb@zenez.com>
> ZENEZ   1042 East Fort Union #135, Midvale Utah  84047
> 
> diff --git a/Makefile b/Makefile
> index cce5a6e..a0456c8 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -165,6 +165,28 @@ uname_P := $(shell sh -c 'uname -p 2>/dev/null || echo not')
>  # CFLAGS and LDFLAGS are for the users to override from the command line.
>  
>  CFLAGS = -g -O2 -Wall
> +ifeq ($(uname_S),SCO_SV)
> +	ifeq ($(uname_R),3.2)
> +#	Change to -O2 for released version
> +#	CFLAGS = -O2
> +#	Debug Version
> +		CFLAGS = -g
> +	endif
> +#	For System V based OS's
> +	ifeq ($(uname_R),5)
> +#	For System V based OS's and shared libraries
> +		CFLAGS = -g -O2 -Wall

You don't need this, because CFLAGS is already -g -O2 -Wall, since we set 
it above and couldn't have changed it.

> +#	Use for Static version
> +#		CFLAGS = -g -O2

Static libraries don't support -Wall?

> +	endif
> +endif
> +#	For all UnixWare Versions.
> +ifeq ($(uname_S),UnixWare)
> +#	For System V based OS's and shared libraries
> +	CFLAGS = -g -O2 -Wall

Again, this just sets it to what it must already be.

You might want to test something the person doing the build can put 
somewhere, rather than commenting out the lines you're not using.

	-Daniel
*This .sig left intentionally blank*
