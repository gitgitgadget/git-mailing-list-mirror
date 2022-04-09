Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E448C433EF
	for <git@archiver.kernel.org>; Sat,  9 Apr 2022 11:32:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241503AbiDILe4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 Apr 2022 07:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232971AbiDILey (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Apr 2022 07:34:54 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 067129F6CF
        for <git@vger.kernel.org>; Sat,  9 Apr 2022 04:32:46 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id A0AA7212C2;
        Sat,  9 Apr 2022 11:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1649503965; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aD3ZB1afckktm7IJ5DABjDSiy9sjON0jAvDtZu2qdS8=;
        b=aMrTzStqrwtVulquBAByrlLvbn2y0t9VT3Y2BfIQ1qL7QbIzSx/MCxDhilYdCtlIP7ucOQ
        sNMxGomvQ7QGrhQdOxfSK7t8QpB9MvF6wov+Vjo4+aJCoR+VQ1P9AixacVMm+DYBIWVMjq
        ZnErTtAXQdoFO0ZQ+8uIeZxYf5ZJey0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1649503965;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aD3ZB1afckktm7IJ5DABjDSiy9sjON0jAvDtZu2qdS8=;
        b=y23itH0Juk5R1nt6ZX+2NYHInC23uTvXMSJD/Ox9XZbN2cnzGSqeG/U0QAMSPX6MmSQjgO
        TDqdEw1r/x6rwsBA==
Received: from kunlun.suse.cz (unknown [10.100.128.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 80D9EA3B83;
        Sat,  9 Apr 2022 11:32:45 +0000 (UTC)
Date:   Sat, 9 Apr 2022 13:32:44 +0200
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     rsbecker@nexbridge.com
Cc:     "'brian m. carlson'" <sandals@crustytoothpaste.net>,
        jurgen_gjoncari@icloud.com, git@vger.kernel.org
Subject: Re: Make commit messages optional
Message-ID: <20220409113244.GX163591@kunlun.suse.cz>
References: <7ED89912-2E10-4356-9C61-14B90EC0719C@icloud.com>
 <YlC3devsgmv17PnQ@camp.crustytoothpaste.net>
 <00ca01d84ba0$dd7ee0c0$987ca240$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <00ca01d84ba0$dd7ee0c0$987ca240$@nexbridge.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 08, 2022 at 07:32:03PM -0400, rsbecker@nexbridge.com wrote:
> On April 8, 2022 6:30 PM, brian m. carlson wrote:
> >On 2022-04-08 at 03:35:04, jurgen_gjoncari@icloud.com wrote:
> >> I think that often commit messages are unnecessary. I propose that by
> >> default a user should be able to commit without a message.
> >
> >This topic comes up from time to time and you can see the previous discu=
ssion in
> >the archives.  The reasons we haven't done this are roughly as follows.
> >
> >First, writing commit messages is a way of communicating to others about=
 your
> >changes, as well as to future you.  In my experience, it is substantiall=
y more
> >important in software engineering to communicate clearly and effectively=
 than it is
> >to write code.  The computer will accept anything that runs, but when yo=
u write
> >code others must read it and change it, and they must have the appropria=
te
> >context behind those changes to evaluate your changes and to make their =
own in
> >the future.
> >We want to encourage good software engineering practices.
> >
> >Tools like git log use the commit message, and empty commit messages mea=
n that
> >viewing the list of commits is completely useless without viewing a diff=
=2E  This
> >means that functionality such as `git log --graph` is just completely br=
oken.  Writing
> >even one line in the commit summary makes a massive difference in the us=
ability
> >of these tools.
> >
> >Users who want this behaviour can use --allow-empty-message or create an=
 alias
> >with that option.  The functionality already exists.  I use aliases exte=
nsively in my
> >development and I know others do as well, so this shouldn't be an impedi=
ment if
> >you're working on projects where this is acceptable.
> >
> >> I don't think this would be a problem from the UX point of view,
> >> because a user could get a lot of information about a change, from the
> >> history of the GitHub repository, such as from the time of change, and
> >> seeing the diff.
> >
> >I certainly hope when you are writing code that you explain your changes
> >somewhere.  I know some people who use pull requests prefer to do so in =
the pull
> >request rather than the commit message, but I for one would never accept=
 a
> >change that doesn't contain some sort of explanation about why it's valu=
able or
> >relevant somewhere.  I am, unfortunately, not omniscient, so I need peop=
le to
> >communicate their intentions and decisions to me, and the best way to do=
 that is
> >with words.
> >
> >I should also point out that the GitHub UI is specifically designed to s=
how the
> >commit summary in the history view, so GitHub intends for you to write a=
t least
> >one line of helpful text (the summary) in this context.
> >
> >Overall, I don't believe your proposal is likely to gain traction here f=
or the reasons I
> >mentioned above, and I personally don't support it.
>=20
> The commit message is an essential part of why a change was made, in part=
icular for forensics when something goes wrong, or when you are trying to f=
igure out why you did something. Without a commit message, you are saying, =
"yeah, ok, something happened." It's up there with reporting a bug saying, =
"It doesn't work", with no additional details - I have customers who do tha=
t, and it is not helpful. To be harsh about it, if someone commits somethin=
g with no or a useless message, I will reject the change with impunity. Not=
 explaining yourself is not helpful to those who come after. It's up there =
with "Why did you not document your code, when you used single letter varia=
bles and strung the whole program on one line because C (or APL) allows it,=
" with an answer along the lines of "Any decent developer should be able to=
 figure out the code." Sorry, but I feel very strongly on the subject that =
this is not a good idea. If you want to put junk in your commit, that is yo=
ur business, but expect a
>   significant segment of the population looking at your repo on GitHub to=
 judge harshly. This sounds more like "I don't want to use a version contro=
l system, but I have to for some reason, like HR metrics." I know I am bein=
g harsh on this, and I apologize in advance for it if I offended anyone, bu=
t I would want a way to disable (potentially at build time) this if it ever=
 went forward.

There is nothing stopping you using '.' as the commit message which is
as informative as when it is empty. Hence this enforcement of non-empty
commit message does not serve the stated purpose.

Sure, if you are merging someone's pull request you can enforce that the
changes are intelliginle by human review but that's not something git
can do automatically.

Also I have an auto-generated git repository of web pages in which every
single commit message is the same. It is not empty because I was too
lazy to figure out how to do that but the effective information value is
the same. And it's in git because the publication system uses git as
backend so there it goes.

Thanks

Michal
