From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/3] Reject non-ff pulls by default
Date: Wed, 4 Sep 2013 05:25:27 -0400
Message-ID: <20130904092527.GB22348@sigill.intra.peff.net>
References: <1377988690-23460-1-git-send-email-felipe.contreras@gmail.com>
 <xmqqd2opu8hr.fsf@gitster.dls.corp.google.com>
 <CAMP44s2NzzS48BBpD_oQ24t2SYETte7_U4+O+32SOo5qhooQew@mail.gmail.com>
 <xmqqfvtlpm2l.fsf@gitster.dls.corp.google.com>
 <20130904081047.GB2582@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	git@vger.kernel.org, Andreas Krey <a.krey@gmx.de>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Wed Sep 04 11:25:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VH9LE-0007hz-Mu
	for gcvg-git-2@plane.gmane.org; Wed, 04 Sep 2013 11:25:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934321Ab3IDJZc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Sep 2013 05:25:32 -0400
Received: from cloud.peff.net ([50.56.180.127]:34992 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762204Ab3IDJZb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Sep 2013 05:25:31 -0400
Received: (qmail 401 invoked by uid 102); 4 Sep 2013 09:25:31 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 04 Sep 2013 04:25:31 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 04 Sep 2013 05:25:27 -0400
Content-Disposition: inline
In-Reply-To: <20130904081047.GB2582@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233827>

On Wed, Sep 04, 2013 at 09:10:47AM +0100, John Keeping wrote:

> I think there are two distinct uses for pull, which boil down to:
> 
>     (1) git pull
>     (2) git pull $remote $branch
> 
> For (1) a merge is almost always the wrong thing to do since it will be
> backwards and break --first-parent.

Is it always wrong? You are assuming a topic-branch workflow where
--first-parent is actually meaningful. What about a centralized workflow
where everyone works on "master"? The correct thing to do on a non-ff
push in that case is "git pull && git push". Some people would argue
that the pull should rebase there, but I think there are valid arguments
either way. We can discuss in that direction if you want.

I can perhaps buy the argument that it is better to help people who are
using a topic branch workflow (which we generally want to encourage) to
avoid making backwards merges, and the cost is that people with sloppy
workflows will have to do more work / configuration. But we should be
clear that this is a tradeoff we are making.

The patch in jc/pull-training-wheel talks about annoying old timers, but
I think you may also be annoying clueless new users who simply want an
svn-like workflow without thinking too hard about it.

> > I do not think we know what we want is to affect "git pull origin".
> 
> I consider "git pull $remote" to be an artifact of the way git-pull is
> implemented on top of git-fetch; perhaps I'm missing something but I
> can't see a scenario where this is useful.

Imagine a workflow where each topic is in its own repository instead of
in its own branch inside a repository. Or where each developer has his
or her own repository, but everybody just works on the master branch of
their repository (or perhaps uses branches, but keeps master as a stable
base). Alice is the integration manager; Bob tells her that he has work
ready to integrate.  She runs "git pull ~bob/project", which will merge
Bob's HEAD.

This is not very different from the kernel workflow, where Linus may do
a "git pull $remote" to fetch a sub-system maintainer's work, except
that these days people typically mark the to-be-integrated work in a
"for-linus" branch or tag. However, you can find many "Merge git://"
entries even in recent kernel history.

I think this kind of pull would fall into the same situation as your (2)
above.

-Peff
