From: Daniel Stenberg <daniel@haxx.se>
Subject: Re: [PATCH 1/2] http.c: Use curl_multi_fdset to select on curl fds
 instead of just sleeping
Date: Wed, 2 Nov 2011 23:40:49 +0100 (CET)
Message-ID: <alpine.DEB.2.00.1111022336270.7774@tvnag.unkk.fr>
References: <1320265288-12647-1-git-send-email-mika.fischer@zoopnet.de> <1320265288-12647-2-git-send-email-mika.fischer@zoopnet.de> <20111102203221.GB5628@sigill.intra.peff.net> <CAOs=hR+QqUpYuth8Uvi2o7pm1LO8ogO2pN7nrMchYj96Cutmww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org, gitster@pobox.com
To: Mika Fischer <mika.fischer@zoopnet.de>
X-From: git-owner@vger.kernel.org Wed Nov 02 23:41:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RLjUY-0002w3-SO
	for gcvg-git-2@lo.gmane.org; Wed, 02 Nov 2011 23:41:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752419Ab1KBWlB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Nov 2011 18:41:01 -0400
Received: from giant.haxx.se ([80.67.6.50]:33861 "EHLO giant.haxx.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751907Ab1KBWlB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Nov 2011 18:41:01 -0400
Received: from giant.haxx.se (localhost.localdomain [127.0.0.1])
	by giant.haxx.se (8.14.4/8.14.4/Debian-2) with ESMTP id pA2Meoi1002058
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 2 Nov 2011 23:40:50 +0100
Received: from localhost (dast@localhost)
	by giant.haxx.se (8.14.4/8.14.4/Submit) with ESMTP id pA2Men0U002004;
	Wed, 2 Nov 2011 23:40:49 +0100
X-Authentication-Warning: giant.haxx.se: dast owned process doing -bs
X-X-Sender: dast@giant.haxx.se
In-Reply-To: <CAOs=hR+QqUpYuth8Uvi2o7pm1LO8ogO2pN7nrMchYj96Cutmww@mail.gmail.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
X-fromdanielhimself: yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184678>

On Wed, 2 Nov 2011, Mika Fischer wrote:

> The only problem I can see is that curl_multi_fdset is not guaranteed to 
> return any fds. So in theory it could be possible that we don't get fds, but 
> we're actually reading stuff. In this case things would get slow, because we 
> would sleep for 50ms after every read...
>
> However, I don't know if this is a case that actually comes up in the real 
> world. Maybe Daniel has some advice on this.

It doesn't really happen so it should be safe.

The case where no fds are returned is when libcurl cannot return a socket to 
wait for during name resolving (if your particular libcurl is built to use 
such a resolver backend - libcurl has several different ones). And during name 
resolving there won't be any data to read for the libcurl-app anyway.

-- 

  / daniel.haxx.se
