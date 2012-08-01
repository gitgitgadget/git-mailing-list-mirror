From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [WIP PATCH] Manual rename correction
Date: Wed, 1 Aug 2012 08:10:12 +0700
Message-ID: <CACsJy8B14qSLkAt9VRQTCkoZx5UtGTpAmMHKyqk+_o14bc9GmQ@mail.gmail.com>
References: <20120731141536.GA26283@do> <7vtxwnki1a.fsf@alter.siamese.dyndns.org>
 <20120731192342.GB30808@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Aug 01 03:10:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SwNSc-0002vq-Ig
	for gcvg-git-2@plane.gmane.org; Wed, 01 Aug 2012 03:10:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752669Ab2HABKp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Jul 2012 21:10:45 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:58982 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751582Ab2HABKo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jul 2012 21:10:44 -0400
Received: by yenl2 with SMTP id l2so6781735yen.19
        for <git@vger.kernel.org>; Tue, 31 Jul 2012 18:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=tBTEuxamfPDUyhPSAzq765w9MC3h+xK0bQoLKKFfHBo=;
        b=zNjU2gHaWm8XUBBRqd18y8T5sayTKcLGwVnzfqHIzFRReAckMu05AKYmbFljxMG0N1
         EhKDOHUetEYvMsginE2ilM374avO11T9q3mysSunpBLGlUCc553fwv6mzW6yqOxpfYFY
         /9jY7KrGF7YAQh0VSmzGgK29S+mycPWN4xiU4kcqYlccUoqXFVUliUUi8ITg6kmAKpeX
         naN5ON8Zm9dEaXY/mhXdiTCSEVgvLuR0X6oDW3XNByCmRkqVmmcg7iliwfMxZqoTNkAb
         IdxJZmdkZdBLDgfCQqLFTNeTcTqyGGwSON1Vo50T4+MtafN3SfRUfxC4Ra/xkNBEISIw
         2NXQ==
Received: by 10.50.212.98 with SMTP id nj2mr2382328igc.35.1343783443746; Tue,
 31 Jul 2012 18:10:43 -0700 (PDT)
Received: by 10.64.90.2 with HTTP; Tue, 31 Jul 2012 18:10:12 -0700 (PDT)
In-Reply-To: <20120731192342.GB30808@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202699>

On Wed, Aug 1, 2012 at 2:23 AM, Jeff King <peff@peff.net> wrote:
>> It is a good direction to go in, I would think, to give users a way
>> to explicitly tell that "in comparison between these two trees, I
>> know path B in the postimage corresponds to path A in the preimage".
>
> I do not think that is the right direction. Let's imagine that I have a
> commit "A" and I annotate it (via notes or whatever) to say "between
> A^^{tree} and A^{tree}, foo.c became bar.c". That will help me when
> doing "git show" or "git log". But it will not help me when I later try
> to merge "A" (or its descendent). In that case, I will compute the diff
> between "A" and the merge-base (or worse, some descendent of "A" and the
> merge-base), and I will miss this hint entirely.
>
> A much better hint is to annotate pairs of sha1s, to say "do not bother
> doing inexact rename correlation on this pair; I promise that they have
> value N".

I haven't had time to think it through yet but I throw my thoughts in
any way. I actually went with your approach first. But it's more
difficult to control the renaming. Assume we want to tell git to
rename SHA-1 "A" to SHA-1 "B". What happens if we have two As in the
source tree and two Bs in the target tree? What happens if two As and
one B, or one A and two Bs? What if a user defines A -> B and A -> C,
and we happen to have two As in source tree and B and C in target
tree?

There's also the problem with transferring this information. With
git-notes I think I can transfer it (though not automatically). How do
we transfer sha1 map (that you mentioned in the commit generation mail
in this thread)?

> Then it will find that pair no matter which trees or commits
> are being diffed, and it will do so relatively inexpensively[1].

But does that happen often in practice? I mean diff-ing two arbitrary
trees and expect rename correction. I disregarded it as "git log" is
my main case, but I'm just a single user..
-- 
Duy
