From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Using bitmaps to accelerate fetch and clone
Date: Sun, 30 Sep 2012 19:26:44 -0700
Message-ID: <CAJo=hJs8TcU=Vvq4Re2aqTUrgRqiSyHs1rA+fPDHUkvrhwc3OA@mail.gmail.com>
References: <CAJo=hJstK1tGrWhtBt3s+R1a6C0ge3wMtJnoo43Fjfg5A57eVw@mail.gmail.com>
 <CACsJy8AUdRyjSrAgM+ABzWet2NKz7N7M4re2QVoRPrrA=zfvvg@mail.gmail.com>
 <CAJo=hJsWczUqhvj6Kqsomeh9WxAAJO-Yc-=61k94jos6vVtEjQ@mail.gmail.com> <CACsJy8D5AXSWAdK7tgtXnE4Ro_+okaYM=zf9JnQfObkcx=FCOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git <git@vger.kernel.org>, Colby Ranger <cranger@google.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 01 04:27:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TIVj4-0005GF-Gn
	for gcvg-git-2@plane.gmane.org; Mon, 01 Oct 2012 04:27:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751956Ab2JAC1H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Sep 2012 22:27:07 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:46497 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751709Ab2JAC1G (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Sep 2012 22:27:06 -0400
Received: by qchd3 with SMTP id d3so3318544qch.19
        for <git@vger.kernel.org>; Sun, 30 Sep 2012 19:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=aFElYM+bAyueeabqj+ZErOepDMNfd5qEMYFCO8C4pDw=;
        b=AlluL8moVsPz/YaqS8EwQXDtwMBQCrBPovexY0pILeb5M/vvQA5wUXTRSPN6uYBeCU
         BKhkBBaqM07R0Sw0/zMDPb3Dc2HnrJj6rpgHGLVzuPd0kb21kdYGFluNz0GlCs7augsP
         7tepYl0sy0/jmlSvyxFCQO7GyN5tpc6GahmPU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:x-gm-message-state;
        bh=aFElYM+bAyueeabqj+ZErOepDMNfd5qEMYFCO8C4pDw=;
        b=XJFDzO8RN++RmKEZU0jNmneGMBLt4n+MeN+TEKEKL75eKWs1pJd1NFh3jsTPQWtKlG
         hBhZi516eI2yEhIimDvdOmgMtpEt3UAs1WFooACX6OIXZlv4bWg4ZWX7byDuiORuASnN
         kTa1i/MJzpTMCl02eyLcojsDKnKNkVfLGBxpFnGtTN7dkFZcD8zF7wKiy0IZFb+jbv2I
         E6zkRrvVp02i8i8gbJURqWane1fBkC6PZQju9syCCOiO44tAzroR3OzCoKjNxH0m6S73
         BtcYVTNZ9XV7ps54o0sTd8ycNUEZM3bdBTyyzFBm6wKRPrSXWG35ZGnUCTWf8MSguHzg
         hJAg==
Received: by 10.229.178.193 with SMTP id bn1mr1964408qcb.80.1349058424501;
 Sun, 30 Sep 2012 19:27:04 -0700 (PDT)
Received: by 10.49.35.75 with HTTP; Sun, 30 Sep 2012 19:26:44 -0700 (PDT)
In-Reply-To: <CACsJy8D5AXSWAdK7tgtXnE4Ro_+okaYM=zf9JnQfObkcx=FCOw@mail.gmail.com>
X-Gm-Message-State: ALoCoQlPTuDYnzxKJZQxKAHb4cFEu1p8i26uzsPyagZ+I9FKB+gUxW/bfe4+bqyXJpmoHiB1qhnf
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206707>

On Sun, Sep 30, 2012 at 6:59 PM, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> On Mon, Oct 1, 2012 at 8:07 AM, Shawn Pearce <spearce@spearce.org> wrote:
>>> You mentioned this before in your idea mail a while back. I wonder if
>>> it's worth storing bitmaps for all packs, not just the self contained
>>> ones.
>>
>> Colby and I started talking about this late last week too. It seems
>> feasible, but does add a bit more complexity to the algorithm used
>> when enumerating.
>
> Yes. Though at server side, if it's too much trouble, the packer can
> just ignore open packs and use only closed ones.

Its not trouble once the code is written. We were just trying to be
expedient in producing a prototype that we could start to deploy on
real-world workloads. Enumerating the non-closed-pack objects using
the classical implementation is still slow and consumes CPU time at
the server, using partial bitmaps should eliminate most of that CPU
usage and reduce server loads.

One of the more troublesome problems is building the bitmaps is
difficult from a streaming processor like index-pack. You need the
reachability graph for all objects, which is not currently produced
when moving data over the wire. We do an fsck after-the-fact to verify
we didn't get corrupt data, but this is optional and currently after
the pack is stored. We need to refactor this code to run earlier to
get the bitmap built. If we take Peff's idea and put the bitmap data
into a new stream rather than the pack-*.idx file we can produce the
bitmap at the same time as the fsck check, which is probably a simpler
change.

>>> We could have one leaf bitmap per pack to mark all leaves where
>>> we'll need to traverse outside the pack. Commit leaves are the best as
>>> we can potentially reuse commit bitmaps from other packs. Tree leaves
>>> will be followed in the normal/slow way.
>>
>> Yes, Colby proposed the same idea.
>>
>> We cannot make a "leaf bitmap per pack". The leaf SHA-1s are not in
>> the pack and therefore cannot have a bit assigned to them.
>
> We could mark all objects _in_ the pack that lead to an external
> object. That's what I meant by leaves. We need to parse the leaves to
> find out actual SHA-1s that are outside the pack.

OK, yes, I was being pretty stupid. Of course we could mark the
objects _in_ the pack as leaves and parse the leaves when we need to
find the external pointers.

> Or we could go with
> your approach below too.

I actually think my approach may be better. The root tree of a leaf
commit would need to be scanned every time to identify trees that are
reachable from this leaf commit, but are not reachable in the ancestry
of the leaf's parents. This turns out to be rather expensive to
compute every time a server or an fsck algorithm considers the partial
pack. Its also somewhat uncommon for such an object to exist, it has
to happen by an unrelated side branch introducing the same object and
the creator of the pack seeing that object already exist and not
including it in the pack.

Defining the pack's "edge" as a list of SHA-1s not in this pack but
known to be required allows us to compute that leaf root tree
reachability once, and never consider parsing it again. Which saves
servers that host frequently accessed Git repositories but aren't
repacking all of the time. (FWIW we repack frequently, I hear GitHub
does too, because a fully repacked repository serves clients better
than a partially packed one.)

>> We could
>> add a new section that listed the unique leaf SHA-1s in their own
>> private table, and then assigned per bitmap a leaf bitmap that set to
>> 1 for any leaf object that is outside of the pack.
>
>> One of the problems we have seen with these non-closed packs is they
>> waste an incredible amount of disk. As an example, do a `git fetch`
>> from Linus tree when you are more than a few weeks behind. You will
>> get back more than 100 objects, so the thin pack will be saved and
>> completed with additional base objects. That thin pack will go from a
>> few MiBs to more than 40 MiB of data on disk, thanks to the redundant
>> base objects being appended to the end of the pack. For most uses
>> these packs are best eliminated and replaced with a new complete
>> closure pack. The redundant base objects disappear, and Git stops
>> wasting a huge amount of disk.
>
> That's probably a different problem. I appreciate disk savings but I
> would not want to wait a few more minutes for repack on every
> git-fetch. But if this bitmap thing makes repack much faster than
> currently, repacking after every git-fetch may become practical.

I know the "Counting objects" phase of a repack is very expensive, but
so too is the time required to do the IO in and out of every object in
the repository. Spinning disks only transfer data so fast. Assuming
the drive can move 50 MiB/s each way, a 500 MiB repository will take
10 seconds just to write back out the new pack. You aren't ever going
to want to wait for repacking during git-fetch.
