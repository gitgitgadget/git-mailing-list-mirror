From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: last-modified time should be commiter, not author
Date: Mon, 26 Jan 2009 02:54:49 +0100
Message-ID: <200901260254.49919.jnareb@gmail.com>
References: <1232686121-1800-5-git-send-email-giuseppe.bilotta@gmail.com> <1232923370-4427-1-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 26 02:56:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRGiC-00036n-0v
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 02:56:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751145AbZAZBzA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jan 2009 20:55:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751127AbZAZBy7
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jan 2009 20:54:59 -0500
Received: from fg-out-1718.google.com ([72.14.220.153]:24012 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751133AbZAZBy6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jan 2009 20:54:58 -0500
Received: by fg-out-1718.google.com with SMTP id 19so3337456fgg.17
        for <git@vger.kernel.org>; Sun, 25 Jan 2009 17:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=CCJY2y2fgeep7Tn0XAb20KG6wLLesttC+vRiXTqa5ro=;
        b=Nmu+HXMM3+Xpcz9xdospbRcdMi7/DwaVWBOlWs+soCEyfj9BtEA0C0b8PMyyeYX1bR
         ocuz1bBg3HkOnY3vq5s+EnvtqymYbiecruaGXVf44mlOLDFk4zdtT3RC+i8Hp0MRbtSt
         9jT5YUW8Z/P7VZ6xhKcBbRyizOHoEbbowmEYM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=QeQaYxzFOJPXlrxy8jTVrYUjNgfc6jLQvb/67yV0etAN5KD2sRj5wpeMJ+neXPQloI
         p877lnpi196IKvu1etqXpJDeZs/tQdYzF01/kR7AXXSwyFV3xmma0LK+tPomMZG6PsLv
         iRlXMyULd6A1kVhR0b1z9zH9Yu0+wEFsY3M5E=
Received: by 10.86.92.7 with SMTP id p7mr1637778fgb.54.1232934896918;
        Sun, 25 Jan 2009 17:54:56 -0800 (PST)
Received: from ?192.168.1.15? (abvk161.neoplus.adsl.tpnet.pl [83.8.208.161])
        by mx.google.com with ESMTPS id e20sm7971053fga.53.2009.01.25.17.54.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 25 Jan 2009 17:54:55 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <1232923370-4427-1-git-send-email-giuseppe.bilotta@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107157>

On Sun, 25 Jan 2009, Giuseppe Bilotta wrote:

> Subject: [PATCH] gitweb: last-modified time should be commiter, not author

Should be really either "[PATCH 1/2]" or "[PATCH 5/4]" or "[PATCH 5/6]"
just in case for the next patch, because next patch _depends_ on this
one, and just in case of threading problem it should be marked as it;
it also makes easier to apply patches from emails saved as individual
files each.

>
> The last-modified time header added by RSS to increase cache hits from
> readers should be set to the date the repository was last modified. The
> author time in this respect is not a good guess because the last commit
> might come from a oldish patch.
> 
> Use the committer time for the last-modified header to ensure a more
> correct guess of the last time the repository was modified.

Good catch, good thinking IMHO. Committer date has much better chance
to be monotonic than author date, and is more close related to 
_publishing_ date (author date is more of _creation_ date).

Lack signoff; if Junio forges it (or you reply that it should be
signed off), you can add from me

Acked-by: Jakub Narebski <jnareb@gmail.com>


P.S. I wonder what other web interfaces do, for example cgit. I guess
that web interfaces for other SCMs like SVN::Web, ViewVC etc. do not
have this problem because they have only one, single date.

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
