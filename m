From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: fix wrong base URL when non-root DirectoryIndex
Date: Fri, 13 Feb 2009 09:45:19 +0100
Message-ID: <200902130945.20601.jnareb@gmail.com>
References: <200902122303.37499.jnareb@gmail.com> <1234510803-23268-1-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Petr Baudis <pasky@suse.cz>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 13 09:47:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXthH-0000s1-37
	for gcvg-git-2@gmane.org; Fri, 13 Feb 2009 09:46:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751854AbZBMIp1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Feb 2009 03:45:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751561AbZBMIp1
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Feb 2009 03:45:27 -0500
Received: from mail-bw0-f161.google.com ([209.85.218.161]:53395 "EHLO
	mail-bw0-f161.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751426AbZBMIp0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Feb 2009 03:45:26 -0500
Received: by bwz5 with SMTP id 5so1552143bwz.13
        for <git@vger.kernel.org>; Fri, 13 Feb 2009 00:45:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=1q/yzng9PnHC903ZYe15tnb10f1t60M9xAiDngxg6GU=;
        b=VUMpTAars+YGBTwduMFm8e/f6uGaFucaow2+iaM5qHiCghYKq9nUaLwQRIOzFlKt37
         vwCDMZDn12yVB1rwQtcBVHhA1UA+XMiwXeON/zhZFDWpSCo4j1o/AZd48tx9KBtJ5Z55
         A1AFOIvBCfIrZFxD7pabzEiH8Avsuwg+5G8ms=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=Rv2fOdPFgHtTbG2Z8A8NB4M4ONmZLlP+WTFVEurUPMWF+rgiGyxFFgWOhqhy2XJnqN
         LNtZTeBav1HEUbRcbfdEjxH3EbBr4EX6n1eAnMyvHh2S7x8cZ/9Kg0sTrC/0eGnSCTOY
         m4mQ2fOFnZHgtywQO/y1G8m7mWsAVv0b3jcWI=
Received: by 10.86.99.9 with SMTP id w9mr120754fgb.68.1234514724433;
        Fri, 13 Feb 2009 00:45:24 -0800 (PST)
Received: from ?192.168.1.13? (abvs153.neoplus.adsl.tpnet.pl [83.8.216.153])
        by mx.google.com with ESMTPS id e11sm2478120fga.40.2009.02.13.00.45.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 13 Feb 2009 00:45:24 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <1234510803-23268-1-git-send-email-giuseppe.bilotta@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109727>

On Fri, 13 Feb 2009, Giuseppe Bilotta wrote:

> CGI::url() has some issues when rebuilding the script URL if the script
> is a DirectoryIndex.
> 
> One of these issue is the inability to strip PATH_INFO, which is why we
> had to do it ourselves.
> 
> Another issue is that the resulting URL cannot be used for the <base>
> tag: it works if we're the DirectoryIndex at the root level, but not
> otherwise.
> 
> We fix this by building the proper base URL ourselves, and improve the
> documentation about the need to strip PATH_INFO manually while we're at
> it.
> 
> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>

Sounds good. I don't use gitweb as DirectoryIndex myself, but
Acked-by: Jakub Narebski <jnareb@gmail.com>

> ---
>  gitweb/gitweb.perl |   16 ++++++++++++----
>  1 files changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index c2c8080..48cfd5f 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -27,15 +27,23 @@ our $version = "++GIT_VERSION++";
>  our $my_url = $cgi->url();
>  our $my_uri = $cgi->url(-absolute => 1);
>  
> -# if we're called with PATH_INFO, we have to strip that
> -# from the URL to find our real URL
> -# we make $path_info global because it's also used later on
> +# When the script is used as DirectoryIndex, the URL does not contain the name
> +# of the script file itself, and $cgi->url() fails to strip PATH_INFO, so we
> +# have to do it ourselves. We make $path_info global because it's also used
> +# later on
>  our $path_info = $ENV{"PATH_INFO"};
>  if ($path_info) {
>  	$my_url =~ s,\Q$path_info\E$,,;
>  	$my_uri =~ s,\Q$path_info\E$,,;
>  }
>  
> +# Another issue with the script being the DirectoryIndex is that the resulting
> +# $my_url data is not the full script URL: this is good, because we want
> +# generated links to keep implying the script name if it wasn't explicitly
> +# indicated in the URL we're handling, but it means that $my_url cannot be used
> +# as base URL. Therefore, we have to build the base URL ourselves:
> +our $base_url = $cgi->url(-base => 1) . $ENV{'SCRIPT_NAME'};
> +
>  # core git executable to use
>  # this can just be "git" if your webserver has a sensible PATH
>  our $GIT = "++GIT_BINDIR++/git";
> @@ -2908,7 +2916,7 @@ EOF
>  	# the stylesheet, favicon etc urls won't work correctly with path_info
>  	# unless we set the appropriate base URL
>  	if ($ENV{'PATH_INFO'}) {
> -		print "<base href=\"".esc_url($my_url)."\" />\n";
> +		print "<base href=\"".esc_url($base_url)."\" />\n";
>  	}
>  	# print out each stylesheet that exist, providing backwards capability
>  	# for those people who defined $stylesheet in a config file
> -- 
> 1.5.6.5
> 
> 

-- 
Jakub Narebski
Poland
