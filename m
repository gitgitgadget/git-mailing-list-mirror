From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Git clone fails during pre-commit hook due to GIT_WORK_TREE=.
 (regression 2.5 -> 2.6)
Date: Wed, 25 Nov 2015 21:13:05 +0100
Message-ID: <CACsJy8C7xoV9faGpbn_5XGt-CmCj--fgXaCFR-ngs=-pWUnrCA@mail.gmail.com>
References: <CA+dzEB=2LJXiLSTqyLw8AeHNwdQicwvEiMg=hVEX0-_s1bySpA@mail.gmail.com>
 <CA+dzEB=XiGVFg+AhuJM-jUCPmgZKCJHTp3sinrFt8yzXeC_63Q@mail.gmail.com> <CAGZ79kY=t9SeoXjgeJjfCMD2=6g3JJxDxcnY6JeJCpUqaN+eOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Stefan Beller <sbeller@google.com>
To: Anthony Sottile <asottile@umich.edu>
X-From: git-owner@vger.kernel.org Wed Nov 25 21:13:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a1gRe-0006Yi-Jl
	for gcvg-git-2@plane.gmane.org; Wed, 25 Nov 2015 21:13:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751935AbbKYUNh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Nov 2015 15:13:37 -0500
Received: from mail-lf0-f49.google.com ([209.85.215.49]:35145 "EHLO
	mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751751AbbKYUNg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Nov 2015 15:13:36 -0500
Received: by lfdl133 with SMTP id l133so73711466lfd.2
        for <git@vger.kernel.org>; Wed, 25 Nov 2015 12:13:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=JUk0+XFHA27CXQ5/77He4x/A4XtKIbqY4JjOsMAYG40=;
        b=wvtTDd9L765IO988G0O4x17V/Nx2Hntvjw7SwUb47bbfWymUw2VrM1ADgPVPq32btF
         S9c8IVdRYBC7DAqCbheZqAm0QQ4f7zuf8mzYWV4sWhS8gqxkVOUrHWKaT75zAWcvrmVH
         lwr7MCbo41H5Sr0+6OO/fGKh3VCO+/WY1tHPiRRLTZ6o/g1C6+9BdRcjm+bZmLsL5vOo
         2XU4OYu33D11/XrVokHP6Bg7M5HIX6o0o6dv6AWkVMkQcIRvXKYP09Ejtcx2Y7IVH7N7
         TS+tEY7rRDIxgXisYuw0rs4FtSks8HHYSqoAoNGv23fI5Rm1tJ819QXB6anYY78tXXuz
         D8nA==
X-Received: by 10.25.170.149 with SMTP id t143mr16545961lfe.162.1448482414587;
 Wed, 25 Nov 2015 12:13:34 -0800 (PST)
Received: by 10.112.199.5 with HTTP; Wed, 25 Nov 2015 12:13:05 -0800 (PST)
In-Reply-To: <CAGZ79kY=t9SeoXjgeJjfCMD2=6g3JJxDxcnY6JeJCpUqaN+eOA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281737>

On Tue, Nov 24, 2015 at 6:57 PM, Stefan Beller <sbeller@google.com> wro=
te:
> +to Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>
>
> On Mon, Nov 23, 2015 at 6:22 PM, Anthony Sottile <asottile@umich.edu>=
 wrote:
>> * Short description of the problem *
>>
>> It seems GIT_WORK_DIR is now exported invariantly when calling git
>> hooks such as pre-commit.  If these hooks involve cloning repositori=
es
>> they will not fail due to this exported environment variable.  This
>> was not the case in prior versions (such as v2.5.0).

I'm getting good at fixing one bug and adding ten more. I don't think
the cited commit is the problem. It just exposes another bug. I did

> ~/w/git $ GIT_WORK_TREE=3Dabc ./git clone .git /tmp/def

and what I got was really surprising, /tmp/def contains the git
repository while the true worktree is in "abc". It does not make
sense, at least from the first sight, unless it inherits this from
git-init, where we do(?)  want GIT_WORK_TREE to specify a separate
worktree. No time to dig to the bottom yet..
--=20
Duy
