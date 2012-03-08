From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 7/5] transport: optionally honor DNS SRV records
Date: Thu, 8 Mar 2012 15:35:45 -0600
Message-ID: <20120308213545.GB9497@burratino>
References: <20120308124857.GA7666@burratino>
 <20120308132155.GG9426@burratino>
 <CABPQNSYpRGfu7Ew+KstCFsG4YDSx+i-jzHS1Bw0BA4S2hoz4SA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Eric Wong <normalperson@yhbt.net>
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 08 22:36:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5l0B-0007Hd-A6
	for gcvg-git-2@plane.gmane.org; Thu, 08 Mar 2012 22:35:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756438Ab2CHVfy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Mar 2012 16:35:54 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:33514 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755270Ab2CHVfx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2012 16:35:53 -0500
Received: by ghrr11 with SMTP id r11so555899ghr.19
        for <git@vger.kernel.org>; Thu, 08 Mar 2012 13:35:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=tgEx8cKlh1BHfqQ7tS/Rg19otCUHB7ykMYjQ4iarytU=;
        b=p+WVodC8fX6029Fz+yyOBCz93yaQNqV85fSIgl7l3AYB7rG/hnQHuoDeBs7JVhyKWt
         lnKa+eet3uIRL5sKjkWxqtN9dJjD+v+m4VNORwpQpDHCHZOJrq/19ujhn/V0zuh9P7d5
         auklVHPmzMDWK+mLH32/NF1CL0+ERPQy3aT6YEQJzU5x0t/9Qq7/Qw7emut78Sj3NipX
         fXoImhkSMVuEnIY00u9p78ioziV0yLDw2CTUN+783Tw4pkcCQUUF5TINQBvl31yBChvu
         kNaRqlog/dEgMWkYJuuIKdRuLJaKYMT1RSvr1yO1KJK4Fdw5NHWkQ0lHnRkN1dNK1pl+
         ySuQ==
Received: by 10.60.26.163 with SMTP id m3mr3028768oeg.40.1331242553085;
        Thu, 08 Mar 2012 13:35:53 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id n7sm1554192oeh.4.2012.03.08.13.35.51
        (version=SSLv3 cipher=OTHER);
        Thu, 08 Mar 2012 13:35:52 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CABPQNSYpRGfu7Ew+KstCFsG4YDSx+i-jzHS1Bw0BA4S2hoz4SA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192654>

Erik Faye-Lund wrote:

> It's an interesting feature, but I'm a little bit worried if this
> promotes non-portable setups; won't these repos be unreachable (at
> least without manually redirecting or also keeping a copy on the
> advertised URL) on machines where libresolv is unavailable? I'm mainly
> thinking about the "a single domain can use different hosts for
> different services"-benefit you mentioned.

Yes.  I think of redirecting with SRV records without a fallback as a
misconfiguration ("don't do that, then").  Note that it would not only
affect people without drand48 but people with broken DNS servers.

In the case of Alioth, what they do is let inetd listen on
git.debian.org = vasks.debian.org, using netcat to forward connections
to wagner.debian.org.  So clients with and without SRV support end up
finding their bits shuttled to the same place, with the only
difference being a little wasted load on vasks in the no-SRV case.

This means the Alioth admins don't get the benefit of not having to
set up a proxy, but they do get the benefit of clients taking on more
of the work and the service continuing to be available for some
clients if vasks goes down.

Maybe adding an envvar to disable the SRV handling would make it
easier for server admins to check the fallback.  Can we do more?

(By the way, what platforms don't support BIND and a random number
generator?)

Thanks,
Jonathan
