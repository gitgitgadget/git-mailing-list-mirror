From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv7 6/9] gitweb: gravatar url cache
Date: Sun, 28 Jun 2009 00:15:30 +0200
Message-ID: <200906280015.31639.jnareb@gmail.com>
References: <1246104305-15191-1-git-send-email-giuseppe.bilotta@gmail.com> <1246104305-15191-6-git-send-email-giuseppe.bilotta@gmail.com> <1246104305-15191-7-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 28 00:15:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MKgBW-00034D-K6
	for gcvg-git-2@gmane.org; Sun, 28 Jun 2009 00:15:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752821AbZF0WP3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Jun 2009 18:15:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752772AbZF0WP3
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Jun 2009 18:15:29 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:60992 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752346AbZF0WP3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jun 2009 18:15:29 -0400
Received: by fg-out-1718.google.com with SMTP id e21so683563fga.17
        for <git@vger.kernel.org>; Sat, 27 Jun 2009 15:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=5jLW5MBp9OHF+98MrhgTCbzEtr6HjMRlgmKMcNphGYY=;
        b=aGadZlps7EvoOkOZu+29p1FbUMCUn2WKXJsCMmwSCoyo0Wu5xgc1fQ5QvHr7IRNaFi
         4s1RjowQR2rQndwuF3Fzd5dI+lERUxD4GAyq6kARCLfvEX6mvI2R1G5nuGuBxH4JCE1i
         VUZ7vciKeeDK9rglt5Vf8XYbF/YlinSzrc7wM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=pBTtE97i8ifp+1V6toZ5eNPlPSrOsHcVVpM6vRGEuJ0lb8Bbxmna2PyppgyvaXRt79
         lHDvWDM8n8Mf/SeQZTJ06Xcnnf8b7Y74/5wyFHi7pIPyiJJtkRqPIkT0EikSZYcJhBwt
         8uQXID8gsYLzMyn3iJZ5sOXQkPX6WaP97jdts=
Received: by 10.86.98.16 with SMTP id v16mr556567fgb.40.1246140931103;
        Sat, 27 Jun 2009 15:15:31 -0700 (PDT)
Received: from ?192.168.1.13? (abwd106.neoplus.adsl.tpnet.pl [83.8.227.106])
        by mx.google.com with ESMTPS id 3sm1465793fge.17.2009.06.27.15.15.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 27 Jun 2009 15:15:30 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1246104305-15191-7-git-send-email-giuseppe.bilotta@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122386>

On Sat, 27 June 2009, Giuseppe Bilotta wrote:

> Views which contain many occurrences of the same email address (e.g.
> shortlog view) benefit from not having to recalculate the MD5 of the
> email address every time.
> 
> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>

Acked-by: Jakub Narebski <jnareb@gmail.com>

> ---

Here there are some very simple benchmarks of the effect of gravatar 
URL cache.  I'm not sure if they should be put in commit message.

When running gitweb as a script
   $ time gitweb-run.sh "p=git.git;a=shortlog" >/dev/null
I got the following results

             | before          | after 
 ------------+-----------------|------------------
 summary     | 0.978s (0.964s) | 0.961s (0.940s)
 shortlog    | 1.001s (0.980s) | 1.033s (1.008s)

which means the same results within the margin of error, (as seen when
repeating benchmark the differences are within the range of fluctuations).
Time is real (wallclock) time, in parentheses there is user + sys time.


When using ApacheBench 2.0.41-dev, with gitweb run as CGI script
(not as legacy, i.e. ModPerl::Registry, mod_perl script)
  $ ab <opt> "http://localhost/cgi-bin/gitweb/gitweb.cgi/git.git/shortlog"
I got the folowing results

             | before          | after 
 ------------+-----------------|------------------
 -n 10       | 1094.050 [ms]   |  989.136 [ms]
 -n 10 -c 2  | 1147.965 [ms]   | 1041.324 [ms]

which means around 10% improvement.  Standard deviation is around 10 ms
for no concurrency, and around 200 ms (more than third of difference)
for concurrent connections.  Shown here is time per request (mean, 
across all concurrent requests).

>  gitweb/gitweb.perl |   30 +++++++++++++++++++++++++++---
>  1 files changed, 27 insertions(+), 3 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index ad9ae31..de4cc63 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -1515,6 +1515,27 @@ sub format_subject_html {
>  	}
>  }
>  
> +# Rather than recomputing the url for an email multiple times, we cache it
> +# after the first hit. This gives a visible benefit in views where the avatar
> +# for the same email is used repeatedly (e.g. shortlog).
> +# The cache is shared by all avatar engines (currently gravatar only), which
> +# are free to use it as preferred. Since only one avatar engine is used for any
> +# given page, there's no risk for cache conflicts.
> +our %avatar_cache = ();

Good comment.

> +
> +# Compute the gravatar url for a given email, if it's not in the cache already.
> +# Gravatar stores only the part of the URL before the size, since that's the
> +# one computationally more expensive. This also allows reuse of the cache for
> +# different sizes (for this particular engine).
> +sub gravatar_url {
> +	my $email = lc shift;
> +	my $size = shift;
> +	$avatar_cache{$email} ||=
> +		"http://www.gravatar.com/avatar.php?gravatar_id=" .
> +			Digest::MD5::md5_hex($email) . "&amp;size=";

The same comment as for previous patch: why not use modern API?

  +		"http://www.gravatar.com/avatar/" .
  +			Digest::MD5::md5_hex($email) . "?size=";


> +	return $avatar_cache{$email} . $size;
> +}

Nice.

> +
>  # Insert an avatar for the given $email at the given $size if the feature
>  # is enabled.
>  sub git_get_avatar {
> @@ -1524,15 +1545,18 @@ sub git_get_avatar {
>  	my $size = $avatar_size{$opts{'size'}} || $avatar_size{'default'};
>  	my $url = "";
>  	if ($git_avatar eq 'gravatar') {
> -		$url = "http://www.gravatar.com/avatar.php?gravatar_id=" .
> -			Digest::MD5::md5_hex(lc $email) . "&amp;size=$size";
> +		$url = gravatar_url($email, $size);
>  	}

Great encapsulation.

>  	# Currently only gravatars are supported, but other forms such as
>  	# picons can be added by putting an else up here and defining $url
>  	# as needed. If no variant puts something in $url, we assume avatars
>  	# are completely disabled/unavailable.
>  	if ($url) {
> -		return $pre_white . "<img width=\"$size\" class=\"avatar\" src=\"$url\" />" . $post_white;
> +		return $pre_white .
> +		       "<img width=\"$size\" " .
> +		            "class=\"avatar\" " .
> +		            "src=\"$url\" " .
> +		       "/>" . $post_white;

This is independent change.  It shouldn't be here; if you prefer such 
solution, you should squash it with previous patch.  Please drop this
chunk.

>  	} else {
>  		return "";
>  	}
> -- 

Thanks again for great work on this series!

-- 
Jakub Narebski
Poland
