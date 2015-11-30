From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Git clone fails during pre-commit hook due to GIT_WORK_TREE=.
 (regression 2.5 -> 2.6)
Date: Mon, 30 Nov 2015 20:01:07 +0100
Message-ID: <CACsJy8Ciuirgk9D_fbQ5pgo-8u1AnM+zBdKUHcz_HLfRqM9QxQ@mail.gmail.com>
References: <CA+dzEB=2LJXiLSTqyLw8AeHNwdQicwvEiMg=hVEX0-_s1bySpA@mail.gmail.com>
 <CA+dzEB=XiGVFg+AhuJM-jUCPmgZKCJHTp3sinrFt8yzXeC_63Q@mail.gmail.com>
 <CAGZ79kY=t9SeoXjgeJjfCMD2=6g3JJxDxcnY6JeJCpUqaN+eOA@mail.gmail.com> <CACsJy8C7xoV9faGpbn_5XGt-CmCj--fgXaCFR-ngs=-pWUnrCA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Stefan Beller <sbeller@google.com>
To: Anthony Sottile <asottile@umich.edu>
X-From: git-owner@vger.kernel.org Mon Nov 30 20:01:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a3Thn-0003r5-2x
	for gcvg-git-2@plane.gmane.org; Mon, 30 Nov 2015 20:01:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754489AbbK3TBj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Nov 2015 14:01:39 -0500
Received: from mail-lf0-f45.google.com ([209.85.215.45]:36324 "EHLO
	mail-lf0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753990AbbK3TBi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Nov 2015 14:01:38 -0500
Received: by lfs39 with SMTP id 39so204922558lfs.3
        for <git@vger.kernel.org>; Mon, 30 Nov 2015 11:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=xXv9KsvMqqh13clKPjDZXVJo4XLhMy+JG1izGGLQaIk=;
        b=YnPhfujUqFTKJLculvex4DJPYh3509N+o9z/LPflxVTMn2DeFVptC8ujRL6sx9g5O0
         9tiflZNW7Qg9YH1uFVpWhKVSoQo23QhujI1NYohysBHLE/5MMSAxeAi7qpD8WNqUwt7t
         xH/eK2bAHjQwo6zeabJHCZMsEF+LjUx+JdJE4TvewKVgukog5wIqJ90pOmA9RBFvUQgC
         njBygtVx5EKMKikhMRiINpMTG+0HPwW4Ha/Ndnpp5qiLjTvRY9X2Kmz4QVJS+IMFQCEs
         ncr21H3G9d4H6JpEPcrQBLuMcEc24lrF6V1ejeZlSEkGWPAi0Rynn+xMcSvjOZe4zADi
         kdoQ==
X-Received: by 10.25.33.4 with SMTP id h4mr21200068lfh.3.1448910096904; Mon,
 30 Nov 2015 11:01:36 -0800 (PST)
Received: by 10.112.199.5 with HTTP; Mon, 30 Nov 2015 11:01:07 -0800 (PST)
In-Reply-To: <CACsJy8C7xoV9faGpbn_5XGt-CmCj--fgXaCFR-ngs=-pWUnrCA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281810>

On Wed, Nov 25, 2015 at 9:13 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Tue, Nov 24, 2015 at 6:57 PM, Stefan Beller <sbeller@google.com> w=
rote:
>> +to Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>
>>
>> On Mon, Nov 23, 2015 at 6:22 PM, Anthony Sottile <asottile@umich.edu=
> wrote:
>>> * Short description of the problem *
>>>
>>> It seems GIT_WORK_DIR is now exported invariantly when calling git
>>> hooks such as pre-commit.  If these hooks involve cloning repositor=
ies
>>> they will not fail due to this exported environment variable.  This
>>> was not the case in prior versions (such as v2.5.0).
>
> I'm getting good at fixing one bug and adding ten more. I don't think
> the cited commit is the problem. It just exposes another bug. I did
>
>> ~/w/git $ GIT_WORK_TREE=3Dabc ./git clone .git /tmp/def
>
> and what I got was really surprising, /tmp/def contains the git
> repository while the true worktree is in "abc". It does not make
> sense, at least from the first sight, unless it inherits this from
> git-init, where we do(?)  want GIT_WORK_TREE to specify a separate
> worktree. No time to dig to the bottom yet..

I was wrong, GIT_WORK_TREE support was added in git-clone many years
ago in 20ccef4 (make git-clone GIT_WORK_TREE aware - 2007-07-06). So
my change accidentally triggers an (undocumented) feature. We could
add a hack to ignore GIT_WORK_TREE if GIT_DIR is set too, but I don't
think people will like it. I don't really like reverting d95138e
(setup: set env $GIT_WORK_TREE when work tree is set, like $GIT_DIR -
2015-06-26) because another bug reappears. So I'm out of options..
--=20
Duy
