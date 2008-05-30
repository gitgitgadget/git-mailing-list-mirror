From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] perl/Git.pm: add rev_parse method
Date: Fri, 30 May 2008 11:50:47 +0200
Message-ID: <20080530095047.GD18781@machine.or.cz>
References: <1212122585-7350-1-git-send-email-LeWiemann@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Lea Wiemann <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 30 11:51:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K21Gy-00026L-MO
	for gcvg-git-2@gmane.org; Fri, 30 May 2008 11:51:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752813AbYE3Juv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 May 2008 05:50:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752787AbYE3Juv
	(ORCPT <rfc822;git-outgoing>); Fri, 30 May 2008 05:50:51 -0400
Received: from w241.dkm.cz ([62.24.88.241]:52418 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752491AbYE3Juu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 May 2008 05:50:50 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id EC08A1E4C02F; Fri, 30 May 2008 11:50:47 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1212122585-7350-1-git-send-email-LeWiemann@gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83281>

Hi,

On Fri, May 30, 2008 at 06:43:05AM +0200, Lea Wiemann wrote:
> diff --git a/perl/Git.pm b/perl/Git.pm
> index d05b633..9ef8cb0 100644
> --- a/perl/Git.pm
> +++ b/perl/Git.pm
> @@ -716,6 +716,28 @@ sub ident_person {
>  	return "$ident[0] <$ident[1]>";
>  }
>  
> +=item rev_parse ( REVISION_NAME )

I believe it would be more consistent to call it parse_rev() and in fact
also less confusing since this is not full-fledged rev-parse frontend
(and probably should not be; rev-parse is terribly overloaded with much
more stuff).

> +
> +Look up the specified revision name and return the SHA1 hash, or
> +return undef if the lookup failed.  See the git-rev-parse command.
> +
> +=cut
> +
> +sub rev_parse {
> +    # We could allow for a list of revisions here.
> +    my ($self, $rev_name) = @_;
> +
> +    my $hash;
> +    try {
> +        # The --default option works around rev-parse's lack of
> +        # support for getopt style "--" separators (it would fail for
> +        # tags named "--foo" without it).
> +        $hash = $self->command_oneline("rev-parse", "--verify", "--default",
> +                                       $rev_name);
> +    } catch Git::Error::Command with { };

I think it is better style to use the regular pattern of checking
$E->value() and either return undef right away or pass the exception
(e.g. in case rev-parse cannot be executed for some reason).

> +    return undef unless defined $hash and $hash =~ /^([0-9a-fA-F]{40})$/;

When can this trigger?

> +    $hash;
> +}
>  
>  =item hash_object ( TYPE, FILENAME )
>  

-- 
				Petr "Pasky" Baudis
Whatever you can do, or dream you can, begin it.
Boldness has genius, power, and magic in it.	-- J. W. von Goethe
