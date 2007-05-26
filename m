From: "Dana How" <danahow@gmail.com>
Subject: Re: [PATCH 1/3] Lazily open pack index files on demand
Date: Sat, 26 May 2007 10:31:00 -0700
Message-ID: <56b7f5510705261031o311b89bapd730374cbc063931@mail.gmail.com>
References: <20070526052419.GA11957@spearce.org>
	 <7vabvsm1h8.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	danahow@gmail.com
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat May 26 20:42:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from pat.uio.no ([129.240.10.15])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hs165-0002zj-1i
	for gcvg-git@gmane.org; Sat, 26 May 2007 20:34:37 +0200
Received: from mail-mx9.uio.no ([129.240.10.39])
	by pat.uio.no with esmtp (Exim 4.66)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Hs09t-0005jA-7s
	for gcvg-git@gmane.org; Sat, 26 May 2007 19:34:29 +0200
Received: from vger.kernel.org ([209.132.176.167])
	by mail-mx9.uio.no with esmtp (Exim 4.66)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Hs09q-0005BD-1Y
	for gcvg-git@gmane.org; Sat, 26 May 2007 19:34:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759268AbXEZRbE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 26 May 2007 13:31:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759548AbXEZRbE
	(ORCPT <rfc822;git-outgoing>); Sat, 26 May 2007 13:31:04 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:39199 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760409AbXEZRbC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 May 2007 13:31:02 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1348446ugf
        for <git@vger.kernel.org>; Sat, 26 May 2007 10:31:00 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=G5rimX8Z6BiYJ4SaATEqrQcTJ6z1BIfNUheQEb08xXVaTjaUA2hXox8q5DVXT4jIstEi0gBu9MjabPcrpJ/RBzortDuNaR2jUrfgJr1QBJ61AhjW5VDFpAhvLG1ykX5wbqYprJCFtevfE0sw3XYHtTN0bmfVP3XvqkBxETI1LNg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XgwzfacFffdChEdsTUlAU1w2FbhYHgS8dAFzTP9dYSWxdCBa+30dvlcI7WrZNAOlfXUbEMLvW/NtBSs5mgsEW5S9Jh55BJLPt+mvLhMhVzOrOFk++6DLRTd/s5T0L0izlMyzTGM0N/H0nL5LJ68PIizMBfF4gHEsxm/oCaRr7A4=
Received: by 10.78.132.2 with SMTP id f2mr107974hud.1180200660705;
        Sat, 26 May 2007 10:31:00 -0700 (PDT)
Received: by 10.78.129.3 with HTTP; Sat, 26 May 2007 10:31:00 -0700 (PDT)
In-Reply-To: <7vabvsm1h8.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.0, required=12.0, autolearn=disabled, UIO_VGER=-3)
X-UiO-Scanned: 562D7067E1726C7D5436AFAC32B2E762BAECB62C
X-UiO-SPAM-Test: remote_host: 209.132.176.167 spam_score: -29 maxlevel 200 minaction 2 bait 0 mail/h: 41 total 249573 max/h 813 blacklist 0 greylist 0 ratelimit 0

On 5/26/07, Junio C Hamano <junkio@cox.net> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> >  This conflicts (in a subtle way) with Dana How's
> >  "sha1_file.c:rearrange_packed_git() should consider packs' object
> >  sizes" patch as we now have num_objects = 0 for any indexes we
> >  have not opened.  In the case of Dana's patch this would cause
> >  those packfiles to have very high ranks, possibly sorting much
> >  later than they should have.
> I am keeping that rearrange stuff on hold, partly because I am
> moderately hesitant to do the fp, which feels overkill at that
> low level of code.
Oh,  I thought the fp might cause a gag reflex -- I had to add -lm.
Unfortunately,  when trying to automatically detect and grade outliers,
which is what I was trying to do,  (datum - mean) / std_dev is hard to beat,
and I needed sqrt for std_dev -- all other fp could be easily written out.

> Also, I am hoping that we can discard that the object density
> criteria altogether by making the default repack behaviour
> friendlier to the pathological cases, e.g. by emitting huge
> blobs at the end of the packstream, potentially pushing it out
> to later parts of split packs by themselves and automatically
> marking them with the .keep flag.  Until that kind of
> improvements materialize, people with pathological cases could
> (1) handcraft a pack that contains only megablob, (2) place that
> on central alternate, (3) touch it with artificially old
> timestamp, which hopefully is a good enough workaround.
I think we should do what we can to make the timestamp as
meaningful as possible,  which is why I submitted that stamping patch.

I think there are two interesting strategies compatible
with maximally-informative timestamps:

(1) git-repack -a -d repacks everything on each call.  You would need:
(1a) Rewrite builtin-pack-objects.c so only the object_ix hash
       accesses the "objects" array directly, everything else
       goes through a pointer table.
(1b) Sort the new pointer table by object type,  in order
       tag -> commit -> tree -> nice blob -> naughty blob.
      The sort is stable so the order within each group is unchanged.
(1c) Do not deltify naughty blobs.  Naughty blobs are those
      blobs marked "nodelta" or very large blobs.
(1d) Write out objects in new pointer table order.  Splitting
       will cause metadata to be in first pack,  naughty blobs
       tend to be in the last pack.
(1e) When done writing all packs,  swap their timestamps
      so current timestamp sorting will look at naughty blobs last.

(2) git-repack -a -d runs in two passes and maintains .keep files:
(2a) Add a new flag --types=[gctb]+ to pack-objects to be supplied
      by git-repack.  This means only taGs/Commits/Trees/Blobs
      are to be passed,  all others dropped.
(2b) Put a new loop around the core of git-repack.  In the first iteration,
      pack with --types=b, then with --types=gct in the second.
      Thus metadata will have more recent timestamp.
(2c) If packs are split, also swap timestamps like in (1e),
       within each iteration.
(2d) If an iteration produces split packs, mark all but the last
      in the sequence with a .keep file automatically.  The
      .keep files contain the string "repack".
(2e) Add new option to repack: -A.  If specified,  the first
      thing repack does is remove any keep file containing "repack".
(2f) The existing response of repack to keep files -- do not repack them --
     is retained to ensure on each -a/not -A repack,  we only
     repack the tail of each set of packs: metadata, data.
     The metadata set will probably only ever contain one pack
     and will always be repacked.

I've (badly) implemented (1b) and confirmed it had no impact
on linux-2.6 repo.  I've also implemented (2a), (2b), (2d), and (2f),
but not fully measured them.  I'd like to finish this work,  but
"megapacks" are very time-consuming to manipulate,  and
with the loose megablob approach they are not as useful for me.

Finally,  some people might want more esoteric repacking
strategies than what I've listed above.  We could add a
--packed flag to pack-objects to help them.  This means that
git pack-objects --packed --unpacked=<pack1> --unpacked=<pack2>
would only repack pack1 and pack2 and would not absorb
any loose blobs.  This would allow you to maintain any number
of packfile classes you want and maintain them yourself.
Each would be indicated by something different in a .keep file.
(To newly absorb loose blobs in a class,  you would do
 cat object-list | git-pack-objects --incremental
from some object-list you built following your rules).
These strategies would be too special-purpose to be in git,
but adding --packed is a small and useful change.

Shawn:  When I first saw the index-loading code,  my first
thought was that all the index tables should be
merged (easy since sorted) so callers only need to do one search.
With indices loaded lazily,  either you can't merge,  or you
merge sequentially, raising merge cost from (total entries) to
almost (index files) * (total entries).  What do you think about
merging the SHA-1 tables,  and how would/should it interact with
lazy index file loading?

BTW,  if it's not apparent,  I think my object density patch
should be dropped.  It has served its purpose as a thought experiment.

Thanks,
-- 
Dana L. How  danahow@gmail.com  +1 650 804 5991 cell
