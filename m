From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-archimport: allow remapping branch names
Date: Wed, 07 Mar 2007 00:09:43 -0800
Message-ID: <7vodn5iiew.fsf@assigned-by-dhcp.cox.net>
References: <eslrcr$9rc$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Wed Mar 07 09:09:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOrDa-0003UC-6J
	for gcvg-git@gmane.org; Wed, 07 Mar 2007 09:09:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030187AbXCGIJp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Mar 2007 03:09:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030196AbXCGIJp
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Mar 2007 03:09:45 -0500
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:60912 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030187AbXCGIJo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Mar 2007 03:09:44 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070307080945.MCEU2394.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Wed, 7 Mar 2007 03:09:45 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Xk9j1W00f1kojtg0000000; Wed, 07 Mar 2007 03:09:44 -0500
In-Reply-To: <eslrcr$9rc$1@sea.gmane.org> (Paolo Bonzini's message of "Wed, 07
	Mar 2007 08:59:22 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41655>

Paolo Bonzini <bonzini@gnu.org> writes:

> The new command-line syntax should not be a problem, since a colon
> in a branch name would be a pretty weird choice even for
> Arch standards.
>
> The new feature is implemented so that archives rotated every
> year can be remapped into a single git archive.

>  'git-archimport' [-h] [-v] [-o] [-a] [-f] [-T] [-D depth] [-t tempdir]
> -               <archive/branch> [ <archive/branch> ]
> +               <archive/branch>[:<git-branch>] ...
> ...
> -my %arch_branches = map { $_ => 1 } @ARGV;
> +my %arch_branches = map { my $branch = $_; $branch =~ s/:.*//; $branch => 1 } @ARGV;
> +
> +# $branch_name_map:
> +# maps arch branches to git branch names
> +my %branch_name_map = map { m/^([^:]*):(.*)/; $1 => $2 } grep { m/:/ } @ARGV;

I am no arch/tla expert, but at least git does not allow colon
in branch names at all, so if you make your command line parser
to match left-greedy-anything, colon and then right-non-colon
(i.e. m/^(.*):([^:]*)$/), you should be able to handle colons in
arch archive names.
