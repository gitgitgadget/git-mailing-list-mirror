From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v2 05/11] gitweb: git_split_heads_body function.
Date: Sat, 15 Nov 2008 00:59:14 +0100
Message-ID: <200811150059.14515.jnareb@gmail.com>
References: <1226616555-24503-1-git-send-email-giuseppe.bilotta@gmail.com> <1226616555-24503-5-git-send-email-giuseppe.bilotta@gmail.com> <1226616555-24503-6-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 15 01:00:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L18aY-0005y3-Ux
	for gcvg-git-2@gmane.org; Sat, 15 Nov 2008 01:00:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751815AbYKNX7T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Nov 2008 18:59:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751822AbYKNX7T
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Nov 2008 18:59:19 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:34748 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751697AbYKNX7S (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Nov 2008 18:59:18 -0500
Received: by ug-out-1314.google.com with SMTP id 39so18759ugf.37
        for <git@vger.kernel.org>; Fri, 14 Nov 2008 15:59:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=jUeA83XU5X/W9XuPJ4RBV6LwuPd1MsFueD7a+yz0a10=;
        b=MGvL/lbi4Nqb9ujEN33ur0s389EVpl8owEJquOCKI7EhRMND410jEFT4lcNBrLWa7t
         pwi3xLs+TmHrQ/QjvoFjjH0/I/4FMjG1samNE0SlnTHtkVNnBC2+m4nAY8RYV+3QUG74
         LfTPx6XFU2nTzJt/nftBywTF5Mjx9LHdBSYdg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=ZTtwZTg0bCSh9ISI9axDb0jXUYGdsA0HyBMNkY9lSFd3e2QzH0A6S7lXcs5NkjGhnx
         dDrddu8qgIPLmu0O4j5WNB0+9sAk4NzFjWkLS37PQC+rU9/1qUcxp1z/aDCjRdRDqoDp
         A1AIPikfB19VCVmzfwNpdJywsSmkMYzKjZoEY=
Received: by 10.67.26.7 with SMTP id d7mr41106ugj.16.1226707156654;
        Fri, 14 Nov 2008 15:59:16 -0800 (PST)
Received: from ?192.168.1.11? (abwt29.neoplus.adsl.tpnet.pl [83.8.243.29])
        by mx.google.com with ESMTPS id j34sm43243ugc.53.2008.11.14.15.59.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 14 Nov 2008 15:59:15 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <1226616555-24503-6-git-send-email-giuseppe.bilotta@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101036>

On Thu, 13 Nov 2008, Giuseppe Bilotta wrote:

> The purpose of this function is to split a headlist into groups
> determined by the leading part of the refname, and call git_heads_body()
> on each group.

What is the reason of this patch? Is it to split remote-tracking
branches ('remotes' references) into remotes, and group them by
the remote repository name?

If it is true, then first: you should have wrote the _reason_ behind
this patch and not only what it does in this commit message. And use
better summary (commit title / subject of this patch).

Second, this patch wouldn't do what you want from it if there are
remotes with '/' in name.  I for example use "gsoc2008/gitweb-caching"
for Lea Wiemann repository with her GSoC 2008 work on adding caching
to gitweb.  Because there are many ways to specify remotes due to
backwards compatibility (and simplicity, as some for example prefer
old 'branches/' way to specify remotes), namely config, files under
'.git/remotes', and (from Cogito) files in '.git/branches', you would
have to either reimplement/reuse parts of git-remote (there is old Perl
implementation in contrib/examples), or use "git remote" or 
"git remote -v" command output[1].


So from me there is slight NAK on this patch, in this form.

> 
> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
> ---
>  gitweb/gitweb.perl |   33 ++++++++++++++++++++++++++++++++-
>  1 files changed, 32 insertions(+), 1 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index a736f2a..836b6ba 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -4271,6 +4271,37 @@ sub git_tags_body {
>  	print "</table>\n";
>  }
>  
> +sub git_split_heads_body {
> +	my ($headlist, $head, $from, $to, $extra) = @_;

It should probably be said somewhere that git_split_heads_body has to
have the same signature as git_heads_body.

> +	my %headlists;
> +	my $leader; my $list; my @list;

Style - I would use:

+	my ($leader, $list, @list);

although I wouldn't use $list and @list together...

> +
> +	# Split @$headlist into a hash of lists
> +	map {
> +		my %ref = %$_;
> +		$ref{'hname'} = $ref{'name'};
> +		if ($ref{'name'} =~ /\//) {
> +			$ref{'name'} =~ s!^([^/]+)/!!;

As I said, this would fail on for example "gsoc2008/gitweb-caching"
remote...

> +			$leader = $1;
> +		} else {
> +			$leader = "\000";

Can't you use undef or "" for $leader? $headlists{undef} works...

> +		}
> +		if (defined $headlists{$leader}) {
> +			@list = @{$headlists{$leader}}
> +		} else {
> +			@list = ()
> +		}
> +		push @list, \%ref;
> +		$headlists{$leader} = [@list];

We have similar code in href(), but we use there:

  if (defined $ref{key}) {
  	push @{$ref{$key}}, $elem;
  } else {
  	$ref{$key} = [ $elem ];
  }

Isn't it simpler and easier to understand?


> +	} @$headlist;

Why such ugly and ungainy 'map' invocation, instead of IMHO simpler
and better here foreach loop?

> +
> +	foreach $leader (sort(keys %headlists)) {
> +		print "<b>$leader</b><br/>\n" unless $leader eq "\000";
> +		$list = $headlists{$leader};
> +		git_heads_body($list, $head, $from, $to, $extra);
> +	}
> +}

Wouldn't be it simpler to loop over @$headlist, and if prefix (or to be
more exact repository shorthand aka 'remote') changes then run 
git_heads_body, adjusting $from / $to accordingly, based on current and
remembered index? I think we can assume that list is sorted by refname,
can't we? If not then perhaps the way by building hash is good idea
after all...

> +
>  sub git_heads_body {
>  	# uses global variable $project
>  	my ($headlist, $head, $from, $to, $extra) = @_;
> @@ -4541,7 +4572,7 @@ sub git_summary {
>  
>  	if (@remotelist) {
>  		git_print_header_div('remotes');
> -		git_heads_body(\@remotelist, $head, 0, 15,
> +		git_split_heads_body(\@remotelist, $head, 0, 15,
>  		               $#remotelist <= 15 ? undef :
>  		               $cgi->a({-href => href(action=>"heads")}, "..."));
>  	}

Nice.


Footnotes:
==========
[1] It is strange that there is no explicit "git remote list"
-- 
Jakub Narebski
Poland
