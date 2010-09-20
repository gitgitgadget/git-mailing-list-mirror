From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Enable highlight executable path as a configuration option
Date: Mon, 20 Sep 2010 11:10:37 +0200
Message-ID: <201009201110.38271.jnareb@gmail.com>
References: <4C96938C.5050505@cdwilson.us>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	"Alejandro R. =?iso-8859-1?q?Sede=F1o?=" <asedeno@mit.edu>,
	git@vger.kernel.org
To: Christopher Wilson <cwilson@cdwilson.us>
X-From: git-owner@vger.kernel.org Mon Sep 20 11:10:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxcOn-0006e4-Oq
	for gcvg-git-2@lo.gmane.org; Mon, 20 Sep 2010 11:10:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755948Ab0ITJKv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Sep 2010 05:10:51 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:51167 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752209Ab0ITJKv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Sep 2010 05:10:51 -0400
Received: by bwz11 with SMTP id 11so4085320bwz.19
        for <git@vger.kernel.org>; Mon, 20 Sep 2010 02:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=5OfmymiS41D577J1Y8nvmkKcdpw0zCmXHzq48wW4npw=;
        b=YQBj0YiszoE3zdqvaUNI2hQJLPvq3gmCVPO3M9JApQWjMPRl3kCQmcYnk/xgp+yd0+
         3VqeyyKsl0hM0U0tSKnNSQldr0C7Xw79GEX71NVu9x0gVrDWH1m7b3kOh2+UDG6/YG6V
         6J897AHJHRlXcjrO/3IM865QmIRfh8DDNOlc8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=W77BAWe6OeEQzDMS1YpJplLC6l+TSrAUivpaNaLPVa2XTRs6PIBcNX7a6peygRGR5c
         uQd/xu+odrimznKGrTb9Zl5GQjViyYu7nthb0slkF96T8huNu+2wuVjcsSy2wUvAtSj6
         AHt5w5TnaSjb+LjF3yz18BqjNelWUil6EIbR4=
Received: by 10.204.113.65 with SMTP id z1mr5427323bkp.25.1284973848108;
        Mon, 20 Sep 2010 02:10:48 -0700 (PDT)
Received: from [192.168.1.13] (abwt29.neoplus.adsl.tpnet.pl [83.8.243.29])
        by mx.google.com with ESMTPS id 24sm6278862bkr.7.2010.09.20.02.10.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 20 Sep 2010 02:10:46 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <4C96938C.5050505@cdwilson.us>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156601>

On Mon, 20 Sep 2010, Christopher Wilson wrote:

> Allow build-time/run-time configuration of the highlight executable. Defaults
> to previous behavior which assumes that highlight is available on the server
> PATH. However, if this is not the case, the path to the highlight executable
> can be configured at build time as a configuration variable
> 
>     HIGHLIGHT_BIN = /path/to/highlight
> 
> or at runtime by configuring GITWEB_CONFIG
> 
>     $highlight_bin = /path/to/highlight
> 
> Signed-off-by: Christopher Wilson <cwilson@cdwilson.us>

Good idea... but I am not sure about shell quoting and the problem
with spaces in pathnames.  See comments below.

> ---
>  gitweb/Makefile    |    4 +++-
>  gitweb/README      |    7 ++++++-
>  gitweb/gitweb.perl |    6 +++++-
>  3 files changed, 14 insertions(+), 3 deletions(-)

> diff --git a/gitweb/README b/gitweb/README
> index d481198..69f9860 100644
> --- a/gitweb/README
> +++ b/gitweb/README
> @@ -114,6 +114,9 @@ You can specify the following configuration variables when building GIT:
>     when gitweb.cgi is executed, then the file specified in the environment
>     variable will be loaded instead of the file specified when gitweb.cgi was
>     created.  [Default: /etc/gitweb.conf]
> + * HIGHLIGHT_BIN
> +   Path to the highlight executable to use. Useful if highlight is not
> +   installed on your webserver's PATH. [Default: highlight]
  
I think it needs to be said that this 'highlight' executable must be 
the one from http://www.andre-simon.de (assumptions about parameters and
output).
  
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index a85e2f6..e808485 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
[...]
> @@ -3360,7 +3364,7 @@ sub run_highlighter {
>  	close $fd
>  		or die_error(404, "Reading blob failed");
>  	open $fd, quote_command(git_cmd(), "cat-file", "blob", $hash)." | ".
> -	          "highlight --xhtml --fragment --syntax $syntax |"
> +	          "$highlight_bin --xhtml --fragment --syntax $syntax |"

I think you need 

  +	          quote_command($highlight_bin)." --xhtml --fragment --syntax $syntax |"

here

>  		or die_error(500, "Couldn't open file or run syntax highlighter");
>  	return $fd;
>  }
> -- 
> 1.7.2.3
> 
> 

-- 
Jakub Narebski
Poland
