From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitweb: squelch harmless variable scoping errors
Date: Sat, 08 Aug 2009 11:40:20 -0700
Message-ID: <7vvdkygne3.fsf@alter.siamese.dyndns.org>
References: <F203660D-5123-475D-8288-F398EA670002@mailservices.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
	Mark A Rada <marada@uwaterloo.ca>
To: merlyn@stonehenge.com (Randal L. Schwartz)
X-From: git-owner@vger.kernel.org Sat Aug 08 20:40:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZqqP-0004Cj-RL
	for gcvg-git-2@gmane.org; Sat, 08 Aug 2009 20:40:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752952AbZHHSkc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Aug 2009 14:40:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752911AbZHHSkb
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Aug 2009 14:40:31 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:54947 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751930AbZHHSkb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Aug 2009 14:40:31 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D206622C41;
	Sat,  8 Aug 2009 14:40:31 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 06D6322C3F; Sat,  8 Aug 2009
 14:40:21 -0400 (EDT)
In-Reply-To: <F203660D-5123-475D-8288-F398EA670002@mailservices.uwaterloo.ca>
 (Mark A. Rada's message of "Sat\, 8 Aug 2009 12\:50\:35 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F3AC1488-844A-11DE-B434-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125296>

Mark A Rada <marada@uwaterloo.ca> writes:

> I fiddled around a bit and this solution seems to work, but is a bit
> odd, as the method is declared obsolete in the Perl documentation
> (v5.8.8).
>
> What do you think?

I'd prefer to summon our resident Perl expert ;-)

> --
> Mark A Rada (ferrous26)
> marada@uwaterloo.ca
>
>
> --->8---
> This will use the 'vars' method of declaring global variables instead
> of the 'our' method.
>
> Though 'vars' has been obsoleted, it has the advantage of pre-declaring
> global symbols; this ensures that those symbols will be available to
> routines loaded later, whereas 'our' does not seem to do this.
>
> The result is that when using mod_perl you will no longer get any
> warnings printed to your error_log.
>
> Signed-off-by: Mark Rada <marada@uwaterloo.ca>
> ---
> gitweb/gitweb.perl |    8 +++++---
> 1 files changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 37120a3..0544aa2 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -57,12 +57,14 @@ if ($path_info) {
> our $GIT = "++GIT_BINDIR++/git";
>
> # absolute fs-path which will be prepended to the project path
> -#our $projectroot = "/pub/scm";
> -our $projectroot = "++GITWEB_PROJECTROOT++";
> +use vars qw($projectroot);
> +#$projectroot = "/pub/scm";
> +$projectroot = "++GITWEB_PROJECTROOT++";
>
> # fs traversing limit for getting project list
> # the number is relative to the projectroot
> -our $project_maxdepth = "++GITWEB_PROJECT_MAXDEPTH++";
> +use vars qw($project_maxdepth);
> +$project_maxdepth = "++GITWEB_PROJECT_MAXDEPTH++";
>
> # target of the home link on top of all pages
> our $home_link = $my_uri || "/";
> -- 
> 1.6.4
