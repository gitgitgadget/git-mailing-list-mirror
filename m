From: Janusz Harkot <janusz.harkot@gmail.com>
Subject: Re: SNI (SSL virtual hosts)
Date: Tue, 4 Jun 2013 18:59:52 +0200
Message-ID: <CEC3E2C7A86A477DAC658432461A60BC@gmail.com>
References: <DC851F5EA18E478DACB62178624BF5B7@gmail.com>
 <97F8F367D27D4B3E93439FF8D0F121FA@gmail.com>
 <alpine.DEB.2.00.1306041142200.16303@tvnag.unkk.fr>
 <8B7A2C3A8CC346D6B34D153F591F878F@gmail.com>
 <alpine.DEB.2.00.1306041349290.32021@tvnag.unkk.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Daniel Stenberg <daniel@haxx.se>
X-From: git-owner@vger.kernel.org Tue Jun 04 19:12:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ujumn-0002lg-Ih
	for gcvg-git-2@plane.gmane.org; Tue, 04 Jun 2013 19:12:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757660Ab3FDRMg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 Jun 2013 13:12:36 -0400
Received: from mail-bk0-f54.google.com ([209.85.214.54]:63296 "EHLO
	mail-bk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757485Ab3FDQ75 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Jun 2013 12:59:57 -0400
Received: by mail-bk0-f54.google.com with SMTP id it19so316298bkc.13
        for <git@vger.kernel.org>; Tue, 04 Jun 2013 09:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject:x-mailer
         :mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=rEeAuZvE+rJJ7vdzIpQGWF4Sm9nAy2rGpegwNIWHHyQ=;
        b=G5Fp0bF0pEtVPnMSanWAU/3ygfgUc8gdog1+6aF/f6TYUkNIXbXwAn4h1Jz7OqinPd
         zgX6fQWJlezrspZj2M41fDuvH1ccQkR6T/m6pN5rmGtB8yJWxXUVF8eJ0B1Q5iR3new+
         eqsw9+KB5ANfm0uReULmlo3EgGGTADbtBz1gK2Lp+5yQ1jXPg9NvpdNEn3DcFvX4fXXS
         fWL1BkWLMcC2fguMw4K6hEUD+P6BSS9ovnL6VQ0u1okpZa5ZsLihQCJPh3JioWSZzqC+
         2H5boYLPGHEaRgtm36akJAchrMRoadBjtCeaNg9ctXdNXANHfJfkqTJMtCWUKUtChTbv
         SbRA==
X-Received: by 10.204.185.136 with SMTP id co8mr8361403bkb.23.1370365195827;
        Tue, 04 Jun 2013 09:59:55 -0700 (PDT)
Received: from [10.0.1.200] (77-252-124-82.ip.netia.com.pl. [77.252.124.82])
        by mx.google.com with ESMTPSA id so13sm23769224bkb.15.2013.06.04.09.59.54
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 04 Jun 2013 09:59:54 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1306041349290.32021@tvnag.unkk.fr>
X-Mailer: sparrow 1.6.4 (build 1178)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226379>

> What makes you suggest that's what's happening? Sure, if it would've =
sent no =20
> or the wrong host name it would probably have that effect.

line:

[36] * Re-using existing connection! (#0) with host (nil) =20
> Any chance you can snoop on the network and the SSL handshake to see =
who's to =20
> blame? I can't but to think that is is a very common use case!


I was trying to verify this via command line curl, and GET/POST is work=
ing fine.

There is one thing that make me suspicious - this is that message about=
 SSL session expiration:
[64] * SSL re-using session ID
[65] * SSL connection using RC4-SHA
[66] * old SSL session ID is stale, removing



So, I've spent last few hours playing with different settings/builds et=
c. =20
I was using sources of curl (7.30.0) and git (1.8.2.3)

curl & git bult with default os-x's openssl (0.9.8) - failed
curl & git bult with '--with-darwin-ssl' + default openssl for git - fa=
iled

curl & git both bult with newest openssl (1.0.1e):
error: SSL certificate problem: self signed certificate in certificate =
chain while accessing https://....

so it looks promising, I've set GIT_SSL_CAPATH (because bundle config i=
s not supported in git - this is a good feature request)

and.. t looks like it is working=E2=80=A6
first and second attempt was to correct SNI host!

So, the question is still why it is not working with openssl 0.9.8r - t=
his version supports SNI by default.
This looks like an error in openssl (maybe: Only allow one SGC handshak=
e restart for SSL/TLS.)

Now is the question, shall this be handled by curl or left alone?
(handling older version of openssl, and force new ssl session?)


kind regards,
Janusz


p.s.
I've tested cur built with polarssl - works and gnutls - works too...
