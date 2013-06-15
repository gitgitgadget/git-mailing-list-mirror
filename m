From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 3/3] rebase: use peel_committish() where appropriate
Date: Sat, 15 Jun 2013 19:17:37 +0530
Message-ID: <CALkWK0k5jgafQa6b5=_d2vTT1zzdc4rCgzuoFhOCA1Xtm8v19w@mail.gmail.com>
References: <1371215872-9796-1-git-send-email-artagnon@gmail.com>
 <1371215872-9796-4-git-send-email-artagnon@gmail.com> <7vmwqspr52.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 15 15:48:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Unqq7-0001Ho-Sh
	for gcvg-git-2@plane.gmane.org; Sat, 15 Jun 2013 15:48:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754217Ab3FONsU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Jun 2013 09:48:20 -0400
Received: from mail-ie0-f175.google.com ([209.85.223.175]:50216 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753522Ab3FONsT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Jun 2013 09:48:19 -0400
Received: by mail-ie0-f175.google.com with SMTP id a13so3557374iee.20
        for <git@vger.kernel.org>; Sat, 15 Jun 2013 06:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=RKgLOfL1XM1R6m4+ddXWZuxl7Zv2f1hYx9b5q6O3/gc=;
        b=pb1uVpZJKLiwsXsxrUfL1W3FdoUHvQfyF6I4xfiRwKExGUzqs0nxc2H07+3kL50Eej
         Com80g+R7yviJkITWVI8NxWHhEfs+6zZpmJ47Hd4n5LRL3rw1L0VM0OqAmN0chrHsA1f
         JfaKX6Pv3Ns8u5k7zAyCsMkv/OP1eopLuP+3pWsXIY86VkGTIVT+ER1wEfoLamLL5gTj
         /Sz7x2wWomcSkNcdyukH251zoDvgX6NN/vB1KuEeWsjcmcHhkVsQfXSbvrUuqF0JMbi/
         4E//onDI5vR5QPy1pkNx23gZijrq6mCrQeZwB2OMFxKNpYhYVpvtTm8zCSZ6zWFyMVax
         NUEA==
X-Received: by 10.50.80.9 with SMTP id n9mr1135477igx.42.1371304098948; Sat,
 15 Jun 2013 06:48:18 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Sat, 15 Jun 2013 06:47:37 -0700 (PDT)
In-Reply-To: <7vmwqspr52.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227957>

Junio C Hamano wrote:
> You can also specify the commit at the end of the history to be
> rebased (very useful while trial runs to see where a series should
> apply):
>
>     git rebase foo ":/Add B"
>
> This is already handled properly because it first gets turned into
> an object name $orig_head and then we use it (without ^0) to update
> the ORIG_HEAD.

Correct, but what sense does it make unless <branch> is a ref to update?

  $ git rebase master :/v1.8.1
  First, rewinding head to replay your work on top of it...
  Fast-forwarded :/v1.8.1 to master.

Huh?  The message is wrong, and no end-user can figure out what happened.

> Even after this patch, there is
>
>         git checkout -q "$onto^0"
>
> when detaching the HEAD to that commit.  Can that peeling be dropped
> now (I am not suggesting to drop it in this patch)?

Yeah, that can be dropped.

> What would happen when you are given "--onto :/f...o" is somewhat
> interesting, but that may be a separate topic, I think.  At that
> point, it is probably in the realm of "don't do it then" ;-)

The utility of this very series can be questioned.  I've rarely wanted
to use the :/fommery with rebase, so this mostly an exercise in
"theoretical correctness" (something I usually stay away from).
