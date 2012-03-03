From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH (BUGFIX)] gitweb: Fix fixed string (non-regexp) project
 search
Date: Fri, 02 Mar 2012 16:08:33 -0800
Message-ID: <7vwr72a6m6.fsf@alter.siamese.dyndns.org>
References: <20120228183919.26435.86795.stgit@localhost.localdomain>
 <4F512327.3050504@ramsay1.demon.co.uk> <201203022334.25544.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 03 01:08:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3cWr-0002P0-GZ
	for gcvg-git-2@plane.gmane.org; Sat, 03 Mar 2012 01:08:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965617Ab2CCAIh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Mar 2012 19:08:37 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38452 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965489Ab2CCAIg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2012 19:08:36 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A6DB6663F;
	Fri,  2 Mar 2012 19:08:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9/EH3F3VDwC2DFbIgHymmNPK174=; b=xg20BS
	eN7JldM8SOnfEPOAEsLocXqmoMhIghS3J/BBfH1tYq4sXDKHYh7RyGl9PNqf3SSb
	nA61xWzHXYnONN65OB2SyBmb1ypY8zHwuZSdmnlwSO0ji3ZZcmdTV43bk0TiHcr1
	83ebMIppcIeygR+eoQbOk5iMro5RXgrG8OMeo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=c39gnK3y+4GS4TNc5GTUUuQKEBrUPDqB
	D9yvjN/REWp6/dmiUn5pPqKSm89W8rylJ2yICTCqAtcTWwFyfMVxiMwWzlkXpmHp
	lLk1Afa6Eq8mr5YTtI8LO65Zr0lP3eTeI+EoxauGABI/1C4wJ5/m8YdFdgudC3FL
	3mx1zLb/14o=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9EB35663D;
	Fri,  2 Mar 2012 19:08:35 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F1566663C; Fri,  2 Mar 2012
 19:08:34 -0500 (EST)
In-Reply-To: <201203022334.25544.jnareb@gmail.com> (Jakub Narebski's message
 of "Fri, 2 Mar 2012 23:34:24 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 04D1702A-64C5-11E1-AED5-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192075>

Jakub Narebski <jnareb@gmail.com> writes:

> Use $search_regexp, where regex metacharacters are quoted, for
> searching projects list, rather than $searchtext, which contains
> original search term.
>
> Reported-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
> Signed-off-by: Jakub Narebski <jnareb@gmail.com>
> ---
> I think this bug was here from the very beginning of adding project
> search, i.e. from  v1.6.0.2-446-g0d1d154 (gitweb: Support for simple
> project search form, 2008-10-03)  which was present since 1.6.1
>
> On Fri, 2 Mar 2012, Ramsay Jones wrote:
> 
>> This patch solves the problem for me when using a regex search
>> (re checkbox checked), but *not* for a non-regex search.
>> 

This patch depends on the more recent changes than the regexp fix, no?  I
was hoping that we could merge the earlier fix for the regexp case to
older maintenance tracks later, but if we were going to do so, we would
want to do the same for a fix for fixed-string case.

I am fine with not to worrying too much about older maintenance tracks,
and applying this directly to 'master', but just wanted to see what your
preference is.

Thanks.

>> If you have a leading '*' or '+', in the non-regex case, then you
>> still get the above complaint (and xml error page etc.), although
>> the line number has changed slightly from that given above.
>
> Ramsay, please provide those line number in the future, together with
> line and if possible some context.
>
> The line is different because it is different bug: this is about not
> using quotemeta'ed string for search for fixed-string search.
>
>  gitweb/gitweb.perl |   22 +++++++++++-----------
>  1 files changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 22ad279..7398be1 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -3072,16 +3072,16 @@ sub filter_forks_from_projects_list {
>  # for 'descr_long' and 'ctags' to be filled
>  sub search_projects_list {
>  	my ($projlist, %opts) = @_;
> -	my $tagfilter  = $opts{'tagfilter'};
> -	my $searchtext = $opts{'searchtext'};
> +	my $tagfilter = $opts{'tagfilter'};
> +	my $search_re = $opts{'search_regexp'};
>  
>  	return @$projlist
> -		unless ($tagfilter || $searchtext);
> +		unless ($tagfilter || $search_re);
>  
>  	# searching projects require filling to be run before it;
>  	fill_project_list_info($projlist,
> -	                       $tagfilter  ? 'ctags' : (),
> -	                       $searchtext ? ('path', 'descr') : ());
> +	                       $tagfilter ? 'ctags' : (),
> +	                       $search_re ? ('path', 'descr') : ());
>  	my @projects;
>   PROJECT:
>  	foreach my $pr (@$projlist) {
> @@ -3092,10 +3092,10 @@ sub search_projects_list {
>  				grep { lc($_) eq lc($tagfilter) } keys %{$pr->{'ctags'}};
>  		}
>  
> -		if ($searchtext) {
> +		if ($search_re) {
>  			next unless
> -				$pr->{'path'} =~ /$searchtext/ ||
> -				$pr->{'descr_long'} =~ /$searchtext/;
> +				$pr->{'path'} =~ /$search_re/ ||
> +				$pr->{'descr_long'} =~ /$search_re/;
>  		}
>  
>  		push @projects, $pr;
> @@ -5498,9 +5498,9 @@ sub git_project_list_body {
>  		if ($check_forks);
>  	# search_projects_list pre-fills required info
>  	@projects = search_projects_list(\@projects,
> -	                                 'searchtext' => $searchtext,
> -	                                 'tagfilter'  => $tagfilter)
> -		if ($tagfilter || $searchtext);
> +	                                 'search_regexp' => $search_regexp,
> +	                                 'tagfilter' => $tagfilter)
> +		if ($tagfilter || $search_regexp);
>  	# fill the rest
>  	@projects = fill_project_list_info(\@projects);
