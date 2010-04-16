From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v2] git-send-email.perl: Add sub maildomain_sanitize
Date: Fri, 16 Apr 2010 18:11:11 +0200
Message-ID: <201004161811.14259.jnareb@gmail.com>
References: <1270789906-23735-1-git-send-email-brian@gernhardtsoftware.com> <m38w8og9w4.fsf@localhost.localdomain> <87wrw7qtx8.fsf_-_@jondo.cante.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Fri Apr 16 18:11:27 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2o8c-0001Oi-RH
	for gcvg-git-2@lo.gmane.org; Fri, 16 Apr 2010 18:11:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758103Ab0DPQLV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Apr 2010 12:11:21 -0400
Received: from mail-ew0-f220.google.com ([209.85.219.220]:53817 "EHLO
	mail-ew0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756283Ab0DPQLU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Apr 2010 12:11:20 -0400
Received: by ewy20 with SMTP id 20so940217ewy.1
        for <git@vger.kernel.org>; Fri, 16 Apr 2010 09:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=GfrK3Ul6k/a817GpI9cASdxvWDu1B/hbCCD4VFyfOAU=;
        b=h3HWFX8kdBRZa3YifgL2mdBBnx4sXX4ChK27URei5jVn0KoMebY3P1h3olcp7rNyxn
         YHXG7raGX9h+OwGcSyfA4c6HdUfe40ruTYWu7b/yV3MitQAro8kCroqPN9fa+na7F90E
         getr+G/jmoLRANeEZCdoqcoXdeWhZ/ZmRn05Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=mvVvEtRiIvBRVKlZOdCra/L48538TZzo7PRHxCRWrdEdYxwssSKDTar7qWxWr4a9UK
         IrdpdTEeIZ/QFiGXRaEnSgGXzIf1BTNDTOCPCtAFCFvQ+vh1Ac5n34UdwOHcKDxylNg7
         vpyEukM2xIXAXsBCGdpFYZlRaR+F0BLtVt/ZE=
Received: by 10.103.80.8 with SMTP id h8mr1218037mul.90.1271434278482;
        Fri, 16 Apr 2010 09:11:18 -0700 (PDT)
Received: from [192.168.1.13] (abwa84.neoplus.adsl.tpnet.pl [83.8.224.84])
        by mx.google.com with ESMTPS id j9sm14615933mue.17.2010.04.16.09.11.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 16 Apr 2010 09:11:17 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <87wrw7qtx8.fsf_-_@jondo.cante.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145069>

Jari Aalto wrote:

>     Jakub Narebski <jnareb@gmail.com> writes:
>     >   +sub maildomain_sanitize {
>     >   +	local $domain = shift;
>     >   +
>     >   +	#  On Mac, the the domain name is not necessarily in FQDN format
>     >   +	#  Require a period in the string
>     >   +
>     >   +	if ($^O eq 'darwin'  &&  $domain =~ /\.local$/) {
>     >   +		# Nope, pass this one.
>     >   +	} elsif ($domain =~ /\./) {
>     >   +		return $domain;
>     >   +	}
>     >   +}
> 
>     Thanks for 2nd eye. Changed these in above:
> 
>     * Starting brace placement at function start
>     * Placement of else
>     * Maybe: use or "return" (debatable).
> 
>     But not these. Motivation:
> 
>     * The "$_" simplifies usage everywhere in the function. XP: less is more.
>     * The "and" is more readable than "&&". The "and" is also safer
>       due to its lower precedence.

O.K.


Note however that while setting $_ ($ARG with English) simplifies regexp
matching, you have to take care to use

   local $_ = shift;

and not

   my $_ = shift; 

And to use 'local'.

A bit of "difficulty conservation" at work.

[...]
> +sub maildomain_sanitize {
> +	local $_ = shift;
> +
> +	#  On Mac, the the domain name is not necessarily in FQDN format.
> +	#  Require a period in the string.
> +
> +	if ( $^O eq 'darwin'  and  /\.local$/ ) {
> +		# Nope, pass this one.
> +	} elsif ( /\./ ) {
> +		return $_;
> +	}
> +}

-- 
Jakub Narebski
Poland
