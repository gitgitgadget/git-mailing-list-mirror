From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [WIP PATCH] Manual rename correction
Date: Wed, 1 Aug 2012 11:36:00 +0700
Message-ID: <CACsJy8AYzYTJ+k72ZEuWW-RdKe7arYbbscVALNYakKSfYqD_zw@mail.gmail.com>
References: <20120731141536.GA26283@do> <7vtxwnki1a.fsf@alter.siamese.dyndns.org>
 <20120731192342.GB30808@sigill.intra.peff.net> <CACsJy8B14qSLkAt9VRQTCkoZx5UtGTpAmMHKyqk+_o14bc9GmQ@mail.gmail.com>
 <20120801020124.GA18071@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Aug 01 06:36:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SwQfp-0001ut-Ou
	for gcvg-git-2@plane.gmane.org; Wed, 01 Aug 2012 06:36:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751179Ab2HAEgc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Aug 2012 00:36:32 -0400
Received: from mail-gh0-f174.google.com ([209.85.160.174]:53992 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751015Ab2HAEgc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Aug 2012 00:36:32 -0400
Received: by ghrr11 with SMTP id r11so434686ghr.19
        for <git@vger.kernel.org>; Tue, 31 Jul 2012 21:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=p02528M9TIgb2UtVE5NH68uxwikijKMeJKx3AGV7Afg=;
        b=ol4+P9KJVFCALCEe6pnSLEcbSCHO5bMmYq4TAp3GJN0cBSy70q3/6lnzuJTn7R+YT8
         oNr3UlxAxurygxO4ADebAk41tvEbLQvctgJE3935nbCByVPk0svJgnZOocv9+uaSut/d
         VEugtGrLldkmtmZPqLMt/NQyOYVn2lw9yh/M9rDpxogwTHqy9wEOlpvF8x9+Ng9+js6B
         QskCQ23oS91wquRi8XzbDEmfblnc8i70bH8cwDX71wwoNraHxWnmZuzpL9sSi+G4dF/f
         j6Vdm+gxdYLA2NOpt0TvD2FaOkJsXkV/UQGQ3BMr57MDpUcQ6GgmPPuWNzOrpq0F7wne
         +R6w==
Received: by 10.50.6.197 with SMTP id d5mr3991427iga.44.1343795791024; Tue, 31
 Jul 2012 21:36:31 -0700 (PDT)
Received: by 10.64.90.2 with HTTP; Tue, 31 Jul 2012 21:36:00 -0700 (PDT)
In-Reply-To: <20120801020124.GA18071@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202702>

On Wed, Aug 1, 2012 at 9:01 AM, Jeff King <peff@peff.net> wrote:
> On Wed, Aug 01, 2012 at 08:10:12AM +0700, Nguyen Thai Ngoc Duy wrote:
>
>> > I do not think that is the right direction. Let's imagine that I have a
>> > commit "A" and I annotate it (via notes or whatever) to say "between
>> > A^^{tree} and A^{tree}, foo.c became bar.c". That will help me when
>> > doing "git show" or "git log". But it will not help me when I later try
>> > to merge "A" (or its descendent). In that case, I will compute the diff
>> > between "A" and the merge-base (or worse, some descendent of "A" and the
>> > merge-base), and I will miss this hint entirely.
>> >
>> > A much better hint is to annotate pairs of sha1s, to say "do not bother
>> > doing inexact rename correlation on this pair; I promise that they have
>> > value N".
>>
>> I haven't had time to think it through yet but I throw my thoughts in
>> any way. I actually went with your approach first. But it's more
>> difficult to control the renaming. Assume we want to tell git to
>> rename SHA-1 "A" to SHA-1 "B". What happens if we have two As in the
>> source tree and two Bs in the target tree? What happens if two As and
>> one B, or one A and two Bs? What if a user defines A -> B and A -> C,
>> and we happen to have two As in source tree and B and C in target
>> tree?
>
> Yes, it disregards path totally. But if you had the exact same movement
> of content from one path to another in one instance, and it is
> considered a rename, wouldn't it also be a rename in a second instance?

Yes. This is probably cosmetics only, but without path information, we
leave it to chance to decide which A to pair with B and C (in the
A->B, A->C case above). Wrong path might lead to funny effects (i'm
thinking of git log --follow).

>> There's also the problem with transferring this information. With
>> git-notes I think I can transfer it (though not automatically). How do
>> we transfer sha1 map (that you mentioned in the commit generation mail
>> in this thread)?

I wasn't clear. This is about transferring info across repositories.

> That is orthogonal to the issue of what is being stored. I chose my
> mmap'd disk implementation because it is very fast, which makes it nice
> for a performance cache. But you could store the same thing in git-notes
> (indexed by dst sha1, I guess, and then pointing to a blob of (src,
> score) pairs.
>
> If you want to include path-based hints in a commit, I'd say that using
> some micro-format in the commit message would be the simplest thing.

Rename correction is after the commit is created. I don't think we can
recreate commits.

> But
> that has been discussed before; ultimately the problem is that it only
> covers _one_ diff that we do with that commit (it is probably the most
> common, of course, but it doesn't cover them all).

How about we generate sha1 mapping from commit hints? We try to take
advantage of path hints when we can. Else we fall back to sha-1
mapping. This way we can transfer commit hints as git-notes to another
repo, then regenerate sha-1 mapping there. No need to transfer sha1
maps.

>> > Then it will find that pair no matter which trees or commits
>> > are being diffed, and it will do so relatively inexpensively[1].
>>
>> But does that happen often in practice? I mean diff-ing two arbitrary
>> trees and expect rename correction. I disregarded it as "git log" is
>> my main case, but I'm just a single user..
>
> It happens every time merge-recursive does rename detection, which
> includes "git merge" but also things like "cherry-pick".

Thanks. I'll look into merge/cherry-pick.
-- 
Duy
