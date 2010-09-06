From: Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 00/17] Narrow clone v3 (was subtree clone)
Date: Sun, 5 Sep 2010 23:17:07 -0600
Message-ID: <AANLkTinNnm=Z=e_=P_auuNgSrDynt_P+FLiZgWeNNgps@mail.gmail.com>
References: <1283669264-15759-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 06 07:17:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsU4x-0002kf-VR
	for gcvg-git-2@lo.gmane.org; Mon, 06 Sep 2010 07:17:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751437Ab0IFFRK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Sep 2010 01:17:10 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:42526 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751396Ab0IFFRJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Sep 2010 01:17:09 -0400
Received: by fxm13 with SMTP id 13so2301332fxm.19
        for <git@vger.kernel.org>; Sun, 05 Sep 2010 22:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=vBAb+ODV0CUCaKhY2NF2AIVFPdxljUM+zgMdEUVOxKc=;
        b=mt9tTjcMKdpKcBGUuGKM0A079t6xTaUquojv9Vcn5U+L4DJwofYe1rwC/JGWm8p5ee
         YwlJcFaZw4CkkPYrxqSUUs+oCYOoprF64YhJbCt/cyjAEyD8yzGIRxtfae92KJPPO+wc
         6+jxMbRo1wM6WCQQOeiakAsubgoycgwkC3L7o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=SSiV5r0/afUZC3yIZmc0CJpKlrDiQpmCGtiVeonzqoeOoScvEjUkwy4M1xkb481Fnv
         E8LCEEEwVrm4VSimMInDQlDpLy/3m0x0j3zwAmB4eE+X94Pa72IdLmWVH6NzxwcW2qQP
         c5A3FLqwZnKWq4uLtXdsGmkeYKZwJDaB10U0M=
Received: by 10.223.125.196 with SMTP id z4mr2014211far.80.1283750227664; Sun,
 05 Sep 2010 22:17:07 -0700 (PDT)
Received: by 10.223.50.154 with HTTP; Sun, 5 Sep 2010 22:17:07 -0700 (PDT)
In-Reply-To: <1283669264-15759-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155528>

Hi,

2010/9/5 Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>:
> I'll describe differences between this series and Elijah's one [1].
> I think it's more interesting. Changes from v2 [2] will follow later.

So, I downloaded your patches and even made sure to sort them
appropriately to fix the order, but I'm getting conflicts trying to
apply them (on top of current pu).  What version did you base them on?

> In short I think the two series are converging. The outstanding
> difference is Elijah drops shallow clone in favor of more flexible
> history cutting while I only focus on tree cutting.
>
> Two other differences are tree traversal and tree generating. I admit
> that changing traverse_trees() the way Elijah does is more flexible
> and is probably the only way to support negative pathspec. And I thin=
k
> his sparse clone supports even cloning a single file. Mine does not
> support that. I'm going to steal some of his patches at some point.

Yes, I can clone a single file.

> Tree generating from index, Elijah merges the base tree inside
> write_cache_as_tree() while it does it inside commit_tree(). Again th=
e
> principle is pretty much the same. I'll see if I can resist from
> stealing some more :)

You're too modest; your comparison simply omitted some of the areas
where your series shines, such as the get_pathspec fixes (my stuff was
broken and much less complete), merge support, and nicer
fetch/push/clone support.  You also had some other nice touches
(documentation updates, new rev-parse flag) that may not have been a
big deal, but they're still nice.  I'm going to be cherry-picking a
lot of that stuff, and replacing the relevant bits of my series.  Who
knows, maybe we're converging quicker than it looked at first glance?
:-)

> Things that won't work:
>
> =C2=A0- Shell scripts that use "git write-tree"

Yeah, write-tree didn't work in mine either; I had to make it throw an
error.  But wouldn't your idea to make a tree object (referenced for
sha1sums outside the sparse/narrow paths) part of the index allow even
write-tree to work?

> =C2=A0- only send commits that have changes in narrow area and graft =
it at
> =C2=A0 client side

After reviewing more of your changes, and replacing various patches of
mine with yours, this is fairly high on my priority list as well
(whereas fsck & prune are a bit lower).  Maybe we can discuss ideas on
tackling this when we start working on it.  I've got some rough
initial ideas (though I have no idea if they'll pan out); I'll see if
I can write some of them up in the next day or two.

Elijah
