From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [BUG?] Path limiting in "git log" when run from another subdir
Date: Mon, 24 Sep 2012 20:30:49 +0700
Message-ID: <CACsJy8A4-XC7AS4ZqZ1Whsoo-mztTNFvEnk810e10-rwXBkJHA@mail.gmail.com>
References: <CALKQrged+ptCQYm-=JKRborrAeKmaNFG=rDS8BQK5CNhwqjnkQ@mail.gmail.com>
 <CACsJy8CECnFbkD6QFWiDMxz6J4mOngrmHPwjuXvsFBUXhNc1_w@mail.gmail.com> <CALKQrgfb8qbeKmCzri27iA1qk9H8R4FgyA-YsUQf_JQRWvGK4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git mailing list <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon Sep 24 15:31:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TG8l0-0002gs-Kf
	for gcvg-git-2@plane.gmane.org; Mon, 24 Sep 2012 15:31:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754883Ab2IXNbW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Sep 2012 09:31:22 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:33424 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754569Ab2IXNbV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Sep 2012 09:31:21 -0400
Received: by ieak13 with SMTP id k13so10787925iea.19
        for <git@vger.kernel.org>; Mon, 24 Sep 2012 06:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=FLaDn/YejQctSlKvzJFQfob5Hdi/Lal/vQw2lmGO7PA=;
        b=yzJY5665h+EJ7dXzs0JOjzTgVQKcreIbV3FTpHk670deFoHtWcKqwz1vtWDKOnojze
         F8AEJBakhqoAO12A5Zbq1lTECCblvtTQc0Hpjflo5mAgYR/VVTracJtKoPoga9RyiNNf
         MUO4CymwrGnbfXIVP2gSheWx0Hz+GMeYfWkCld6rEjCpTnWyAGxK0ygxcGvBvsfmnxbS
         o3tavrVq3crgrrM135AfRFl43z5drU+GDo350rYKgs6A9WN7nlaKWVyiuoh9sZNRdNdt
         fhVPBwE7FrEZcUlKNxGf/v9mj0WKEk7Lm/L74holiXxTEDmqjCZhwzHl45akqYTtNPms
         bHyg==
Received: by 10.50.154.225 with SMTP id vr1mr5158783igb.26.1348493480692; Mon,
 24 Sep 2012 06:31:20 -0700 (PDT)
Received: by 10.64.29.199 with HTTP; Mon, 24 Sep 2012 06:30:49 -0700 (PDT)
In-Reply-To: <CALKQrgfb8qbeKmCzri27iA1qk9H8R4FgyA-YsUQf_JQRWvGK4g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206268>

On Mon, Sep 24, 2012 at 8:16 PM, Johan Herland <johan@herland.net> wrote:
> On Mon, Sep 24, 2012 at 2:22 PM, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
>> On Mon, Sep 24, 2012 at 6:59 PM, Johan Herland <johan@herland.net> wrote:
>>> The following works in the git.git repo:
>>>
>>> $ cd t
>>> $ git log -- /Documentation
>>> [...]
>>>
>>
>> What version? Mine (recent master) does not work
>>
>> ~/w/git/t $ ../git log -- /Documentation
>> fatal: '/Documentation' is outside repository
>
> We initially found it on 1.7.9.5, and conrfirmed it on various 1.7.10
> versions. A bisect reveals that this behavior changed in
> v1.7.11.5-35-gf4c21e8 (Michael Haggerty: real_path(): properly handle
> nonexistent top-level paths).

OK checking. I still don't know why it does not happen to me. Any
special in gitdir/worktree setting? That commit is in master.

> Does this mean that "git log -- /Documentation" never should have
> worked in the first place (and was "fixed" by this commit), or that it
> should work (but was broken by this commit)?

I think that should mean Documentation at root. "git log -- `chdir
../Documentation;pwd`" works and that clearly conflicts with
interpreting "/Documentation" as the directory at worktree's root.

> In any case, what is the _preferred_ way to path-limit "git log" to
> Documentation/RelNotes, when my cwd is t/?

If you want worktree root no matter where you stand, use "git log --
:/Documentation/RelNotes". The idea is ":" starts some "magic" in path
handling, but for now there is only ":/". Or if you don't like magic,
`git rev-parse --git-dir` should give you worktree's root to start
with.
-- 
Duy
