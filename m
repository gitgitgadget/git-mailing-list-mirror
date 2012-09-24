From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: GIT_DIR vs. --git-dir
Date: Mon, 24 Sep 2012 09:57:40 +0200
Message-ID: <50601274.80506@drmicha.warpmail.net>
References: <5060097F.9050203@drmicha.warpmail.net> <CACsJy8DHGtktnvvziA_+Fp6a4VFsE9_=zkWKNBJU7Ro_QO+==A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 24 09:57:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TG3YA-0006Pf-3L
	for gcvg-git-2@plane.gmane.org; Mon, 24 Sep 2012 09:57:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755311Ab2IXH5o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Sep 2012 03:57:44 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:41383 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755207Ab2IXH5m (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Sep 2012 03:57:42 -0400
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id EA789201F2;
	Mon, 24 Sep 2012 03:57:41 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute2.internal (MEProxy); Mon, 24 Sep 2012 03:57:41 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=7X7Zli+KwIUy/KXaWxp4vV
	6FpOU=; b=g7hbs6+wW4aNxnQUqltbFt6ijZWAnU3sMywiorfb6oDg6i/7IXDeXi
	l4tng3vJ6rfs6/H+/YaBPSkBEP2jfUqlqHLlBRDVOfjjcQKnt27keZZ9LtZ+h8Dt
	CWn0RguOpyXUzYFBGDKf1pVHkvzlieXbbglmEjhuqxuD+VKt8FsPc=
X-Sasl-enc: hPf5BgjZRv4qdVkUXOH8eJ/hv9oHF+Otxii8fRGUoHG/ 1348473461
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 6E3054824E8;
	Mon, 24 Sep 2012 03:57:41 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120827 Thunderbird/15.0
In-Reply-To: <CACsJy8DHGtktnvvziA_+Fp6a4VFsE9_=zkWKNBJU7Ro_QO+==A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206258>

Nguyen Thai Ngoc Duy venit, vidit, dixit 24.09.2012 09:41:
> On Mon, Sep 24, 2012 at 2:19 PM, Michael J Gruber
> <git@drmicha.warpmail.net> wrote:
>> [mjg@localhost ~]$ GIT_DIR=~/.githome git rev-parse --show-toplevel
>> /home/mjg
>>
>> [mjg@localhost ~]$ git --git-dir=~/.githome rev-parse --show-toplevel
>> fatal: Not a git repository: '~/.githome'
>>
>> Huh?
> 
> The message looks pretty clear to me that ~ is not expanded.

...to you and me, of course, but the point is whether we can be more
helpful to most users.

> 
>> Ok, so most users probably would not try further and blame git, but:
>>
>> [mjg@localhost ~]$ git --git-dir=/home/mjg/.githome rev-parse
>> --show-toplevel
>> /home/mjg
>>
>> (All this is with core.worktree set to /home/mjg.)
>>
>> So, while I do understand that we don't expand '~' in any of these cases
>> and it's only a matter of bash tilde expansion kicking in or not, we
>> might want to do something about it. (--git-dir=$HOME/.githome gets
>> expanded, as well, and --git-dir=.githome works from the appropriate cwd
>> only).
> 
> "~" is a shell feature. Know your shell. If we make an exception for
> --git-dir, we might have to support --blahblah=~/somewhere. That's a
> lot of changes and we might mistakenly over-expand something. Users
> running git on cmd.exe may get surprised that "~" is expanded. We
> could print an advice "did you mean $HOME/.githome?". That could still
> be a lot of changes, but it's no-op so less worries of breaking
> something. I prefer doing nothing in this case.

First of all, we expand '~' in other cases (basically all config vars)
ta) where it's unambiguously a path. And --git-dir really is the
sensible version of core.gitdir (which would make no sense, of course).

Then, "we" refuse to make "~2" a shorthand for "HEAD~2" in the revision
parser because "~2" has a meaning for certain shells in certain
situations (depending on your dirstack) and would need to be quoted, so
we certainly take into account how the shell behaves.

It might be difficult to implement, but I'm sorry I can't follow the
argumentation above at all; it's not based on what we do in other places
and other cases.

Michael
