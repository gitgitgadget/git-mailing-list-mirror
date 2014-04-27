From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH 1/2] blame: large-scale performance rewrite
Date: Sun, 27 Apr 2014 10:53:09 -0700
Message-ID: <CAJo=hJvHiCu8WdHdD7wjnbZeCmKkCdCQwvuLAcF6rfMc2nzLsw@mail.gmail.com>
References: <1398470210-28746-1-git-send-email-dak@gnu.org>
 <CAJo=hJukmej1rJXuVoECwd7AxmSue8Wmv4rBmCHEYcWBWNarSw@mail.gmail.com>
 <87wqec8rb5.fsf@fencepost.gnu.org> <CAJo=hJs=ap=Ct_PzOsO=vHmDVMvUF+nvbB7b67bgnmug+Yrohg@mail.gmail.com>
 <87d2g481nb.fsf@fencepost.gnu.org> <874n1g80dd.fsf@fencepost.gnu.org>
 <CAJo=hJs-Nn=o=aGS_3bO9mnxb+urst6JTZf29_qAejBipz_ZHg@mail.gmail.com> <87vbtv7ou0.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Sun Apr 27 19:53:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WeTGj-0002TG-Pf
	for gcvg-git-2@plane.gmane.org; Sun, 27 Apr 2014 19:53:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751530AbaD0Rxd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Apr 2014 13:53:33 -0400
Received: from mail-wg0-f45.google.com ([74.125.82.45]:54294 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750733AbaD0Rxb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Apr 2014 13:53:31 -0400
Received: by mail-wg0-f45.google.com with SMTP id l18so5404822wgh.4
        for <git@vger.kernel.org>; Sun, 27 Apr 2014 10:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=CSQ9UKOeSmBhIU9P0ww0fJ+u33FZwv48AL/jmv2/Pl4=;
        b=AbIMpoh/VDT1UYXG0CR8rZ5hDLDzdbY50kNroPLpxUzaCqGUmEDEp7waeJl0CBqrpQ
         8o6V/JO3KKeKYfkY1zQ5Mb2EK5DiwFLWKpgONKDG4Zo6gZRvkbrgkH2Qx6TCur9wklnG
         t8yy/i6oQy1cyELgV0qFHWzRkUfy6qiLdZ0Lc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=CSQ9UKOeSmBhIU9P0ww0fJ+u33FZwv48AL/jmv2/Pl4=;
        b=FqOwE16Kdlu6uDFistpchg2EpTYcqtsbOAY3/IFj0WBk1S3GBUdxqM7B7Vi5gsc5M3
         Qd9NIVJl9rNCgv0g+5WFho5Gl9vAF60GO2RDT/6815ZCzcZJSkPgtDfqAPrgF+bWgwhT
         EEYvUr75ZXo4dg3dgM1ZmDZHh4Bhrvj/PXKcMfK1/LZFnxyEpAVGrFHLlqJSsfEPK9I3
         3743dKJ3KcNJ4TKq9DXsTUwKBuqVpvf0sUH7EMp4IK26WlVSADkdQEIWHjoKmuZlHKhi
         BLObvbo0YLw2aMyLQXh17/iyVanHPxsdbfuQlawBINtAMw1G23rAohcvi5S/vChhOP/F
         9mPw==
X-Gm-Message-State: ALoCoQml2gMbE4KtSYl/jZJcrziwVmLCWruz0DFFQJL0rnysxV0OXHwuJAIekSge5VsXKJWgY06p
X-Received: by 10.194.92.81 with SMTP id ck17mr15710527wjb.14.1398621210025;
 Sun, 27 Apr 2014 10:53:30 -0700 (PDT)
Received: by 10.227.7.131 with HTTP; Sun, 27 Apr 2014 10:53:09 -0700 (PDT)
In-Reply-To: <87vbtv7ou0.fsf@fencepost.gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247210>

On Sat, Apr 26, 2014 at 2:39 PM, David Kastrup <dak@gnu.org> wrote:
>
> At least the stuff I fixed with regard to performance would seem to be
> done right in JGit to start with.

Hah! Its Java. We have to do things right, otherwise its too slow. :-)

>> Its still not as fast as I want it to be. :-)
>
> Most of the diff data/CRC is computed over and over because of the
> blackbox use of xdiff.

Yes, I have been thinking about this all week.

JGit blame uses HistogramDiff by default instead of MyersDiff. The
first stage after we trim common header/trailer from both files is to
compute a hash of each line and store those hashes. Those hashes are
discarded as the blame algorithm moves to the next commit.

Clearly for a commit chain of A -> B -> C, the hashes computed at B
for the A->B compare can be reused for the B->C compare. This is not
the case in either git-core or JGit, because the diff algorithm is a
block box to the blame algorithm. I think this is what you mean by the
CRC being computed again.


For any given compare blame has a list of regions it is interested in
learning about from the diff algorithm. Anything outside of those
regions is useless noise that will be discarded. I have been pondering
pushing that region list down into the diff algorithm so it can avoid
executing on sections that are not relevant to the caller. At least
for HistogramDiff this makes some sense, the algorithm is recursively
applied after it finds a longest common subsequence. If one side of
the LCS is outside of the region of interest from blame, there is no
value in recursing on that portion.

If the blame region list covers a small enough portion, it may even
make sense to avoid the common header/trailer elimination
preprocessing step. Unfortunately that sounds "hard" as you could be
working with a file like a ChangeLog which grows on one of those
sides.


>  And then the delta-chain storage is packing
> stuff based on CRCs as well (not sure whether it keeps them around for
> unpacking).

There are CRCs validated by libz during inflation, but these aren't
rechecked once the inflated bytes are cached in that silly undersized
16M delta base cache.

> So there is a lot that could likely be improved while
> keeping the same basic algorithms, by cracking open the black boxes of
> the xdiff engine and the delta-chain coding.

The delta chain coding has no relationship to the source file.
Currently even plain text files are delta chain coded on a byte basis,
not a line basis. Just matching up the delta coding against a source
text file to determine lines 0-N are common is costly, since you have
a byte range in the delta coding and you want a line range out the
end.

To make things more challenging, the delta chain coding can be against
completely different blobs. In a compare of A->B from the commit graph
being walked by blame there is no requirement the delta coding uses
this pairing, and it almost certainly never uses this direction (its
usually B->A, if its even this pair!).


Given your comments in the other patch, I understand why you probably
won't be working on blame more. But the above may help someone else
that has available time to continue.
