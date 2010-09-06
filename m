From: Elijah Newren <newren@gmail.com>
Subject: Re: [RFC PATCH 07/15] cache_tree_update(): Capability to handle tree
 entries missing from index
Date: Sun, 5 Sep 2010 22:42:53 -0600
Message-ID: <AANLkTinufi3TwnPZ+smq5FE5S3zZdQSzKpqYv=hVfcLV@mail.gmail.com>
References: <1283645647-1891-1-git-send-email-newren@gmail.com>
	<1283645647-1891-8-git-send-email-newren@gmail.com>
	<AANLkTi=ijbaATavcujUY-WnEfKFKrNue_kP6vSngKSvQ@mail.gmail.com>
	<AANLkTikK9vGgtzrrAAyqptPVHM2wjOjK_cH6GB0rgewP@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 06 06:43:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsTXo-0008Np-ST
	for gcvg-git-2@lo.gmane.org; Mon, 06 Sep 2010 06:43:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750992Ab0IFEmz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Sep 2010 00:42:55 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:40994 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750768Ab0IFEmy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Sep 2010 00:42:54 -0400
Received: by fxm13 with SMTP id 13so2295312fxm.19
        for <git@vger.kernel.org>; Sun, 05 Sep 2010 21:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=VpBtBzqFmXoet28elChlE2xJPtTrbX6ep69zVOxZcBI=;
        b=n62Qxuzb1F6Yto4t3g+l6KJpg3eIyw7tlSiwM17ZluGJ9ikZSDp2+TiUxz8ebrdntr
         xgQv1tCT8MKrLIN3S5rKGhnFCkGJDNweWFxmhYOTzSKUCmdpmtG0169wxvPsXecGCuYR
         JtnS4+wgAXFjJZir5qiPxhBlNpK0pH9DkWxHE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=J75y6Bsu4Ud4X4jBHF/WdLGntB2Mikbt8lbo/JP6ek0RsexMWlRxzGUDfZnlzwWMgQ
         GRWBjqA4GAp9eAyYWNMmRPUgmrRrJBbCPiu2c2yRqfsX8BxsVM8g/c1qHk4xOMKwUlsV
         fw6cynIKUcCn2Q6ZUJ7fJidTSdx5c+jYQIM8k=
Received: by 10.223.117.14 with SMTP id o14mr2174892faq.5.1283748173464; Sun,
 05 Sep 2010 21:42:53 -0700 (PDT)
Received: by 10.223.50.154 with HTTP; Sun, 5 Sep 2010 21:42:53 -0700 (PDT)
In-Reply-To: <AANLkTikK9vGgtzrrAAyqptPVHM2wjOjK_cH6GB0rgewP@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155520>

On Sun, Sep 5, 2010 at 3:09 PM, Elijah Newren <newren@gmail.com> wrote:
> n Sun, Sep 5, 2010 at 1:54 AM, Nguyen Thai Ngoc Duy <pclouds@gmail.co=
m> wrote:
>> On Sun, Sep 5, 2010 at 10:13 AM, Elijah Newren <newren@gmail.com> wr=
ote:
>>> cache_tree_update() will write trees using the index. =C2=A0With sp=
arse clones,
>>> the index will only contain entries matching the sparse limits, mea=
ning
>>> that the index does not provide enough information to write complet=
e tree
>>> objects. =C2=A0Having cache_tree_update() take a tree (typically HE=
AD), will
>>> allow new complete trees to be constructed by using entries from th=
e
>>> specified tree outside the sparse limits together with the index.
>>
>> You are moving it closer to the index (from my view because I change=
d
>> in commit_tree()). This makes me think, why don't you move the base
>> tree into the index itself?
>>
>> The index is supposed to save the image of full worktree. While you
>> don't have all path names, you have the clue to all of them, the bas=
e
>> tree. To me, that means it belongs to the index. That would reduce
>> code change to
>> =C2=A0- cache-tree.c (generate new tree from the base tree and index=
)
>> =C2=A0- read-cache.c (new sparse-clone index extension)
>> =C2=A0- index writing operations (save the base tree in index): read=
-tree and merge
>
> That's a really good idea. =C2=A0I'll look into that.

Hmm..maybe before I get ahead of myself, I should back up for a
second.  Which way do we think is better -- handling this in
cache_tree_update() or doing a fixup in commit_tree()?  If the latter,
then I should just drop my 7/15 and 8/15 for your 13/17 and 14/17.  If
the former, then it makes sense to look into this change you suggest.
In that case, we'd probably keep my 7/15 but drop 8/15 for patch(es)
that implement your idea above.  But you're more familiar with the
index format than I am and it's your idea, so you'd probably be the
better one to implement it.

Thoughts?

Elijah
