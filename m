From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: git-fetch in 1.5.4 fails versus 1.5.3.8
Date: Fri, 8 Feb 2008 16:27:21 +0300
Message-ID: <20080208132721.GW30368@dpotapov.dyndns.org>
References: <pan.2008.02.04.18.25.26@progsoc.org> <20080205050741.GA4624@coredump.intra.peff.net> <pan.2008.02.06.21.56.35@progsoc.org> <20080207042332.GA7632@sigill.intra.peff.net> <pan.2008.02.07.10.15.05@progsoc.org> <20080207232337.GR30368@dpotapov.dyndns.org> <pan.2008.02.08.02.43.21@progsoc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Anand Kumria <wildfire@progsoc.org>
X-From: git-owner@vger.kernel.org Fri Feb 08 14:29:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNTHx-0003BS-4c
	for gcvg-git-2@gmane.org; Fri, 08 Feb 2008 14:29:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758185AbYBHN1f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2008 08:27:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753210AbYBHN1f
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Feb 2008 08:27:35 -0500
Received: from el-out-1112.google.com ([209.85.162.179]:40646 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758185AbYBHN11 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2008 08:27:27 -0500
Received: by el-out-1112.google.com with SMTP id v27so1501511ele.23
        for <git@vger.kernel.org>; Fri, 08 Feb 2008 05:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        bh=hWA8m/OPO6hgE5ZuqH9ZHU5wQVG2y9PZLsSpIdWPKFQ=;
        b=Rsnaz/H4S/ZcZa6Fo3K8S/Y/JmIP30xDQCyC9BUNV6L99Ah9K0IRSsB+ZubINkPF44jriTChd9PaEW5+r7XSr7EhN9h/DtZpRYnW7IaAf1yWfI14hfQqGmWbc4VR614z1EJARsKj6wDxG2rSEZz9vjEGb5xiEDQvam/7eTBTZfo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=BK0Y2Rl/NpWL8hODh3C07nBcVAJKSUybmd1lyl3fvo3sCbywXJcngxbF5FOxY7SlDjzk6QYYBvfpuWRgC1jCRTSNLF8ks5ti4ulv1V821bdguth72P7M98oJ7CZMc4pFLcAL6/mjkmei0vY3qT5Rpr9oPofaqW33ldm4qQTZsJ4=
Received: by 10.150.201.13 with SMTP id y13mr5286933ybf.53.1202477244679;
        Fri, 08 Feb 2008 05:27:24 -0800 (PST)
Received: from localhost ( [85.141.191.38])
        by mx.google.com with ESMTPS id w5sm10007456mue.2.2008.02.08.05.27.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 08 Feb 2008 05:27:23 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <pan.2008.02.08.02.43.21@progsoc.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73086>

On Fri, Feb 08, 2008 at 02:43:19AM +0000, Anand Kumria wrote:
> 
> Yes. I've tried the Debian git 1.5.3.8 and git 1.5.4 with whatever they 
> are linked to (libcurl3-gnutls as you point out).
> 
> When I decided to build & bisect to see if I could troubleshoot, I ended 
> up building with libcurl4-gnutls-dev installed first. When compiled 
> against libcurl4-openssl-dev things works. 
> 
> So it definately seems specific to how git uses libcurl and how it, in 
> turn, uses gnutls.

I have investigated this issue a bit more... As I mentioned before I
used Git 1.5.4 with libcurl3-gnutls on Debian Etch and did not have
that problem, but when I installed exactly the same package on Debian
unstable it exhibits the above problem. Debian Etch has curl v7.15.5,
while Debian testing uses curl v7.17.1 and Debian unstable uses curl
7.18.0 (both libcurl3 and libcurl4 are built from the same sources).
So the version of libcurl seems to be relevant here. OTOH, git 1.5.3.8
works with both versions of libcurl-gnutls, while git 1.5.4 does not
work with a new one. So, it is also specific to how git uses libcurl.
I will look into it more during the weekend.

Dmitry
