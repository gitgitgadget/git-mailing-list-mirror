From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv2 5/6] gitweb: last-modified time should be commiter, not author
Date: Thu, 5 Feb 2009 00:38:57 +0100
Message-ID: <200902050038.57999.jnareb@gmail.com>
References: <1232970616-21167-1-git-send-email-giuseppe.bilotta@gmail.com> <1232970616-21167-5-git-send-email-giuseppe.bilotta@gmail.com> <1232970616-21167-6-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 05 00:40:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUrMO-0002tA-MZ
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 00:40:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757965AbZBDXjJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 18:39:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753006AbZBDXjH
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 18:39:07 -0500
Received: from fg-out-1718.google.com ([72.14.220.153]:63240 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757965AbZBDXjG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 18:39:06 -0500
Received: by fg-out-1718.google.com with SMTP id 16so1387471fgg.17
        for <git@vger.kernel.org>; Wed, 04 Feb 2009 15:39:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=2F1F7sd7HOc3f9fzTqXXRzNl4DXZfTta45C8nR+B8AU=;
        b=oK49+yXmHsHfX/DWOKdHaqVzdnBwhO56tcMpV1Hv0SB2kMWoxvTYe9Klmw5W/LzXpO
         4yDhXoJccqjFH2flbFR2FjoTn2EavpGIkkwet9494QF8zHZWF87v6m+zBM5ixHFwyVjb
         bfNx6h/3K2sDsU6ibZTJCQzLJWGeMA5NlAEHU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=FimVTx92cx1wtoN6e1mir/IKIFeU9mHXjNAaqIoGDSzg+2E+y2bg8pFwm0/iyKIDT7
         6UEv3d0FPBhbFTyew4Tf7I1BL8VURQjLWuTEotxh7xMCe3gxmUFq2z41ekiPgrwMNLo4
         nJpxXwvBeNL2xYtEnmGkrn/JtA//5RUx7tXjo=
Received: by 10.86.91.3 with SMTP id o3mr1036121fgb.35.1233790742900;
        Wed, 04 Feb 2009 15:39:02 -0800 (PST)
Received: from ?192.168.1.13? (abwq247.neoplus.adsl.tpnet.pl [83.8.240.247])
        by mx.google.com with ESMTPS id 3sm1090856fge.22.2009.02.04.15.39.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 04 Feb 2009 15:39:01 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <1232970616-21167-6-git-send-email-giuseppe.bilotta@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108466>

On Mon, 26 Jan 2009, Giuseppe Bilotta wrote:

> The last-modified time header added by RSS to increase cache hits from
> readers should be set to the date the repository was last modified. The
> author time in this respect is not a good guess because the last commit
> might come from a oldish patch.
> 
> Use the committer time for the last-modified header to ensure a more
> correct guess of the last time the repository was modified.

First, changing %latest_date from author time to committer time affects
not only Last-Modified HTTP header, but (after this series) also
various "publication dates" in the feed contents.  But I think that for
all those committer time is better approximation of publication date
and last change date than author time.

Second, author time reflects when change (commit) was made, according
to authors (perhaps skewed) clock.  Committer time reflects when given
commit (version of a commit) was entered into repository, or to be more
exact into some clone of given project.  But there is also an issue of
when changes got into given instance of repository (given clone): that
I guess might be found by stat-ing HEAD (if it arrived by commit),
FETCH_HEAD (if it arrived by fetch or pull) and ??? (if it arrived by
push)... err... it looks like it wouldn't work in most common case,
sorry, unless we want to stat all refs and packed-refs file. But while
this date might be better for Last-Modified, I'm not sure if it is good
at all for publication date.

So committer time is better than author time, and looks like good
middle ground.

> 
> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
> ---
>  gitweb/gitweb.perl |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 756868a..8c49c75 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -6015,7 +6015,7 @@ sub git_feed {
>  	}
>  	if (defined($commitlist[0])) {
>  		%latest_commit = %{$commitlist[0]};
> -		%latest_date   = parse_date($latest_commit{'author_epoch'});
> +		%latest_date   = parse_date($latest_commit{'committer_epoch'});

Nice and simple. Good.

>  		print $cgi->header(
>  			-type => $content_type,
>  			-charset => 'utf-8',
> -- 
> 1.5.6.5
> 
> 

-- 
Jakub Narebski
Poland
