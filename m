From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Allow gitweb tab width to be set per project.
Date: Tue, 28 Sep 2010 05:25:05 -0700 (PDT)
Message-ID: <m34odagioh.fsf@localhost.localdomain>
References: <1285673709-24924-1-git-send-email-magnus@hagander.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Magnus Hagander <magnus@hagander.net>
X-From: git-owner@vger.kernel.org Tue Sep 28 14:25:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0ZFM-0003oW-5p
	for gcvg-git-2@lo.gmane.org; Tue, 28 Sep 2010 14:25:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753237Ab0I1MZR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Sep 2010 08:25:17 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:53596 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752440Ab0I1MZQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Sep 2010 08:25:16 -0400
Received: by ewy23 with SMTP id 23so1728460ewy.19
        for <git@vger.kernel.org>; Tue, 28 Sep 2010 05:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=p84M4kvjNe6BMokfqItEUJe3jahJPwh8+dS5vCzOxfs=;
        b=dkogzsIQnZEgUBijymRjxvnVPbwyGdnWc309LOaVUz62x4mYpYu66SXVamOVgGkxhL
         jquA0qQe1YvXospc/QQzukhUdPjnSGElN0MDhgVKBv5bT5PsRsMg8ZwxtyQOzmP/MKgJ
         RBIChlRLPZw7qpQ4yZlzcp0PZ++ZFywtFAL+I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=ljnNWVFkIE81xtu2WCkYXvKtTjhkGFZXGotHEEmf3xtItOtIvtVHqhLI6z8eZCR1TF
         lfLD+dBXxIvFejxsdnj6chT/jjd+gNaJchTmQ1TpL4NiUat/RMTBrwUK4JUYvoml8+/O
         oXKuTg4wvHSYUI7FSoohf4GmNko6IkSQS25pw=
Received: by 10.213.33.1 with SMTP id f1mr7111497ebd.53.1285676715054;
        Tue, 28 Sep 2010 05:25:15 -0700 (PDT)
Received: from localhost.localdomain (abvm69.neoplus.adsl.tpnet.pl [83.8.210.69])
        by mx.google.com with ESMTPS id a48sm10369062eei.6.2010.09.28.05.25.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 28 Sep 2010 05:25:05 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o8SCOUbS013209;
	Tue, 28 Sep 2010 14:24:41 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o8SCOEPE013205;
	Tue, 28 Sep 2010 14:24:14 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1285673709-24924-1-git-send-email-magnus@hagander.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157415>

Magnus Hagander <magnus@hagander.net> writes:

> Allow the gitweb.tabwidth option to control how many spaces a tab
> gets expanded to.
> 
> Signed-off-by: Magnus Hagander <magnus@hagander.net>

This might be a good idea, but the solution looks like it includes
some unnecessary performance hit (see coment below).

> ---
> 
> In the PostgreSQL project, we're using 4-space tabs, but we have other projects
> as well on our gitweb server, so we need to be able to control this on a
> per-project basis.

Some of this comment should IMHO make it into commit message, e.g.

  Different project scan use different tab widths, even on the same
  gitweb server.

Or something like that.

> 
> 
>  gitweb/gitweb.perl |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index a85e2f6..ef92a4f 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -1465,9 +1465,11 @@ sub unquote {
>  # escape tabs (convert tabs to spaces)
>  sub untabify {
>  	my $line = shift;
> +	my $tabwidth = git_get_project_config('tabwidth', '--int');

Note that untabify() is called once for each _line_ in a file or a
diff...

This has acceptable performance only because gitweb config is cached
in %config hash by git_get_project_config() subroutine.


I'm not sure if it wouldn't be better to have $tabwidth be passed as
an (optional) argument to untabify(), and calculated either in calling
sites for untabify(), or be calculated per-request and save in a
global variable.

We might want to turn 'tabwidth' into a feature, though that is
probably overengineering.

> +	$tabwidth = 8 if ($tabwidth <= 0);

git_get_project_config('tabwidth', '--int') can return 'undef' if a
configuration key does not exist, resulting in

  Use of uninitialized value in numeric le (<=) at 

warning in web server logs.

>  
>  	while ((my $pos = index($line, "\t")) != -1) {
> -		if (my $count = (8 - ($pos % 8))) {
> +		if (my $count = ($tabwidth - ($pos % $tabwidth))) {
>  			my $spaces = ' ' x $count;
>  			$line =~ s/\t/$spaces/;
>  		}
> -- 
> 1.7.0.4
> 

-- 
Jakub Narebski
Poland
ShadeHawk on #git
