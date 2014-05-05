From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: What's cooking in git.git (Apr 2014, #09; Tue, 29)
Date: Mon, 05 May 2014 14:08:28 -0500
Message-ID: <5367e1ac39571_5977e7531081@nysa.notmuch>
References: <xmqq7g67iwxc.fsf@gitster.dls.corp.google.com>
 <20140505184546.GB23935@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 06 19:31:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Whi7I-0006KZ-Ui
	for gcvg-git-2@plane.gmane.org; Tue, 06 May 2014 18:21:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751863AbaEETTM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2014 15:19:12 -0400
Received: from mail-oa0-f49.google.com ([209.85.219.49]:44987 "EHLO
	mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751671AbaEETTM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2014 15:19:12 -0400
Received: by mail-oa0-f49.google.com with SMTP id eb12so309937oac.36
        for <git@vger.kernel.org>; Mon, 05 May 2014 12:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=69v9fAdx66ZbbUlOQrd4JgysQR98ptsx+pYx4P48IT4=;
        b=oWGqp+N+G+eXPpgFrAF6m8M2R7pVhE9HdYUAxf4g498ffSIP481t+COukeO37e0mQj
         hfjL3W8vuw7ws3xDEeiRyfT9WD8jBEPTUGDP5SzmLfrCKuWuJ6Op21ZaO7PtOOSq8Poc
         UNoqoeXnk+Ec8tUxecDkh86d7XHBpAPoMeBBTCNXSJCk6cDFp2bqP1jIW8dWXZ7L0fYl
         sZLMphCfFssqUzERjgoUgKv8xW3e/FW2DI1mCkDzx7S6w3jNAhVCMT7Ge6Toa6tphHWi
         6ELttpS8IHskoVux/53QKxUj8yS0p1YwMf48S8GX2SphMcDwjRTdtbjBBPGVA3Cb4vUb
         o7Aw==
X-Received: by 10.60.176.39 with SMTP id cf7mr35561836oec.45.1399317551598;
        Mon, 05 May 2014 12:19:11 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id pt8sm21218431obb.5.2014.05.05.12.19.09
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 May 2014 12:19:10 -0700 (PDT)
In-Reply-To: <20140505184546.GB23935@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248186>

John Keeping wrote:
> I am not convinced that tools for interoperating with other VCSs need to
> be part of core Git; as Junio has pointed out previously, while contrib/
> was necessary for promoting associated tools when Git was young and had
> not established mindshare, Git is now by far the most popular DVCS and
> is rapidly catching up with centralized systems.  Associated tools can
> therefore live on their own and do not need to be promoted as part of
> Git itself (as git-imerge is doing successfully).

Then let's remove git-p4.

> In the case of git-remote-hg specifically, the remote helper has to use
> an interface that the Mercurial developers consider unstable [1];

There is no other sensible way of doing them.

> the version currently on 'pu' fails the test suite for me because I
> have Mercurial 3.0:
> 
> 	AttributeError: 'mqrepo' object has no attribute 'getbundle'

And because this patch has not been picked up[1].

> I do not want to end up in a situation where an update to Git is blocked
> by a distribution because git-remote-hg is not updated to support newer
> versions of Mercurial sufficiently quickly; this previously happened in
> Gentoo due to git-svn and meant that was stuck on 1.7.8 until 1.7.13 was
> released [2].

Travis-CI ensures that won't happen[2].

> Since the remote helper interface is stable and the remote helpers do
> not use any of the Git internals, I consider the risks of including them
> in core Git to outweigh the benefits of wider distribution.  In fact,
> the remote helpers may benefit from having their own release cadences
> so that they can respond to changes in related projects more quickly
> than the normal Git release cycle.

Maybe, but git-remote-hg has already benefitted a lot from the wider
exposure of being in 'contrib/', I'm sure it would benefit even more if
it's distributed by default.

Moreover, there's a ton of subpar tools out there[3], and I believe
giving the burden of choosing one to the user is detrimental to the Git
project. If we as a project say: this is the one we recommend, and has
the Git stamp, that helps the users tremendously.

Your point is valid though, but it's valid not just for
git-remote-hg/bzr.

So I think these are the two options:

  1) Include git-remote-hg/bzr to the core and distribute them by
     default (as is the current intention)

  2) Remove git-remote-hg/bzr entirely from the Git tree. And do the
     same for other tools: git-p4, git-svn, git-cvs*. Given the huge
     amount of people using Subversion, we might want to defer that one
     for later, but eventually do it.

I'd say for v2.0 we should go for 1), and 2) should be considered for
v3.0, perhaps.

[1] http://article.gmane.org/gmane.comp.version-control.git/248065
[2] https://travis-ci.org/felipec/git
[3] https://github.com/felipec/git/wiki/Comparison-of-git-remote-hg-alternatives

-- 
Felipe Contreras
