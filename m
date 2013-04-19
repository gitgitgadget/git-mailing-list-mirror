From: Jeff King <peff@peff.net>
Subject: Re: Git over HTTPS with basic authentication
Date: Fri, 19 Apr 2013 11:36:39 -0400
Message-ID: <20130419153639.GA14263@sigill.intra.peff.net>
References: <1366314422.12299.3.camel@sibbo-laptop>
 <vpq8v4f62dj.fsf@grenoble-inp.fr>
 <20130418204320.GA6888@sigill.intra.peff.net>
 <1366361766.3873.4.camel@sibbo-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org
To: Sebastian Schmidt <isibboi@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 19 17:36:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTDMn-0007on-M1
	for gcvg-git-2@plane.gmane.org; Fri, 19 Apr 2013 17:36:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030787Ab3DSPgo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Apr 2013 11:36:44 -0400
Received: from cloud.peff.net ([50.56.180.127]:44096 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030772Ab3DSPgo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Apr 2013 11:36:44 -0400
Received: (qmail 3095 invoked by uid 102); 19 Apr 2013 15:36:48 -0000
Received: from 99-108-225-125.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.225.125)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 19 Apr 2013 10:36:48 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 19 Apr 2013 11:36:39 -0400
Content-Disposition: inline
In-Reply-To: <1366361766.3873.4.camel@sibbo-laptop>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221764>

On Fri, Apr 19, 2013 at 10:56:06AM +0200, Sebastian Schmidt wrote:

> I tried switching to smart http now, but have the same error, I guess I
> did something wrong. It seems like it is getting 401, but I also noticed
> that info/refs is just an empty file. This is the config of my apache2:
> 
> SetEnv GIT_PROJECT_ROOT /crypt/git
> SetEnv GIT_HTTP_EXPORT_ALL
> ScriptAlias /git/ /usr/lib/git

This should point to /usr/lib/git/git-http-backend, which I think is the
source of your problems.

> <Directory /crypt/git>
> 	Allow from all
> 	Order deny,allow
> 	
> 	AuthType Basic
> 	AuthName "Git global"
> 	AuthUserFile /etc/apache2/auth/passwd
> 	AuthGroupFile /etc/apache2/auth/groups
> 	
> 	Require group git-shared
> </Directory>

I'm not sure this <Directory> match will do what you want, because from
Apache's perspective, it is hitting /usr/lib/git/git-http-backend on the
filesystem, and it is only git that actually touches the filesystem.

I think you want to use

  <Location /git>
     ...
  </Location>

instead. But I am not an Apache expert, so maybe it does work.

-Peff
