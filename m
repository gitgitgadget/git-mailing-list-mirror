From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Newbie grief
Date: Fri, 4 May 2012 21:13:09 +0200
Message-ID: <CAMP44s34RDcPejbGXzThvE8VGGgZOQRx=0yMogk03D7T664+kw@mail.gmail.com>
References: <4F9F128C.5020304@palm.com>
	<201204302331.q3UNVo7o032303@no.baka.org>
	<4F9F3919.6060805@palm.com>
	<CAMK1S_jwVsyKrGoL5uVAiuRrOa8bz79-DAueBmHZE2k=PpcJ2Q@mail.gmail.com>
	<20120501111415.GD5769@thunk.org>
	<CAMK1S_jN_WdZF4W4szzyJqLfC3FmnhKQ65XQiD-JS_jxwSm8_g@mail.gmail.com>
	<4FA02830.3040407@palm.com>
	<86havzoi8h.fsf@red.stonehenge.com>
	<4FA04D02.6090702@palm.com>
	<86mx5rmx32.fsf@red.stonehenge.com>
	<4FA055D0.7040102@palm.com>
	<CAMP44s2h4EY3Qu2+Ys_n3TUzmyykMkG-wMoqmKg5hjg24JQ+bg@mail.gmail.com>
	<4FA2D565.1080806@palm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "Randal L. Schwartz" <merlyn@stonehenge.com>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	"Ted Ts'o" <tytso@mit.edu>, Seth Robertson <in-gitvger@baka.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Rich Pixley <rich.pixley@palm.com>
X-From: git-owner@vger.kernel.org Fri May 04 21:13:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQNwJ-0002Tu-TF
	for gcvg-git-2@plane.gmane.org; Fri, 04 May 2012 21:13:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753601Ab2EDTNL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 May 2012 15:13:11 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:37265 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753285Ab2EDTNK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2012 15:13:10 -0400
Received: by wibhr7 with SMTP id hr7so1679343wib.1
        for <git@vger.kernel.org>; Fri, 04 May 2012 12:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Vpgifxl7kUP17k8KBn7D6xE3rl13D11NbBsetQaO1QU=;
        b=OHiRJc6d7lbzHlHFxyxjn0mgisytNcDHEgr1RRCpbSVNbgbHZW39iezpD6CHPfkb/q
         VfM3BMbcy6UIq9vbng+4WsJsB2yB0FZXgYLZ760oAVeoRLz/g4YgeIKE59hsBAFCLIF9
         pTu40IfFx6iqtABBwQ0Xg41Z0orHo6dNJlALG2TvBI4qv3dPlLrpRxyO8v05GtHA+IwK
         fgY3Eabf/IiqfZUYR+vL+GJ2XT0Qonldnlmry2KMnMLHKPBuNBkXbMLf3Gi24l3snwaQ
         j97lbDdC1CyfEQswnYbuLzTq2XxFAWzUNPFI4wgkvfVPMaO/4nTjnsEG1hAzPhF+HBS7
         rr3w==
Received: by 10.180.99.72 with SMTP id eo8mr14836867wib.10.1336158789606; Fri,
 04 May 2012 12:13:09 -0700 (PDT)
Received: by 10.216.124.197 with HTTP; Fri, 4 May 2012 12:13:09 -0700 (PDT)
In-Reply-To: <4FA2D565.1080806@palm.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197051>

On Thu, May 3, 2012 at 8:58 PM, Rich Pixley <rich.pixley@palm.com> wrote:
> On 5/1/12 16:30 , Felipe Contreras wrote:
>>
>> Show all the hg commands of what you are trying to do, and we can show
>> you how you can achieve the same in git, but much more easily.
>
> hg init foo
> for i in `yes | head -4000`; do (set -x ; d=`date +%s.%N` ; hg clone foo
> foo-$d; (cd foo-$d && date > bar && hg add bar && hg ci -m $d)); done
> for i in foo-*; do (set -x ; (cd $i && hg push -f)); done

Well, that's your problem right there; you are doing something totally stupid.

Even the mercurial documentation tells you so:

---
By default, push will not allow creation of new heads at the
destination, since multiple heads would make it unclear which head to
use. In this situation, it is recommended to pull and merge before
pushing.
---

The git way (which happens to be the mercurial way too), is to fetch
and merge (pull) before pushing:

do_commit() { (cd $1 && date +%N > bar && git add bar && git commit -m "$2") ;}
git init foo; do_commit foo "Initial commit"
for i in $(seq 1 10); do git clone foo foo-$i; do_commit foo-$i $i; done
for i in foo-*; do (set -x; (cd $i && git pull -s ours --no-edit; git
push)); done

Do you seriously think it makes sense to have 4000 people doing
independent development on 4000 different lines of development all
ignoring each other? Which of the 4000 heads would you pick to test
this "branch"? Who is going to do the merge of these 4000 heads?

This is a recipe for disaster.

You prefer a DVCS that allows you to do stupid stuff, well that's your
choice, but don't blame git for making it difficult for you to do
stupid stuff. You should stop doing that and follow the git/mercurial
way; fetch/pull, merge, and push.

Cheers.

-- 
Felipe Contreras
