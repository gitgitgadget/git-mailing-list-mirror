From: =?UTF-8?B?SmFrdWIgTmFyxJlic2tp?= <jnareb@gmail.com>
Subject: Re: git-http-backend: anonymous read, authenticated write
Date: Thu, 11 Apr 2013 18:43:53 +0200
Message-ID: <5166E849.40609@gmail.com>
References: <20130409054553.GA1537@mteis.lan> <20130409171247.GD21972@sigill.intra.peff.net> <5165DA13.8010100@gmail.com> <20130410214722.GA6215@sigill.intra.peff.net> <20130410231919.GA1315@mteis.lan> <20130411015613.GA8455@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Magnus Therning <magnus@therning.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 11 18:44:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQKbV-0005zE-UI
	for gcvg-git-2@plane.gmane.org; Thu, 11 Apr 2013 18:44:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934757Ab3DKQoA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Apr 2013 12:44:00 -0400
Received: from mail-ee0-f42.google.com ([74.125.83.42]:62453 "EHLO
	mail-ee0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764503Ab3DKQn6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Apr 2013 12:43:58 -0400
Received: by mail-ee0-f42.google.com with SMTP id d4so846797eek.15
        for <git@vger.kernel.org>; Thu, 11 Apr 2013 09:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=cbF0iWpKDV4NErqduSEbYxWad3PnFZuN21PnpZUcFPo=;
        b=Sk4/5ZLLEbqwRqSOuhCQYFalCqHU0b4sqHtDNqc3SdrZsuXjWErnKr+wY8SsJYek7Q
         0vZBCU3YCmjRd0AvmXbKfI67sHLsfh6o7kbB1d0kp8wMshaPSFc/0TApXWTTsiecbxwN
         vyTx4plwx8WSxvaw7sLjg5n6w/f3gdhCEnOdkFagLDAF3xMX44Nsy67Kripg8/iiryPl
         +nEuNnlcDRNuB3K7pYdPbiGMX1cYRajs09VAumiuIk+TEIBO+43aiz7NHJNyUxS/SFms
         Jxk18Jur8J+/HFlXxUoaOeXcdkhZG1fr8QYD/YsTQjpj4Wi5BBeGGKZ6KnYn4j5qTPri
         +PPA==
X-Received: by 10.14.39.5 with SMTP id c5mr18641537eeb.27.1365698637409;
        Thu, 11 Apr 2013 09:43:57 -0700 (PDT)
Received: from [192.168.1.14] (ewi48.neoplus.adsl.tpnet.pl. [83.20.232.48])
        by mx.google.com with ESMTPS id b5sm6445213eew.16.2013.04.11.09.43.54
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 11 Apr 2013 09:43:56 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <20130411015613.GA8455@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220887>

W dniu 11.04.2013 03:56, Jeff King napisa=C5=82:

> So _if_ you fixed it by setting http.receivepack (which I think is th=
e
> simplest thing under Apache, since matching the query string there is
> hard), then you would need a version of git with that fix on the
> client side to actually have git prompt for the password correctly.
>=20
> But your fix under lighttpd is much better, as it asks for the
> credentials up front (which means the client does not go to any work
> creating a packfile just to find out that it does not have access).

According to http://paperlined.org/apps/git/SmartHTTP_Ubuntu.html
it is (supposedly) not that hard in Apache (though it requires mod_rewr=
ite):


  RewriteCond %{QUERY_STRING} =3Dservice=3Dgit-receive-pack [OR]
  RewriteCond %{REQUEST_URI} /git-receive-pack$
  RewriteRule (.*) $1 [E=3DAUTHREQUIRED:yes]

  <Location /git/>
      Order Deny,Allow
      Deny from env=3DAUTHREQUIRED

      AuthType Basic
      AuthName "Git Access"
      Require group committers

      Satisfy Any
  <Location>

Not tested.


P.S. By the way, is there some debugger for apache config (mod_rewrite
and deny/allow)?
--=20
Jakub Nar=C4=99bski
