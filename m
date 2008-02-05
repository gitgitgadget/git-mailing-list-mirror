From: Jeff King <peff@peff.net>
Subject: Re: git-fetch in 1.5.4 fails versus 1.5.3.8
Date: Tue, 5 Feb 2008 00:07:41 -0500
Message-ID: <20080205050741.GA4624@coredump.intra.peff.net>
References: <pan.2008.02.04.18.25.26@progsoc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Anand Kumria <wildfire@progsoc.org>
X-From: git-owner@vger.kernel.org Tue Feb 05 06:08:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMG2x-0006qH-9C
	for gcvg-git-2@gmane.org; Tue, 05 Feb 2008 06:08:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755190AbYBEFHo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2008 00:07:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755231AbYBEFHo
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Feb 2008 00:07:44 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3665 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754072AbYBEFHn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2008 00:07:43 -0500
Received: (qmail 11770 invoked by uid 111); 5 Feb 2008 05:07:42 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 05 Feb 2008 00:07:42 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 05 Feb 2008 00:07:41 -0500
Content-Disposition: inline
In-Reply-To: <pan.2008.02.04.18.25.26@progsoc.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72625>

On Mon, Feb 04, 2008 at 06:25:25PM +0000, Anand Kumria wrote:

> $ cat .git/config
> {{ ... }}
> [remote "richard"]
>     url = https://server.example.com/~richard/newfoo.git
>     fetch = +refs/heads/*:refs/remotes/richard/*
> 
> $ git fetch richard
> error:  (curl_result = 77, http_code = 0, sha1 = 
> 0bc27e5162d0e74053b71fc637cbbf8fc942e969)

I was unable to reproduce your problem here. However, peeking in curl's
header files, it looks like error 77 is:

    CURLE_SSL_CACERT_BADFILE,  /* 77 - could not load CACERT file, missing
                                  or wrong format */

> Downgrading to git-core in Debian (1.5.3.8) and it works perfectly.

Since you are running Debian, can you confirm whether you have the
'ca-certificates' package installed? It creates the
/etc/ssl/certs/ca-certificates.crt file, which is presumably the source
of the complaining.

That being said, there seems to be some difference between 1.5.3.8 and
1.5.4 that made us care more about SSL certs (though I note that the
SSL_VERIFYPEER curl knob has been set since pre-1.0). Have you tried
setting GIT_SSL_NO_VERIFY?

-Peff
