From: Daniel Stenberg <daniel@haxx.se>
Subject: Re: error: git-remote-https died of signal 13
Date: Thu, 24 Apr 2014 14:15:33 +0200 (CEST)
Message-ID: <alpine.DEB.2.00.1404241414100.21490@tvnag.unkk.fr>
References: <CAEHyFQLmu4GWHcd+Xd6MOikf_LJgK0dGM7VXk6h6OLsud+-Wgw@mail.gmail.com> <20140423065938.GB20675@sigill.intra.peff.net> <CAEHyFQLPYh2b5CsmadazDJG3paHL7JDY4JhT=xf=wHXhLd=EkQ@mail.gmail.com> <20140424041504.GA17398@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Greg M <morenzg@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 24 14:27:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdIkp-0002Em-F0
	for gcvg-git-2@plane.gmane.org; Thu, 24 Apr 2014 14:27:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753473AbaDXMYR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Apr 2014 08:24:17 -0400
Received: from giant.haxx.se ([80.67.6.50]:59072 "EHLO giant.haxx.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753257AbaDXMYP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Apr 2014 08:24:15 -0400
X-Greylist: delayed 516 seconds by postgrey-1.27 at vger.kernel.org; Thu, 24 Apr 2014 08:24:15 EDT
Received: from giant.haxx.se (localhost.localdomain [127.0.0.1])
	by giant.haxx.se (8.14.4/8.14.4/Debian-4.1) with ESMTP id s3OCFYC1027869
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Apr 2014 14:15:34 +0200
Received: from localhost (dast@localhost)
	by giant.haxx.se (8.14.4/8.14.4/Submit) with ESMTP id s3OCFX1B027536;
	Thu, 24 Apr 2014 14:15:34 +0200
X-Authentication-Warning: giant.haxx.se: dast owned process doing -bs
X-X-Sender: dast@giant.haxx.se
In-Reply-To: <20140424041504.GA17398@sigill.intra.peff.net>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
X-fromdanielhimself: yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246966>

On Thu, 24 Apr 2014, Jeff King wrote:

> Thanks, that's very helpful. I wasn't able to reproduce your problem 
> locally, but I suspect the curl patch below may fix it:

...

> Daniel, I think the similar fix to curl_multi_cleanup in commit a900d45 
> missed this code path, and we need something like the above patch. I know 
> you were trying to keep the SIGPIPE mess at the entrance-points to the 
> library, and this works against that. But we need a SessionHandle to pass to 
> sigpipe_ignore to look at its "no_signal" flag, and of course in the case of 
> multi we may have several such handles. If there's a similar flag we can 
> check on the multi handle, we could just cover all of curl_multi_cleanup 
> with a single ignore/reset pair.

Thanks a lot for this! I've taken this issue over to the libcurl mailing list 
and we'll work out the best way to address it over there... At least we know 
the patch works as intended.

-- 

  / daniel.haxx.se
