From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitweb: Sort projects with undefined ages last
Date: Sun, 09 Dec 2012 22:16:32 -0800
Message-ID: <7vip8actz3.fsf@alter.siamese.dyndns.org>
References: <1355114061-4652-1-git-send-email-mattjd@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthew Daley <mattjd@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 10 07:17:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Thwfk-0006U5-Ib
	for gcvg-git-2@plane.gmane.org; Mon, 10 Dec 2012 07:17:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751746Ab2LJGQn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Dec 2012 01:16:43 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49178 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751092Ab2LJGQm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Dec 2012 01:16:42 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 18B876962;
	Mon, 10 Dec 2012 01:16:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=I/G5ZnSBElVevS/iWexHtwFC1Ys=; b=v1VXPM
	n2+EGeRqu3ZPtZKaouJdiB4YtWi3oKw1lUMY+MPcQQk9o1mWho5j3NmMcKsYvFHf
	6etnRDylcYcTmTVCUfAUycUu+dR/F9s2HRr04d60W708lOKZpgOhDxrjNh9J156h
	aPosPrKwRO1NcnkO9Dtzd1Fn2z8PNr4h4te0M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fQBeYfAJp4VCbwI7nfmKXSORv8ZSPkEF
	zWRyLQM2BbP26iSBp6VXThEWWxF1d63QBpDnycQkhJc0jISqbFkVS0HbVrtWUUbx
	ajbHRklfU9eoVVDjDbkUAsB0NO71Fsc2amW77cBACP2LFXAYShnNPpK0Ir2OaW0o
	404nVZMGP9w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 06D416961;
	Mon, 10 Dec 2012 01:16:42 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 76E206942; Mon, 10 Dec 2012
 01:16:37 -0500 (EST)
In-Reply-To: <1355114061-4652-1-git-send-email-mattjd@gmail.com> (Matthew
 Daley's message of "Mon, 10 Dec 2012 17:34:21 +1300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 278044DE-4291-11E2-9493-995F2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211249>

Matthew Daley <mattjd@gmail.com> writes:

> Sorting gitweb's project list by age ('Last Change') currently shows
> projects with undefined ages at the head of the list. This results in a
> less useful result when there are a number of projects that are missing
> or otherwise faulty and one is trying to see what projects have been
> updated recently.
>
> Fix by sorting these projects with undefined ages at the bottom of the
> list when sorting by age.
>
> Signed-off-by: Matthew Daley <mattjd@gmail.com>
> ---
> I realize this might be a bit bikesheddy, but it does improve the listing
> in the given use case. For an example of the problem, see ie.
> http://git.kernel.org/?o=age or http://repo.or.cz/w?a=project_list;o=age .

Yeah, it could be argued that in a very minor corner case showing
new and empty ones at the top might attract more attention to them,
but new and empty ones can stay inactive, so this change would be an
overall improvement for these two sites.  An alternative could be to
give the mtime of the git directory to the age field if there is no
commits in the repository, to sink the empty and inactive ones to
the bottom quickly while showing newly created ones at the top, but
it shouldn't make any practical difference.

> I'm also not a Perl native, so any advice on making the patch good Perl is
> appreciated.
>
>  gitweb/gitweb.perl |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 0f207f2..21da1b5 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -5541,7 +5541,9 @@ sub sort_projects_list {
>  	if ($oi->{'type'} eq 'str') {
>  		@projects = sort {$a->{$oi->{'key'}} cmp $b->{$oi->{'key'}}} @$projlist;
>  	} else {
> -		@projects = sort {$a->{$oi->{'key'}} <=> $b->{$oi->{'key'}}} @$projlist;
> +		@projects = sort {$a->{$oi->{'key'}} <=> $b->{$oi->{'key'}}}
> +		            grep {defined $_->{$oi->{'key'}}} @$projlist;
> +		push @projects, grep {!defined $_->{$oi->{'key'}}} @$projlist;
>  	}

Two observations:

 * This iterates over the same @$projlist twice with grep, with one
   "defined" and the other "!defined", which may risk these two
   complementary grep conditions to go out of sync (it also may
   affect performance but that is a lessor issue).

   An alternative may be to change the expression used inside sort()
   to treat an undef as if it were a very large value, something
   like:

	sort {
        	defined $a->{$oi->{'key'}}
                ? (defined $b->{$oi->{'key'}}
                  ? ($a->{$oi->{'key'}} <=> $b->{$oi->{'key'}})
		  : -1)
                : (defined $b->{$oi->{'key'}} ? 1 : 0);
        }

 * This "sort undefs at the end is better than at the beginning" is
   good only for the "age" field, and we wouldn't know if we would
   add other keys for which it may be better to sort undef at the
   beginning.  The order_info{} currently has only one field of the
   'num' type, so this is not an immediate issue, but in order to
   future proof, it may make sense to rewrite the sort_projects_list
   function to map the order field name to a function given to sort,
   e.g.

	my %order_sort = (
		project => sub { $a->{'path'} cmp $b->{'path'} },
                descr => sub { $a->{'descr_long'} cmp $b->{'descr_long'} },
		owner => sub { $a->{'owner'} cmp $b->{'owner'} },
		age => sub { ... the num cmp with undef above ... },
	);
	if (!exists $order_sort{$order}) {
        	return @$projlist;
	}
	return sort $order_sort{$order} @$projlist;

I am not sure the second one is worth it, though.
