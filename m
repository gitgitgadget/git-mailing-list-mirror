From: Jeff King <peff@peff.net>
Subject: Re: [bug] git-clone over ssh fails when repository has local
	commits
Date: Sun, 6 Apr 2008 13:51:36 -0400
Message-ID: <20080406175136.GB32399@coredump.intra.peff.net>
References: <1caff7430804060645s764f24f8y3d07ee8647ec8f25@mail.gmail.com> <20080406161120.GB24358@coredump.intra.peff.net> <1caff7430804060922seba4978qa13b123103b8282b@mail.gmail.com> <20080406165655.GA26060@coredump.intra.peff.net> <1caff7430804061011ye82e74v289dd3536b253bcb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: seventh guardian <seventhguardian@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 06 19:52:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JiZ2W-0005hx-Fd
	for gcvg-git-2@gmane.org; Sun, 06 Apr 2008 19:52:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751719AbYDFRvk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Apr 2008 13:51:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751814AbYDFRvk
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Apr 2008 13:51:40 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3873 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751623AbYDFRvj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Apr 2008 13:51:39 -0400
Received: (qmail 959 invoked by uid 111); 6 Apr 2008 17:51:37 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sun, 06 Apr 2008 13:51:37 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 06 Apr 2008 13:51:36 -0400
Content-Disposition: inline
In-Reply-To: <1caff7430804061011ye82e74v289dd3536b253bcb@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78903>

On Sun, Apr 06, 2008 at 06:11:12PM +0100, seventh guardian wrote:

> I figured ;) Let me see if I can explain it better:
> 
> remote master: the project git server, located remotely over the internet
> local master: my laptop repository, made by cloning the project master repo
> slave(s): my local machines, which clone the local master, instead of
> the remote master (to save bandwidth)

OK, I understand now. I think that is a reasonable terminology for your
situation, but keep in mind that git doesn't really understand the
concept of a "master". From the perspective of your slaves, there is
only your "local master" as the remote "origin", and they can't tell any
difference between that and the original "remote master".

> So on the local master (my laptop) I did:
> $ git-clone http://remote.master.address/foo/bar.git
> 
> Because I had to do some local changes to the code (what I've called a
> "local commit"), I did this on the local master:
> $ git-commit -a
> 
> Now I want a copy of the repository on another machine, "slave". So I do this:
> $ git-clone ssh://local.master.address/path/to/repo
> 
> Which gives the annoying error.. If I skipped the "local commit"
> stuff, then the cloning would work perfectly.

Hmm. This _should_ just work, but something funny is going on. For some
reason the "local master" is telling us that his HEAD points to
f7a51afd, but we don't actually get that object. But I'm not quite sure
how we get into that situation; my guess is that there is something
confusing going on at the remote master, since the http fetching code is
not as strict and might fail to notice a missing object there. Is it
possible for us to see the remote master so we can take a look?

-Peff
