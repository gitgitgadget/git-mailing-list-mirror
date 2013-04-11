From: =?UTF-8?B?SmFrdWIgTmFyxJlic2tp?= <jnareb@gmail.com>
Subject: Re: [PATCH 2/2] doc/http-backend: give some lighttpd config examples
Date: Thu, 11 Apr 2013 18:47:49 +0200
Message-ID: <5166E935.2080206@gmail.com>
References: <20130411033022.GA14462@sigill.intra.peff.net> <20130411033613.GB14551@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Magnus Therning <magnus@therning.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 11 18:48:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQKfW-0003yx-9Q
	for gcvg-git-2@plane.gmane.org; Thu, 11 Apr 2013 18:48:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935352Ab3DKQrz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Apr 2013 12:47:55 -0400
Received: from mail-ea0-f178.google.com ([209.85.215.178]:33167 "EHLO
	mail-ea0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934395Ab3DKQry (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Apr 2013 12:47:54 -0400
Received: by mail-ea0-f178.google.com with SMTP id o10so863132eaj.37
        for <git@vger.kernel.org>; Thu, 11 Apr 2013 09:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=mcFQBzbsBZApQRJgal4j+1gYXYwV0ETX69ovj0kcSTk=;
        b=a+AhG9p1SB/GgGmtPtQ7+wa3un/OjVgqqeFsNgzJbUjM1Se7kUnp/hM3gN2u0C+CkD
         K/oOy1VrvANg9FYkKtT/vu0BZ0/suephTAFdLgewilhIs5qzaT0BIOouOGbAva51FQCL
         2qzFhID0wIrkG4Hbj+OywJ/hjqhsh4Zq3UdqmNedfKIH1VRBj2kafkkNkfiIoL+izk9Z
         p5n47ycH7TFwHLonuQKr9mN9c/ssOVbRPfV9NKoBoHs38edHiG/CKJSGWTNl/pucCV5s
         l+nreDHmyMkxQq4ZALjTdqRHGbZ6c1F9PNlR4RO+CDUWka3DL7p0Hj3JHl1PahUCMZ/8
         Ss4g==
X-Received: by 10.15.32.142 with SMTP id a14mr18732910eev.22.1365698872873;
        Thu, 11 Apr 2013 09:47:52 -0700 (PDT)
Received: from [192.168.1.14] (ewi48.neoplus.adsl.tpnet.pl. [83.20.232.48])
        by mx.google.com with ESMTPS id s47sm6543207eeg.8.2013.04.11.09.47.51
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 11 Apr 2013 09:47:52 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <20130411033613.GB14551@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220889>

W dniu 11.04.2013 05:36, Jeff King napisa=C5=82:

> +Note that unlike the similar setup with Apache, we can easily match =
the
> +query string for receive-pack, catching the initial request from the
> +client. This means that the server administrator does not have to wo=
rry
> +about configuring `http.receivepack` for the repositories (the defau=
lt
> +value, which enables it only in the case of authentication, is
> +sufficient).

Perhaps it would be worth including for Apache2 beside basic setup that
requires http.receivepack set to true, also one like for LigHTTPd, i.e.

  RewriteCond %{QUERY_STRING} =3Dservice=3Dgit-receive-pack [OR]
  RewriteCond %{REQUEST_URI} /git-receive-pack$
  RewriteRule (.*) $1 [E=3DAUTHREQUIRED:yes]

  <Location /gitweb/>
      Order Deny,Allow
      Deny from env=3DAUTHREQUIRED

      AuthType Basic
      AuthName "Git Access"
      Require group committers

      Satisfy Any
  <Location>

And perhaps also adding it as test...
--=20
Jakub Nar=C4=99bski
