From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] git-send-email.perl - Fix 550 EHLO argument does not match calling host
Date: Sun, 14 Mar 2010 06:17:57 -0700 (PDT)
Message-ID: <m34okjkpq0.fsf@localhost.localdomain>
References: <4B97C157.4020806@gmail.com>
	<20100311081213.GA13575@sigill.intra.peff.net>
	<20100311083148.GA13786@sigill.intra.peff.net>
	<7vaaueziv8.fsf@alter.siamese.dyndns.org> <4B9A74CA.4080507@gmail.com>
	<7vy6hxnnfx.fsf@alter.siamese.dyndns.org>
	<87bpesi0om.fsf_-_@jondo.cante.net>
	<7vfx433l9x.fsf@alter.siamese.dyndns.org>
	<87eijng4hy.fsf@jondo.cante.net>
	<7vtysjs9hi.fsf@alter.siamese.dyndns.org>
	<878w9vdx01.fsf@jondo.cante.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Sun Mar 14 14:18:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nqni2-0003pI-Dc
	for gcvg-git-2@lo.gmane.org; Sun, 14 Mar 2010 14:18:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753963Ab0CNNSB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Mar 2010 09:18:01 -0400
Received: from mail-fx0-f227.google.com ([209.85.220.227]:48890 "EHLO
	mail-fx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751027Ab0CNNSA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Mar 2010 09:18:00 -0400
Received: by fxm27 with SMTP id 27so2925988fxm.28
        for <git@vger.kernel.org>; Sun, 14 Mar 2010 06:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=+cmn7FsBxNKCgdZHFFscg6MBe9XjKSAKUcJyxrGcvus=;
        b=TG9LOLsroQ9IooW+Pkka3BQ+y82uAhT3tSJqOS6oStbYXJF8eHla1Hy2Pm/5LQrlyO
         WKzBTxSPuoPoighveQffOQYj3LwpoeHJfjftOoGEXZ1JOx7YLOWQ0bI6dyAzkX8zd1vi
         1tBKhqSjLUm8hKGazeasQB1jdb9tfvvnyzQPQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=oL0PBs+QxZsKmUhYILFV/N1HIKCN+V4gydwxb3DilgL7JcpXoHce9J3vXHIuvvcfce
         VasCHXUE0Xs+Qey/Kff07HnJgn0dWK+JF5mv4TCBNZESOXlbQtRDHdsOoEOytl2wwWSj
         rLJIgJGG4GHqIrtVHbtJn/dboAU/mJLzar6x4=
Received: by 10.87.68.35 with SMTP id v35mr1060713fgk.25.1268572678438;
        Sun, 14 Mar 2010 06:17:58 -0700 (PDT)
Received: from localhost.localdomain (abwr74.neoplus.adsl.tpnet.pl [83.8.241.74])
        by mx.google.com with ESMTPS id l19sm1397568fgb.18.2010.03.14.06.17.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 14 Mar 2010 06:17:57 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o2EDHILO024309;
	Sun, 14 Mar 2010 14:17:28 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o2EDGulp024291;
	Sun, 14 Mar 2010 14:16:56 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <878w9vdx01.fsf@jondo.cante.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142136>

Jari Aalto <jari.aalto@cante.net> writes:

> +sub maildomain_net
> +{
> +	my $maildomain;
> +	eval "use Net::Domain";
> +
> +	unless ($@) {

I think the Perl idiom for this is

   	if (eval { require Net::Domain; 1 }) {

Note the block form of eval (which is more efficient, and is usual way
of trap exceptions in Perl), using return value of eval instead of
using $@ variable, and using 'require' rather than 'use'.

> +		eval "use Net::Domain";
> +		unless ($@) {

Why this duplication?  You have 'eval unless eval unless', with 
'eval unless' twice.

> +		    my $domain = Net::Domain::domainname();
> +		    $maildomain = $domain
> +			    unless $^O eq 'darwin' && $domain =~ /\.local$/;

I'd like to have a comment about the above line: why it is necessary?

> +		}
> +	}
> +
> +	$maildomain;

It is a matter of style, but unless function is a very simple one, the
preferred way is to use explicit return statement, i.e.

   	return $maildomain;

> +}

-- 
Jakub Narebski
Poland
ShadeHawk on #git
