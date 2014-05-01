From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: git send-email doesn't work with IPv6 and STARTTLS
Date: Thu, 1 May 2014 13:55:09 -0700
Message-ID: <20140501205509.GC9218@google.com>
References: <53615259.90200@mirix.org>
 <20140501180546.GA9218@google.com>
 <20140501204814.GA31294@genua.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthias-Christian Ott <ott@mirix.org>, git@vger.kernel.org
To: Steffen Ullrich <Steffen_Ullrich@genua.de>
X-From: git-owner@vger.kernel.org Thu May 01 22:55:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wfy0m-0004Vh-DI
	for gcvg-git-2@plane.gmane.org; Thu, 01 May 2014 22:55:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751834AbaEAUzO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2014 16:55:14 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:37926 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751481AbaEAUzN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 May 2014 16:55:13 -0400
Received: by mail-pd0-f179.google.com with SMTP id g10so1408743pdj.10
        for <git@vger.kernel.org>; Thu, 01 May 2014 13:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=2snFLSQgPWDoRbbjo9GVfqQih28p70zIpch4QeglcUk=;
        b=zGPOiMFmcZJCUtl7JChF2OFTJ+ugsvR7sF/2Wy7VSRUp7sw9VmTXSlaKlVs71AjEgg
         NgD/jj7/oouUqRoGhQBaM6dwpU9p+rcFu10dVrDPZnevAlR5OhNO3DxLUFuvdEC8m+ca
         c9cuJ1qZoIjCCzQipyFSA1kuBPrOAcAJ/7nPy0rlwWlGumq1Y5FjjxExDRtCDi6A0UJQ
         JHG2gzVQ7BDiqgIgiITwzXUiq7Hk8u0pOcoJeC+t2ZfzHozgYvw354rxGooRoTZW41zS
         2i7ulv9/NVnCXF0759gTQtN2kyTUssxnsbWS7UGmyva7TfSBrEREaFaWPqpxgGpX9oc4
         vNgw==
X-Received: by 10.66.228.37 with SMTP id sf5mr25772208pac.19.1398977712224;
        Thu, 01 May 2014 13:55:12 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id yj6sm165234145pab.19.2014.05.01.13.55.11
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 01 May 2014 13:55:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140501204814.GA31294@genua.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247881>

Hi,

Steffen Ullrich wrote:

> git-send-mail does not use Net::SMTP directly for SSL support, but:
> - for direct connections (port 465) it uses Net::SMTP::SSL which just
>   replaces the superclass if Net::SMTP with IO::Socket::SSL and thus
>   implicitly supports IPv6 (because IO::Socket::SSL does)
> - for plain connections with SSL upgrade git-send-mail uses Net::SMTP for
>   the initial connect and then does Net::SMTP::SSL->start_SSL (e.g.
>   inherited from IO::Socket::SSL) to upgrade the socket to SSL.
>
> The problem here is that Net::SMTP does not support IPv6, but this
> should be solvable by using Net::INETGlue::INET_is_INET6 before loading
> Net::SMTP.

Sounds like a good change, fwiw.  Even after Net::SMTP is fixed, it
would be useful as a way to make sure git works well with old versions
of Net::SMTP too.

> But all these tricks are just workarounds for missing IPv6 and SSL support
> directly in the Net::SMTP, Net::FTP and Net::POP3.
> I therefore repeat my proposal from RT#93823 (no response yet) to add
> transparent support for IPv6 and SSL into these modules. By transparent I
> mean that the features are available if the necessary modules are installed
> (e.g. IO::Socket::SSL for SSL and IO::Socket::INET6 or IO::Socket::IP for
> IPv6), but that it works like before if they are not installed.
>
> I don't have these patches yet, but most of the necessary code is already
> there in Net::SSLGlue and Net::INET6Glue.
> Would you accept and incorporate such patches?

Thanks for a kind offer.  I am not Net::SMTP upstream, but I'd be
happy to work with upstream to get such patches applied.

Thanks for your work,
Jonathan
