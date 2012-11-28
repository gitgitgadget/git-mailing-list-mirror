From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] fsck: warn about '.' and '..' in trees
Date: Wed, 28 Nov 2012 11:22:20 +0700
Message-ID: <CACsJy8DQCo9UzDadHJ2dF-eK20tFDTVn_ScwV+T7z-qLDJMytw@mail.gmail.com>
References: <20121128022736.GA3739@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 28 05:23:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdZAy-0008AQ-4P
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 05:23:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751836Ab2K1EWw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2012 23:22:52 -0500
Received: from mail-ea0-f174.google.com ([209.85.215.174]:38578 "EHLO
	mail-ea0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751326Ab2K1EWv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2012 23:22:51 -0500
Received: by mail-ea0-f174.google.com with SMTP id e13so5109332eaa.19
        for <git@vger.kernel.org>; Tue, 27 Nov 2012 20:22:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=tE/wkfhOgYtFYXMFcpciqExUHwdnOcrT60jgTnb2Neg=;
        b=knB/OQrsJ/qL2DOoGZiOb3PztIqwKUT3bKYNv4B/Xxpl1RrY+3Naod75/qNPvx/jUY
         0U/DL+VM5Hnx+hw50t5H63heGhY16e4S6O2u+QT4EhUOVB7S8/PoX3tRqUrfxvI7OWCa
         kFyZYbcWLQV7IExi8tg6noNJHrE7Aw0Ha5aD4mxG6G5aZo7J4RGIOJ4hf3xXbjPaLU22
         4Rr7E5+Avqb9fs3e7uAHkbHh+wq8R5j3/d1KJaYxQdcwer6HyVcqU+xE5LuGzB5NqFty
         pMVVRIeduSQJNE0rfHWiMoA1rErZyLOqEb8sHPRLi4wjnlqzPE6mPYGXIXQwqk1qhmjQ
         Di8w==
Received: by 10.14.194.4 with SMTP id l4mr16755267een.42.1354076570647; Tue,
 27 Nov 2012 20:22:50 -0800 (PST)
Received: by 10.14.199.194 with HTTP; Tue, 27 Nov 2012 20:22:20 -0800 (PST)
In-Reply-To: <20121128022736.GA3739@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210697>

On Wed, Nov 28, 2012 at 9:27 AM, Jeff King <peff@peff.net> wrote:
> A tree with meta-paths like '.' or '..' does not work well
> with git; the index will refuse to load it or check it out
> to the filesystem (and even if we did not have that safety,
> it would look like we were overwriting an untracked
> directory). For the same reason, it is difficult to create
> such a tree with regular git.
>
> Let's warn about these dubious entries during fsck, just in
> case somebody has created a bogus tree (and this also lets
> us prevent them from propagating when transfer.fsckObjects
> is set).
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> I don't think this is happening in the wild, but I did see somebody
> playing around with libgit2 make such a tree (and it is easy to do with
> git-mktree, of course).
>
> Technically one could use git with such a tree as long as you never ever
> checked out the result, but I think it is sufficiently crazy that we
> should probably detect it, just in case.

Can we declare "." and ".." illegal? There's no room for extension in
tree objects and I'm thinking of using maybe "." entry as an extension
indicator. Not sure if it works, old gits may attempt to checkout "."
entries and fail...
-- 
Duy
