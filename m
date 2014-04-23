From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 2/3] remote-helpers: move out of contrib
Date: Wed, 23 Apr 2014 15:54:03 -0500
Message-ID: <5358286ba756e_24448772ec82@nysa.notmuch>
References: <1398112633-23604-1-git-send-email-felipe.contreras@gmail.com>
 <1398112633-23604-3-git-send-email-felipe.contreras@gmail.com>
 <38F8C9C6-E186-4C42-B3F0-931AE73400FA@quendi.de>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Max Horn <max@quendi.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 23 23:04:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wd4LL-0005vG-PP
	for gcvg-git-2@plane.gmane.org; Wed, 23 Apr 2014 23:04:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754970AbaDWVEa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2014 17:04:30 -0400
Received: from mail-ob0-f172.google.com ([209.85.214.172]:61721 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753990AbaDWVE3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2014 17:04:29 -0400
Received: by mail-ob0-f172.google.com with SMTP id wo20so1691724obc.3
        for <git@vger.kernel.org>; Wed, 23 Apr 2014 14:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=zAaeEeW0KB2CbvYNAQAz7gCOH907Fh77ihxiU8LeruY=;
        b=Q8PmLY6KDDLbQj2khniXMpb/Yd/yTf5d1+TyLNX+Pgsdv4qVBLCOgPiYQ+sIw0yRzd
         +UyvbtUvWoStPPvO8OSGlPBnW4zfniclVmPXMD2QM0LaAdElbGkxgQCQTo5fXDg4vkBN
         jG157FOgqxD2qJX11j8zCMNftl1cj/ZYXCr4NyluMMr6Fc9oKWVmU2iPFyB5sbRvU//I
         MZzxucpe8N2zrXzItshdFlUekVaAvxuO3yolFGWfKzRO+C9fFFMh/v+98tTSFOgVfsYr
         /d+nkPdCjGPEszEFbqUJOT+neEgka+QEHuDM7+70RFOycewWPspjMeJ11tPwXVwa2f1p
         mbiw==
X-Received: by 10.182.47.196 with SMTP id f4mr14400225obn.50.1398287068712;
        Wed, 23 Apr 2014 14:04:28 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id e8sm8450323oed.7.2014.04.23.14.04.26
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Apr 2014 14:04:27 -0700 (PDT)
In-Reply-To: <38F8C9C6-E186-4C42-B3F0-931AE73400FA@quendi.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246894>

Max Horn wrote:
> On 21.04.2014, at 22:37, Felipe Contreras <felipe.contreras@gmail.com> wrote:
> 
> > The remote-helpers in contrib/remote-helpers have proved to work, be
> > reliable, and stable. It's time to move them out of contrib, and be
> > distributed by default.
> 
> Really? While I agree that git-remote-hg by now works quite well for basic
> usage in simple situation, there are still unresolved bugs and fundamental
> issues with it.

s/basic usage in simple situation/complex usage in the vast majority of situations/

> E.g. I recently showed you a reproducible use case involving git-remote-hg
> that puts the helper into a broken state from which it is difficult for a
> normal user to recover. Namely when a hg branch has multiple heads, then
> git-remote-hg exports all of those to git, but only adds a git ref for one of
> them; after pruning unreferenced commits, the fast-import marks file
> references git commits that now are missing, prompting git fast-import to
> crash and trash the marks file. Afterwards, attempts to push or pull from the
> remote hg repository are answered with an error.

Yes, and how often does that happen? A normal user would only see this if a
branch remains with multiple heads in Mercurial for more than one month or so.

In practice that's very unlikely, and proof of that is that nobody has reported
such issues.

Either way, I just fixed it [1].

> There are more issues related to unresolved clashes between the git and hg
> ways of naming things. E.g. I am collaborating on a hg repository that has
> branches "foo" and "foo/bar" which git-remote-hg cannot handle because it
> translates them to git branch names, and, well, git cannot handle that.

I don't see this as a limitation of git-remote-hg, ideally Git remote-helpers
should have a standardized way to let users map external branch names.

> It may be hard to deal with some of them, and admittedly I wouldn't
> necessarily expect that all of these are handled from the outset, i.e. "in
> version 1.0". But I think at the very least, users should be warned about
> these things.
> 
> More broadly speaking, there is currently no documentation at all in git.git
> for those remote helpers, which I find worrisome.

Here is the documentation:
https://github.com/felipec/git/wiki/git-remote-hg
https://github.com/felipec/git/wiki/git-remote-hg

> That said, I don't know what the criteria are for moving something out of
> contrib. Perhaps it is OK to move an undocumented remote-helper with known
> bugs out of contrib.

There are no known bugs. This is the list of open bugs:

https://github.com/felipec/git/issues

Now if you want to label the limitation of Git that you can't have both 'foo'
and 'foo/bar' as a bug of git-remote-hg, that's up to you, but it's something
nobody had reported before, so it definitely can't be labeled as a "known bug".

[1] https://github.com/felipec/git/commit/fbaae8caa51804a655fd6bc5727763b64e3c2e9f

-- 
Felipe Contreras
