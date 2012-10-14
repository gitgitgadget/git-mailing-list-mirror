From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] git-cvsimport: allow local timezone for commits
Date: Sat, 13 Oct 2012 23:04:21 -0700
Message-ID: <7vfw5hzj16.fsf@alter.siamese.dyndns.org>
References: <cover.1350100320.git.chris@rorvick.com>
 <db5c9b72e08ed9d5522f38098d68126e5d3c7e5a.1350100320.git.chris@rorvick.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Chris Rorvick <chris@rorvick.com>
X-From: git-owner@vger.kernel.org Sun Oct 14 08:05:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNHK3-0004V5-2n
	for gcvg-git-2@plane.gmane.org; Sun, 14 Oct 2012 08:05:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752165Ab2JNGEZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Oct 2012 02:04:25 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45705 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752002Ab2JNGEY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Oct 2012 02:04:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 970A46E02;
	Sun, 14 Oct 2012 02:04:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=55Zx6w8Mk0XEYt2U5Xb0UmzxyTA=; b=f3iUiL
	OyrzhNNZJapGKGhGX6rguVcLN9/9WVOEas6nDVaUZSyEsJ4sBodSWa6liiIZfMaP
	M1gANrl/ncspQxdM2lMuML2DrtZwP6Q/C5ZS11dqLV1EACfoTTpDjiCx0K5jrxNM
	F5j9DIR6HneoXe/ylnYlzlFTWwumT9v4W2jic=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=stQwO+oP4mjtdhj/s1UtlpLZN/y4fOYW
	HVbu8vuMj13MVATTOQiexDd6pIsamedz5JwJSZz7qgw/bhiZ4Q+d74tfLvaE6n5N
	LpY1W5zQVr/wFWWXNX/NMUkJGSdeKOvVMXsrObDXgQJqEIzIXwrjhqal00H1KoMY
	ZojCr9lyOlo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 847BF6E01;
	Sun, 14 Oct 2012 02:04:23 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B8D986DFF; Sun, 14 Oct 2012
 02:04:22 -0400 (EDT)
In-Reply-To: <db5c9b72e08ed9d5522f38098d68126e5d3c7e5a.1350100320.git.chris@rorvick.com>
 (Chris Rorvick's message of "Fri, 12 Oct 2012 23:11:55 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0005A956-15C5-11E2-9B74-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207636>

Chris Rorvick <chris@rorvick.com> writes:

> CVS patches are imported with the timezone offset of +0000 (UTC).
> Allow timezone offsets to be calculated from the the local timezone by
> adding -l to the command line or specifying cvsimport.l in the config.

A single "I do not like everybody's timestamp is in GMT, so instead
use the local timezone I the importer happen to be in" sounds more
like an uninteresting hack with limited application than a useful
new feature.  Even back in CVS days, many projects and repositories
worth converting to Git were multi-people projects that span across
timezones.

I am wondering if it is sufficient to enhance existing cvs-authors
file to tie a person to a timezone to add a feature like this in a
more sensible manner.  I'd assume that in many multi-person project,
one person, even when travelling, tend to record commits in a single
timezone (i.e. his or her home timezone).  Even for a single-person
project, adding a single entry ot the file is not too much to ask to
the user.  Being able to view his human-readable name and timezone
would be good value for the amount of trouble.

> This could be made the default behavior, as setting TZ=UTC in the
> environment before doing the import is equivalent to the current
> behavior.  But since a new default may be an unwelcome surprise to
> some, make this new behavior available as an option.

This, just like use of cvs-authors, will never be the default.

When you and somebody else import the same history recorded in the
same CVS repository, you would want to see the same resulting
history, and that is even more true when these two people may
perform their import incrementally.  If you switch the default
in one version of Git, their histories will diverge at a different
place depending on when their sysadmins updated Git.

The repeatability is why the script does not use the local timezone
the importer happens to be in.


> Signed-off-by: Chris Rorvick <chris@rorvick.com>
> ---
>  Documentation/git-cvsimport.txt |   13 ++++++++++---
>  git-cvsimport.perl              |    9 +++++----
>  2 files changed, 15 insertions(+), 7 deletions(-)
>
> diff --git a/Documentation/git-cvsimport.txt b/Documentation/git-cvsimport.txt
> index 6695ab3..9059ad1 100644
> --- a/Documentation/git-cvsimport.txt
> +++ b/Documentation/git-cvsimport.txt
> @@ -11,9 +11,9 @@ SYNOPSIS
>  [verse]
>  'git cvsimport' [-o <branch-for-HEAD>] [-h] [-v] [-d <CVSROOT>]
>  	      [-A <author-conv-file>] [-p <options-for-cvsps>] [-P <file>]
> -	      [-C <git_repository>] [-z <fuzz>] [-i] [-k] [-u] [-s <subst>]
> -	      [-a] [-m] [-M <regex>] [-S <regex>] [-L <commitlimit>]
> -	      [-r <remote>] [-R] [<CVS_module>]
> +	      [-C <git_repository>] [-z <fuzz>] [-i] [-k] [-l] [-u]
> +	      [-s <subst>] [-a] [-m] [-M <regex>] [-S <regex>]
> +	      [-L <commitlimit>] [-r <remote>] [-R] [<CVS_module>]
>  
>  
>  DESCRIPTION
> @@ -89,6 +89,13 @@ the old cvs2git tool.
>  	to avoid noisy changesets. Highly recommended, but off by default
>  	to preserve compatibility with early imported trees.
>  
> +-l::
> +	Use the local timezone for computing the timezone offset of commit
> +	timestamps instead of the default of +0000 (UTC).  The `TZ`
> +	environment variable can be used to override the default local
> +	timezone, possibly useful if you are importing from a non-local
> +	repository.
> +
>  -u::
>  	Convert underscores in tag and branch names to dots.
>  
> diff --git a/git-cvsimport.perl b/git-cvsimport.perl
> index 2f5da9e..927d75c 100755
> --- a/git-cvsimport.perl
> +++ b/git-cvsimport.perl
> @@ -28,9 +28,8 @@ use POSIX qw(strftime dup2 ENOENT);
>  use IPC::Open2;
>  
>  $SIG{'PIPE'}="IGNORE";
> -$ENV{'TZ'}="UTC";
>  
> -our ($opt_h,$opt_o,$opt_v,$opt_k,$opt_u,$opt_d,$opt_p,$opt_C,$opt_z,$opt_i,$opt_P, $opt_s,$opt_m,@opt_M,$opt_A,$opt_S,$opt_L, $opt_a, $opt_r, $opt_R);
> +our ($opt_h,$opt_o,$opt_v,$opt_k,$opt_u,$opt_l,$opt_d,$opt_p,$opt_C,$opt_z,$opt_i,$opt_P, $opt_s,$opt_m,@opt_M,$opt_A,$opt_S,$opt_L, $opt_a, $opt_r, $opt_R);
>  my (%conv_author_name, %conv_author_email);
>  
>  sub usage(;$) {
> @@ -40,7 +39,7 @@ sub usage(;$) {
>  Usage: git cvsimport     # fetch/update GIT from CVS
>         [-o branch-for-HEAD] [-h] [-v] [-d CVSROOT] [-A author-conv-file]
>         [-p opts-for-cvsps] [-P file] [-C GIT_repository] [-z fuzz] [-i] [-k]
> -       [-u] [-s subst] [-a] [-m] [-M regex] [-S regex] [-L commitlimit]
> +       [-l] [-u] [-s subst] [-a] [-m] [-M regex] [-S regex] [-L commitlimit]
>         [-r remote] [-R] [CVS_module]
>  END
>  	exit(1);
> @@ -128,7 +127,7 @@ sub read_repo_config {
>  	}
>  }
>  
> -my $opts = "haivmkuo:d:p:r:C:z:s:M:P:A:S:L:R";
> +my $opts = "haivmkulo:d:p:r:C:z:s:M:P:A:S:L:R";
>  read_repo_config($opts);
>  Getopt::Long::Configure( 'no_ignore_case', 'bundling' );
>  
> @@ -138,6 +137,8 @@ GetOptions( map { s/:/=s/; /M/ ? "$_\@" : $_ } split( /(?!:)/, $opts ) )
>      or usage();
>  usage if $opt_h;
>  
> +$ENV{'TZ'}="UTC" unless $opt_l;
> +
>  if (@ARGV == 0) {
>  		chomp(my $module = `git config --get cvsimport.module`);
>  		push(@ARGV, $module) if $? == 0;
