From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH RFC 2/2] gitweb: Hyperlink multiple git hashes on the same commit message line
Date: Wed, 18 Feb 2009 22:55:11 +0100
Message-ID: <200902182255.13983.jnareb@gmail.com>
References: <1234926043-7471-1-git-send-email-marcel@oak.homeunix.org> <1234926043-7471-2-git-send-email-marcel@oak.homeunix.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, fg@one2team.net, giuseppe.bilotta@gmail.com,
	pasky@suse.cz
To: "Marcel M. Cary" <marcel@oak.homeunix.org>
X-From: git-owner@vger.kernel.org Wed Feb 18 22:57:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZuPh-0008BJ-DQ
	for gcvg-git-2@gmane.org; Wed, 18 Feb 2009 22:57:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757996AbZBRVzg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2009 16:55:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757557AbZBRVzf
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Feb 2009 16:55:35 -0500
Received: from mail-gx0-f163.google.com ([209.85.217.163]:45800 "EHLO
	mail-gx0-f163.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753471AbZBRVzb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2009 16:55:31 -0500
Received: by gxk7 with SMTP id 7so111045gxk.13
        for <git@vger.kernel.org>; Wed, 18 Feb 2009 13:55:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=1XAlw4WZ5QPM+xjHYW+zgQ11gh0W44qzBGKkjRQ7+Z4=;
        b=QKm63RXt9vtD/k/+53QLSUtq+8c7aQbuFfskmq0CPGM/klTPN0W0whFpe3dvnDoJRC
         rPG5u3TuWUJSR1e0rbjKFaEErujmmlCv6qHFdspezQcvlKpu+lJc/FTJplT1URPDX51X
         O4jPoaJir1g1BepocBn0okjBfjCp85FLUDA+c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=pLw5cseIjqzrJQOzjwOYHlB1E8d1QXn6rMKD0Mw7I2gfqwUfrCT3T/a1tUsoDFrqtl
         JQAYYp5HjGdlqMP45oMI9K6u0rEmtqZv3C/fgnFFZyXI0H74LZeV9cvRLGE6dcOhmZJM
         A+yiuOg6iZ2sP+vX51bwzL9eRYL59h55ZCpmY=
Received: by 10.110.92.8 with SMTP id p8mr2429300tib.19.1234994128940;
        Wed, 18 Feb 2009 13:55:28 -0800 (PST)
Received: from ?192.168.1.13? (abvv197.neoplus.adsl.tpnet.pl [83.8.219.197])
        by mx.google.com with ESMTPS id b4sm974089tic.36.2009.02.18.13.55.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 18 Feb 2009 13:55:27 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <1234926043-7471-2-git-send-email-marcel@oak.homeunix.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110584>

On Wed, 18 Feb 2009, Marcel M. Cary wrote:

> The current implementation only hyperlinks the first hash on
> a given line of the commit message.  It seems sensible to
> highlight all of them if there are multiple, and it seems
> plausible that there would be multiple even with a tidy line
> length limit, because they can be abbreviated as short as 8
> characters.

That is a good catch. Code simply was not modified since we required
fill-length 40-characters SHA-1 id.

> 
> Benchmark:
> 
> I wanted to make sure that using the 'e' switch to the Perl regex
> wasn't going to kill performance, since this is called once per commit
> message line displayed.
> 
> In all three A/B scenarios I tried, the A and B yielded the same
> results within 2%, where A is the version of code before this patch
> and B is the version after.
> 
> 1: View a commit message containing the last 1000 commit hashes
> 2: View a commit message containing 1000 lines of 40 dots to avoid
>    hyperlinking at the same message length
> 3: View a short merge commit message with a few lines of text and
>    no hashes

I don't think we should worry about that; after all esc_path and
unescape subroutines also use 'e' switch to Perl regexp.

So the benchmark is nice addition, but I don't think it is really
necessary, especially that the change results in shorter and easier
(I think) to maintain code.

[...]
> So I think the patch has no noticeable effect on performance.
> 
> Signed-off-by: Marcel M. Cary <marcel@oak.homeunix.org>
> ---
> 
> And here's another.
> 
> Marcel

Do I understand correctly that those patches are not related at all
semantically or textually, only in that you have them one after other
(and blob sha-1 in the index line reflects state after former), isn't
it?

> 
> 
>  gitweb/gitweb.perl |   12 +++++-------
>  1 files changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 653f0be..51b7f56 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -1384,13 +1384,11 @@ sub format_log_line_html {
>  	my $line = shift;
>  
>  	$line = esc_html($line, -nbsp=>1);
> -	if ($line =~ m/\b([0-9a-fA-F]{8,40})\b/) {
> -		my $hash_text = $1;
> -		my $link =
> -			$cgi->a({-href => href(action=>"object", hash=>$hash_text),
> -			        -class => "text"}, $hash_text);
> -		$line =~ s/$hash_text/$link/;
> -	}
> +	$line =~ s{\b([0-9a-fA-F]{8,40})\b}{
> +		return $cgi->a({-href => href(action=>"object", hash=>$1),
> +					   -class => "text"}, $1);
> +	}eg;
> +

Almost correct... but for this unnecessary 'return' statement.
Without it: ACK.

>  	return $line;
>  }
>  
> -- 
> 1.6.1
> 
> 

P.S. Why bare emails (without user names), e.g. "pasky@suse.cz"
and not "Petr Baudis <pasky@suse.cz>"? Just curious...

-- 
Jakub Narebski
Poland
