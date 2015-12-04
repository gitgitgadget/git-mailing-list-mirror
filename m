From: demerphq <demerphq@gmail.com>
Subject: Re: best practices against long git rebase times?
Date: Fri, 4 Dec 2015 18:33:17 +0100
Message-ID: <CANgJU+W2NWX4eK8M7GXu7+kmKsyEriau=_WXO8EEQZinCFTtRg@mail.gmail.com>
References: <20151204150546.GA17210@inner.h.apk.li>
	<CANgJU+Ums-zg1kDiW4mm_X_zxreb=wBVc1gpHUOFN=44x1TyRQ@mail.gmail.com>
	<20151204172851.GQ18913@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Andreas Krey <a.krey@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: John Keeping <john@keeping.me.uk>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 04 18:33:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a4uEY-0007nK-BQ
	for gcvg-git-2@plane.gmane.org; Fri, 04 Dec 2015 18:33:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752288AbbLDRdU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Dec 2015 12:33:20 -0500
Received: from mail-wm0-f43.google.com ([74.125.82.43]:37524 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751687AbbLDRdS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Dec 2015 12:33:18 -0500
Received: by wmww144 with SMTP id w144so74037775wmw.0
        for <git@vger.kernel.org>; Fri, 04 Dec 2015 09:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=At6bOXyxvbFQafXYfsK12UbC/+f6l1X/+VdSJAFgQ1Q=;
        b=htrFbxJ9MKsPV3d16BBw1Mu7iGSY1e07DBkvCe0keOpcrcbN7TJLcjNOH+EuovkCa6
         OI2cnsR3COiE7ctDsnQCawVpkFH6q4KDw02b/77kAsCDQEUAyMYkDMEMPki38LSVoYu3
         nfBjEV7o0i6PdyEG3jT3ODQF3Ufe2pEMdxJEdW0W6/WKNJA/JXil2jcVvUvN0iurfBy/
         8ilN5xdv2zi4hJz0A23zYePGH/2nnEdmxa7z/4Su3uowb0RpI25L+QQC6a03wlndvE1C
         P1uo06Q6ljUCkLR0iNiww4+9YMOQ+DJJ3s4ls3Q58oAAGroLa+cNCD4IpJ8MyWe685Uc
         NB/Q==
X-Received: by 10.28.171.134 with SMTP id u128mr6799489wme.22.1449250397090;
 Fri, 04 Dec 2015 09:33:17 -0800 (PST)
Received: by 10.27.39.70 with HTTP; Fri, 4 Dec 2015 09:33:17 -0800 (PST)
In-Reply-To: <20151204172851.GQ18913@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281990>

On 4 December 2015 at 18:28, John Keeping <john@keeping.me.uk> wrote:
> On Fri, Dec 04, 2015 at 06:09:33PM +0100, demerphq wrote:
>> On 4 December 2015 at 16:05, Andreas Krey <a.krey@gmx.de> wrote:
>> > Hi all,
>> >
>> > our workflow is pretty rebase-free for diverse reasons yet.
>> >
>> > One obstacle now appearing is that rebases simply take
>> > very long - once you might want to do a rebase there are
>> > several hundred commits on the remote branch, and our tree
>> > isn't small either.
>> >
>> > This produces rebase times in the minute range.
>> > I suppose this is because rebase tries to see
>> > if there are new commits in the destination
>> > branch that are identical to one of the local
>> > commits, to be able to skip them. (I didn't
>> > try to verify this hypothesis.)
>> >
>> > What can we do to make this faster?
>>
>> I bet you have a lot of refs; tags, or branches.
>>
>> git rebase performance along with many operations seems to scale
>> proportionately to the number of tags.
>>
>> At $work we create a tag every time we "roll out" a "server type".
>>
>> This produces many tags a day.
>>
>> Over time rebase, and many operations actually, start slowing down to
>> the point of painfulness.
>>
>> The workaround we ended up using was to set up a cron job and related
>> infra that removed old tags.
>>
>> Once we got rid of most of our old tags git became nice to use again.
>
> This is quite surprising.  Were you using packed or loose tags?

It didn't matter.

> It would be interesting to run git-rebase with GIT_TRACE_PERFORMANCE to
> see which subcommand is slow in this particular scenario.

These days it isn't that slow :-)

But I cc'ed Avar, he did the work on that, all I know is when he
finished the tag remover I stopped cursing every time I rebased.

I believe I remember him saying that you can reproduce it using a
public repo by taking the linux repo and creating a tag every 10
commits or so. Once you are done git in many operations will be nice
and slow!

In all fairness however, I do believe that some of the recent changes
to git helped, but I dont how much or which. What I do know is we
still have the cron sweeper process cleaning refs. (It broke one of my
repos that I set up with --reference just the other day).

Yves




-- 
perl -Mre=debug -e "/just|another|perl|hacker/"
