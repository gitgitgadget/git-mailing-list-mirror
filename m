From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv7 5/9] gitweb: (gr)avatar support
Date: Sat, 27 Jun 2009 21:45:46 +0200
Message-ID: <200906272145.46506.jnareb@gmail.com>
References: <1246104305-15191-1-git-send-email-giuseppe.bilotta@gmail.com> <1246104305-15191-5-git-send-email-giuseppe.bilotta@gmail.com> <1246104305-15191-6-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 27 21:46:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MKdqg-0003bs-0Z
	for gcvg-git-2@gmane.org; Sat, 27 Jun 2009 21:46:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751941AbZF0Tpr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Jun 2009 15:45:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751427AbZF0Tpq
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Jun 2009 15:45:46 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:34084 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751292AbZF0Tpq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jun 2009 15:45:46 -0400
Received: by fg-out-1718.google.com with SMTP id e21so670778fga.17
        for <git@vger.kernel.org>; Sat, 27 Jun 2009 12:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=qPPa3uU3a7kL2JCuJyshHHMBylPjzwR0qDDFZQS3rF4=;
        b=saKj1WGJMntDRFiIu8g5f2DoVzYTHVCOy9n/NaK9ml7ZIEWMI+6S2WBEq4zuGp0y+g
         wcqKsehD8ayyRrfh0AFKACEYiq534+BOOLNJn0QP9KRDCqgTEGh7ifeAWrVDF2BflZjj
         tPNAmNC9xVCMrVjsUtfXoheMh8zLlCIUKFrG0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=KHTiNLRrgnRVXqulKNAG84vsVlUjZUrVk/36YLHCrz+3Zrly2nAIHT8RU3eu+ifrG7
         QbQY2jNQEDGYwx9sQkhigeg37e3nFmBQvINZWomrfdiRcoa2lr/2AoA1mPUqVTPCPwxp
         p1kwMloti+uj+wMg3o/jtDjOhAXHik6Pziz3A=
Received: by 10.86.96.18 with SMTP id t18mr497894fgb.58.1246131946628;
        Sat, 27 Jun 2009 12:45:46 -0700 (PDT)
Received: from ?192.168.1.13? (abwd106.neoplus.adsl.tpnet.pl [83.8.227.106])
        by mx.google.com with ESMTPS id e20sm2781048fga.25.2009.06.27.12.45.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 27 Jun 2009 12:45:46 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1246104305-15191-6-git-send-email-giuseppe.bilotta@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122383>

On Sat, 27 June 2009, Giuseppe Bilotta wrote:

> Introduce avatar support: the feature adds the appropriate img tag next
> to author and committer in commit(diff), history, shortlog, log and tag
> views. Multiple avatar providers are possible, but only gravatar is
> implemented at the moment.
> 
> Gravatar support depends on Digest::MD5, which is a core package since
> Perl 5.8. If gravatars are activated but Digest::MD5 cannot be found,
> the feature will be automatically disabled.
> 
> No avatar provider is selected by default, except in the t9500 test.

This is well written commit message.  Good work!

> 
> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
> ---
>  gitweb/gitweb.css                      |    4 ++
>  gitweb/gitweb.perl                     |   81 ++++++++++++++++++++++++++++++-
>  t/t9500-gitweb-standalone-no-errors.sh |    2 +

Please, now that you added this to t9500 to be able to test gravatar
and avatar code, run t9500-gitweb-standalone-no-errors.sh script...

> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 7183ad2..ad9ae31 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -195,6 +195,14 @@ our %known_snapshot_format_aliases = (
>  	'x-zip' => undef, '' => undef,
>  );
>  
> +# Pixel sizes for icons and avatars. If the default font sizes or lineheights
> +# are changed, it may be appropriate to change these values too via
> +# $GITWEB_CONFIG.
> +our %avatar_size = (
> +	'default' => 16,
> +	'double'  => 32
> +);

Nice.  Good and complete explanation.

[...]
> +	# Avatar support. When this feature is enabled, views such as
> +	# shortlog or commit will display an avatar associated with
> +	# the email of the committer(s) and/or author(s).
> +
> +	# Currently only the gravatar provider is available, and it
> +	# depends on Digest::MD5.
> +
> +	# To enable system wide have in $GITWEB_CONFIG
> +	# $feature{'avatar'}{'default'} = ['gravatar'];
> +	# To have project specific config enable override in $GITWEB_CONFIG
> +	# $feature{'avatar'}{'override'} = 1;
> +	# and in project config gitweb.avatar = gravatar;
> +	'avatar' => {
> +		'sub' => \&feature_avatar,
> +		'override' => 0,
> +		'default' => ['']},
>  );

So you have chosen [''] and not [] as "no avatar" value, to simplify
later code.  All right.

>  
>  sub gitweb_get_feature {
> @@ -433,6 +458,16 @@ sub feature_patches {
>  	return ($_[0]);
>  }
>  
> +sub feature_avatar {
> +	my @val = (git_get_project_config('avatar'));
> +
> +	if (@val) {
> +		return @val;
> +	}
> +
> +	return @_;
> +}

Hmmm... why not simply

  +	return @val ? @val : @_;


By the way, we might want to accept 'none' instead of empty value
or no value to turn off avatar support for specific project (if
avatars are turned on globally, and project specific override is on).
We use this technique for 'snapshot' feature.

But this isn't terribly important.

[...]
> @@ -814,6 +849,17 @@ $git_dir = "$projectroot/$project" if $project;
>  our @snapshot_fmts = gitweb_get_feature('snapshot');
>  @snapshot_fmts = filter_snapshot_fmts(@snapshot_fmts);
>  
> +# check that the avatar feature is set to a known provider name,
> +# and for each provider check if the dependencies are satisfied.
> +# if the provider name is invalid or the dependencies are not met,
> +# reset $git_avatar to the empty string.
> +our ($git_avatar) = gitweb_get_feature('avatar');
> +if ($git_avatar eq 'gravatar') {
> +	$git_avatar = '' unless (eval { require Digest::MD5; 1; });
> +} else {
> +	$git_avatar = '';
> +}

Thoughts for the future: this can lead to not very pretty if-elsif
chain.  We have replaces such chain for selecting action (for dispatch)
by using %actions hash of subroutine refs (as a kind of 'switch'/'given'
statement).  We could do the same for avatar provider initialization
and validation subroutines.

But for now it is clear enough.  Don't worry about this issue now.

> @@ -1469,6 +1515,29 @@ sub format_subject_html {
>  	}
>  }
>  
> +# Insert an avatar for the given $email at the given $size if the feature
> +# is enabled.
> +sub git_get_avatar {
> +	my ($email, %opts) = @_;
> +	my $pre_white  = ($opts{'pad_before'} ? "&nbsp;" : "");
> +	my $post_white = ($opts{'pad_after'}  ? "&nbsp;" : "");
> +	my $size = $avatar_size{$opts{'size'}} || $avatar_size{'default'};

Running t9500-gitweb-standalone-no-errors.sh with --debug option shows
failing of 15 among 87 tests, with error:

   gitweb.perl: Use of uninitialized value in hash element at gitweb/gitweb.perl line 1524.

which is the above line.  This line should read:

  +	my $size = exists $opts{'size'}
  +		? $avatar_size{$opts{'size'}} || $avatar_size{'default'}
  +		: $avatar_size{'default'};

or something like that, e.g.:

  +	my $size = $avatar_size{ defined $opts{'size'} ? $opts{'size'} : 'default' }
  +		|| $avatar_size{'default'};


BTW. didn't we agree on '-size' and '-pad_before' convention? 

> +	my $url = "";
> +	if ($git_avatar eq 'gravatar') {
> +		$url = "http://www.gravatar.com/avatar.php?gravatar_id=" .
> +			Digest::MD5::md5_hex(lc $email) . "&amp;size=$size";

Why not use the new API[1][2]?:

  +		$url = "http://www.gravatar.com/avatar/" .
  +			Digest::MD5::md5_hex(lc $email) . "?size=$size";

[1] http://www.gravatar.com/site/implement/url
[2] http://search.cpan.org/perldoc/Gravatar::URL
    http://p3rl.org/Gravatar::URL

> +	}
> +	# Currently only gravatars are supported, but other forms such as
> +	# picons can be added by putting an else up here and defining $url
> +	# as needed. If no variant puts something in $url, we assume avatars
> +	# are completely disabled/unavailable.
> +	if ($url) {
> +		return $pre_white . "<img width=\"$size\" class=\"avatar\" src=\"$url\" />" . $post_white;
> +	} else {
> +		return "";
> +	}
> +}

Good idea, and nice description.

[...]
> @@ -1476,7 +1545,9 @@ sub format_author_html {
>  	my $tag = shift;
>  	my $co = shift;
>  	my $author = chop_and_escape_str($co->{'author_name'}, @_);
> -	return "<$tag class=\"author\">" . $author . "</$tag>";
> +	return "<$tag class=\"author\">" .
> +	       git_get_avatar($co->{'author_email'}, 'pad_after' => 1) .
> +	       $author . "</$tag>";
>  }
>  
>  # format git diff header line, i.e. "diff --(git|combined|cc) ..."
> @@ -3249,7 +3320,8 @@ sub git_print_authorship {
>  			       $ad{'hour_local'}, $ad{'minute_local'}, $ad{'tz_local'});
>  		}
>  	}
> -	print "]</$tag>\n";
> +	print "]" . git_get_avatar($co->{'author_email'}, 'pad_before' => 1)
> +		  . "</$tag>\n";
>  }
>  
>  # Outputs table rows containing the full author or committer information,
> @@ -3264,7 +3336,10 @@ sub git_print_authorship_rows {
>  	@people = ('author', 'committer') unless @people;
>  	foreach my $who (@people) {
>  		my %ad = parse_date($co->{$who . '_epoch'}, $co->{$who . '_tz'});
> -		print "<tr><td>$who</td><td>" . esc_html($co->{$who}) . "</td></tr>\n".
> +		print "<tr><td>$who</td><td>" . esc_html($co->{$who}) . "</td>" .
> +		      "<td rowspan=\"2\">" .
> +		      git_get_avatar($co->{$who . '_email'}, 'size' => 'double') .

Nitpick: you can use  "${who}_email", but I am not sure if it is more
readable than  $who . '_email' form.

> +		      "</td></tr>\n" .
>  		      "<tr>" .
>  		      "<td></td><td> $ad{'rfc2822'}";
>  		if ($ad{'hour_local'} < 6) {

Short and nice, thanks to refactoring done in earlier patches in this
series.  Very good.

> diff --git a/t/t9500-gitweb-standalone-no-errors.sh b/t/t9500-gitweb-standalone-no-errors.sh
> index d539619..6275181 100755
> --- a/t/t9500-gitweb-standalone-no-errors.sh
> +++ b/t/t9500-gitweb-standalone-no-errors.sh
> @@ -660,6 +660,7 @@ cat >>gitweb_config.perl <<EOF
>  
>  \$feature{'blame'}{'override'} = 1;
>  \$feature{'snapshot'}{'override'} = 1;
> +\$feature{'avatar'}{'override'} = 1;
>  EOF
>  
>  test_expect_success \
> @@ -671,6 +672,7 @@ test_expect_success \
>  	'config override: tree view, features disabled in repo config' \
>  	'git config gitweb.blame no &&
>  	 git config gitweb.snapshot none &&
> +	 git config gitweb.avatar gravatar &&
>  	 gitweb_run "p=.git;a=tree"'
>  test_debug 'cat gitweb.log'
>  

Please run it too :-)


Apart from this issue of Perl warning (which would get logged, but 
otherwise is not an error), and using old Gravatar API, this patch
shapes very nicely, thanks to all the work done earlier on refactoring.
I like it very much.

-- 
Jakub Narebski
Poland
