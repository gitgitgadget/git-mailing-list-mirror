From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 16/18] gitweb: When changing output (STDOUT) change STDERR as well
Date: Thu, 09 Dec 2010 17:36:02 -0800 (PST)
Message-ID: <m3vd32z9yk.fsf@localhost.localdomain>
References: <1291931844-28454-1-git-send-email-warthog9@eaglescrag.net>
	<1291931844-28454-17-git-send-email-warthog9@eaglescrag.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: "John 'Warthog9' Hawley" <warthog9@eaglescrag.net>
X-From: git-owner@vger.kernel.org Fri Dec 10 02:36:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQruB-0003AT-FH
	for gcvg-git-2@lo.gmane.org; Fri, 10 Dec 2010 02:36:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757780Ab0LJBgG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Dec 2010 20:36:06 -0500
Received: from mail-fx0-f43.google.com ([209.85.161.43]:51807 "EHLO
	mail-fx0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757648Ab0LJBgE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Dec 2010 20:36:04 -0500
Received: by fxm18 with SMTP id 18so3185852fxm.2
        for <git@vger.kernel.org>; Thu, 09 Dec 2010 17:36:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=/P/iApvCCsPT2fQaf+8/hjz4QTZfjtpYZReFAiOHWlI=;
        b=dI9AqiO6K48kGtmC8OB3uBET28f1AT53sA9Hs6fPsUcl3+NA2bONpKDntVoL7imcep
         q0AEFjABtCE0loI0H/XCxnd/C2bDSiAQ7YVDs0LW0HjL+z4slXKtWYmaPayGmt3AhF8q
         /JSyp0LN06lt8Eryfga42T5MQNuyZFwXaGS3c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=jZTCn0cyRcr+bQW7wOpfM7gTNtdda07BB8i/utmddWSOYtzRDD8lO7wJk/u2PI+zov
         xKHUBkWryKmEa7fDjkmMOXz2HcaaL8e+3+VxbNSmtT6jX+vx8ECsX2DfPxbOnEJULvLO
         DzqEa3lhuc9nbYA4ce6aYlkPgxZcCHZQgFbZk=
Received: by 10.223.125.207 with SMTP id z15mr184666far.42.1291944962940;
        Thu, 09 Dec 2010 17:36:02 -0800 (PST)
Received: from localhost.localdomain (abvv86.neoplus.adsl.tpnet.pl [83.8.219.86])
        by mx.google.com with ESMTPS id n3sm751457fax.7.2010.12.09.17.36.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 09 Dec 2010 17:36:02 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id oBA1ZVgC021370;
	Fri, 10 Dec 2010 02:35:42 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id oBA1ZFQF021365;
	Fri, 10 Dec 2010 02:35:15 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1291931844-28454-17-git-send-email-warthog9@eaglescrag.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163377>

"John 'Warthog9' Hawley" <warthog9@eaglescrag.net> writes:

> This sets up a trap for STDERR as well as STDOUT.  This should
> prevent any transient error messages from git itself percolating
> up to gitweb and outputting errant information before the HTTP
> header has been sent.

Hmm... anuthing that happens after 'use CGI::Carp;' is parsed should
have STDERR redirected to web server logs, see CGI::Carp manpage

    [...]
 
       use CGI::Carp

    And the standard warn(), die (), croak(), confess() and carp() calls will
    automagically be replaced with functions that write out nicely time-stamped
    messages to the HTTP server error log.

    [...]

    REDIRECTING ERROR MESSAGES

       By default, error messages are sent to STDERR.  Most HTTPD servers direct
       STDERR to the server's error log.

    [...]

Especially the second part.


Could you give us example which causes described misbehaviour?

I have nothing against this patch: if you have to have it, then you
have to have it.  I oly try to understand what might be core cause
behind the issue that this patch is to solve...

> Signed-off-by: John 'Warthog9' Hawley <warthog9@eaglescrag.net>
> ---
>  gitweb/gitweb.perl  |   22 +++++++++++++++++++++-
>  gitweb/lib/cache.pl |   22 ----------------------
>  2 files changed, 21 insertions(+), 23 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 7f8292e..d39982a 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -1214,6 +1214,10 @@ sub evaluate_argv {
>  sub change_output {
>  	our $output;
>  
> +	#
> +	# STDOUT
> +	#
> +
>  	# Trap the 'proper' STDOUT to STDOUT_REAL for things like error messages and such
>  	open(STDOUT_REAL,">&STDOUT") or die "Unable to capture STDOUT $!\n";
>  	print STDOUT_REAL "";
> @@ -1223,12 +1227,28 @@ sub change_output {
>  
>  	# Trap STDOUT to the $output variable, which is what I was using in the original
>  	# patch anyway.
> -	open(STDOUT,">", \$output) || die "Unable to open STDOUT: $!"; #open STDOUT handle to use $var
> +	open(STDOUT,">", \$output) || die "Unable to open STDOUT: $!"; #open STDOUT handle to use $output
> +
> +	#
> +	# STDERR
> +	#
> +
> +	# Trap the 'proper' STDOUT to STDOUT_REAL for things like error messages and such
> +	open(STDERR_REAL,">&STDERR") or die "Unable to capture STDERR $!\n";
> +	print STDERR_REAL "";

'print STDERR_REAL "";' nicely solves the spurious warning problem.
Nice.

> +
> +	# Close STDOUT, so that it isn't being used anymore.
> +	close STDERR;
> +
> +	# Trap STDOUT to the $output variable, which is what I was using in the original
> +	# patch anyway.
> +	open(STDERR,">", \$output_err) || die "Unable to open STDERR: $!"; #open STDERR handle to use $output_err

Err... where $output_err is defined?

>  }
>  
>  sub reset_output {
>  	# This basically takes STDOUT_REAL and puts it back as STDOUT
>  	open(STDOUT,">&STDOUT_REAL");
> +	open(STDERR,">&STDERR_REAL");
>  }
>  
>  sub run {
> diff --git a/gitweb/lib/cache.pl b/gitweb/lib/cache.pl
> index 28e4240..a8c902d 100644
> --- a/gitweb/lib/cache.pl
> +++ b/gitweb/lib/cache.pl
> @@ -380,28 +380,6 @@ EOF
>  	return;
>  }
>  
> -sub cacheDisplayErr {
> -
> -	return if ( ! -e "$fullhashpath.err" );
> -
> -	open($cacheFileErr, '<:utf8', "$fullhashpath.err");
> -	$lockStatus = flock($cacheFileErr,LOCK_SH|LOCK_NB);
> -
> -	if (! $lockStatus ){
> -		show_warning(
> -				"<p>".
> -				"<strong>*** Warning ***:</strong> Locking error when trying to lock error cache page, file $fullhashpath.err<br/>/\n".
> -				"This is about as screwed up as it gets folks - see your systems administrator for more help with this.".
> -				"<p>"
> -				);
> -	}
> -
> -	while( <$cacheFileErr> ){
> -		print $_;
> -	}
> -	exit(0);
> -}

Errr... in which patch it was added?


-- 
Jakub Narebski
Poland
ShadeHawk on #git
