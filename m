From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/4] Git.pm: config_boolean() -> config_bool()
Date: Fri, 27 Apr 2007 23:27:42 -0700
Message-ID: <7v7irxko81.fsf@assigned-by-dhcp.cox.net>
References: <20070427020601.22991.13792.stgit@rover>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Sat Apr 28 08:27:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HhgPM-0006Vi-2v
	for gcvg-git@gmane.org; Sat, 28 Apr 2007 08:27:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754726AbXD1G1p (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 Apr 2007 02:27:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754732AbXD1G1p
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Apr 2007 02:27:45 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:58082 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754726AbXD1G1n (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Apr 2007 02:27:43 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070428062743.LLST1218.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Sat, 28 Apr 2007 02:27:43 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id sWTi1W00J1kojtg0000000; Sat, 28 Apr 2007 02:27:43 -0400
In-Reply-To: <20070427020601.22991.13792.stgit@rover> (Petr Baudis's message
	of "Fri, 27 Apr 2007 04:06:01 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45770>

Petr Baudis <pasky@suse.cz> writes:

> This patch renames config_boolean() to config_bool() for consistency with
> the commandline interface and because it is shorter but still obvious. ;-)
> It also changes the return value from some obscure string to real Perl
> boolean, allowing for clean user code.

Doesn't this break send-email?

> @@ -526,14 +528,16 @@ This currently wraps command('config') s
>  
>  =cut
>  
> -sub config_boolean {
> +sub config_bool {
>  	my ($self, $var) = @_;
>  	$self->repo_path()
>  		or throw Error::Simple("not a repository");
>  
>  	try {
> -		return $self->command_oneline('config', '--bool', '--get',
> +		my $var = $self->command_oneline('config', '--bool', '--get',
>  					      $var);
> +		return undef unless defined $var;
> +		return $var eq 'true';

Did you mean to hide $var in the nested scope?
