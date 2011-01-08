From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Resumable clone/Gittorrent (again)
Date: Sat, 8 Jan 2011 09:40:43 +0700
Message-ID: <AANLkTinbCkTvkZ3GVJJH7cV-a+YRSM=XzfsXcVBCTifd@mail.gmail.com>
References: <AANLkTinUV9Z_w85Gz13J+bm8xqnxJ9jBJXJm9bn5Y2ec@mail.gmail.com>
 <loom.20110105T222915-261@post.gmane.org> <AANLkTi=_R53fm5Er0CdtZCFvDpE-Dqt8tMHAubcjOUBb@mail.gmail.com>
 <4D25385B.3010103@seznam.cz> <AANLkTikXcrZqhCw+2u2HObUZz5QCStY6BCHTTYYfngMN@mail.gmail.com>
 <4D27B828.8020108@seznam.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Maaartin-1 <grajcar1@seznam.cz>
X-From: git-owner@vger.kernel.org Sat Jan 08 03:41:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PbOk4-0006pk-Nt
	for gcvg-git-2@lo.gmane.org; Sat, 08 Jan 2011 03:41:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752340Ab1AHClQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jan 2011 21:41:16 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:61187 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752149Ab1AHClP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jan 2011 21:41:15 -0500
Received: by wyb28 with SMTP id 28so17982970wyb.19
        for <git@vger.kernel.org>; Fri, 07 Jan 2011 18:41:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=DL4cCN3tm2ojS8Uo2ylW61iVZtESHG6YSKxG1Ab6ps8=;
        b=MJQ2LWKS8I/M2WLhNJiMR806A73mzdKGU58TXx3U6o4tRQwkOywtxwIokJ31g2Uo5G
         7rPVNYbTLfslDcaK6uvgzAEYy+vZhH+t6DCMufUzD4YcH9PztkNTrIEPU+8hNpV573eQ
         HnRd0xLiVLGK+Ts/l+AdtVe5QZ8TA9gKEyyU0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=cJensTe9eyAqTGXtYdjiEpKlKGC3NrnkUGdoC8Gt7ScZQTMzTBuXwmBzfxeV0q1XoZ
         CkV7CAFvHY5PwgzG1/BRJQ1tKpYoMgApY/8SagXtpvzH9Lrkx7pbjT/dcJkAxu/TDnmV
         YU+fJWAwL0M9gg8Xc8+TJ/+gmYhn+jZIZpdNE=
Received: by 10.216.52.206 with SMTP id e56mr25508836wec.19.1294454473854;
 Fri, 07 Jan 2011 18:41:13 -0800 (PST)
Received: by 10.216.63.14 with HTTP; Fri, 7 Jan 2011 18:40:43 -0800 (PST)
In-Reply-To: <4D27B828.8020108@seznam.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164803>

On Sat, Jan 8, 2011 at 8:04 AM, Maaartin-1 <grajcar1@seznam.cz> wrote:
>> Listing all those commits in linux-2.6.git takes 160k*20=3M (I suppose
>> compressing is useless because SHA-1 is random). A compressed listing
>> of those 46k paths takes 200k.
>
> Sure, Linux has only 4 times as much commits as paths, but the commits
> need 30 times more storage. What does it tell us?
>
> IMHO it speaks in favor of my proposal. Imagine a path changing with
> nearly every commit. The root directory is such a path and near top
> directories come close to (as may other files like todo-lists do). For
> each such file you need 3MB for storing the commits SHAs only. Of
> course, you can invent a schema making storing all the SHAs unnecessary,
> but this is another complication.
>
> OTOH, with the commits used as directory entries we get quite a large
> directory. Is this a problem you wanted me to get aware of?

I merely point out that if we use commit sha-1 as "pieces". Then when
a new peer comes in and ask a running peer "what pieces have you got
(so that I can start fetching from you)?", you will need more
bandwidth for that kind of information.

>> The point is you need to fetch its parent commits first in order to
>> verify a commit. Fetching a whole commit is more expensive than a
>> file. So while you can fetch a few commit bases and request for packs
>> from those bases in parallel, the cost of initial commit bases will be
>> high.
>
> You've lost me. I assume you mean that something like that there may be
> very large commits (e.g., in a project not versioned from the very
> beginning). I'd suggest to split such commits in two parts by
> classifying the blobs (and trees) using a fixed bit of their SHAs. Of
> course, this can be repeated in order to get even smaller parts. Let's
> assume a commit X gets split into X0 and X1. As before, for compressing
> of X0 you may use the content any predecessor of X. For compressing of
> X0 you may additionally use the content of X0. This way the compression
> rate could stay close to optimal, IMHO.

Well if you are going to split a commit, then splitting by paths
sounds more natural to me (assume that people don't often move files).

>> They are interchangeable as a whole, yes. But you cannot fetch half
>> the pack from server A and the other half from server B. You can try
>> to recover as many deltas as possible in a broken pack, but how do you
>> request a server to send the rest of the pack to you?
>
> Indeed, it's not resumable. For most commits it's not needed since they
> are very small. Why? There are more commits than paths, so the commits
> are smaller than paths on the average. I expect my schema to allow for
> nearly as good compression as git usually does, especially I'd hope it's
> no worse than when packing paths.

A commit diff consists of all tree and blobs diff compared to the
parent commit (let's ignore merges). How can it be smaller than just a
single tree/blob diff (of the same path, compared to the parent
commit)?

> However, there may be very large commits in my schema (and maybe also
> very large "path-packs" in yours). Such large commits get split as I
> described above. Small commits get paired (possibly multiple times) as I
> described earlier. You end up with only reasonably sized pieces of data,
> let's say between 256 and 512 kB, so you don't need to resume.

Yeah, I started thinking how to transfer effieciently and I came to
similar thing: assume we have good order of packing and know what to
pack, then we close the pack when its size is greater than a limit and
start sending another pack. If this pack stream is corrupt, resume
from the corrupt pack forward. I currently hardcode the limit 4k, not
greater because pack overhead is very low already (12 header bytes and
20 sha1 trailer bytes each pack).

> Actually, with a really bad connection, you could ask the very server
> from which you obtained an incomplete pack to resume from a given byte
> offset (similar to HTTP ranges). The server may or may not have it. This
> time it should try to keep it available for you in case you connections
> abort again. Don't get me wrong -- this is just an additional help for
> very badly connected people.

Replace "byte range" with rev-list syntax (SHA1~10..SHA1-20) then we
have quite fine-grained way of asking for data. Deltas are usually
very small (I observed cache.h only so this could be a wrong
assumption). But if SHA1~10..SHA1~11 has too big diff that keeps
failing, sending byte ranges of the blob in SHA1~11 is probably the
only way left.
-- 
Duy
