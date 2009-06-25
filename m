From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv4 2/2] gitweb: gravatar support
Date: Thu, 25 Jun 2009 03:35:27 +0200
Message-ID: <200906250335.28019.jnareb@gmail.com>
References: <1245710999-17763-1-git-send-email-giuseppe.bilotta@gmail.com> <1245710999-17763-2-git-send-email-giuseppe.bilotta@gmail.com> <1245710999-17763-3-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Aaron Crane <git@aaroncrane.co.uk>,
	Nanako Shiraishi <nanako3@lavabit.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 25 03:35:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJdsN-0001aN-By
	for gcvg-git-2@gmane.org; Thu, 25 Jun 2009 03:35:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753359AbZFYBfb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jun 2009 21:35:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753173AbZFYBfb
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Jun 2009 21:35:31 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:38957 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753073AbZFYBfa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jun 2009 21:35:30 -0400
Received: by fg-out-1718.google.com with SMTP id e21so177017fga.17
        for <git@vger.kernel.org>; Wed, 24 Jun 2009 18:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=bWHvT9q4tcQqfMPQditojIl3Z3NtVAz8D1IsYPW7b+s=;
        b=qRSOozkkvA+Wd0ypJpyfEheJOQ7UsT3aq66hJ/wuACg6mQ5GiMDRVLXWnLKFgRByUD
         Ml/LOS4EipkPYBIjnhS052kM/jNk6iXYpmsbA5mOmP+bP1/6pdSuNOCkcAFDst1MCZ+N
         mOpBQ/0/yA42ctgc8LhFgCHkHHoq5yRBPX0f8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=f+eEFh5IXKunInpps3nMPzN75/zuPmdza3ZHTlisQEWiC28wTvR1xk89PFt9KEkbGs
         ZFEoMWXD8/6iXuGVCIeIzhw9bZHyZ4vmbFqz7mzxI5yM/3F3pykNQhfFBHo1F4+/kJJk
         aMp4okwezyY/m73g+SCnsSvM6jqm3iGMzzbZY=
Received: by 10.86.62.3 with SMTP id k3mr2012245fga.28.1245893732025;
        Wed, 24 Jun 2009 18:35:32 -0700 (PDT)
Received: from ?192.168.1.13? (abvy107.neoplus.adsl.tpnet.pl [83.8.222.107])
        by mx.google.com with ESMTPS id 4sm3893269fgg.2.2009.06.24.18.35.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 24 Jun 2009 18:35:31 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1245710999-17763-3-git-send-email-giuseppe.bilotta@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122175>

On Tue, 23 June 2009, Giuseppe Bilotta wrote:

> Introduce gravatar support by adding the appropriate img tag next to
> author and committer in commit(diff), history, shortlog and log view.

That reminds me that I have refactoring all log-like views in my TODO
file for gitweb for quite long time.

> 
> The feature is disabled by default, and depends on Digest::MD5, which
> is a core package since Perl 5.8. If Digest::MD5 cannot be found,
> enabling this feature results in a no-op.

Good description.

> 
> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
> ---
>  gitweb/gitweb.css  |    4 +++
>  gitweb/gitweb.perl |   56 ++++++++++++++++++++++++++++++++++++++++++++++-----
>  2 files changed, 54 insertions(+), 6 deletions(-)
> 
> diff --git a/gitweb/gitweb.css b/gitweb/gitweb.css
> index 68b22ff..ddf982b 100644
> --- a/gitweb/gitweb.css
> +++ b/gitweb/gitweb.css
> @@ -28,6 +28,10 @@ img.logo {
>  	border-width: 0px;
>  }
>  
> +img.avatar {
> +	vertical-align:middle;
> +}
> +

Nitpick: "vertical-align: middle;" (with space separating key from
value).

>  div.page_header {
>  	height: 25px;
>  	padding: 8px;
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 223648f..531d589 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -195,6 +195,14 @@ our %known_snapshot_format_aliases = (
>  	'x-zip' => undef, '' => undef,
>  );
>  
> +# Pixel sizes for avatars. If the default font sizes or lineheights
> +# are changed, it may be appropriate to change these values too via
> +# $GITWEB_CONFIG.
> +our %avatar_size = (
> +	'default' => 16,
> +	'double'  => 32
> +) ;

Good idea, good description.  I wonder if it would be worth adding
to gitweb_conf.perl description in gitweb/README and gitweb/INSTALL...

Nitpick: ");"

> +
>  # You define site-wide feature defaults here; override them with
>  # $GITWEB_CONFIG as necessary.
>  our %feature = (
> @@ -365,6 +373,21 @@ our %feature = (
>  		'sub' => \&feature_patches,
>  		'override' => 0,
>  		'default' => [16]},
> +
> +	# Gravatar support. When this feature is enabled, views such as
> +	# shortlog or commit will display the gravatar associated with
> +	# the email of the committer(s) and/or author(s). Please note that
> +	# the feature depends on Digest::MD5.
> +
> +	# To enable system wide have in $GITWEB_CONFIG
> +	# $feature{'gravatar'}{'default'} = [1];
> +	# To have project specific config enable override in $GITWEB_CONFIG
> +	# $feature{'gravatar'}{'override'} = 1;
> +	# and in project config gitweb.gravatar = 0|1;
> +	'gravatar' => {
> +		'sub' => sub { feature_bool('gravatar', @_) },
> +		'override' => 0,
> +		'default' => [0]},
>  );

Good.

>  
>  sub gitweb_get_feature {
> @@ -814,6 +837,10 @@ $git_dir = "$projectroot/$project" if $project;
>  our @snapshot_fmts = gitweb_get_feature('snapshot');
>  @snapshot_fmts = filter_snapshot_fmts(@snapshot_fmts);
>  
> +# check if gravatars are enabled and dependencies are satisfied
> +our $git_gravatar_enabled = gitweb_check_feature('gravatar') &&
> +	(eval { require Digest::MD5; 1; });
> +

I think this is correct.

>  # dispatch
>  if (!defined $action) {
>  	if (defined $hash) {
> @@ -1474,7 +1501,7 @@ sub format_author_html {
>  	my $tag = shift;
>  	my $co = shift;
>  	my $author = chop_and_escape_str($co->{'author_name'}, @_);
> -	return "<$tag class=\"author\">" . $author . "</$tag>\n";
> +	return "<$tag class=\"author\">" . git_get_gravatar($co->{'author_email'}, 'space_after' => 1) . $author . "</$tag>\n";
>  }

Line too long, please break it.

>  
>  # format git diff header line, i.e. "diff --(git|combined|cc) ..."
> @@ -3222,6 +3249,21 @@ sub git_print_header_div {
>  	      "\n</div>\n";
>  }
>  
> +# insert a gravatar for the given $email at the given $size if the feature
> +# is enabled
> +sub git_get_gravatar {
> +	if ($git_gravatar_enabled) {
> +		my ($email, %params) = @_;
> +		my $pre_white = ($params{'space_before'} ? "&nbsp;" : "");
> +		my $post_white = ($params{'space_after'} ? "&nbsp;" : "");

This name of parameter is a bit too low level for my taste.  It doesn't
matter whether we add '&nbsp;' nonbreakable space before or after img,
but whethere gravatar image has _padding_ on the left/on the right hand
side of gravatar image.  So 'pad_left' and 'pad_right', or 'pad_before'
and 'pad_after' rather than 'space_before' and 'space_after'.

But this is a matter of taste...

> +		my $size = $avatar_size{$params{'size'}} || $avatar_size{'default'};

Nice trick.

> +		return $pre_white . "<img class=\"avatar\" src=\"http://www.gravatar.com/avatar.php?gravatar_id=" .
> +		       Digest::MD5::md5_hex(lc $email) . "&amp;size=$size\" />" . $post_white;
> +	} else {
> +		return "";
> +	}
> +}
> +
>  # Outputs the author name and date in long form
>  sub git_print_authorship {
>  	my $co = shift;
> @@ -3238,7 +3280,8 @@ sub git_print_authorship {
>  		printf(" (%02d:%02d %s)",
>  		       $ad{'hour_local'}, $ad{'minute_local'}, $ad{'tz_local'});
>  	}
> -	print "]</$tag>\n";
> +	print "]" . git_get_gravatar($co->{'author_email'}, 'space_before' => 1)
> +		  . "</$tag>\n";
>  }
>  

Good.

>  # Outputs the author and commiter name and date in long form
> @@ -3246,9 +3289,9 @@ sub git_print_who {
>  	my $co = shift;
>  	my %ad = parse_date($co->{'author_epoch'}, $co->{'author_tz'});
>  	my %cd = parse_date($co->{'committer_epoch'}, $co->{'committer_tz'});
> -	print "<tr><td>author</td><td>" . esc_html($co->{'author'}) . "</td></tr>\n".
> -	      "<tr>" .
> -	      "<td></td><td> $ad{'rfc2822'}";
> +	print "<tr><td>author</td><td>" . esc_html($co->{'author'}) . "</td>".
> +	      "<td rowspan=\"2\">" .git_get_gravatar($co->{'author_email'}, 'size' => 'double') . "</td></tr>\n" .

                                    . git_get_gravatar($co->{'author_email'}, 'size' => 'double') .

> +	      "<tr><td></td><td> $ad{'rfc2822'}";

If you put <tr> on separate line, as was before, it would be more 
obvious in this diff that you are only adding single line.

>  	if ($ad{'hour_local'} < 6) {
>  		printf(" (<span class=\"atnight\">%02d:%02d</span> %s)",
>  		       $ad{'hour_local'}, $ad{'minute_local'}, $ad{'tz_local'});
> @@ -3258,7 +3301,8 @@ sub git_print_who {
>  	}
>  	print "</td>" .
>  	      "</tr>\n";
> -	print "<tr><td>committer</td><td>" . esc_html($co->{'committer'}) . "</td></tr>\n";
> +	print "<tr><td>committer</td><td>" . esc_html($co->{'committer'}) . "</td>".
> +	      "<td rowspan=\"2\">" .git_get_gravatar($co->{'committer_email'}, 'size' => 'double') . "</td></tr>\n";
>  	print "<tr><td></td><td> $cd{'rfc2822'}" .
>  	      sprintf(" (%02d:%02d %s)", $cd{'hour_local'}, $cd{'minute_local'}, $cd{'tz_local'}) .
>  	      "</td></tr>\n";

Sidenote: you add here additional column.  Which is present only in 
fragment of this table.  Doesn't it screw layout of the rest of headers?

> -- 
> 1.6.3.rc1.192.gdbfcb
> 
> 

-- 
Jakub Narebski
Poland
