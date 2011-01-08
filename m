From: Maaartin-1 <grajcar1@seznam.cz>
Subject: Re: Resumable clone/Gittorrent (again)
Date: Sat, 08 Jan 2011 02:04:40 +0100
Message-ID: <4D27B828.8020108@seznam.cz>
References: <AANLkTinUV9Z_w85Gz13J+bm8xqnxJ9jBJXJm9bn5Y2ec@mail.gmail.com> <loom.20110105T222915-261@post.gmane.org> <AANLkTi=_R53fm5Er0CdtZCFvDpE-Dqt8tMHAubcjOUBb@mail.gmail.com> <4D25385B.3010103@seznam.cz> <AANLkTikXcrZqhCw+2u2HObUZz5QCStY6BCHTTYYfngMN@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 08 02:04:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PbNEj-0008M9-2u
	for gcvg-git-2@lo.gmane.org; Sat, 08 Jan 2011 02:04:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752397Ab1AHBEr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jan 2011 20:04:47 -0500
Received: from smtp.seznam.cz ([77.75.72.43]:58866 "EHLO smtp.seznam.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752036Ab1AHBEq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jan 2011 20:04:46 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=beta; d=seznam.cz;
	h=X-Seznam-DomainKeys:X-Seznam-SPF:X-Virus-Info:Received:Message-ID:Date:From:User-Agent:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Smtpd:X-Seznam-User:X-Session:X-Country:X-QM-Mark;
	b=BI83BRc1tSgpivar2hkdnDav4GRPd2Ck9E6dSmGqxCyE2/YltGL6kvY8WWHBUtLsS
	z/Ozt4UAgoX6J3o7ObnXMtTSrbMiyjFj03AH7JAsDb3sbbxpRvw3JcOqAizXDht11Jk
	vctPUmUtCs+4mBCWGpw8CG5DSmh7G2yVomFZeoo=
X-Seznam-DomainKeys: unknown
X-Seznam-SPF: neutral
X-Virus-Info: clean
Received: from [10.0.3.100] (188-120-198-113.luckynet.cz [188.120.198.113])
	by email-relay1.go.seznam.cz (Seznam SMTPD 1.2.14@16206) with ESMTP;
	Sat, 08 Jan 2011 02:04:42 +0100 (CET)  
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.2; en-US; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <AANLkTikXcrZqhCw+2u2HObUZz5QCStY6BCHTTYYfngMN@mail.gmail.com>
X-Smtpd: 1.2.14@16206
X-Seznam-User: grajcar1@seznam.cz
X-Session: 16306
X-Country: CZ
X-QM-Mark: email-qm3<455267646>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164800>

On 11-01-06 07:36, Nguyen Thai Ngoc Duy wrote:
> On Thu, Jan 6, 2011 at 10:34 AM, Maaartin-1 <grajcar1@seznam.cz> wrote:
>> In theory, I could create many commits per seconds. I could create many
>> unique paths per seconds, too. But I don't think it really happens. I do
>> know no larger repository than git.git and I don't want to download it
>> just to see how many commits, paths, and object it contains, but I'd
>> suppose it's less than one million commits, which should be manageable,
>> especially when commits get grouped together as I described below.
> 
> In pratice, commits are created every day in an active project. Paths
> on the other hand are added less often (perhaps except webkit).
> 
> I've got some numbers:
> 
>  - wine.git has 72k commits, 260k trees, 200k blobs, 12k paths
>  - git.git has 24k commits, 39k trees, 24k blobs, 2.7k paths
>  - linux-2.6.git has 160k commits, 760k trees, 442k blobs, 46k paths
> 
> Large repos are more interesting because small ones can be cloned with
> git-clone.

Sure. Linux is the winner and has 4 times as much commits as paths.

> Listing all those commits in linux-2.6.git takes 160k*20=3M (I suppose
> compressing is useless because SHA-1 is random). A compressed listing
> of those 46k paths takes 200k.

Sure, Linux has only 4 times as much commits as paths, but the commits
need 30 times more storage. What does it tell us?

IMHO it speaks in favor of my proposal. Imagine a path changing with
nearly every commit. The root directory is such a path and near top
directories come close to (as may other files like todo-lists do). For
each such file you need 3MB for storing the commits SHAs only. Of
course, you can invent a schema making storing all the SHAs unnecessary,
but this is another complication.

OTOH, with the commits used as directory entries we get quite a large
directory. Is this a problem you wanted me to get aware of?

> The point is you need to fetch its parent commits first in order to
> verify a commit. Fetching a whole commit is more expensive than a
> file. So while you can fetch a few commit bases and request for packs
> from those bases in parallel, the cost of initial commit bases will be
> high.

You've lost me. I assume you mean that something like that there may be
very large commits (e.g., in a project not versioned from the very
beginning). I'd suggest to split such commits in two parts by
classifying the blobs (and trees) using a fixed bit of their SHAs. Of
course, this can be repeated in order to get even smaller parts. Let's
assume a commit X gets split into X0 and X1. As before, for compressing
of X0 you may use the content any predecessor of X. For compressing of
X0 you may additionally use the content of X0. This way the compression
rate could stay close to optimal, IMHO.

> They are interchangeable as a whole, yes. But you cannot fetch half
> the pack from server A and the other half from server B. You can try
> to recover as many deltas as possible in a broken pack, but how do you
> request a server to send the rest of the pack to you?

Indeed, it's not resumable. For most commits it's not needed since they
are very small. Why? There are more commits than paths, so the commits
are smaller than paths on the average. I expect my schema to allow for
nearly as good compression as git usually does, especially I'd hope it's
no worse than when packing paths.

However, there may be very large commits in my schema (and maybe also
very large "path-packs" in yours). Such large commits get split as I
described above. Small commits get paired (possibly multiple times) as I
described earlier. You end up with only reasonably sized pieces of data,
let's say between 256 and 512 kB, so you don't need to resume.

Actually, with a really bad connection, you could ask the very server
from which you obtained an incomplete pack to resume from a given byte
offset (similar to HTTP ranges). The server may or may not have it. This
time it should try to keep it available for you in case you connections
abort again. Don't get me wrong -- this is just an additional help for
very badly connected people.
