From: Johan Herland <johan@herland.net>
Subject: Re: [1.8.0] Provide proper remote ref namespaces
Date: Mon, 07 Feb 2011 00:22:51 +0100
Message-ID: <201102070022.51403.johan@herland.net>
References: <AANLkTi=yFwOAQMHhvLsB1_xmYOE9HHP2YB4H4TQzwwc8@mail.gmail.com>
 <201102060104.37146.johan@herland.net> <vpqaai8oqkc.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jeff King <peff@peff.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Nicolas Pitre <nico@fluxnic.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 07 00:23:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmDwb-0007xe-Rn
	for gcvg-git-2@lo.gmane.org; Mon, 07 Feb 2011 00:23:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753551Ab1BFXW4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Feb 2011 18:22:56 -0500
Received: from smtp.getmail.no ([84.208.15.66]:52164 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753193Ab1BFXW4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Feb 2011 18:22:56 -0500
Received: from get-mta-scan02.get.basefarm.net ([10.5.16.4])
 by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LG70097KYA6EHB0@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Mon, 07 Feb 2011 00:22:54 +0100 (MET)
Received: from get-mta-scan02.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 2E59D1EA559C_D4F2D4EB	for <git@vger.kernel.org>; Sun,
 06 Feb 2011 23:22:54 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan02.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 366941EA33B7_D4F2D4DF	for <git@vger.kernel.org>; Sun,
 06 Feb 2011 23:22:53 +0000 (GMT)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LG7007KWYA3HA00@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Mon, 07 Feb 2011 00:22:53 +0100 (MET)
User-Agent: KMail/1.13.6 (Linux/2.6.37-ARCH; KDE/4.6.0; x86_64; ; )
In-reply-to: <vpqaai8oqkc.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166213>

(resend without HTML part; I apologize for the inconvenience)

On Sunday 06 February 2011, Matthieu Moy wrote:
> Johan Herland <johan@herland.net> writes:
> > I don't see how the separate namespaces cause problems here. Also, I
> > don't know what you're proposing instead, or indeed what other
> > organization of tags would lead to less confusion.
> 
> I'm not against the idea, but one drawback of the separate namespace
> is that it introduces complexity for the user. In the common case,
> where the user may fetch the same tag from various sources, there
> will still be several refs (probably listed by "git tag" ?), and this
> may confuse the user.

If the user is confused by putting remote tags in separate namespaces, then 
the user is likely also confused by the current practice of putting remote 
_branches_ in separate namespaces. My point is that by strictly delineating 
the boundaries between what is local and what belongs to a given remote, I 
hope we could help some newbies past the local vs. remote confusion that 
often manifests itself when migrating from a centralized VCS to a DVCS.

> Another question is what happens when you push. With branches,
> fetching XXX fetches in origin/XXX, but pushing YYY does push to YYY.
> This asymetry between push and pull works well because most of the
> time, if we have a origin/XXX branch, we also have XXX (with
> origin/XXX as upstream).

I look at it differently: "fetch" is for information discovery (i.e. "I want 
to know what's happened on the remote"), while pull/push is about making 
real changes to local/remote branches.

> For tags, it's clearly different. If I have origin/v1.7.4, I don't see
> much reason to have _also_ v1.7.4 as a local tag. And if I have only
> origin/v1.7.4 and push it as origin/v1.7.4, then someone pulling from
> it will get origin/origin/v1.7.4, and so on.

Wrong. If you have origin/v1.7.4, it's because v1.7.4 already exists in the 
origin remote, so there's no point in trying to push it back. On the other 
hand, if you have v1.7.4 locally (but not origin/v1.7.4), you should 
(assuming this is intended to be a public tag) consider pushing it to the 
"origin" remote, thus causing origin/v1.7.4 to appear in your repo.

> So, my feeling is that the "separate namespace" should not be
> automatic.
> 
> For example, today, git.git repo contains tags like v1.7.4 and others
> like gitgui-0.13.0, which is clearly a handmade namespace, where a
> real namespace would be better. That would make a lot of sence to me
> if Junio had something like
> 
> [remote "git-gui"]
> 	url = ...
> 	fetch = +refs/heads/*:refs/remotes/git-gui/*
> 	fetch = +refs/tags/*:refs/tags/remotes/git-gui/*
> 
> or whatever other syntax, so that git-gui's tags be automatically
> fetched into the right namespace (with no warning in case of
> duplicate).
> 
> But OTOH, I don't want to have several namespaces in my git repo even
> if I configure several remotes to fetch from. In this case, duplicate
> tags are just redundancy if they point to the same object, and a real
> conflict I want to know about immediately otherwise.

As Nicolas mentioned elsewhere in the thread, having separate tag namespaces 
does not prevent us from also warning about ambiguous tag names on fetch. 
With separate namespaces, you could probably implement such a warning more 
easily as a hook, instead of hacking the fetch code directly.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
