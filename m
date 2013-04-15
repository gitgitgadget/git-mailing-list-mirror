From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [RFC/PATCH] clone: introduce clone.submoduleGitDir to relocate $GITDIR
Date: Mon, 15 Apr 2013 23:30:40 +0530
Message-ID: <CALkWK0n0y6OPJvYjNeEbUx_CC58vHRRLCsmJtws+RKyv3wRTwQ@mail.gmail.com>
References: <1365881007-25731-1-git-send-email-artagnon@gmail.com>
 <7vy5ck4m6b.fsf@alter.siamese.dyndns.org> <CALkWK0mvtRhFc0_4883ATNaYpb+kDwpV9VxeAoqJy5HxNQ6vgg@mail.gmail.com>
 <516C21CF.5080705@xiplink.com> <7vvc7nu1hu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: marcnarc@xiplink.com, Git List <git@vger.kernel.org>,
	Duy Nguyen <pclouds@gmail.com>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 15 20:01:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URniY-000248-Q9
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 20:01:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756048Ab3DOSBW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Apr 2013 14:01:22 -0400
Received: from mail-bk0-f52.google.com ([209.85.214.52]:53528 "EHLO
	mail-bk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754985Ab3DOSBW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Apr 2013 14:01:22 -0400
Received: by mail-bk0-f52.google.com with SMTP id it16so2458410bkc.25
        for <git@vger.kernel.org>; Mon, 15 Apr 2013 11:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=jbSnEiY/k8IMHKFFDIjfuyE5I4cnOzHi6/VubdGP5Gw=;
        b=brrTqG2i8GP8AU04fWQeXWvC3Fm43UlDt6DH9LG4jf0r5Bv274zNmP5zY4uJxzqPHy
         OR6fzDGCz2ksXBvpZGX3qZM+5+x8rHlaKcpBjCdd96umzHcrQKL9bTpHN4gQBwJQdkjT
         0iwjmf8ajyFGVJ8vuvInEdLzOI4yEIHDljjoQxnHwy03Pyhxy9U9M5ym22c0JozGihpU
         y4A6Lo31hUu4XsSdK0ePs4NcebPtWay3kEGJFfaI4i6G6aoVMau+vn3UEZVLXwBFaHWA
         fGIn0EmDj+WQQ/iM1ihVRAY7q/CeTyyMATwzuXPZAFnt4sFZSNjGivr484vySg9ivWnD
         Uz7A==
X-Received: by 10.205.33.81 with SMTP id sn17mr8763281bkb.53.1366048880716;
 Mon, 15 Apr 2013 11:01:20 -0700 (PDT)
Received: by 10.204.37.69 with HTTP; Mon, 15 Apr 2013 11:00:40 -0700 (PDT)
In-Reply-To: <7vvc7nu1hu.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221277>

Junio C Hamano wrote:
> My
> understanding is that this "config" is about making that option
> easier to use when you _know_ any new repository you create with
> "git clone" or "git init" inside your (toplevel super)project's
> working tree will become its submodule, as it is more convenient to
> have their $GIT_DIR inside the .git/modules/$name of the
> superproject.

Right.  But I'm still worried about .git/modules/$name.  Can you
explain why it's a better idea than having a dedicated ~/bare?  In the
case when I have it in ~/bare, I can do many more interesting things:
for instance, if I cloned a repository that is actually another
project's submodule for instance, I don't have to re-clone it when I
clone that superproject.  What's more?  I can remove submodules and
attach a worktree to my ~/bare/repo.git and use it as a separate
repository easily.  I can move submodules between projects.  In
comparison, .git/modules/$name just seems like a mess.

> I do not think the addition Ram is envisioning in the patch will
> prevent you from teaching "add" to do that.  An implemention of such
> an addition indeed would most likely use the same --separate-git-dir
> mechanism anyway.

Well, I'm against the change in principle because add operates on
worktree paths, not URLs.  I don't want to change that arbitrarily.
