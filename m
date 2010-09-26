From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv5 08/12] gitweb: auxiliary function to group data
Date: Sun, 26 Sep 2010 23:47:15 +0200
Message-ID: <201009262347.15779.jnareb@gmail.com>
References: <1285344167-8518-1-git-send-email-giuseppe.bilotta@gmail.com> <1285344167-8518-9-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 26 23:47:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ozz4I-0003SA-1j
	for gcvg-git-2@lo.gmane.org; Sun, 26 Sep 2010 23:47:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757849Ab0IZVrT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Sep 2010 17:47:19 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:59714 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757541Ab0IZVrT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Sep 2010 17:47:19 -0400
Received: by fxm3 with SMTP id 3so1495993fxm.19
        for <git@vger.kernel.org>; Sun, 26 Sep 2010 14:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=LuiQZECSxcm2JPhfBesI+p7W83R80P8QnAxL1GOcq40=;
        b=NjhAi4e6cr3kfZK52DtNWqE2D8zWqRC6dfmwgsoyDeBenaheRyZQcpRmAcnk1UXeVT
         AYupPjJKyzYxg1lYECA2a+0oncEQSd/jPcnEzVk8Vb5ZEbvFhmuJveG1d0+Z/XoM1Fu4
         Vkx7xBt5zs3c93DW6KTeLm0R2me3xhz4EBDqg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=ean8cYhTW9D0C00lw7+WqeghYhUm0PnyE+iKlSRmMaHxnR4n4FwHkD3vp1MLphYR9g
         CESyoto1t8ygTuQXYA9kb0Mow2OAcmTdVd5p1jW4IkHslquW6azNLDyH4/AIq++Ac2jc
         lUbcPsk/9eXHotNlEj2VoczKXX0ESXX8IKq+g=
Received: by 10.223.115.19 with SMTP id g19mr6628249faq.70.1285537637873;
        Sun, 26 Sep 2010 14:47:17 -0700 (PDT)
Received: from [192.168.1.13] (abwp12.neoplus.adsl.tpnet.pl [83.8.239.12])
        by mx.google.com with ESMTPS id h12sm2073451faa.13.2010.09.26.14.47.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 26 Sep 2010 14:47:16 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1285344167-8518-9-git-send-email-giuseppe.bilotta@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157261>

On Fri, 24 Sep 2010, Giuseppe Bilotta wrote:

> Subject: gitweb: auxiliary function to group data
>

Errr... what!?  git_group() is not "auxiliary function to group data",
but a template for output of group of data.

It would be probably good to describe how this output looks like
(using e.g. ASII-art mockup) in a commit message.

> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
> ---
>  gitweb/gitweb.perl |   16 ++++++++++++++++
>  1 files changed, 16 insertions(+), 0 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 7c62701..8f11fb5 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -3786,6 +3786,22 @@ sub git_print_header_div {
>  	      "\n</div>\n";
>  }
>  
> +sub git_group {

Name?

> +	my ($class, $id, @rest) = @_;
> +
> +	my $content_func = pop @rest;
> +
> +	$class = join(' ', 'group', $class);
> +
> +	print $cgi->start_div({
> +		-class => $class,
> +		-id => $id,
> +	});
> +	git_print_header_div(@rest);
> +	$content_func->() if defined $content_func;

More defensive programming would be to use

  +	$content_func->() if ref($content_func) eq 'CODE';

Or even:

  +	if (ref($content) eq 'CODE') {
  +		$content->();
  +	} elsif (ref($content) eq 'ARRAY') {
  +		print @$content;
  +	} elsif (!ref($content) && defined($content)) {
  +		print $content;
  +	}

Well, $content could be also open filehandle...

> +	print $cgi->end_div;
> +}

Nice usage of start_div and end_div.

> +
>  sub print_local_time {
>  	print format_local_time(@_);
>  }
> -- 
> 1.7.3.68.g6ec8
> 
> 

-- 
Jakub Narebski
Poland
