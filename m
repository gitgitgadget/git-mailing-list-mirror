From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: .gitignore sub-dir exclusions not overriding '*'
Date: Thu, 20 Nov 2014 08:26:42 +0700
Message-ID: <CACsJy8Cfg5eEoJb3zvPKoTjC8ZX-2ptggTUo_6yFz+q+-rqAnA@mail.gmail.com>
References: <20141119034010.GA18145@tower.spodhuis.org> <CACsJy8BHvucnEAW065OXOe5NBQkxp7+8HJb7XCGYgOa=pkxLVA@mail.gmail.com>
 <20141119234136.GA53731@tower.spodhuis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Phil Pennock <phil-gitml@phil.spodhuis.org>
X-From: git-owner@vger.kernel.org Thu Nov 20 02:27:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XrGWj-0000r3-PI
	for gcvg-git-2@plane.gmane.org; Thu, 20 Nov 2014 02:27:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754910AbaKTB1O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Nov 2014 20:27:14 -0500
Received: from mail-ie0-f182.google.com ([209.85.223.182]:44582 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754001AbaKTB1N (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Nov 2014 20:27:13 -0500
Received: by mail-ie0-f182.google.com with SMTP id x19so1845661ier.27
        for <git@vger.kernel.org>; Wed, 19 Nov 2014 17:27:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=kiPTaAVWhDF5xDLnZoYGn5bNsenp89Cr5RTItqf0p3k=;
        b=Z950muicUGfMblIA3xnm4Kqi2PrIcgym3armKqqdsQUiC2XM4Sj9h/0USK4tynpcsa
         7dLVCyLkhpVdRJeLRnl6wX6V+WdZli/rUft3nHskWhECaCuQthuRC6GgF9BYIBFQ6YAC
         wUtv4iYvNWcbl8mTqHY6dJDYvA8GqcOmdN4jKEL2Jmli8SxnEPbLopgC9wRpxdZjtbQ5
         dGUJdZsZvIPqURpDjDsVp97YbBDrSwdvmO/V0l0mW4ftSRZ8IRDTmIXstrfWGuIOrspQ
         b/Y7t0ZWxMGFS9qG/QPgFLvs5rtUImcLs0rQpRJz6Nepv38cZLtYvTcwZuPOvBNlJrBm
         ekbg==
X-Received: by 10.43.170.134 with SMTP id nq6mr5551648icc.30.1416446833060;
 Wed, 19 Nov 2014 17:27:13 -0800 (PST)
Received: by 10.107.176.8 with HTTP; Wed, 19 Nov 2014 17:26:42 -0800 (PST)
In-Reply-To: <20141119234136.GA53731@tower.spodhuis.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 20, 2014 at 6:41 AM, Phil Pennock
<phil-gitml@phil.spodhuis.org> wrote:
> On 2014-11-19 at 16:48 +0700, Duy Nguyen wrote:
>> On Wed, Nov 19, 2014 at 10:40 AM, Phil Pennock
>> <phil-gitml@phil.spodhuis.org> wrote:
>> > Expected to work as .gitignore in top-level of repo:
>> >
>> >     *
>> >     !**/*.asc
>> >     !.gitignore
>> >
>>
>> gitignore man page has this "It is not possible to re-include a file
>> if a parent directory of that file is excluded". In this case,
>> directory "foo" is ignored by "*". Although it makes sense for this
>> particular case to re-include something in foo because we can clearly
>> see there are rules to re-include. It's on my todo list, but I don't
>> know when it will be implemented.
>
> Thanks for this and the patches and discussion which follow.
>
> I didn't cover it in my report, but one of the scenarios I tried was to
> explicitly re-include directories, to make them candidates again, and
> either use directory-matching patterns in the top-level .gitignore or to
> use per-directory .gitignore to handle those directories.
>
> Looking fresh today, I see that I failed to compare baseline behaviour
> without a .gitignore when using `git status` as a baseline for
> comparison.  So a .gitignore like this:
>
>     *
>     !*/
>     !*.asc
>
> appeared to not work; even within the `foo/` sub-directory, `git status`
> shows no candidates for inclusion.  But this is true even without a
> .gitignore.  *sigh*

I should have read this mail before replying to Junio in the other
email :( Yeah the "!*/" would re-include dirs back. I'm not sure if
there are any side effects by doing this, no time to think about this
yet. Maybe we can put this in the example section in gitignore man
page with more explanation.

> In fact, it looks like the simple three lines above work, without any
> .gitignore in sub-directories.
>
> The behaviour which confused me between this simplified test-case and
> the original was that `git status` shows files in the top-level
> directory which are untracked, and in untracked files sub-directories
> where some other file in that directory is already tracked, but if no
> file in the sub-directory is already tracked, then `git status` does not
> report the files for inclusion, even if the cwd is inside that
> directory.
>
> I tied myself in knots trying to avoid adding unencrypted files to the
> repo.
>
> Thanks,
> -Phil



-- 
Duy
