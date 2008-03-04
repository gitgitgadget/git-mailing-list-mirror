From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: FastCGI support in gitweb
Date: Tue, 4 Mar 2008 01:19:21 +0100
Message-ID: <200803040119.22240.jnareb@gmail.com>
References: <1c3be50f0803011334u2629011cg85cb8728a244ea4e@mail.gmail.com> <m38x12jeqt.fsf@localhost.localdomain> <47CBEED2.30808@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Juan Jose Comellas <juanjo@comellas.org>, git@vger.kernel.org
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Tue Mar 04 01:19:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWKsu-0006Ya-RQ
	for gcvg-git-2@gmane.org; Tue, 04 Mar 2008 01:19:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753657AbYCDATP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2008 19:19:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752752AbYCDATP
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Mar 2008 19:19:15 -0500
Received: from fk-out-0910.google.com ([209.85.128.186]:59175 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754030AbYCDATN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2008 19:19:13 -0500
Received: by fk-out-0910.google.com with SMTP id z23so417925fkz.5
        for <git@vger.kernel.org>; Mon, 03 Mar 2008 16:19:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=OZgLNMqydJhlmhVslAG6BLu6bw88HydgN73BCbm0uUc=;
        b=GDRkhgV7m+z4v5syCE4jnli9sqn7i/IJWlkwo88fjbGX1gYWeF8CR/Udzq7AIST72GGndZFsqP7e1IFBGx7f2XCqGxQmBz/aAnoOJygnS+7qCy21noBFb1Y0aclb0+N/fnPFhbpwCOSmttU20dZ3FdidqpCJqgaKfSeFNI0Ryoc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=L6qftgzsH/wVG9+G0/ayacP7yjPmLHEaG94Cl+G8Yi7YQAZ5rZU7r8Ezfo+N1feUnhhxGc5O/vVvRT3MwSi94mw5ih95Q1cbBjDobGCt1JvXSt6bnm4OhC2sCdOVxQn/I6AEdKIQpr3gzFJvVLrllrE4VHYXPNKhPAtTaZAGV7s=
Received: by 10.82.165.13 with SMTP id n13mr2087734bue.16.1204589952072;
        Mon, 03 Mar 2008 16:19:12 -0800 (PST)
Received: from ?192.168.1.15? ( [83.8.251.32])
        by mx.google.com with ESMTPS id f6sm1086188nfh.21.2008.03.03.16.19.09
        (version=SSLv3 cipher=OTHER);
        Mon, 03 Mar 2008 16:19:09 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <47CBEED2.30808@vilain.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76003>

On Mon, 3 Mar 2008, Sam Vilain wrote:
> Jakub Narebski wrote:
>> First, as far as I understand it, the patch made gitweb had to be used
>> with FastCGI server.  It has no comments in code, and if I remember
>> correctly the commit message was also fairly nonexistent.  It mixes
>> FastCGI changes with site-wide changes.  It wrapped the whole file in
>> "until last request" loop instead of wrapping dispatch only.
>> 
>> Also I am not sure if gitweb doesn't rely on variables being correctly
>> set which they are not in FastCGI mode.
>> 
>> But most important part: it was never resend (IIRC it was send when
>> gitweb development was in separate repository)
>> 
>> 
>> I have attached the FastCGI patch and CC-ed the author.
> 
> Thanks.  I didn't submit this because I couldn't fix the bugs in it.
> Glad you found it.  I had to make many changes in a similar vein with a
> current gitweb version; did it work for you in its current form?

I couldn't test it with FastCGI server, as I use Apache2, and all
FastCGI modules for Apache are third part modules. Besides, it doesn't
make much sense to use generic FastCGI for Perl, when there is mod_perl
module.

For me for the FastCGI change to be made into mainline it would have
to have the following properties:
 * it should be able to run as both CGI module, and under mod_perl
   module (in legacy mode with ModPerl::Registry) without trouble
 * is should be able to run even if CGI::Fast or FCGI Perl modules
   are not installed in the system
 * the loop over requests should try to be minimal, and not encompass
   whole file
The last condition would probably require to separate option parsing
and validation into separate subroutine.

> You can get it to run externally using FCGI_SOCKET=:3000 (eg, to listen
> on FastCGI TCP port 3000)

Could you elaborate on this?


P.S. It would be good to have examples for web servers other than
Apache2 how to configure them to run gitweb: perhaps lighthttpd, Cheetah,
maybe IIS...

-- 
Jakub Narebski
Poland
