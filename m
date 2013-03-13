From: Matt McClure <matthewlmcclure@gmail.com>
Subject: Re: [PATCH] difftool: Make directory diff symlink work tree
Date: Tue, 12 Mar 2013 20:26:21 -0400
Message-ID: <CAJELnLEmrBSiua3xe_Y7MS1SCL8TD28sQH-R6Kfn9Zk+Zm6=kw@mail.gmail.com>
References: <CAJELnLGq_oLBiNHANoaE7iEiA6g4fXX0PtJbqPFi4PQ+5LLvnA@mail.gmail.com>
	<CAJDDKr4mTc8-FX7--pd7j0vUbdk_1+KU0YniKEhRdee6SaS-8Q@mail.gmail.com>
	<CAJELnLEL8y0G3MBGkW+YDKtVxX4n4axJG7p0oPsXsV4_FRyGDg@mail.gmail.com>
	<CAJELnLGOK5m-JLwgfUdmQcS1exZMQdf1QR_g-GB_UhryDw3C9w@mail.gmail.com>
	<20130312190956.GC2317@serenity.lan>
	<20130312192459.GD2317@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: David Aguilar <davvid@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Tim Henigan <tim.henigan@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Wed Mar 13 01:27:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFZXF-0001iR-QC
	for gcvg-git-2@plane.gmane.org; Wed, 13 Mar 2013 01:27:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932784Ab3CMA0a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Mar 2013 20:26:30 -0400
Received: from mail-pb0-f54.google.com ([209.85.160.54]:43550 "EHLO
	mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932708Ab3CMA0W (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Mar 2013 20:26:22 -0400
Received: by mail-pb0-f54.google.com with SMTP id rr4so406390pbb.41
        for <git@vger.kernel.org>; Tue, 12 Mar 2013 17:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=fv1yZZyHOJN5A/mw/Qj14/hRTV+PjmBI3uYbBYku3Fo=;
        b=YUdKBohUjNg4YBfD9A6r/wZ5NR+DL78dMCWXnRyJTJFnHqlhFvLInhSKDMurQz87lK
         oVehiGMAA9XkP+P5MnzXLo08MwgKMv+jiNbTZCp8eSwUQdprMvmm8NsmcSDIHeYFCzhm
         u5kH9SkEdb1jzC4neACEQ2XDgY9pLPwL6PYJXGDIJQbj19TE93YaYBXOixbnoDVVZ4sP
         DrhMg8CAvAdEvVOyxG+srCRDOT3OGIReIbxbIlPHwgKAQHzTp/WFWIrSleoXcCxp3PFS
         dtVDmKcpn4Aw0mUTjUBGEaX+7XWKW9PkTu1iDy3INcABSgytqhL5J89KJxSJGbJcz4Q0
         1yhA==
X-Received: by 10.68.194.8 with SMTP id hs8mr18885094pbc.44.1363134381958;
 Tue, 12 Mar 2013 17:26:21 -0700 (PDT)
Received: by 10.68.49.65 with HTTP; Tue, 12 Mar 2013 17:26:21 -0700 (PDT)
In-Reply-To: <20130312192459.GD2317@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218015>

On Tue, Mar 12, 2013 at 3:24 PM, John Keeping <john@keeping.me.uk> wrote:
> When I tried this I got the expected behaviour even without this patch.
>
> It turns out that an uncommitted, but *staged* change emits the SHA1 of
> the blob rather than the null SHA1.  Do you get the desired behaviour if
> you "git reset" before using difftool?

I tried this:

$ git diff --raw HEAD^
:100644 100644 f35de0f... ead9399... M  diff-lib.c

$ git reset HEAD^
Unstaged changes after reset:
M diff-lib.c

$ git diff --raw
:100644 100644 f35de0f... 0000000... M  diff-lib.c

$ git difftool -d

and the last command did indeed create symlinks into my working tree
rather than file copies.

So... it seems that using git-reset is at least a workaround to get
the symlink behavior I want as a user, though the dance I have to do
is a little more awkward than `git difftool -d HEAD^` would be.

> If so I think you want some new mode of operation for difftool instead
> of this patch which will also affect unrelated commands.

Are you suggesting that difftool do the reset work above given a new
option or by default?

--
Matt McClure
http://www.matthewlmcclure.com
http://www.mapmyfitness.com/profile/matthewlmcclure
