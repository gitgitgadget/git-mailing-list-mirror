From: Johan Herland <johan@herland.net>
Subject: Re: [1.8.0] Provide proper remote ref namespaces
Date: Thu, 03 Feb 2011 09:46:00 +0100
Message-ID: <201102030946.01086.johan@herland.net>
References: <AANLkTi=yFwOAQMHhvLsB1_xmYOE9HHP2YB4H4TQzwwc8@mail.gmail.com>
 <201102020322.00171.johan@herland.net>
 <AANLkTi=tMq18mKqr0cp9rXqtDApKu3P_AZGyX6fA3hsx@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>,
	Jeff King <peff@peff.net>, Nicolas Pitre <nico@fluxnic.net>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 03 09:46:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PkupV-0008GH-Dr
	for gcvg-git-2@lo.gmane.org; Thu, 03 Feb 2011 09:46:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755360Ab1BCIqJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Feb 2011 03:46:09 -0500
Received: from smtp.getmail.no ([84.208.15.66]:63128 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752002Ab1BCIqI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Feb 2011 03:46:08 -0500
Received: from get-mta-scan02.get.basefarm.net ([10.5.16.4])
 by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LG100KMQ9ORCP60@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Thu, 03 Feb 2011 09:46:04 +0100 (MET)
Received: from get-mta-scan02.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id D71291EA5678_D4A6B4BB	for <git@vger.kernel.org>; Thu,
 03 Feb 2011 08:46:03 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan02.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 1EED11EA2A5F_D4A6B4AF	for <git@vger.kernel.org>; Thu,
 03 Feb 2011 08:46:02 +0000 (GMT)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LG100DC39OPB900@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Thu, 03 Feb 2011 09:46:02 +0100 (MET)
User-Agent: KMail/1.13.6 (Linux/2.6.37-ARCH; KDE/4.6.0; x86_64; ; )
In-reply-to: <AANLkTi=tMq18mKqr0cp9rXqtDApKu3P_AZGyX6fA3hsx@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165965>

On Thursday 03 February 2011, Nguyen Thai Ngoc Duy wrote:
> On Wed, Feb 2, 2011 at 9:21 AM, Johan Herland <johan@herland.net> wrote:
> > Migration plan:
> > ...
> > In v1.8.0, we should default to the new default refspecs when creating
> > new remotes. However, existing remotes (created pre-v1.8.0) must
> > continue to work as before, so we cannot simply remove the implicit
> > refspecs (or tag auto-following). Instead we need to make sure that
> > the implicit refspecs is NOT applied to the new-style remotes.
> > Identifying new-style vs. old-style remotes can be done by looking at
> > the refspec itself (old-style: "refs/remotes/$remote/*", new-style:
> > "refs/remotes/$remote/heads/*"), or (worst case) by introducing a
> > config variable specifying the desired behavior (defaulting to
> > old-style).
> 
> How about convert old style remotes to new style? Should it be done
> automatically when new git detects old style remotes, or done by
> command, or manually?

I don't think we want to mess with existing remote refs without the user's 
consent, especially since the user might have all kinds of repo-specific 
practices tied to the old layout of remote refs.

Providing a command to do it (git remote renew?) is a much better way to go 
about it, IMHO. Still, it is vitally important that new git keeps working 
with old-style remotes.

Another issue is whether we should automatically make the old-style implicit 
refspecs into _explicit_ (but still old-style) refspecs. I.e. when 
encountering an old-style remote, new git could automatically add the 
following refspecs to the remote:

	+HEAD:refs/remotes/origin/HEAD
    ~refs/tags/*:refs/tags/*


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
