From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv8 4/7] gitweb: (gr)avatar support
Date: Tue, 30 Jun 2009 22:16:48 +0200
Message-ID: <200906302216.48872.jnareb@gmail.com>
References: <1246312854-3365-1-git-send-email-giuseppe.bilotta@gmail.com> <1246312854-3365-4-git-send-email-giuseppe.bilotta@gmail.com> <1246312854-3365-5-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Petr Baudis <pasky@suse.cz>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 30 22:30:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MLjy0-000791-AP
	for gcvg-git-2@gmane.org; Tue, 30 Jun 2009 22:30:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753612AbZF3UaC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jun 2009 16:30:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753214AbZF3UaB
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jun 2009 16:30:01 -0400
Received: from mail-bw0-f225.google.com ([209.85.218.225]:65459 "EHLO
	mail-bw0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752710AbZF3UaA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jun 2009 16:30:00 -0400
Received: by bwz25 with SMTP id 25so119582bwz.37
        for <git@vger.kernel.org>; Tue, 30 Jun 2009 13:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=JWzSizREhx8/m6EAmiucKmBoUPKy1T07O1er+gELgyQ=;
        b=Muf1VhEMUx+f6K0SKNVyd5tUDHRAf7kAfKwVxxBnfD5JIrpVLmc/VqaB2ODhFTLKE7
         hmKO39381OmiCSdXAHwI5rCSfBGqtOtImBiR/JrI2PZJcDS8gsdnjnFwvbPdfECwiMeM
         o4W5n/Sc66EpU89icYEx4Ve7R82sVbRetXr4s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=Xfd2BnZT9zY4ER7utyDgEOuVi3Y+krW/QcbJdIWpO/4+jg2Oq5JaC230ylGYRLrW/S
         v6h49H+aqRlwbsUkK2zc664rMZtNxyBuCgArqh7ITleeL8ZOo8JLZEQSBh/aBzcHbrcZ
         nxTIehzoSqK5nuJHdIRLvEQH93Tk7Jzl7B6YE=
Received: by 10.103.214.13 with SMTP id r13mr5119561muq.37.1246393801785;
        Tue, 30 Jun 2009 13:30:01 -0700 (PDT)
Received: from ?192.168.1.13? (abvk72.neoplus.adsl.tpnet.pl [83.8.208.72])
        by mx.google.com with ESMTPS id t10sm2191632muh.0.2009.06.30.13.29.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 30 Jun 2009 13:30:00 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1246312854-3365-5-git-send-email-giuseppe.bilotta@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122536>

On Tue, 30 Jun 2009, Giuseppe Bilotta wrote:

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
> 
> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>

I like both commit message and comprehensive comments.

Acked-by: Jakub Narebski <jnareb@gmail.com>

[...]
> +# Insert an avatar for the given $email at the given $size if the feature
> +# is enabled.
> +sub git_get_avatar {
> +	my ($email, %opts) = @_;
> +	my $pre_white  = ($opts{-pad_before} ? "&nbsp;" : "");
> +	my $post_white = ($opts{-pad_after}  ? "&nbsp;" : "");
> +	$opts{-size} ||= 'default';
> +	my $size = $avatar_size{$opts{-size}} || $avatar_size{'default'};
> +	my $url = "";
> +	if ($git_avatar eq 'gravatar') {
> +		$url = "http://www.gravatar.com/avatar/" .
> +			Digest::MD5::md5_hex(lc $email) . "?s=$size";
> +	}

I guess that you use short form 's' instead of 'size' to make URL (and
therefore gitweb pages) shorter, isn't it?

> +	# Currently only gravatars are supported, but other forms such as
> +	# picons can be added by putting an else up here and defining $url
> +	# as needed. If no variant puts something in $url, we assume avatars
> +	# are completely disabled/unavailable.
> +	if ($url) {
> +		return $pre_white .
> +		       "<img width=\"$size\" " .
> +		            "class=\"avatar\" " .
> +		            "src=\"$url\" " .
> +		       "/>" . $post_white;

Nitpicky sidenote: it might be more readable to use qq( ... ) quote-like
operator to avoid need to escape \" while providing variable 
interpolation.  But on the other hand it might not: this is more obscure
Perl operator.

Nevertheless it is not something to worry about (and certainly not 
something that would require resend).

> +	} else {
> +		return "";
> +	}
> +}
> +
>  # format the author name of the given commit with the given tag
>  # the author name is chopped and escaped according to the other
>  # optional parameters (see chop_str).
> @@ -1476,7 +1547,9 @@ sub format_author_html {
>  	my $tag = shift;
>  	my $co = shift;
>  	my $author = chop_and_escape_str($co->{'author_name'}, @_);
> -	return "<$tag class=\"author\">" . $author . "</$tag>";
> +	return "<$tag class=\"author\">" .
> +	       git_get_avatar($co->{'author_email'}, -pad_after => 1) .
> +	       $author . "</$tag>";
>  }
>  
>  # format git diff header line, i.e. "diff --(git|combined|cc) ..."
> @@ -3252,7 +3325,8 @@ sub git_print_authorship {
>  	      esc_html($co->{'author_name'}) .
>  	      " [$ad{'rfc2822'}";
>  	print_local_time(%ad) if ($opts{-localtime});
> -	print "]</$tag>\n";
> +	print "]" . git_get_avatar($co->{'author_email'}, -pad_before => 1)
> +		  . "</$tag>\n";
>  }
>  
>  # Outputs table rows containing the full author or committer information,
> @@ -3267,7 +3341,10 @@ sub git_print_authorship_rows {
>  	@people = ('author', 'committer') unless @people;
>  	foreach my $who (@people) {
>  		my %wd = parse_date($co->{"${who}_epoch"}, $co->{"${who}_tz"});
> -		print "<tr><td>$who</td><td>" . esc_html($co->{$who}) . "</td></tr>\n".
> +		print "<tr><td>$who</td><td>" . esc_html($co->{$who}) . "</td>" .
> +		      "<td rowspan=\"2\">" .
> +		      git_get_avatar($co->{"${who}_email"}, -size => 'double') .
> +		      "</td></tr>\n" .
>  		      "<tr>" .
>  		      "<td></td><td> $wd{'rfc2822'}";
>  		print_local_time(%wd);
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
> -- 
> 1.6.3.rc1.192.gdbfcb
> 
> 

-- 
Jakub Narebski
Poland
