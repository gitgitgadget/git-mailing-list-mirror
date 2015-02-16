From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Experience with Recovering From User Error (And suggestions for improvements)
Date: Mon, 16 Feb 2015 13:10:33 +0100
Message-ID: <CACBZZX7Kjf2owiAyVzRVMs36Vj4-aYVgQ13amiJRHH91HW3RWA@mail.gmail.com>
References: <54E1C96D.2080109@active-4.com> <CACBZZX4NkkMymnG5ZWtO1ya2xzVhxuqh4d3tU2U+mPU49n=m8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Armin Ronacher <armin.ronacher@active-4.com>
X-From: git-owner@vger.kernel.org Mon Feb 16 13:11:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YNKVu-0002fG-Ef
	for gcvg-git-2@plane.gmane.org; Mon, 16 Feb 2015 13:10:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755514AbbBPMKy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 Feb 2015 07:10:54 -0500
Received: from mail-ob0-f175.google.com ([209.85.214.175]:32860 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755240AbbBPMKy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Feb 2015 07:10:54 -0500
Received: by mail-ob0-f175.google.com with SMTP id va2so41544367obc.6
        for <git@vger.kernel.org>; Mon, 16 Feb 2015 04:10:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=BW5t3SCt/mxgmaJWjPFmDB41fWtqZcarbxB+5osmlog=;
        b=sSaXw/WEf8loLtfQ0PcdC9gA5mAdCUACJ15jQOnOVxL38Wcsz9/tofchF9GMX+rp9F
         zu3dK+ZMLq1ONe5JO/Ogr0yDIdwwjG972k72b/CFOghyWKXSbMfC2NWNrFHHPcWGl6Ng
         9XqDMcO+OL0gWOx5pbQjc+k/AqZJzLLn684+yNpTl2LSvtitJ1Kuj1DjZCbUEGPRoXFw
         UDn6ZuB7sND2AxXsBylzr1Dh70AjllCG5jd5jf4JxQyj2O1P1PuJfG/seTQzZhusMvk/
         UhUf/xXT5e7jsls9+bhK5eIIabIAfIghgqOf7PuVuqDpHufUavC3SKFA9VV5IjqqYGVv
         SUcg==
X-Received: by 10.182.68.68 with SMTP id u4mr15063931obt.82.1424088653610;
 Mon, 16 Feb 2015 04:10:53 -0800 (PST)
Received: by 10.76.82.1 with HTTP; Mon, 16 Feb 2015 04:10:33 -0800 (PST)
In-Reply-To: <CACBZZX4NkkMymnG5ZWtO1ya2xzVhxuqh4d3tU2U+mPU49n=m8g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263896>

On Mon, Feb 16, 2015 at 1:09 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> On Mon, Feb 16, 2015 at 11:41 AM, Armin Ronacher
> <armin.ronacher@active-4.com> wrote:
>> Long story short: I failed big time yesterday with accidentally exec=
uting
>> git reset hard in the wrong terminal window but managed to recover m=
y
>> changes from the staging area by manually examining blobs touched re=
cently.
>>
>> After that however I figured I might want to add a precaution for my=
self
>> that would have helped there.  git fsck is quite nice, but unfortuna=
tely it
>> does not help if you do not have a commit.  So I figured it might be=
 nice to
>> create a dangling backup commit before a reset which would have help=
ed me.
>> Unfortunately there is currently no good way to hook into git reset.
>>
>> Things I noticed in the process:
>>
>> *   for recovering blobs, going through the objects itself was more
>>     useful because they were all recent changes and as such I could
>>     order by timestamp.  git fsck will not provide any timestamps
>>     (which generally makes sense, but made it quite useless for me)
>> *   Recovering from blobs is painful, it would be nice if git reset
>>     --hard made a dangling dummy commit before :)
>> *   There is no pre-commit hook which could be used to implement the
>>     previous suggestion.
>>
>> Would it make sense to introduce a `pre-commit` hook for this sort o=
f thing
>> or even create a dummy commit by default?  I did a quick googling ar=
ound and
>> it looks like I was not the first person who made this mistake.  Git=
hub's
>> windows client even creates dangling backup commits in what appears =
to be
>> fixed time intervals.
>>
>> I understand that ultimately this was a user error on my part, but i=
t seems
>> like a small change that could save a lot of frustration.
>
> Something like "can we have a hook for every change in the working
> tree" has come up in the past, but has been defeated by performance
> concerns. "git reset --hard" is a low-level-ish operation, and it's
> really useful to be able to quickly reset the working tree to some
> state no matter what, and without creating extra commits or whatever.
>
> We should definitely make recovery like this harder, but is there a
> reason for why you don't use "git reset --keep" instead of --hard?
> It'll keep any local changes to your index/staging area, and reset th=
e
> files that don't conflict, if there's any conflicts the operation wil=
l
> be aborted.

"Recovery like this easier", i.e. make it easier to get back
previously staged commits / blobs.

> If we created such hooks for "git reset --hard" we'd just need to
> expose some other thing as that low-level operation (and break script=
s
> that already rely on it doing the minimal "yes I want to change the
> tree no matter what" thing), and then we'd just be back to square one
> in a few years when users started using "git reset --really-hard" (or
> whatever the flag would be).
