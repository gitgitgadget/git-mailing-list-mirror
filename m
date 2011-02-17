From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [RFC/PATCH 0/2] CHERRY_HEAD
Date: Thu, 17 Feb 2011 15:09:40 +0100
Message-ID: <AANLkTikWX-Pzok6MZofMD_=pPSvC5iANbzKbs0wgrZ4Q@mail.gmail.com>
References: <1297805034-3512-1-git-send-email-jaysoffian@gmail.com>
	<AANLkTik2NM+mxKgZy_9dCwydz+An4sFM_a4U9mdrJBq3@mail.gmail.com>
	<AANLkTinV+cY-fND2bemDGdShnfqQGMG3eUmZPXrpKayt@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 17 15:10:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pq4Yt-0001Es-VB
	for gcvg-git-2@lo.gmane.org; Thu, 17 Feb 2011 15:10:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752001Ab1BQOKX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Feb 2011 09:10:23 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:44476 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750733Ab1BQOKW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Feb 2011 09:10:22 -0500
Received: by wyb28 with SMTP id 28so2558965wyb.19
        for <git@vger.kernel.org>; Thu, 17 Feb 2011 06:10:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=tMy8Fc7GObnl8il3ylZSmZA5lJMp46A00WcNzSO0rZg=;
        b=H9syLk7TBl5M1RpgkQxE7LxAMY+gVCIUgtRNR0Nc/05tuDzqRw59/IyI7OZOgxhNrU
         k5KpT+lGdMgVCKfuMiGWdcwKF6f9VjxWQ0/+Ubg2A0swArcTSSxkpEgzNp6txP88Fez6
         NPjgkdbfl7bB2WSTSD/ERr7yfhPPKJ4d+ulWU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=fBu5ouKuPRA8AqILLTiWM40PlumD7yg51wodstDqbe6+XGxggWPXWsgHR1dLAHDhxR
         aNcfg+QSRocKOtkoP0ANWbezSwX3WsHubx8KxojK9lkhsz6xgdnLOAG+2EnLsDgGvD2g
         b11RcRCRUew56cipSbL/VMV+0veo9xZZfJarU=
Received: by 10.216.157.129 with SMTP id o1mr385636wek.59.1297951780988; Thu,
 17 Feb 2011 06:09:40 -0800 (PST)
Received: by 10.216.241.78 with HTTP; Thu, 17 Feb 2011 06:09:40 -0800 (PST)
In-Reply-To: <AANLkTinV+cY-fND2bemDGdShnfqQGMG3eUmZPXrpKayt@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167088>

Hi,

On Tue, Feb 15, 2011 at 11:11 PM, Jay Soffian <jaysoffian@gmail.com> wr=
ote:
> On Tue, Feb 15, 2011 at 4:51 PM, =C6var Arnfj=F6r=F0 Bjarmason
> <avarab@gmail.com> wrote:
>> I've read this over, haven't run it, but I really like the idea. It
>> sucks that you have to save away the commit sha1 somwhere after a
>> failed cherry-pick to use it again. It should just behave like `git
>> rebase --continue`, which this implements.
>
> I agree and I said as much. The problem is that cherry-pick has two
> modes of behavior:
>
> 1. Given a single commit. Historically this was the only way to use
> it. In this case, the behavior after a conflict should be the same as
> after a merge conflict. You resolve the conflicts then use git commit=
=2E
>
> 2. Given a rev-list. This is relatively recent addition to cherry-pic=
k
> (7e2bfd3 revert: allow cherry-picking more than one commit,
> 2010-06-02). Here's where I'd expect to have a more rebase-like
> behavior, using --continue/abort to work through the sequence. But
> frankly, I consider 7e2bfd3 a mistake. I think a better implementatio=
n
> would be to make cherry-pick be plumbing, and re-use rebase's logic
> for walking through the series of commit.

Many people wanted to be able to cherry pick many commits, so it seems
logical to make cherry-pick accept a range of commits.

About the implementation, it's better if it's in C. And it's true that
it would be better if rebase and cherry-pick could use the same logic
and even share the same code, but that's exactly what the goal of the
sequencer project has been.

I started to implement cherry-pick --continue and posted some RFC WIP
patches last november:

http://thread.gmane.org/gmane.comp.version-control.git/162183/focus=3D1=
62197

the goal is to have something that in the end can be reused by rebase,
am and perhaps other commands.

I did some work on it after that, but I got stalled and had not much
time during the last months to move it further. I will see if I can
find time to work on it during the next weeks and/or publish/post the
current state.

> I'd like to do (2) eventually[*] but I think in the mean time this is
> a nice incremental improvement.
>
> [*] is the sequencer project dead?

If you are interested, perhaps you can have a look at what I posted
last november. And if you want to work on it you can ask me to publish
the current state, and eventually base some of your work on that.

Thanks,
Christian.
