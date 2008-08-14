From: david@lang.hm
Subject: Re: [RFC] Adding a challenge-response authentication method to
 git://
Date: Thu, 14 Aug 2008 10:24:37 -0700 (PDT)
Message-ID: <alpine.DEB.1.10.0808141021210.13400@asgard.lang.hm>
References: <20080813162644.GC12200@cuci.nl> <20080813164038.GE3782@spearce.org> <20080813173757.GE12200@cuci.nl> <20080813180857.GH3782@spearce.org> <20080814001029.GA14939@cuci.nl> <20080814005723.GM3782@spearce.org> <48A3F7AA.8070001@op5.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	"Stephen R. van den Berg" <srb@cuci.nl>, git <git@vger.kernel.org>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Thu Aug 14 19:26:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTgZZ-0005Df-V8
	for gcvg-git-2@gmane.org; Thu, 14 Aug 2008 19:25:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751624AbYHNRYP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Aug 2008 13:24:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751575AbYHNRYP
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Aug 2008 13:24:15 -0400
Received: from mail.lang.hm ([64.81.33.126]:38550 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751443AbYHNRYP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Aug 2008 13:24:15 -0400
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id m7EHNuEg029679;
	Thu, 14 Aug 2008 10:23:56 -0700
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <48A3F7AA.8070001@op5.se>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92376>

On Thu, 14 Aug 2008, Andreas Ericsson wrote:

> I'd do it like this instead:
>
> daemon: auth_user = dlsym(dlopen("auth-module.so", RTLD_NOW), "authenticat");
> client: "git-authenticate action 'repository'"
> daemon: send pkt-line challenge
> client: send pkt-line username
> client: send pkt-line SHA1(username + password + challenge)
> daemon: if (auth_user(repository, action, username, password, struct 
> sockaddr_in *inbound))
>              allow_connection();
>
> This approach has several nifty benefits:
> * The otherwise duplicated code (for different auth schemes) is
> done only once (in the git daemon).
> * If the git daemon has no authentication module loaded, we might
> as well not bother sending any challenge and just pretend we do
> not know about the authentication scheme.
> * Any kind of authentication scheme can be supported without changing
> the core code. If the authentication module does something wrong,
> one can continue to serve read-only requests by simply unloading
> the module.
> * Modules is a great way for newcomers to get started contributing to
> git so it's a nice way of getting more contributors/sub-maintainers.

if you're going to do modules, you should give the module the connection 
until it's done so that different types of authentication can be 
implemented by the module.

David Lang
