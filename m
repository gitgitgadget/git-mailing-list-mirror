From: Elijah Newren <newren@gmail.com>
Subject: Re: [RFD PATCH 00/32] subtree clone v2
Date: Wed, 25 Aug 2010 07:06:36 -0600
Message-ID: <AANLkTi=sPL4mAH=_Fba8Er6BQvq=NDO+-GF+MaGc8yAm@mail.gmail.com>
References: <1282688422-7738-1-git-send-email-pclouds@gmail.com>
	<20100824223741.GB2376@burratino>
	<AANLkTikipryFVf_XvvbHopWSo5Ey_mvgTevY2NAvhygQ@mail.gmail.com>
	<AANLkTinsNvVup43B6nQtU6dvJy789n8kQm6N6na0J9oa@mail.gmail.com>
	<AANLkTikkybj784PHoVCkVZyxo40q6BhdkOzFho-xBS6G@mail.gmail.com>
	<AANLkTikOtinR1EjzrzMqzR8Pn2hpDRVJrWDmx5b5tGQ_@mail.gmail.com>
	<AANLkTikCa_Yfw4t1=JAOkZPE3_txof67C4CfgrELoPsh@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>, git <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 25 15:06:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OoFgj-0007Si-0m
	for gcvg-git-2@lo.gmane.org; Wed, 25 Aug 2010 15:06:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753535Ab0HYNGk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Aug 2010 09:06:40 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:60773 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753093Ab0HYNGi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Aug 2010 09:06:38 -0400
Received: by fxm13 with SMTP id 13so242916fxm.19
        for <git@vger.kernel.org>; Wed, 25 Aug 2010 06:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=B4+Xz8qylKEsygr7tIB5zo64LuWbVG/w9gxvV7Ipwk8=;
        b=cErpexi2WTO3QEjSPPEr17EEUaI9h2vf98kv4ZPk4hx00cjYGbxbCTFyLrxzEl1SaH
         cDcdA47MwD2umkYYShf8u89yJ4oCCbPVgyKeRxf1PZUKulxPM/G9w0yjVaYV51M/qYtd
         AZwPK+NHGVvydxegMmf5yERto4r7Exx4ZSCTI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=f3MU4gBwMQvMCSidrZkxWbDyLLkhm4rINq0mpDlSSQLGzkCzSLQ8EKHD2t/OOATUtK
         kGfnLGM+YLjyUTNzOKCh++n8ebrYKGnX/vqfIC8PP0Yhqv5KFHKMNAOLymNmS/gNtmyo
         +uAfoI4hQYZaE+NeTl0gJGAq/sz0SMiSsnyJM=
Received: by 10.223.113.12 with SMTP id y12mr7494081fap.36.1282741596843; Wed,
 25 Aug 2010 06:06:36 -0700 (PDT)
Received: by 10.223.50.154 with HTTP; Wed, 25 Aug 2010 06:06:36 -0700 (PDT)
In-Reply-To: <AANLkTikCa_Yfw4t1=JAOkZPE3_txof67C4CfgrELoPsh@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154444>

Hi,

On Wed, Aug 25, 2010 at 12:21 AM, Nguyen Thai Ngoc Duy
<pclouds@gmail.com> wrote:
> OK here is the story. And I could be wrong on this merge stuff.
>
> I was deep in merge-tree.c code (which was the base for my narrow
> merge) and was stuck at
>
> "If either "you" or "upstream" is as same as ancestor (all as dirs),
> then it's easy. What if neither of them is the same as ancestor? If we
> have more trees, we could just descend and figure out. But we don't
> because it's outside narrow area. It could be that "you" added a new
> file and "upstream" added another file, which is trivial at file
> level."
>
> I was deep in code and forgot that in narrow repo, I did not allow to
> change outside narrow area, so it "you" must be as same as ancestor.
> But the question was, what if user decides to branch from some commit
> in history? If he/she does, "you" might not be as same as ancestor. If
> it's non trivial merge, merge should fail (expected).

If you branch from some older commit, then naturally the common
ancestor between you and upstream changes as well (namely, to that
older commit).  Since you don't/can't change anything outside your
subtree, that puts you in the following situation for paths outside
your subtree when you try to merge:

Merge-side: ancestor    you         upstream
            --------    --------    --------------
Sha1sum:    old-stuff   old-stuff   newest-stuff

> But the "it could be that "you" added ... at file level" above
> bothered me. I had a feeling that I could miss a trivial merge (at
> file level) because I could not make a judgement at (shallow) tree
> level. And I did not have all trees to do merge at file level.
>
> Still puzzling thinking about this.. Did I make wrong assumptions?

I'm not sure I understand why there would be any issue with you adding
one file in your subtree, and upstream adding (another/the same?) file
outside your subtree.  The only problematic case I see is when files
are renamed upstream from within the subtree to outside the subtree
and subsequently changed.  If on your side of history you modify one
of these files that were renamed from upstream, there's no way to
apply your changes to the new file.  It'd look something like this:

Merge-side: ancestor    you         upstream
            --------    --------    --------------
old-file:   original    modify1     (missing)
new-file:   (missing)   (missing)   modify2

The correct resolution is a three-way merge between original, modify1,
and modify2, stored in new-file with old-file being deleted.  However,
you don't have access to new-file/modify2 since it's outside your
subtree.  All you'd see is a modify/delete conflict in old-file and
the 'trivial merge' logic I suggested above (which ignores renames)
would result in new-file still having contents of modify2.

Hopefully the modify/delete conflict would be enough to trigger the
user to ask rather than just randomly pick some resolution and
proceed, which makes me think it should be okay to have a renaming
ignoring 'trivial' merge algorithm for subtrees.


Elijah
