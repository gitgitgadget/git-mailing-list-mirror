From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv5 12/12] gitweb: gather more remote data
Date: Mon, 27 Sep 2010 17:47:36 +0200
Message-ID: <201009271747.39201.jnareb@gmail.com>
References: <1285344167-8518-1-git-send-email-giuseppe.bilotta@gmail.com> <1285344167-8518-13-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 27 17:49:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0Fwo-0005T0-42
	for gcvg-git-2@lo.gmane.org; Mon, 27 Sep 2010 17:48:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933145Ab0I0Psv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Sep 2010 11:48:51 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:62976 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933099Ab0I0Psu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Sep 2010 11:48:50 -0400
Received: by bwz11 with SMTP id 11so3412684bwz.19
        for <git@vger.kernel.org>; Mon, 27 Sep 2010 08:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version
         :content-disposition:content-type:content-transfer-encoding
         :message-id;
        bh=tGeJlMuyT0VOmhDoqfUgSZdflHWiH0hwpfeCr130vMk=;
        b=r/cEO0jXCISrNTQ+HSi0ScrcVbrr6Zaja6qGhjB8voSnvNYSzrI3QMs5VlLqaUiMeF
         fbuCat/d/XLQ/VjjLWBDTUcQ0WhjmW/XzDTd/4uKRULGPCLQA2ABp7hGhc52FQFSyePa
         Wq397wyTbpMGY3Db9ae2vRJsOuJdM2KcbiGAI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-disposition:content-type
         :content-transfer-encoding:message-id;
        b=Cn0FIsLkoo4MJa6xmSf1iloeKGEEvnCxYKi/yDEOPz9bQepTLqq61X/Lm/8yLWMnAF
         +q6B/HRPE+VcYN+bjV+haNAF8SK4uGpFzgrOJ8txirOkLnipP/3MasepT3kI9uZKT2Kv
         6ntVXg1pj+V1rg5h8EBWNyTWTQSJvrF8wLmvQ=
Received: by 10.204.131.132 with SMTP id x4mr5490466bks.50.1285602528771;
        Mon, 27 Sep 2010 08:48:48 -0700 (PDT)
Received: from [192.168.1.13] (abvz242.neoplus.adsl.tpnet.pl [83.8.223.242])
        by mx.google.com with ESMTPS id y2sm4537914bkx.8.2010.09.27.08.47.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 27 Sep 2010 08:47:52 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1285344167-8518-13-git-send-email-giuseppe.bilotta@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157351>

On Fri, 24 Sep 2010, Giuseppe Bilotta wrote:

Isn't the most important and visible information the fact that both
standalone 'remotes' view and 'remotes' section in the 'summary' page
is now grouped by remotes?  This should be explicitely mentioned in the
commit message.  It is not very visible IMVHO in what is written below.

> Collect remote information by gathering the list of remotes, and then
> the URL(s) and heads in each remote. In summary view, limit the number
> of remotes for which we collect data, as well as the maximum number of
> heads per remote that we display.
> 
> If the number of remotes is higher than the prescribed limit, do not
> collect any heads information and just show the remotes names and the
> links to the corresponding fetch and push URLs. Otherwise, create a
> group for each remote and display all the information there.

You mean here that in 'summary' view, the 'remotes' section consist 
only of list of remote names (is it truncated to 15 remotes) with 
corresponding fetch and push URLs if number of remotes is higher than
the prescribed limit.  In other case 'remotes' section consist of
separate subsection for each remote (is number of remotes limited 
also in this case), and in each subsection there are displayed up to
prescribed limit remote-tracking branches associated with given remote.

Isn't it?

> 
> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
> ---
>  gitweb/gitweb.perl |  171 ++++++++++++++++++++++++++++++++++++++++++++++------
>  1 files changed, 153 insertions(+), 18 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 93017a4..1e671ff 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -2758,6 +2758,57 @@ sub git_get_last_activity {
>  	return (undef, undef);
>  }
>  
> +# Return an array with: a hash of remote names mapping to the corresponding
> +# remote heads, the value of the $limit parameter, and a boolean indicating
> +# whether we managed to get all the remotes or not.

Perhaps it would be better to provide an example, rather than trying to
describe the output.

> +# If $limit is specified and the number of heads found is higher, the head
> +# list is empy. Additional filtering on the number of heads can be done when
> +# displaying the remotes.
> +sub git_get_remotes_data {
> +	my ($limit, $wanted) = @_;

I'm not sure if it wouldn't be better to not worry git_get_remotes_data
about $limit, but do limiting on output.  The amount of work gitweb
needs to do in both situation is, I guess, nearly the same.

> +	my %remotes;
> +	open my $fd, '-|' , git_cmd(), 'remote', '-v';
> +	return unless $fd;
> +	my $more = 1;
> +	while (my $remote = <$fd> and $more) {

Why not use 'last' instead of using $more variable (though I have not
checked if it would really make code simpler and more readable).

> +		chomp $remote;
> +		$remote =~ s!\t(.*?)\s+\((\w+)\)$!!;
> +		next if $wanted and not $remote eq $wanted;
> +		my $url = $1;
> +		my $key = $2;

Minor nitpick: why not

  +		my ($url, $key) = ($1, $2);

> +
> +		# a remote may appear more than once because of multiple URLs,
> +		# so if this is a remote we know already, be sure to continue,
> +		# lest we end up with a remote for which we get the fetch URL
> +		# bot not the push URL, for example
> +		$more = exists $remotes{$remote};
> +		$more ||= defined $limit ? (keys(%remotes) < $limit) : 1;
> +		if ($more) {
> +			$remotes{$remote} ||= { 'heads' => () };
> +			$remotes{$remote}{$key} = $url;
> +		}
> +	}
> +	close $fd or return;
> +
> +	# if the while finished with $more being true, it means we ran
> +	# out of remotes before we hit $limit; paradoxically, it being true out
> +	# of the loop means there are 'no more' remotes.
> +	# Rather than waste time renaming the variable, we just read it to
> +	# answer the question: "did we get all remotes before we hit
> +	# the limit?"

Ah, I see that the fact that we exited early is important.

> +	if ($more) {
> +		my @heads = map { "remotes/$_" } keys %remotes;
> +		my @remoteheads = git_get_heads_list(undef, @heads);
> +		foreach (keys %remotes) {
> +			my $remote = $_;
> +			$remotes{$remote}{'heads'} = [ grep {
> +				$_->{'name'} =~ s!^$remote/!!
> +			} @remoteheads ];
> +		}
> +	}
> +	return (\%remotes, $limit, $more);

Hmmmm... as it can be seen making this function do more work results
in this ugly API.  If git_get_remotes_data didn't worry about limiting,
we could return simply %remotes hash (or \%remotes hash reference).

> +}
> +
>  sub git_get_references {
>  	my $type = shift || "";
>  	my %refs;
> @@ -5018,6 +5069,93 @@ sub git_heads_body {
>  	print "</table>\n";
>  }
>  
> +# Display a single remote block
> +sub git_remote_body {
> +	my ($remote, $rdata, $limit, $head, $single) = @_;
> +	my %rdata = %{$rdata};

Why do you need this, instead of simply using $rdata->{'heads'} etc.?

> +	my $heads = $rdata{'heads'};

Why not

  +	my @heads = @{$rdata{'heads'}};

Or

  +	my @heads = @{$rdata->{'heads'}};

without this strange '%rdata = %{$rdata};'

> +
> +	my $fetch = $rdata{'fetch'};
> +	my $push = $rdata{'push'};
> +
> +	my $urls = "<table class=\"projects_list\">\n" ;
> +
> +	if (defined $fetch) {
> +		if ($fetch eq $push) {
> +			$urls .= git_repo_url("URL", $fetch);
> +		} else {
> +			$urls .= git_repo_url("Fetch URL", $fetch);
> +			$urls .= git_repo_url("Push URL", $push) if defined $push;
> +		}
> +	} elsif (defined $push) {
> +		$urls .= git_repo_url("Push URL", $push);
> +	} else {
> +		$urls .= git_repo_url("", "No remote URL");
> +	}

Perhaps reverse order of conditions would result in less nested 
conditional... but perhaps not.

> +
> +	$urls .= "</table>\n";
> +
> +	my ($maxheads, $dots);
> +	if (defined $limit) {
> +		$maxheads = $limit - 1;

If git_get_remotes_data didn't do limiting, you could use

  +		$maxheads = scalar @heads;

> +		if ($#{$heads} > $maxheads) {
> +			$dots = $cgi->a({-href => href(action=>"remotes", hash=>$remote)}, "...");
> +		}
> +	}

We can always check if we got more remotes than limit.

> +
> +	my $content = sub {
> +		print $urls;
> +		git_heads_body($heads, $head, 0, $maxheads, $dots);
> +	};
> +
> +	if (defined $single and $single) {

'defined $single and $single' is the same as '$single', because
undefined value is false-ish.

> +		$content->();
> +	} else {
> +		git_group("remotes", $remote, "remotes", $remote, $remote, $content);
> +	}

Hmmm... should git_remote_body be responsible for wrapping in subsection?
Wouldn't it be better to have caller use

  git_group("remotes", $remote, "remotes", $remote, $remote, 
            sub { git_remote_body($remote, $rdata, $limit, $head) });

Sidenote: strange (but perhaps unavoidable) repetition we have here...

> +}
> +
> +# Display remote heads grouped by remote, unless there are too many
> +# remotes ($have_all is false), in which case we only display the remote
> +# names

Wouldn't it be better to put displaying only remote names in a separate
subroutine, which would make git_remotes_body extremely simple?

> +sub git_remotes_body {
> +	my ($remotelist, $limit, $have_all, $head) = @_;
> +	my %remotes = %$remotelist;
> +	if ($have_all) {
> +		while (my ($remote, $rdata) = each %remotes) {
> +			git_remote_body($remote, $rdata, $limit, $head);
> +		}
> +	} else {
> +		print "<table class=\"heads\">\n";
> +		my $alternate = 1;
> +		while (my ($remote, $rdata) = each (%$remotelist)) {
> +			my $fetch = $rdata->{'fetch'};
> +			my $push = $rdata->{'push'};
> +			if ($alternate) {
> +				print "<tr class=\"dark\">\n";
> +			} else {
> +				print "<tr class=\"light\">\n";
> +			}
> +			$alternate ^= 1;
> +			print "<td>" .
> +			      $cgi->a({-href=> href(action=>'remotes', hash=>$remote),
> +			               -class=> "list name"},esc_html($remote)) . "</td>";
> +			print "<td class=\"link\">" .
> +			      (defined $fetch ? $cgi->a({-href=> $fetch}, "fetch") : "fetch") .
> +			      " | " .
> +			      (defined $push ? $cgi->a({-href=> $push}, "push") : "push") .
> +			      "</td>";

I see that you don't worry here if $fetch == $push, only if they
are defined.  But I think it might be all right... though the exact
output might need some discussion.

> +
> +			print "</tr>\n";
> +		}
> +		print "<tr>\n" .
> +		      "<td colspan=\"3\">" .
> +		      $cgi->a({-href => href(action=>"remotes")}, "...") .
> +		      "</td>\n" . "</tr>\n";
> +		print "</table>";
> +	}
> +}
> +
>  sub git_search_grep_body {
>  	my ($commitlist, $from, $to, $extra) = @_;
>  	$from = 0 unless defined $from;
> @@ -5164,7 +5302,7 @@ sub git_summary {
>  	# there are more ...
>  	my @taglist  = git_get_tags_list(16);
>  	my @headlist = git_get_heads_list(16, 'heads');
> -	my @remotelist = $remote_heads ? git_get_heads_list(16, 'remotes') : ();
> +	my @remotelist = $remote_heads ? git_get_remotes_data(16) : ();

That's not @remotelist any longer, isn't it?

>  	my @forklist;
>  	my $check_forks = gitweb_check_feature('forks');
>  
> @@ -5244,9 +5382,7 @@ sub git_summary {
>  
>  	if (@remotelist) {
>  		git_print_header_div('remotes');
> -		git_heads_body(\@remotelist, $head, 0, 15,
> -		               $#remotelist <= 15 ? undef :
> -		               $cgi->a({-href => href(action=>"remotes")}, "..."));
> +		git_remotes_body(@remotelist, $head);

Hmmm... (current API, with @remotelist (!) containing list of arguments
to a subroutine).

>  	}
>  
>  	if (@forklist) {
> @@ -5570,26 +5706,25 @@ sub git_remotes {
>  	my $head = git_get_head_hash($project);
>  	my $remote = $input_params{'hash'};
>  
> +	my @remotelist = git_get_remotes_data(undef, $remote);
> +	die_error(500, "Unable to get remote information") unless @remotelist;

@remotelist is not list of remotes.

What if there are no remotes, and no remote-tracking branches?

> +
> +	if (keys(%{$remotelist[0]}) == 0) {
> +		die_error(404, defined $remote ?
> +			"Remote $remote not found" :
> +			"No remotes found");
> +	}

Ah, I see that it is handled here.  Sidenote: with proposed changed
API we can distinguish error case from no-remotes case by returning
undefined value versus returning empty hash / empty hash reference.

> +
>  	git_header_html(undef, undef, 'header_extra' => $remote);
>  	git_print_page_nav('', '',  $head, undef, $head,
>  		format_ref_views($remote ? '' : 'remotes'));
> -	git_print_header_div('summary', $project);
>  
>  	if (defined $remote) {
> -		# only display the heads in a given remote
> -		my @headslist = map {
> -			my $ref = $_ ;
> -			$ref->{'name'} =~ s!^$remote/!!;
> -			$ref
> -		} git_get_heads_list(undef, "remotes/$remote");
> -		if (@headslist) {
> -			git_heads_body(\@headslist, $head);
> -		}
> +		git_print_header_div('remotes', "$remote remote for $project");
> +		git_remote_body($remote, $remotelist[0]->{$remote}, undef, $head, 1);
>  	} else {
> -		my @remotelist = git_get_heads_list(undef, 'remotes');
> -		if (@remotelist) {
> -			git_heads_body(\@remotelist, $head);
> -		}
> +		git_print_header_div('summary', "$project remotes");
> +		git_remotes_body(@remotelist, $head);
>  	}
>  	git_footer_html();
>  }
> -- 
> 1.7.3.68.g6ec8
> 
> 

-- 
Jakub Narebski
Poland
