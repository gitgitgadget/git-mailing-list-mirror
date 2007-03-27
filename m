From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] contrib/workdir: add a simple script to create a working directory
Date: Mon, 26 Mar 2007 22:59:24 -0700
Message-ID: <7vabxzrzur.fsf@assigned-by-dhcp.cox.net>
References: <7vtzw7tvvv.fsf@assigned-by-dhcp.cox.net>
	<20070327003033.4226.8413.julian@quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Tue Mar 27 07:59:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HW4iQ-0007UB-TL
	for gcvg-git@gmane.org; Tue, 27 Mar 2007 07:59:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934058AbXC0F71 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Mar 2007 01:59:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934059AbXC0F71
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Mar 2007 01:59:27 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:44210 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934058AbXC0F7Z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2007 01:59:25 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070327055924.RRUA748.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Tue, 27 Mar 2007 01:59:24 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id fhzQ1W00b1kojtg0000000; Tue, 27 Mar 2007 01:59:25 -0400
In-Reply-To: <20070327003033.4226.8413.julian@quantumfyre.co.uk> (Julian
	Phillips's message of "Tue, 27 Mar 2007 00:15:32 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43230>

Julian Phillips <julian@quantumfyre.co.uk> writes:

> diff --git a/contrib/workdir/git-new-workdir b/contrib/workdir/git-new-workdir
> new file mode 100755
> index 0000000..5bfd87e
> --- /dev/null
> +++ b/contrib/workdir/git-new-workdir
> @@ -0,0 +1,55 @@
> +#!/bin/bash

I do not see anything bash specific you need to do in your
script.

> +
> +function usage () {
> +	echo "usage:" $1;
> +	exit 127;
> +}
> +
> +function die () {
> +	echo $1;
> +	exit 128;
> +}

Do not add noiseword "function" in our shell scripts, please.
This is the only thing POSIX says "produces unspecified results"
I found in your script, so if you lose them you shouldn't have
to say "#!/bin/bash".

> +test $# -eq 3 || usage "$0 <original> <new_workdir> <branch>";
> +
> +orig_git=$1;
> +new_workdir=$2;
> +branch=$3;

Perhaps default branch to whatever original's HEAD points at?

> +
> +# want to make sure that what is pointed to has a .git directory ...
> +test -d ${orig_git}/.git || die "${original_git} is not a git repository!";
> +
> +# don't link to a workdir, link to the original repo the workdir is linked to
> +if test -L ${orig_git}/.git/config
> +then
> +	orig_git=$(dirname $(dirname $(readlink -f gm/.git/config)));
> +fi

"gm"?  I think it is not worth doing this, as readlink is not
all that portable.  Just see if it is a symlink and error out.

Dq all pathname values you get from the user, like "$orig_git".
They may have SP in them.

Do you need all those braces around shell variable names?

> +# vim: tabstop=8
> +# vim: noexpandtab

Lose these two lines, please.
