From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv5 2/6] Gitweb: add support for minifying gitweb.css
Date: Thu, 1 Apr 2010 10:51:38 +0200
Message-ID: <201004011051.39711.jnareb@gmail.com>
References: <4BB430C3.9030000@mailservices.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Mark Rada <marada@uwaterloo.ca>
X-From: git-owner@vger.kernel.org Thu Apr 01 10:52:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NxG8G-0007ml-1g
	for gcvg-git-2@lo.gmane.org; Thu, 01 Apr 2010 10:52:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754465Ab0DAIv7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Apr 2010 04:51:59 -0400
Received: from mail-fx0-f227.google.com ([209.85.220.227]:64868 "EHLO
	mail-fx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754198Ab0DAIv4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Apr 2010 04:51:56 -0400
Received: by fxm27 with SMTP id 27so284944fxm.28
        for <git@vger.kernel.org>; Thu, 01 Apr 2010 01:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=/SC8NHqn/EglDqoMA4n02CgnfVoLlK3oUPYFVRZoBVM=;
        b=abrxwqrCsuCBGos69WvVvu5guom2WJoPLKGZUXW6CTAAd8WmpAUIc29aSkYONDmvbS
         leN8KMmPIGO/eiWZBACGnnSZqsVmHLMDO+16fv8UpobLIhGT9ZXhsXvKWqrhl/lTPWWh
         QHPKTVSipsPppDtrxNLYXz50PxhlNgX080+IM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=ZrN+ICDu1ljDzdXZe2neT1l8hWUUx+q1AYsXH/6VlWMQKkR0pNUa6SLFZqqAFN95qH
         KTYGosccoz9jYNjHhqVOMffhchiH9HoMB7rg58d8O0eBnNHqrncQSuX+XUKNixkyeMGw
         g3l6ggbtzrV/ye/+sRFmpSgiN/3m3/nCD/gFk=
Received: by 10.223.21.17 with SMTP id h17mr387812fab.45.1270111914830;
        Thu, 01 Apr 2010 01:51:54 -0700 (PDT)
Received: from [192.168.1.13] (abws156.neoplus.adsl.tpnet.pl [83.8.242.156])
        by mx.google.com with ESMTPS id 13sm5406168fxm.2.2010.04.01.01.51.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 01 Apr 2010 01:51:52 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <4BB430C3.9030000@mailservices.uwaterloo.ca>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143723>

On Thu, 1 April 2010, Mark Rada wrote:

> The build system added support minifying gitweb.js through a
> JavaScript minifier, but most minifiers come with support to
> minify CSS files as well, so we should use it if we can.
> 
> This patch will add the same facilities to gitweb.css that
> gitweb.js has for minification. That does not mean that they
> will use the same minifier though, as it is not safe to assume
> that all JavaScript minifiers will also minify CSS files.
> 
> Though the bandwidth savings will not be as dramatic as with
> the JavaScript minifier, every byte saved is important.

That's not everything this patch does, isn't it?  I think you should
have added to your commit message the following paragraph:

  While at it, introduce GITWEB_PROGRAMS variable to Makefile and
  use it for gitweb instead of adding to OTHER_PROGRAMS, to keep
  (possible) gitweb dependencies separate.

Or something like that.

> 
> Signed-off-by: Mark Rada <marada@uwaterloo.ca>

I think it is good idea.

[...]
>  ifdef JSMIN
> -OTHER_PROGRAMS += gitweb/gitweb.cgi   gitweb/gitweb.min.js
> -gitweb/gitweb.cgi: gitweb/gitweb.perl gitweb/gitweb.min.js
> -else
> -OTHER_PROGRAMS += gitweb/gitweb.cgi
> -gitweb/gitweb.cgi: gitweb/gitweb.perl
> +GITWEB_PROGRAMS += gitweb/gitweb.min.js
>  endif
> +ifdef CSSMIN
> +GITWEB_PROGRAMS += gitweb/gitweb.min.css
> +endif
> +OTHER_PROGRAMS +=  gitweb/gitweb.cgi  $(GITWEB_PROGRAMS)
> +gitweb/gitweb.cgi: gitweb/gitweb.perl $(GITWEB_PROGRAMS)
>  	$(QUIET_SUBDIR0)gitweb $(QUIET_SUBDIR1) $(patsubst gitweb/%,%,$@)

-- 
Jakub Narebski
Poland
