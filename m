From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] cvsexportcommit: Create config option for CVS dir
Date: Wed, 21 May 2008 12:51:38 -0700
Message-ID: <7vprrf1lmd.fsf@gitster.siamese.dyndns.org>
References: <1210282015-20872-1-git-send-email-tpiepho@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Trent Piepho <tpiepho@freescale.com>,
	Robin Rosenberg <robin.rosenberg@dewire.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 21 21:53:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JyuMg-00045N-1g
	for gcvg-git-2@gmane.org; Wed, 21 May 2008 21:52:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759015AbYEUTvy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 May 2008 15:51:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758974AbYEUTvx
	(ORCPT <rfc822;git-outgoing>); Wed, 21 May 2008 15:51:53 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:37626 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756600AbYEUTvv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 May 2008 15:51:51 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 63A486898;
	Wed, 21 May 2008 15:51:50 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id A988A6893; Wed, 21 May 2008 15:51:42 -0400 (EDT)
In-Reply-To: <1210282015-20872-1-git-send-email-tpiepho@freescale.com> (Trent
 Piepho's message of "Thu, 8 May 2008 14:26:55 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 5A7CABE4-276F-11DD-943B-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82575>

Last night I was going through old mail-logs and found this, which I think
would be nice.  Does anybody see anything wrong with the patch?

Trent Piepho <tpiepho@freescale.com> writes:

> For a given project the directory used with the -w option is almost always
> the same each time.  Let it be specified with 'cvsexportcommit.cvsdir' so
> it's not necessary to manually add it with -w each time.
>
> Signed-off-by: Trent Piepho <tpiepho@freescale.com>
> ---
>  Documentation/git-cvsexportcommit.txt |    8 +++++++-
>  git-cvsexportcommit.perl              |    5 +++++
>  2 files changed, 12 insertions(+), 1 deletions(-)
>
> diff --git a/Documentation/git-cvsexportcommit.txt b/Documentation/git-cvsexportcommit.txt
> index 9a47b4c..363c36d 100644
> --- a/Documentation/git-cvsexportcommit.txt
> +++ b/Documentation/git-cvsexportcommit.txt
> @@ -65,11 +65,17 @@ OPTIONS
>  -w::
>  	Specify the location of the CVS checkout to use for the export. This
>  	option does not require GIT_DIR to be set before execution if the
> -	current directory is within a git repository.
> +	current directory is within a git repository.  The default is the
> +	value of 'cvsexportcommit.cvsdir'.
>  
>  -v::
>  	Verbose.
>  
> +CONFIGURATION
> +-------------
> +cvsexportcommit.cvsdir::
> +	The default location of the CVS checkout to use for the export.
> +
>  EXAMPLES
>  --------
>  
> diff --git a/git-cvsexportcommit.perl b/git-cvsexportcommit.perl
> index b6036bd..c93bd9c 100755
> --- a/git-cvsexportcommit.perl
> +++ b/git-cvsexportcommit.perl
> @@ -6,6 +6,7 @@ use File::Temp qw(tempdir);
>  use Data::Dumper;
>  use File::Basename qw(basename dirname);
>  use File::Spec;
> +use Git;
>  
>  our ($opt_h, $opt_P, $opt_p, $opt_v, $opt_c, $opt_f, $opt_a, $opt_m, $opt_d, $opt_u, $opt_w);
>  
> @@ -15,6 +16,10 @@ $opt_h && usage();
>  
>  die "Need at least one commit identifier!" unless @ARGV;
>  
> +# Get git-config settings
> +my $repo = Git->repository();
> +$opt_w = $repo->config('cvsexportcommit.cvsdir') unless defined $opt_w;
> +
>  if ($opt_w) {
>  	# Remember where GIT_DIR is before changing to CVS checkout
>  	unless ($ENV{GIT_DIR}) {
> -- 
> 1.5.4.1
