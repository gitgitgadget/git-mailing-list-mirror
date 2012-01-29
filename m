From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 1/2] gitweb: add project_filter to limit project list
 to a subdirectory
Date: Sun, 29 Jan 2012 13:06:21 -0800
Message-ID: <7v7h0afcc2.fsf@alter.siamese.dyndns.org>
References: <20120128165606.GA6770@server.brlink.eu>
 <m3wr8bcuon.fsf@localhost.localdomain>
 <20120129012234.GD16079@server.brlink.eu>
 <201201291354.50241.jnareb@gmail.com>
 <20120129160615.GA13937@server.brlink.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: "Bernhard R. Link" <brl+git@mail.brlink.eu>
X-From: git-owner@vger.kernel.org Sun Jan 29 22:06:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RrbxG-00087a-MM
	for gcvg-git-2@plane.gmane.org; Sun, 29 Jan 2012 22:06:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751834Ab2A2VGZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jan 2012 16:06:25 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63246 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753030Ab2A2VGY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jan 2012 16:06:24 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D46DE66D2;
	Sun, 29 Jan 2012 16:06:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=M85IWhMAwnwpiXLIukYSu4HjAfE=; b=vQ3MtF
	aaiCSOTU+R+fSZUhDZyMD/dFpJHzRIHqYw0QD+IWSTTc9Yje9haUdmxdtI1qHnSt
	cI7cw1LcMPVZX7g8yg88HJPGeJBVQyDSNFpRLBC5XKIUCVizDG9O4oebxurBMbzt
	E3j0skOn/b2WQNAefkkmx3EvlLMdD/fR5TZr0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uc1vWL9VMRm4TBaAus1sTzZ2aG955Fe/
	TkInZVlTwZgrBIXDA+x4xihIdG8ZZWj61WGgFBK1v4S917pKJ0LFr04eeIYrEMlz
	vz8Llie4fxyfojtFzXvHsU3iSAH4kI4GEMHAbsyuGKLk+YTPZwk5RivMO90Vn0yH
	Rg3r/HmY9js=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CC40466CE;
	Sun, 29 Jan 2012 16:06:23 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 33D9966CD; Sun, 29 Jan 2012
 16:06:23 -0500 (EST)
In-Reply-To: <20120129160615.GA13937@server.brlink.eu> (Bernhard R. Link's
 message of "Sun, 29 Jan 2012 17:06:15 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 19570676-4ABD-11E1-9576-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189297>

"Bernhard R. Link" <brl+git@mail.brlink.eu> writes:

> This commit changes the project listing views (project_list,
> project_index and opml) to limit the output to only projects in a
> subdirectory if the new optional parameter ?pf=directory name is used.
>
> The change is quite minimal as git_get_projects_list already can limit
> itself to a subdirectory (though that was previously only used for
> 'forks').
>
> If there is a GITWEB_LIST file, the contents are just filtered like
> with the forks action.

Meaning, a directory is shown if it is listed on GITWEB_LIST and is a
subdirectory of the directory specified with project_filter?  If so,
spelling it out instead of saying "just filtered like with the forks
action" may be clearer without making the description excessively longer.

> Without a GITWEB_LIST file only the given subdirectory is searched
> for projects (like with forks) unless GITWEB_STRICT_EXPORT is enabled.
> In the later case GITWEB_PROJECTROOT is traversed normally (unlike
> with forks) and projects not in the directory ignored.

It is unclear to me what "In the later case" refers to, even assuming that
it is a typo of "the latter case".

Do you mean "When there is no GITWEB_LIST but GITWEB_STRICT_EXPORT is set,
project_filter that specifies anything outside GITWEB_PROJECTROOT is
ignored"?

A more fundamental issue I have with this patch is how an end user starts
using this. Once project_filter is set, the breadcrumbs would let the user
click and navigate around, but in my superficial glance at the patch it is
not apparent how the initial setting of project_filter can happen without
the user manually adding pf= to the URL, which is a less than ideal end
user experience.

> @@ -2839,7 +2848,7 @@ sub git_get_projects_list {
>  		my $pfxlen = length("$dir");
>  		my $pfxdepth = ($dir =~ tr!/!!);
>  		# when filtering, search only given subdirectory
> -		if ($filter) {
> +		if ($filter and not $paranoid) {
>  			$dir .= "/$filter";
>  			$dir =~ s!/+$!!;
>  		}
> @@ -2864,6 +2873,10 @@ sub git_get_projects_list {
>  				}
>  
>  				my $path = substr($File::Find::name, $pfxlen + 1);
> +				# paranoidly only filter here
> +				if ($paranoid && $filter && $path !~ m!^\Q$filter\E/!) {
> +					next;
> +				}

When you find "foo" directory and a project_filter tells you to match
"foo", because $path does not match "^foo/", it will not match (even
though its subdirectory "foo/bar" would)?

> +sub print_nav_breadcrumbs_path {
> +	my $dirprefix = undef;
> +	while (my $part = shift) {
> +		$dirprefix .= "/" if defined $dirprefix;
> +		$dirprefix .= $part;
> +		print $cgi->a({-href => href(project => undef,
> +		                             project_filter => $dirprefix,
> +					     action=>"project_list")},
> +			      esc_html($part)) . " / ";
> +	}
> +}
> +
>  sub print_nav_breadcrumbs {
>  	my %opts = @_;
>  
> @@ -3841,6 +3866,8 @@ sub print_nav_breadcrumbs {
>  			print " / $opts{-action_extra}";
>  		}
>  		print "\n";
> +	} elsif (defined $project_filter) {
> +		print_nav_breadcrumbs_path(split '/', $project_filter);
>  	}
>  }

Hmm.

While this may not be wrong, I wonder if this is limiting a useful feature
too narrowly. When I visit "/pub/scm /linux/kernel/git/torvals/linux.git"
at git.kernel.org, for example, there currently are two links, "/pub/scm"
to the toplevel and "/linux/kernel/git/torvals/linux.git" to itself. I
often wish to see uplinks to intermediate levels like "/linux/kernel/git"
and "/linux/kernel/git/torvalds".

Perhaps that is the topic of your second patch. I dunno.
