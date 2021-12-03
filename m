Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7857C433EF
	for <git@archiver.kernel.org>; Fri,  3 Dec 2021 16:52:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382217AbhLCQze convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 3 Dec 2021 11:55:34 -0500
Received: from elephants.elehost.com ([216.66.27.132]:55951 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352889AbhLCQze (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Dec 2021 11:55:34 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from Mazikeen (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [99.229.22.139] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 1B3Gq7sK040857
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 3 Dec 2021 11:52:07 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Loic Fouray'" <loic@yeplaa.net>
Cc:     <git@vger.kernel.org>
References: <008001d7e6ad$a155e290$e401a7b0$@nexbridge.com> <C1412C97-E67D-44F0-AC40-2FB723AFD017@yeplaa.net>
In-Reply-To: <C1412C97-E67D-44F0-AC40-2FB723AFD017@yeplaa.net>
Subject: RE: Merge conflict when lines next to each other are changed
Date:   Fri, 3 Dec 2021 11:52:02 -0500
Organization: Nexbridge Inc.
Message-ID: <006001d7e866$1bd374b0$537a5e10$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQGj38bjHIvLgEDcmNMroe5cXBmSkQH2KLWjrHlZlPA=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On December 3, 2021 11:30 AM, Loic Fouray wrote:
> > Le 1 déc. 2021 à 13:19, rsbecker@nexbridge.com a écrit :
> >
> > ﻿On December 1, 2021 4:30 AM, Loic Fouray wrote:
> >> In a file, I have this 2 lines one below the other:
> >>
> >> Repository: myvalue
> >> Tag: 8.2.10
> >>
> >> On my local branch i have updated repository myvalue.
> >> On the upstream repo, they updated often the tag value (not updated
> >> of my side).
> >>
> >> When i perform a merge from upstream to local branch, i have a conflit.
> >> It seems that it’s related to neighboring lines.
> >> Could you confirm that it ‘s a normal git operation?
> >>
> >> Also, i need to automate this merge. Is It possible with git tools to
> >> avoid this conflict or to resolve this conflict automatically?
> >
> > I try to keep version-specific identifying information, which is already
> contained in git, out of my code. This includes change logs/history in each
> source file because git is good at keeping that information - it is redundant in
> the code. However, for organizations that need to do that, I suggest using
> clean/smudge filters so that the code inside the repository is clean, while
> things like the repo name and tag get injected into the code as git puts it into
> the working directory. The code is then cleaned up while being staged. This
> removes the possibility of the conflict on these lines by removing the
> differing lines. You can script this using a combination of sed and git
> commands. My own git front end does this all the time but it is not generally
> applicable to all platforms (only NonStop and MVS) so I have not contributed
> it.
> >

> Regarding the clean/smudge filters usage, do you know if this filters could be
> triggered by the merge git? Indeed, it would good if the change performed
> by the filters could be integrated with the merge commit.
>

I do not think my point came across. The idea is that the merge should not even see the lines that are causing the conflict because they are not in the file. Your file should have something like the following inside:

Repo: $repo$
Tag: $tag$

A smudge filter can replace the $repo$ with your repository name, and $tag$ with whatever appropriate tag is. A clean filter would remove the conflicting content so merge would never see it.

If you are going to change the same line in each version just to identify that the version changed, you are always going to get conflicts.

[DO NOT DO THE FOLLOWNG] It is like doing the following:

Commit abc1213:

   Line1: This is version 1.0.

Commit 3533adf:

   Line1: This is version 1.1.

This is not how git is intended to be used, in my view.

-Randall

P.S. Please put your responses at the end on this mailing list.

