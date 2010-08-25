From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [RFD PATCH 00/32] subtree clone v2
Date: Wed, 25 Aug 2010 15:21:00 +1000
Message-ID: <AANLkTikkybj784PHoVCkVZyxo40q6BhdkOzFho-xBS6G@mail.gmail.com>
References: <1282688422-7738-1-git-send-email-pclouds@gmail.com>
	<20100824223741.GB2376@burratino>
	<AANLkTikipryFVf_XvvbHopWSo5Ey_mvgTevY2NAvhygQ@mail.gmail.com>
	<AANLkTinsNvVup43B6nQtU6dvJy789n8kQm6N6na0J9oa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git <git@vger.kernel.org>
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 25 07:21:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oo8QN-0006KY-KO
	for gcvg-git-2@lo.gmane.org; Wed, 25 Aug 2010 07:21:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755588Ab0HYFVD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Aug 2010 01:21:03 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:46596 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755566Ab0HYFVB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Aug 2010 01:21:01 -0400
Received: by yxg6 with SMTP id 6so49892yxg.19
        for <git@vger.kernel.org>; Tue, 24 Aug 2010 22:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=3RL9fEWXl+rKdTss0AcTyxczllWiQQSzTiXz9SxtXq8=;
        b=W6ioB2EOdnV/OtP2OvPBPfaQw9ybloydRpYBRnKByEo69JqOmKmuWjYOSPCemql/IJ
         UmMxxlgYj1wfI2CFTvtVbPO1qfUfs2xYGpTUgIBhUilXrDvW93upZyGHHRNM1AWJz/TL
         PvLv8pjHAZSpAOstisXO5c5M6g9ik2A2RP3VU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ag7pMMsgssiuogvatIOcz+NrmZaDfKiFMrozgqdiK9TXKTAluwrQigdErJVZ8nfg4f
         T7O00WnoqlfpWcxFs90NK2FKczX7zGNqGodxf0Wcs08KCNj5HTknTm6x5FM/pi9F/dgO
         Ds+I9ArNV0jdNj+AsemwShcwdkuMzRiy39apI=
Received: by 10.150.178.14 with SMTP id a14mr8011633ybf.131.1282713660801;
 Tue, 24 Aug 2010 22:21:00 -0700 (PDT)
Received: by 10.150.191.7 with HTTP; Tue, 24 Aug 2010 22:21:00 -0700 (PDT)
In-Reply-To: <AANLkTinsNvVup43B6nQtU6dvJy789n8kQm6N6na0J9oa@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154419>

On Wed, Aug 25, 2010 at 2:37 PM, Elijah Newren <newren@gmail.com> wrote=
:
>>>> Remote merge part.
>>>>
>>>> Split a merge operation into two parts, the real merge will be don=
e
>>>> within narrow tree. Conflicts can happen and be resolved in the na=
rrow
>>>> index, locally.
>>>>
>>>> Everything outside narrow tree will be merged (trivially) by
>>>> server. Then server sends the base tree back, so join_narrow_tree(=
) in
>>>> patch 20 can be used to create proper commit.
>>>>
>>>> Server can disable this remote merge feature, which means users ar=
e
>>>> forced to do rebase/fast-forward. Not too bad.
>>>
>>> Yikes. =C2=A0Na=C3=AFve question (please forgive my laziness): is i=
t possible to
>>> merge without remote contact in the boring case, when no changes ha=
ve
>>> occured outside the narrow tree?
>>
>> That's possible (and is implemented in my series). But I guess as so=
on
>> as you do "git pull", the boring case is likely not applicable
>> anymore.
>
> I'm not sure I follow. =C2=A0Are you allowing changes outside the nar=
row
> tree to occur? =C2=A0If you're not, I would have assumed that repeate=
d
> pulls just work, without any need to talk to the server, using a
> resolve-like strategy (with no special rename detection).

I don't. But I can't stop all other users (who use full repos) change
outside the narrow tree and push their changes back upstream. When
narrow user pulls from upstream again, the tree outside narrow tree
might be not the same as before.

> Here's my understanding, though it might have holes:
>
> If you have a narrow/subtree clone, it means that you only have the
> data for a certain paths. =C2=A0I'm assuming that also meant you woul=
d only
> allow modifying those paths. =C2=A0In other words, you have no change=
s
> outside the narrow tree. =C2=A0Because of that, I think you can handl=
e
> paths outside the narrow region using trivial-merge logic: =C2=A0From
> Documentation/technical/trivial-merge.txt, I think the relevant cases
> are 2, 3, 8, 10, 13, or 14. =C2=A013 & 14 already have a specified
> resolution. =C2=A0There's already a comment in the file that cases 8 =
& 10
> could validly be resolved as (empty), it just hasn't been done in the
> code as it tends to happen with the follow-up automatic merge anyway.
> That only leaves cases 2 & 3 as being slightly tricky -- if a path on
> one side of the merge started empty and ended empty, it would seem to
> make sense that the non-empty path on the other side would be the
> resolution. =C2=A0We can't do that in the non-narrow clone case becau=
se the
> non-empty path may have been created due to a rename and we'd like to
> have changes follow the rename appropriately. =C2=A0However, in the n=
arrow
> clone case, one can't rename from a path you don't have to a path you
> do, so this possibility is eliminated.

Trivial merge did not work outside narrow tree for me because I did
not have all trees of a commit. So as soon as it steps on the narrow
border, it has to stop (without retrieving full path to files outside
narrow tree). trivial-merge.txt takes input as files, not directories.
Given two directories (because we don't have further details what
inside those directories), I don't know how to do trivial merge.

> So, if my understanding is correct, then if you have no changes from
> upstream outside the sparse/narrow/whatever paths (where "paths"
> currently means a single tree in your current patches), I think you
> should be able to do a merge locally in that sparse clone. =C2=A0The =
end
> result will also have no changes from upstream outside those paths.
> Thus, you should be able to merge again.

Yes. But other people will change outside narrow tree, unfortunately.
--=20
Duy
