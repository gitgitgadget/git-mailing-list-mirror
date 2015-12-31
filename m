From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] worktree: stop supporting moving worktrees manually
Date: Thu, 31 Dec 2015 00:59:48 -0500
Message-ID: <CAPig+cSDNgSmwMcEKfEQVcY=_7VHFrNiOHkR++YwvPtcsp5WZg@mail.gmail.com>
References: <xmqqmvuudfk6.fsf@gitster.mtv.corp.google.com>
	<1451187796-31138-1-git-send-email-pclouds@gmail.com>
	<20151228062206.GA4621@flurp.local>
	<CACsJy8ALc32ptP20_Mm+XDRXR6+b=Lam4saV77Kfrr1-3rHjfw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Mike Rappazzo <rappazzo@gmail.com>,
	kyle@kyleam.com
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 31 07:00:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aEWHs-0005eC-Mu
	for gcvg-git-2@plane.gmane.org; Thu, 31 Dec 2015 07:00:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750974AbbLaGA0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 31 Dec 2015 01:00:26 -0500
Received: from mail-vk0-f44.google.com ([209.85.213.44]:32943 "EHLO
	mail-vk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751747AbbLaF7t convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 Dec 2015 00:59:49 -0500
Received: by mail-vk0-f44.google.com with SMTP id a188so214187709vkc.0
        for <git@vger.kernel.org>; Wed, 30 Dec 2015 21:59:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=FUbU50clfJ8b3zpbse3eFqaen2ebYE8RaQ2289WVvTI=;
        b=Xp77eNeJEuVnk1mVpS3RDea4692obClUTupLpXptRN73dtY1zGaDrl/WuDRNrJPLs2
         +2J3B/lVOecR9C+vw8Xv9MeCitX+w+9Von14EsNZPWkFuD8pBcc+ytLsOJTlGRuD4THk
         sJT/dcUzGwn70aHCosURs8eWtsASSR6I7H1RF2cxj0WC0mZkfZQgLa0Bua6bnejYl7mM
         YBMr/k8+YRhLQE1bbXbG0/UuL04g0lyeZFZT3MMBr1WTuJrRMBQdUO2Uy9ppo1juHaNS
         bIx69C7t+WRemHYvtXfTl0KVorpcnQcfmeJP5Qa99RbzfJIpEyvp/JvhbzBG67neWOZ7
         8BVA==
X-Received: by 10.31.58.142 with SMTP id h136mr45056589vka.115.1451541588518;
 Wed, 30 Dec 2015 21:59:48 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Wed, 30 Dec 2015 21:59:48 -0800 (PST)
In-Reply-To: <CACsJy8ALc32ptP20_Mm+XDRXR6+b=Lam4saV77Kfrr1-3rHjfw@mail.gmail.com>
X-Google-Sender-Auth: mMnBhhMxmpKVKnpPMC0BRwpXtpw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283227>

On Tue, Dec 29, 2015 at 8:55 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Mon, Dec 28, 2015 at 1:22 PM, Eric Sunshine <sunshine@sunshineco.c=
om> wrote:
>> On Sun, Dec 27, 2015 at 10:43:16AM +0700, Nguy=E1=BB=85n Th=C3=A1i N=
g=E1=BB=8Dc Duy wrote:
>>>  If you move a linked working tree to another file system, or
>>> -within a file system that does not support hard links, you need to=
 run
>>> -at least one git command inside the linked working tree
>>> -(e.g. `git status`) in order to update its administrative files in=
 the
>>> -repository so that they do not get automatically pruned.
>>> +within a file system that does not support hard links, you need to=
 update
>>
>> Hmm, is this "hard links" feature implemented? If not, then this
>> documentation is a bit outdated.
>
> The prune logic is there. But this hard link is not created by
> 'worktree add'. I think calling link() was done at some point but the=
n
> it got dropped. Ah found it, it wasn't a big "no" so maybe we can
> revive it at some point.
>
> http://article.gmane.org/gmane.comp.version-control.git/243475

Hmm, yes...

>>> +$GIT_DIR/worktrees/<id>/gitdir so that they do not get automatical=
ly pruned.
>>
>> Following the example of af189b4 (Documentation/git-worktree: split
>> technical info from general description, 2015-07-06), it might be a
>> good idea to keep this high-level overview free of such low-level
>> details and instead mention $GIT_DIR/worktrees/<id>/gitdir in the
>> "DETAILS" section.
>>
>> Perhaps something like this, on top of your patch (assuming that the
>> "hard links" feature is not implemented):
>
> Looks good.
>
> How about something like this at the end of the last new paragraph?
> "alternatively if your file system supports hard link and the worktre=
e
> and $GIT_DIR are on the same file system, you can create a hard link
> named "link" back to the .git file. See gitrepository-layout.txt for
> more information".

That makes sense, however...

If I understand correctly, while it's true that the 'link' file will
inhibit pruning, don't we still have the problem that "git worktree
list" will show an outdated path if the user fails to update 'gitdir'?
And doesn't the "branch already checked out in some other worktree"
interrogation also depend upon 'gitdir' being up-to-date?
