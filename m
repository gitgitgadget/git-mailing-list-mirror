From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 00/16] Subtree clone proof of concept
Date: Mon, 2 Aug 2010 17:10:03 +1000
Message-ID: <AANLkTinL3i8J046b=1AJQqwcHjBE3snFL7fMcApGyjVD@mail.gmail.com>
References: <1280593105-22015-1-git-send-email-pclouds@gmail.com>
	<AANLkTims5Xq67QXaE54bCTHP-BZSNRVsJnUKM6YJjt2G@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 02 09:10:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OfpAL-0003hr-Uw
	for gcvg-git-2@lo.gmane.org; Mon, 02 Aug 2010 09:10:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752761Ab0HBHKH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Aug 2010 03:10:07 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:57601 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752632Ab0HBHKF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Aug 2010 03:10:05 -0400
Received: by wyb39 with SMTP id 39so2968002wyb.19
        for <git@vger.kernel.org>; Mon, 02 Aug 2010 00:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=OaSAR9En8kvf3i1YWMxuXpB+25RybB72ZbO7usFGvr0=;
        b=fkOn3A8qdTf9bYd34VcpXPcUtPPfkZffTuQpsY5VF3gb8CicppMTqNOcYxv8WFzSI/
         fPIHUTEr2Dmqq0JlGeDmDrmMh0B8rmAUngmLVTnuShOV6M809abA0ObvtZS8+akBUwfH
         C1qpGi2YyOpXr71Uv1wkau9bwZy7Zu0RV7cIw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=op3CIMbpiHlfQqllL0E2n3zxhE+V+KQHQojDgXc8qRTmMriSE5kSGq8FSJapVTSR3A
         xucrMOytEDKELLgT1W2XWRGX2GIc38Z62TD/vFN2tRs7IVhBCrHh2n0Csxauxc1oGNfc
         PohrzqehmDyVj+DE3yO6A7EvS4I7S1i2J5KNE=
Received: by 10.227.155.70 with SMTP id r6mr4581255wbw.26.1280733003917; Mon, 
	02 Aug 2010 00:10:03 -0700 (PDT)
Received: by 10.216.173.199 with HTTP; Mon, 2 Aug 2010 00:10:03 -0700 (PDT)
In-Reply-To: <AANLkTims5Xq67QXaE54bCTHP-BZSNRVsJnUKM6YJjt2G@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152398>

2010/8/2 Elijah Newren <newren@gmail.com>:
>> The idea is the same: pack only enough to access a subtree, rewrite
>> commits at client side, rewrite again when pushing. However I put
>> git-replace into the mix, so at least commit SHA-1 looks as same as =
from
>> upstream. git-subtree is not needed (although it's still an option)
>>
>> With this, I can clone Documentaion/ from git.git, update and push. =
I
>
> I tried it out, but I seem to be doing something wrong. =C2=A0I appli=
ed
> your patches to current master, and tried the following -- am I doing
> something wrong or omitting any important steps?
>
> $ git --version
> git version 1.7.2.1.22.g236df
>
> $ git clone file://$(pwd)/git fullclone
> Cloning into fullclone...
> warning: templates not found /home/newren/share/git-core/templates
> remote: Counting objects: 96220, done.
> remote: Compressing objects: 100% (24925/24925), done.
> remote: Total 96220 (delta 70575), reused 95687 (delta 70236)
> Receiving objects: 100% (96220/96220), 18.45 MiB | 11.43 MiB/s, done.
> Resolving deltas: 100% (70575/70575), done.
> fatal: unable to read tree 49374ea4780c0db6db7c604697194bc9b148f3dc

This one looks like the unintialized case you pointed out in
process_tree(). No I did not try full clone on my patched git :-P

> $ git clone --subtree=3DDocumentation/ file://$(pwd)/git docclone
> Cloning into docclone...
> warning: templates not found /home/newren/share/git-core/templates
> fatal: The remote end hung up unexpectedly
> fatal: early EOF
> fatal: index-pack failed

Not sure. Does file:// use receive-pack/upload-pack? I tested it over
local ssh. Will try again soon.

>> haven't tested it further. Space consumption is 24MB (58MB for full
>> repo). =C2=A0Not really impressive, but if one truely cares about di=
sk
>> space, he/she should also use shallow clone.
>
> 58 MB for full repo? =C2=A0What are you counting? =C2=A0For me, I get=
 25M:
>
> $ git clone git://git.kernel.org/pub/scm/git/git.git
> $ ls -lh git/.git/objects/pack/*.pack
> -r--r--r--. 1 newren newren 25M 2010-08-01 18:05
> git/.git/objects/pack/pack-d41d36a8f0f34d5bc647b3c83c5d6b64fbc059c8.p=
ack
>
> Are you counting the full checkout too or something? =C2=A0If so, tha=
t
> varies very wildly between systems, making it hard to compare numbers=
=2E
> =C2=A0(For me, 'du -hs git/' returns 44 MB.) =C2=A0I'd like to be abl=
e to
> duplicate your numbers and investigate further. =C2=A0It seems to me =
that
> we ought to be able to get that lower.

It's my git.git, probably has more topic branches plus junk stuff. If
you are only interested in numbers, playing with git pack-objects is
enough. You need changes in list-objects.c and builtin/pack-objects.c,
then you can

git pack-objects --stdout --subtree=3Dfoo/ > temp.pack

and examine it with verify-pack.

>> Finally, it's more of a hack just to see how far I can go. It will
>> break things.
>
> I think it's a pretty nifty hack. =C2=A0It's fun to see. =C2=A0:-) =C2=
=A0However, I
> do have a number of reservations about the general strategy: =C2=A0As
> mentioned earlier, I'm not sure I like the on-the-fly commit
> rewriting, as mentioned by Shawn in your previous
> subtree-for-upload-pack patch series. =C2=A0You did take care of the
> "referring to commit-sha1" issue he brought up by using the replace
> mechanism, but I'm still not sure I'm comfortable with it. =C2=A0The
> performance implications also worry me (a lot of the reason for spars=
e
> clones was to improve performance, at least from my view), as does th=
e
> fact that it only works on exactly one subtree (at least your current
> implementation; most of my usecases involve multiple sibling
> subdirectories that I'd like to get), as does the fact that it
> (currently) only handles trees and does not handle files (ruling out
> the translator usecase I'd like to see covered, e.g. cloning just
> po/de.po and its history without all sibling files).

And it's also fun to try. I'd like to try it on larger repos but I
have quite limited network until October.

> Also, I couldn't tell if your implementation downloaded full commit
> information for commits that didn't touch any of the files under the
> relevant subtree. =C2=A0I think it does, but couldn't tell for sure (=
I
> wanted to use a clone and dig into it to find out, but ran into the
> problems I mentioned above). =C2=A0If so, that also worries me a bit =
-- see
> http://article.gmane.org/gmane.comp.version-control.git/152343.

It does. Yes, that's also something to think of.

> Your implementation also suffers from the same limitations as current
> shallow clones. =C2=A0For example, you can't clone or fetch from a su=
btree
> clone. =C2=A0That limits collaboration between people needing to work=
 on
> the same subset of history, and was a limitation I was hoping to see
> fixed, rather than propagated to more features.

I agree. Being able to fetch from an incomplete repo is very nice.
Though I admit I don't know how to do it. I think sparse clone would
suffer the same, wouldn't it?

> I hope I'm not coming across as too critical. =C2=A0I'm really excite=
d to
> see work in this area. =C2=A0Hopefully I can get more time to pursue =
my
> route a bit further; currently I don't have too much more than a
> detailed idea write-up (heavily revised since the previous thread --
> thanks for the feedback, btw). =C2=A0Or maybe you just know how to ad=
dress
> all my concerns and you beat me to the punch. =C2=A0That'd be awesome=
=2E

Look forward to see sparse clone realized. Although I think that would
be painful :-)
--=20
Duy
