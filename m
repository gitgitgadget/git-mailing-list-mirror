From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitweb: Remove commit title from comitdiff_plain body
Date: Wed, 19 Mar 2008 15:35:37 -0700
Message-ID: <7vk5jy1gw6.fsf@gitster.siamese.dyndns.org>
References: <20080319222858.733.79714.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 19 23:36:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jc6tp-0008OO-Q1
	for gcvg-git-2@gmane.org; Wed, 19 Mar 2008 23:36:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935989AbYCSWfx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2008 18:35:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763823AbYCSWfw
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Mar 2008 18:35:52 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:40823 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935983AbYCSWfv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2008 18:35:51 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 3979821AD;
	Wed, 19 Mar 2008 18:35:48 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 7D46C21AC; Wed, 19 Mar 2008 18:35:44 -0400 (EDT)
In-Reply-To: <20080319222858.733.79714.stgit@localhost.localdomain> (Jakub
 Narebski's message of "Wed, 19 Mar 2008 23:28:58 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77576>

Jakub Narebski <jnareb@gmail.com> writes:

> Remove commit title (first line of commit message) from the "body" of
> commitdiff_plain view: it is present there already in format-patch
> like Subject: header.
>
> Signed-off-by: Jakub Narebski <jnareb@gmail.com>
> ---
>
>  gitweb/gitweb.perl |    5 ++++-
>  1 files changed, 4 insertions(+), 1 deletions(-)
>
>
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index ec73cb1..6e3ab85 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -5122,8 +5122,11 @@ sub git_commitdiff {
>  		print "Subject: " . to_utf8($co{'title'}) . "\n";
>  
>  		print "X-Git-Tag: $tagname\n" if $tagname;
> -		print "X-Git-Url: " . $cgi->self_url() . "\n\n";
> +		print "X-Git-Url: " . $cgi->self_url() . "\n";
>  
> +		# remove title, i.e. first line of log
> +		shift @{$co{'comment'}};
> +		# leading empty lines would separate headers from body
>  		foreach my $line (@{$co{'comment'}}) {
>  			print to_utf8($line) . "\n";
>  		}

You seem to be assuming messages that follow git convention, but is it a
good assumption here?  E.g. is the first element of @[$co{'comment'}]
always known to be non blank?  is the second element guaranteed to be
empty?
