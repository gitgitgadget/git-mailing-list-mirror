From: Erez Zilber <erezzi.list@gmail.com>
Subject: Re: How to handle a git repository with multiple branches
Date: Tue, 31 Aug 2010 10:21:01 +0300
Message-ID: <AANLkTi=eVuRenSOut2stYfdUpFRPbiOaUynrg6DPxQ9t@mail.gmail.com>
References: <AANLkTimW-SQi1eprxTPXxF85SBO4d5MU13=dsboNNrzd@mail.gmail.com>
	<AANLkTi=fn1YmK8WW-wfx2Eba8x8RQv3gZ56PU=T7=fLW@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 31 09:21:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqL9b-00047f-In
	for gcvg-git-2@lo.gmane.org; Tue, 31 Aug 2010 09:21:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932232Ab0HaHVG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 31 Aug 2010 03:21:06 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:50388 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932223Ab0HaHVE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Aug 2010 03:21:04 -0400
Received: by bwz11 with SMTP id 11so4261319bwz.19
        for <git@vger.kernel.org>; Tue, 31 Aug 2010 00:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=/DB6K20RwWESdU/Uj6XsVDQk5ekfKQRpCXV13tRn2tk=;
        b=vUUUOkvW6v2PrXWg0VIywU9BmT8LQBiCHbbihARmz8rdCxl53oZczaQ3n7ZDWKaM2u
         wwefRHHtUNxI+IbL/+HJF+P0IPES5gfGaRsnyPJe56Pe1CTbw6MBXXpexFiVAfZyuds1
         2sI2iJtx88eqDiY0OgICcBRJ0/lCSfRZK2Ovo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=TB8ynJSSrOKo1cz9TMoguTbTj+sdZTsTdG/pd+IOvi58xt+jlgeq6PJxyzX2KecfMo
         O0ZjKN7v/6WDizvUlbkWXwZPwPM51uclArirqZIPn9c8rSFR8nEhLJ0sbSJikO8Cjw2L
         7t2PFka84XQ71L5g3EOoyggKqTH9aeKlEH32Q=
Received: by 10.204.66.206 with SMTP id o14mr4005070bki.159.1283239261726;
 Tue, 31 Aug 2010 00:21:01 -0700 (PDT)
Received: by 10.204.21.145 with HTTP; Tue, 31 Aug 2010 00:21:01 -0700 (PDT)
In-Reply-To: <AANLkTi=fn1YmK8WW-wfx2Eba8x8RQv3gZ56PU=T7=fLW@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154883>

On Fri, Aug 27, 2010 at 2:03 AM, Jon Seymour <jon.seymour@gmail.com> wr=
ote:
> On Thu, Aug 26, 2010 at 9:53 PM, Erez Zilber <erezzi.list@gmail.com> =
wrote:
>> Hi,
>>
>> My repository has several branches. Each branch is for a separate co=
de
>> release. Let's assume that I have a branch for V1.0 (branch_1) and a
>> branch for V2.0 (branch_2).
>>
>> Some commits are relevant only for branch_1, some are relevant only
>> for branch_2 and some are relevant for both. For the commits that ar=
e
>> relevant for both branches, I thought about the following solutions:
>> 1. Put these common commits in branch_1 and merge branch_1 into
>> branch_2. This is bad because it will also merge commits that are
>> relevant only for branch_1.
>> 2. Cherry-pick the common commits from branch_1 to branch_2. This is
>> also bad because the commit ID changes, and in case of conflicts, gi=
t
>> is unable to tell that these 2 commits are actually the same commit.
>> This makes it very difficult to track the changes between branches.
>>
>> Since there are several other developers and sub-maintainers in this
>> project which are rebased on both these branches, I don't want to
>> change the git history of my branches because when I do that,
>> sub-maintainers and developers lose the reference to their base.
>>
>> I'm looking for a better solution. Is there any best-practice soluti=
on?
>>
>
> As Josh pointed out in another post, the key to sharing commits acros=
s
> branches is to ensure that the commits that you intend to share
> between branches should always be based on a commit that both branche=
s
> have in common. That way, when you eventually merge the commit into
> the branch the only history it drags in is the history associated wit=
h
> the patch itself.
>
> This requires a slight shift in mind set - don't automatically assume
> the right thing to do is develop a patch is on the tip of branch_1. I=
f
> the branch_1 does contain other stuff that you are not intending to
> merge into branch_2, this is probably the wrong thing to do.
>
> What I tend to do (as described here
> http://permalink.gmane.org/gmane.comp.version-control.git/153168), is
> to
> develop my fixes on =A0the tip of private integration branch (which I
> never share), then rebase them onto a suitable base common to all
> potential delivery targets later. This works for me, because there
> isn't typically much divergence in the files I touch between branches=
=2E
> =A0It might not work so well in cases where there is significant
> divergence.
>
> jon.
>

Thanks for the answers.

Erez
