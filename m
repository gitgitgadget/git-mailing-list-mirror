From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 3/3] gitweb: remove test when closing file descriptor
Date: Thu, 16 Dec 2010 14:30:05 -0800 (PST)
Message-ID: <m3pqu4lx6n.fsf@localhost.localdomain>
References: <1292535801-7421-1-git-send-email-sylvain@abstraction.fr>
	<1292535801-7421-4-git-send-email-sylvain@abstraction.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: Sylvain Rabot <sylvain@abstraction.fr>
X-From: git-owner@vger.kernel.org Thu Dec 16 23:30:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PTML1-0000gx-2x
	for gcvg-git-2@lo.gmane.org; Thu, 16 Dec 2010 23:30:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751379Ab0LPWaJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Dec 2010 17:30:09 -0500
Received: from mail-fx0-f43.google.com ([209.85.161.43]:42668 "EHLO
	mail-fx0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751031Ab0LPWaI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Dec 2010 17:30:08 -0500
Received: by fxm18 with SMTP id 18so63986fxm.2
        for <git@vger.kernel.org>; Thu, 16 Dec 2010 14:30:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=fHK3Ku9UXC/VZg9WyoNlIpcT/h8bsefZvyRoQ915ls0=;
        b=sE9k3fChgMK2YXZkBznd9PIMzjnotvIClZPKfHKdLaLZPi5DW5Vf5BBEmFhZgfqua+
         1C9A2hJh0/CsqIkptZZ8BZHNEpjtRpLJ4GbXO6zgp11uH2ZypYBQ+KINGWO9aVYa2tH8
         L1x2ADMyZwYvfNcbCOr3BqfpdhX4xQZbXUj4g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=lH4aPViRekuLtwnZevu54BCDKdLf2mkh9BqiuJIZBwKjeDH58q2s0HfaPX+OidAluc
         Tof5Hl3Y1z3v2qKJwq644rsLIUiicK5DtGAjS2WpStxUVT6qtuU/HRcAg4bSMrsXpxwl
         3+9FrVfTVQREqUJmEm0QCNhBmkVcJrXy9n3rk=
Received: by 10.223.103.8 with SMTP id i8mr366504fao.47.1292538606600;
        Thu, 16 Dec 2010 14:30:06 -0800 (PST)
Received: from localhost.localdomain (abvg92.neoplus.adsl.tpnet.pl [83.8.204.92])
        by mx.google.com with ESMTPS id 5sm216203fak.47.2010.12.16.14.30.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 16 Dec 2010 14:30:05 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id oAGMTWxY015935;
	Tue, 16 Nov 2010 23:29:35 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id oAGMTK44015931;
	Tue, 16 Nov 2010 23:29:20 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1292535801-7421-4-git-send-email-sylvain@abstraction.fr>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163825>

Sylvain Rabot <sylvain@abstraction.fr> writes:

> it happens that closing file descriptor fails whereas
> the blob is perfectly readable.
> 
> Signed-off-by: Sylvain Rabot <sylvain@abstraction.fr>
> ---
>  gitweb/gitweb.perl |    3 +--
>  1 files changed, 1 insertions(+), 2 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 9398475..9a885b1 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -3450,8 +3450,7 @@ sub run_highlighter {
>  	my ($fd, $highlight, $syntax) = @_;
>  	return $fd unless ($highlight && defined $syntax);
>  
> -	close $fd
> -		or die_error(404, "Reading blob failed");
> +	close $fd;

Actually what I think happens is the following.  "close $fh" cannot
usually fail, unless (`perldoc -f close`):

   If the file handle came from a piped open, "close" will additionally
   return false if one of the other system calls involved fails, or if the
   program exits with non-zero status.  (If the only problem was that the
   program exited non-zero, $! will be set to 0.)  Closing a pipe also waits
   for the process executing on the pipe to complete, in case you want to
   look at the output of the pipe afterwards, and implicitly puts the exit
   status value of that command into $?.

   Prematurely closing the read end of a pipe (i.e. before the process writ-
   ing to it at the other end has closed it) will result in a SIGPIPE being
   delivered to the writer.  If the other end can't handle that, be sure to
   read all the data before closing the pipe.

In this place we close read end of pipe after at most reading a few
bytes (what -T test does), so what might happen is that writer got
SIGPIPE and "failed".  But we are not interested in this, so we can
safely ignore return from 'close'.

I think that some from above explanation should make it to commit
message.

>  	open $fd, quote_command(git_cmd(), "cat-file", "blob", $hash)." | ".
>  	          quote_command($highlight_bin).
>  	          " --xhtml --fragment --syntax $syntax |"

P.S. A better solution would be to redirect opened $fd to highlighter,
instead of closing and reopening a pipe... but I'm not sure how it
could be implemented.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
