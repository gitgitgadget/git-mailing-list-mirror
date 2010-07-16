From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv2 GSOC 06/11] gitweb: Create Gitweb::Escape module
Date: Fri, 16 Jul 2010 11:01:23 +0200
Message-ID: <201007161101.23766.jnareb@gmail.com>
References: <1279178951-23712-1-git-send-email-pavan.sss1991@gmail.com> <1279178951-23712-7-git-send-email-pavan.sss1991@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Petr Baudis <pasky@ucw.cz>
To: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 16 11:01:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZgnc-0006m2-4a
	for gcvg-git-2@lo.gmane.org; Fri, 16 Jul 2010 11:01:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936051Ab0GPJBb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Jul 2010 05:01:31 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:56891 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936026Ab0GPJBa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jul 2010 05:01:30 -0400
Received: by fxm14 with SMTP id 14so903366fxm.19
        for <git@vger.kernel.org>; Fri, 16 Jul 2010 02:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=ADqbWox5anYD3/oabZGYiKPixOMl9BbGyLM79cvWRvI=;
        b=w8E08Z4t56gv+/mwlZmoYDalfTzyTI4plMiBfsJhwRAK0mu2T398SIrHAi9tyVQaIX
         XMTHjnKakcm3qNJX8NxjJTLCv8eMBTdHE9RP0+LU+aNajsK6gE0E5qdd3fQLvOR5KnT0
         suHoKtyC7Xl7m/ZdhCwLb3BF2NvgRU5FPriuI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=p6tkgi710pHzv0TYYihrfKWOHfKQ3CSHBFCIpGG2mrnvzcONhIAZVBFduf7m7hhA4I
         pk80xdBMFO3DjU+YqeZv8TQaM/xhV3g5DIkGLWbRyBuhU4vzXRHmbJv0OqzRzYs5PKT2
         pM/RwRGoAmi/WhHa6ACFH3aeBjMhtpnkVb5b0=
Received: by 10.223.122.198 with SMTP id m6mr377539far.87.1279270888914;
        Fri, 16 Jul 2010 02:01:28 -0700 (PDT)
Received: from [192.168.1.13] (abwm47.neoplus.adsl.tpnet.pl [83.8.236.47])
        by mx.google.com with ESMTPS id h8sm679648faj.38.2010.07.16.02.01.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 16 Jul 2010 02:01:26 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1279178951-23712-7-git-send-email-pavan.sss1991@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151135>

On Thu, 15 Jul 2010, Pavan Kumar Sunkara wrote:

> Create a Gitweb::Escape module in 'gitweb/lib/Gitweb/Escape.pm'
> to store all the quoting/unquoting and escaping subroutines
> regarding the gitweb.perl script.
> 
> This module imports $fallback_encoding variable from
> Gitweb::Config module to use it in sub 'to_utf8'
> 
> Subroutines moved:
> 	to_utf8
> 	esc_param
> 	esc_url
> 	esc_html
> 	esc_path
> 	quot_cec
> 	quot_upr
> 	untabify
> 
> Update gitweb/Makefile to install Gitweb::Escape module alongside gitweb

Nice and straightforward refactoring.

For what it is worth, ACK from me.

[...]
> +# quote unsafe chars, but keep the slash, even when it's not
> +# correct, but quoted slashes look too horrible in bookmarks
> +sub esc_param {
> +	my $str = shift;
> +	return undef unless defined $str;
> +	$str =~ s/([^A-Za-z0-9\-_.~()\/:@ ]+)/CGI::escape($1)/eg;
> +	$str =~ s/ /\+/g;
> +	return $str;
> +}
> +
> +# quote unsafe chars in whole URL, so some charactrs cannot be quoted
> +sub esc_url {
> +	my $str = shift;
> +	return undef unless defined $str;
> +	$str =~ s/([^A-Za-z0-9\-_.~();\/;?:@&= ]+)/CGI::escape($1)/eg;
> +	$str =~ s/ /\+/g;
> +	return $str;
> +}

I see that here (or rather in corresponding preimage) you have dependency
on first patch in series, i.e. "gitweb: fix esc_url".

If you had send first patch as a separate email, not as part of series,
you would have need to mention in cover letter that the series (without
first patch) is based on / requires "gitweb: fix esc_url".

-- 
Jakub Narebski
Poland
