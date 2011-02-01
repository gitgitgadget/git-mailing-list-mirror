From: Johan Herland <johan@herland.net>
Subject: Re: [1.8.0] Remote tag namespace
Date: Wed, 02 Feb 2011 00:15:27 +0100
Message-ID: <201102020015.27270.johan@herland.net>
References: <AANLkTi=yFwOAQMHhvLsB1_xmYOE9HHP2YB4H4TQzwwc8@mail.gmail.com>
 <20110201181428.GA6579@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Nicolas Pitre <nico@fluxnic.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 02 00:15:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PkPRl-0002ld-Ox
	for gcvg-git-2@lo.gmane.org; Wed, 02 Feb 2011 00:15:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751450Ab1BAXPg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Feb 2011 18:15:36 -0500
Received: from smtp.getmail.no ([84.208.15.66]:35567 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751183Ab1BAXPg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Feb 2011 18:15:36 -0500
Received: from get-mta-scan02.get.basefarm.net ([10.5.16.4])
 by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LFY00J3XOLYYUB0@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Wed, 02 Feb 2011 00:15:34 +0100 (MET)
Received: from get-mta-scan02.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 362951EA55FA_D489416B	for <git@vger.kernel.org>; Tue,
 01 Feb 2011 23:15:34 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan02.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 192511EA387A_D489416F	for <git@vger.kernel.org>; Tue,
 01 Feb 2011 23:15:34 +0000 (GMT)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LFY003H8OLTES30@get-mta-in03.get.basefarm.net> for
 git@vger.kernel.org; Wed, 02 Feb 2011 00:15:34 +0100 (MET)
User-Agent: KMail/1.13.6 (Linux/2.6.37-ARCH; KDE/4.6.0; x86_64; ; )
In-reply-to: <20110201181428.GA6579@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165877>

On Tuesday 01 February 2011, Jeff King wrote:
> On Tue, Feb 01, 2011 at 05:44:50PM +0700, Nguyen Thai Ngoc Duy wrote:
> > OK I'm not familiar with tag code, but I can try.
> > 
> > Proposal:
> > 
> > Reserve refs/remote-tags namespace to store tags from remotes. Its
> > structure is the same as in refs/remotes. When pulling tags, put them
> > in refs/remote-tags/<remote> instead of refs/tags.
> > Tag dereference code will be taught about refs/remote-tags with
> > similar deref order as in remote branches.
> 
> There are similar questions around remote notes refs. Should there also
> be a refs/remote-notes? And there was some discussion recently about
> fetching remote replace refs.
> 
> Should we perhaps be massaging refs/remotes into a structure to handle
> all of these things? Like:
> 
>   refs/remotes/origin/HEAD (-> refs/remotes/origin/heads/master)
>   refs/remotes/origin/heads/master
>   refs/remotes/origin/tags/v1.7.4
>   refs/remotes/origin/notes/commit
>   refs/remotes/origin/replace/f67e92af477a2255b64a1ece33d9d126e763fe9b
> 
> i.e., make refs/remotes/* an actual mirror of selected parts of the
> remote's refs/ hierarchy. And then figure out sane rules for merging
> those namespaces into the ref lookup procedure. For heads and tags,
> probably some tweaking of the lookup rules in dwim_ref; for
> replacements, probably you would want to manually say "I am interested
> in this replace" and copy or symref-link it into your refs/ hierarchy.

I fully agree.

In addition - as discussed in http://thread.gmane.org/gmane.comp.version-
control.git/160503/focus=160795 - we should also tweak the refspec format to 
make tag auto-following explicit in the refspec.

> And probably something similar with notes.

(going slightly offtopic with the notes discussion here)

I've been thinking that notes should be organized much in the same fashion 
as branches/heads. There should be remote notes refs that should only be 
updated from the remote, and there should be local notes refs in 
refs/notes/*. You should be able to configure upstream relationships between 
local notes refs and remote notes refs (e.g. notes.foo.remote and 
notes.foo.merge), and auto-merge them on "git notes pull".


Have fun! :)

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
