From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv4 1/2] gitweb: refactor author name insertion
Date: Thu, 25 Jun 2009 03:23:24 +0200
Message-ID: <200906250323.24868.jnareb@gmail.com>
References: <1245710999-17763-1-git-send-email-giuseppe.bilotta@gmail.com> <1245710999-17763-2-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Aaron Crane <git@aaroncrane.co.uk>,
	Nanako Shiraishi <nanako3@lavabit.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 25 03:23:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJdgq-0006oj-AS
	for gcvg-git-2@gmane.org; Thu, 25 Jun 2009 03:23:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752358AbZFYBXZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jun 2009 21:23:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751863AbZFYBXY
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Jun 2009 21:23:24 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:54409 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751270AbZFYBXX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jun 2009 21:23:23 -0400
Received: by fg-out-1718.google.com with SMTP id e21so175948fga.17
        for <git@vger.kernel.org>; Wed, 24 Jun 2009 18:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version
         :content-disposition:content-type:content-transfer-encoding
         :message-id;
        bh=QmL9UU12xQWRPtCUqK9/GbWdJ2NXaUX1Iwp6E5d3/n8=;
        b=bo+ngl2qHAZ1eFTNCdkwiL2oX19fL0jSH/fBc1Auh+ovLmEMa9EKZFOD6NycQBf80y
         IbXLa0vJtVvT+Ay4nmGjc7YbbbqZMZmc1jDo3i+nxZTGvBCbxeKbHbAC7oEcYUMZvEnO
         kG3skCLc5PdsQRhmx1tgywAzrihBKctYA4sLI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-disposition:content-type
         :content-transfer-encoding:message-id;
        b=nwEjrmIT0ofPrAQ1X4disPwLOqjjTxC8/eHQNiN2M8XszDRUqCOj9i86MvvY4G/6CJ
         lfUHKb65j9dPKETe+ZKV2QBT8HvrlKaiTbem5EheFGd0N5tzgysIjqS2c0bVBrWMdZA/
         HKgX5uXWEiUq0hCq4H6yQ7SDrb7R3Hi2GvNC0=
Received: by 10.86.93.19 with SMTP id q19mr1975974fgb.55.1245893004551;
        Wed, 24 Jun 2009 18:23:24 -0700 (PDT)
Received: from ?192.168.1.13? (abvy107.neoplus.adsl.tpnet.pl [83.8.222.107])
        by mx.google.com with ESMTPS id d4sm2035405fga.28.2009.06.24.18.23.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 24 Jun 2009 18:23:23 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1245710999-17763-2-git-send-email-giuseppe.bilotta@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122174>

On Tue, 23 June 2009, Giuseppe Bilotta wrote:

> The refactoring allows easier customization of the output by means of
> CSS, and improves extensibility on the CGI side too.

How?  The above description is slightly lacking in details.  Does it
mean that we replaced remains of presentational HTML (<i> and <b> tags)
by CSS styling using classes?  What about support for text browsers 
such as lynx, links/elinks, w3m?  (I'm not saying here that this should
block moving from presentational HTML to CSS, just that it should be
considered).

How it improves extensibility on the CGI side?  Does it mean that it
would be easier to add new features or otherwise extend gitweb, because
common parts are factored out?

> 
> Layout is preserved for all views except for 'commitdiff', which now
> uses the same format as 'commit'.

Currently (i.e. without this patch) gitweb uses the following forms of
showing authorship, from shortest to longest:

 * "Giuseppe Bilotta"
  
   This is form used in 'shortlog' and 'history' views.

 * "Giuseppe Bilotta [Mon, 22 Jun 2009 22:49:58 +0000]"

   This is form used by 'log' view.

 * "Giuseppe Bilotta [Mon, 22 Jun 2009 22:49:58 +0000 (00:49 +0200)]"

   This is form used by 'commitdiff' view.

 * "author      Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
                Mon, 22 Jun 2009 22:49:58 +0000 (00:49 +0200)
    committer   Jakub Narebski <jnareb@gmail.com>
                Tue, 23 Jun 2009 18:02:21 +0000 (20:02 +0200)"

   This is form used by 'commit' view.

I can understand factoring out code dealing with authorship in 'commit'
view, because it is a bit different from other headers; on the other
hand it is slightly similar to dealing other headers.

I think that changing 'commitdiff' view to use more detailed author
information might be a good idea.  But I do not think that having
it bundled together with this refactoring patch is a good idea.  It
really should be a separate patch, and refactoring shouldn't change
output, if possible (and I think here is very much possible, see below).

If you wanted to reduce number of places where you need to add later
gravatar support, it would be better to factor out formatting authorship
information in 'log' and 'commitdiff' view, either by having 'log' view
use 'commitdiff' authorship subroutine (and not 'commitdiff' use new
'commit' authorship subroutine), or make this subroutine produce two
slightly different outputs.

> 
> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
> ---
>  gitweb/gitweb.css  |    5 ++-
>  gitweb/gitweb.perl |   79 +++++++++++++++++++++++++++++++---------------------
>  2 files changed, 51 insertions(+), 33 deletions(-)
> 
> diff --git a/gitweb/gitweb.css b/gitweb/gitweb.css
> index a01eac8..68b22ff 100644
> --- a/gitweb/gitweb.css
> +++ b/gitweb/gitweb.css
> @@ -132,11 +132,14 @@ div.list_head {
>  	font-style: italic;
>  }
>  
> +.author_date, .author {
> +	font-style: italic;
> +}
> +
>  div.author_date {
>  	padding: 8px;
>  	border: solid #d9d8d1;
>  	border-width: 0px 0px 1px 0px;
> -	font-style: italic;
>  }

Good.

>  
>  a.list {
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 1e7e2d8..223648f 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -1469,6 +1469,14 @@ sub format_subject_html {
>  	}
>  }
>  
> +# format the author name with the given tag and optionally shortening it

I would like to see calling convention for this subroutine described, 
because it is not entirely obvious; see passing of (misnamed)
chop_and_escape_str subroutine parameters.

> +sub format_author_html {
> +	my $tag = shift;
> +	my $co = shift;
> +	my $author = chop_and_escape_str($co->{'author_name'}, @_);
> +	return "<$tag class=\"author\">" . $author . "</$tag>\n";
> +}
> +
>  # format git diff header line, i.e. "diff --(git|combined|cc) ..."
>  sub format_git_diff_header_line {
>  	my $line = shift;
> @@ -3214,11 +3222,13 @@ sub git_print_header_div {
>  	      "\n</div>\n";
>  }
>  
> +# Outputs the author name and date in long form
>  sub git_print_authorship {
>  	my $co = shift;
> +	my $tag = shift || 'div';
>  
>  	my %ad = parse_date($co->{'author_epoch'}, $co->{'author_tz'});
> -	print "<div class=\"author_date\">" .
> +	print "<$tag class=\"author_date\">" .
>  	      esc_html($co->{'author_name'}) .
>  	      " [$ad{'rfc2822'}";
>  	if ($ad{'hour_local'} < 6) {
> @@ -3228,7 +3238,30 @@ sub git_print_authorship {
>  		printf(" (%02d:%02d %s)",
>  		       $ad{'hour_local'}, $ad{'minute_local'}, $ad{'tz_local'});
>  	}
> -	print "]</div>\n";
> +	print "]</$tag>\n";
> +}

Good.  You could have add option to print or not print localtime
(or use version with localtime in 'log' view).

> +
> +# Outputs the author and commiter name and date in long form
> +sub git_print_who {

Hmmm... perhaps git_print_authorship_long?  I am not sure if git_print_who
is a good name to have.  (Yes, I know, naming is hard).

> +	my $co = shift;
> +	my %ad = parse_date($co->{'author_epoch'}, $co->{'author_tz'});
> +	my %cd = parse_date($co->{'committer_epoch'}, $co->{'committer_tz'});
> +	print "<tr><td>author</td><td>" . esc_html($co->{'author'}) . "</td></tr>\n".
> +	      "<tr>" .
> +	      "<td></td><td> $ad{'rfc2822'}";
> +	if ($ad{'hour_local'} < 6) {
> +		printf(" (<span class=\"atnight\">%02d:%02d</span> %s)",
> +		       $ad{'hour_local'}, $ad{'minute_local'}, $ad{'tz_local'});
> +	} else {
> +		printf(" (%02d:%02d %s)",
> +		       $ad{'hour_local'}, $ad{'minute_local'}, $ad{'tz_local'});
> +	}
> +	print "</td>" .
> +	      "</tr>\n";
> +	print "<tr><td>committer</td><td>" . esc_html($co->{'committer'}) . "</td></tr>\n";
> +	print "<tr><td></td><td> $cd{'rfc2822'}" .
> +	      sprintf(" (%02d:%02d %s)", $cd{'hour_local'}, $cd{'minute_local'}, $cd{'tz_local'}) .
> +	      "</td></tr>\n";
>  }

While it might be a good idea of factoring out this part into separate
subroutine, I don't think that 'commitdiff' should use it... well, at
least not in this commit.

>  
>  sub git_print_page_path {
> @@ -4142,11 +4175,9 @@ sub git_shortlog_body {
>  			print "<tr class=\"light\">\n";
>  		}
>  		$alternate ^= 1;
> -		my $author = chop_and_escape_str($co{'author_name'}, 10);
>  		# git_summary() used print "<td><i>$co{'age_string'}</i></td>\n" .
>  		print "<td title=\"$co{'age_string_age'}\"><i>$co{'age_string_date'}</i></td>\n" .
> -		      "<td><i>" . $author . "</i></td>\n" .
> -		      "<td>";
> +			format_author_html('td', \%co, 10) . "<td>";

+		      format_author_html('td', \%co, 10) . "<td>";

Tabs are for indent, spaces are for align, at least for gitweb.perl
(this unfortunately requires either handcrafting, or using smart-tabs,
but it has the advantage of presenting the same layour regardless of
the tab size).

>  		print format_subject_html($co{'title'}, $co{'title_short'},
>  		                          href(action=>"commit", hash=>$commit), $ref);
>  		print "</td>\n" .

Very good.

> @@ -4193,11 +4224,9 @@ sub git_history_body {
>  			print "<tr class=\"light\">\n";
>  		}
>  		$alternate ^= 1;
> -	# shortlog uses      chop_str($co{'author_name'}, 10)
> -		my $author = chop_and_escape_str($co{'author_name'}, 15, 3);
>  		print "<td title=\"$co{'age_string_age'}\"><i>$co{'age_string_date'}</i></td>\n" .
> -		      "<td><i>" . $author . "</i></td>\n" .
> -		      "<td>";
> +	# shortlog uses      format_author_html('td', \%co, 10)
> +			format_author_html('td', \%co, 15, 3) . "<td>";

Tabs are for indent, spaces are for align.
And you don't need to try to align in the comment now.

>  		# originally git_history used chop_str($co{'title'}, 50)
>  		print format_subject_html($co{'title'}, $co{'title_short'},
>  		                          href(action=>"commit", hash=>$commit), $ref);
> @@ -4350,9 +4379,8 @@ sub git_search_grep_body {
>  			print "<tr class=\"light\">\n";
>  		}
>  		$alternate ^= 1;
> -		my $author = chop_and_escape_str($co{'author_name'}, 15, 5);
>  		print "<td title=\"$co{'age_string_age'}\"><i>$co{'age_string_date'}</i></td>\n" .
> -		      "<td><i>" . $author . "</i></td>\n" .
> +		      format_author_html('td', \%co, 15, 5) .
>  		      "<td>" .
>  		      $cgi->a({-href => href(action=>"commit", hash=>$co{'id'}),
>  		               -class => "list subject"},

Good. 

This one has correct whitespace mixture (tabs for indent, spaces for
align).

> @@ -5094,9 +5122,9 @@ sub git_log {
>  		      " | " .
>  		      $cgi->a({-href => href(action=>"tree", hash=>$commit, hash_base=>$commit)}, "tree") .
>  		      "<br/>\n" .
> -		      "</div>\n" .
> -		      "<i>" . esc_html($co{'author_name'}) .  " [$ad{'rfc2822'}]</i><br/>\n" .
>  		      "</div>\n";
> +		      git_print_authorship(\%co);
> +		      print "<br/>\n</div>\n";
>  
>  		print "<div class=\"log_body\">\n";
>  		git_print_log($co{'comment'}, -final_empty_line=> 1);

Good.

> @@ -5115,8 +5143,6 @@ sub git_commit {
>  	$hash ||= $hash_base || "HEAD";
>  	my %co = parse_commit($hash)
>  	    or die_error(404, "Unknown commit object");
> -	my %ad = parse_date($co{'author_epoch'}, $co{'author_tz'});
> -	my %cd = parse_date($co{'committer_epoch'}, $co{'committer_tz'});
>  
>  	my $parent  = $co{'parent'};
>  	my $parents = $co{'parents'}; # listref
> @@ -5183,22 +5209,7 @@ sub git_commit {
>  	}
>  	print "<div class=\"title_text\">\n" .
>  	      "<table class=\"object_header\">\n";
> -	print "<tr><td>author</td><td>" . esc_html($co{'author'}) . "</td></tr>\n".
> -	      "<tr>" .
> -	      "<td></td><td> $ad{'rfc2822'}";
> -	if ($ad{'hour_local'} < 6) {
> -		printf(" (<span class=\"atnight\">%02d:%02d</span> %s)",
> -		       $ad{'hour_local'}, $ad{'minute_local'}, $ad{'tz_local'});
> -	} else {
> -		printf(" (%02d:%02d %s)",
> -		       $ad{'hour_local'}, $ad{'minute_local'}, $ad{'tz_local'});
> -	}
> -	print "</td>" .
> -	      "</tr>\n";
> -	print "<tr><td>committer</td><td>" . esc_html($co{'committer'}) . "</td></tr>\n";
> -	print "<tr><td></td><td> $cd{'rfc2822'}" .
> -	      sprintf(" (%02d:%02d %s)", $cd{'hour_local'}, $cd{'minute_local'}, $cd{'tz_local'}) .
> -	      "</td></tr>\n";
> +	git_print_who(\%co);
>  	print "<tr><td>commit</td><td class=\"sha1\">$co{'id'}</td></tr>\n";
>  	print "<tr>" .
>  	      "<td>tree</td>" .

This makes git_commit subroutine less complex, so it might be good
idea anyway.

> @@ -5579,7 +5590,11 @@ sub git_commitdiff {
>  		git_header_html(undef, $expires);
>  		git_print_page_nav('commitdiff','', $hash,$co{'tree'},$hash, $formats_nav);
>  		git_print_header_div('commit', esc_html($co{'title'}) . $ref, $hash);
> -		git_print_authorship(\%co);
> +		print "<div class=\"title_text\">\n" .
> +		      "<table class=\"object_header\">\n";
> +		git_print_who(\%co);
> +		print "</table>".
> +		      "</div>\n";
>  		print "<div class=\"page_body\">\n";
>  		if (@{$co{'comment'}} > 1) {
>  			print "<div class=\"log\">\n";

But here we can use git_print_authorship('div', \%co, undef, undef, -localtime=>1)
or something like that; no need to change 'commitdiff' view.

> -- 
> 1.6.3.rc1.192.gdbfcb
> 
> 

-- 
Jakub Narebski
Poland
