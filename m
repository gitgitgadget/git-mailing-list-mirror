From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v5 00/14] New remote-hg helper
Date: Tue, 13 Nov 2012 04:45:02 +0100
Message-ID: <CAMP44s3oJhrZ=pdT040uHtN1SmGNQzvvVGGG+W6VfOvch-5qmg@mail.gmail.com>
References: <1351571736-4682-1-git-send-email-felipe.contreras@gmail.com>
	<20121030102526.GN4891@arachsys.com>
	<CAMP44s1g8rFGP7UOcvp9BEZ1oiSh3+-gYheciqO8Fmghipot8A@mail.gmail.com>
	<20121030180021.GX26850@arachsys.com>
	<CAMP44s1-VOetN+e49UgJtpbpwYN2EBVYBzw5j_KoqXu6sbbaHA@mail.gmail.com>
	<20121111221712.GB2774@arachsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Chris Webb <chris@arachsys.com>
X-From: git-owner@vger.kernel.org Tue Nov 13 04:45:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TY7R9-0002wx-O7
	for gcvg-git-2@plane.gmane.org; Tue, 13 Nov 2012 04:45:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752560Ab2KMDpE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2012 22:45:04 -0500
Received: from mail-ob0-f174.google.com ([209.85.214.174]:54390 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751781Ab2KMDpD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2012 22:45:03 -0500
Received: by mail-ob0-f174.google.com with SMTP id uo13so6996881obb.19
        for <git@vger.kernel.org>; Mon, 12 Nov 2012 19:45:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=HXrLyJXyme1jrgHLa4SSnaVdO8tbhHcW6SoGUmdbq2w=;
        b=Wu9Q8i+YiUUaXfFxGaXZEGx6wvDyven2mUxVU5HyI7ANOwRungetcjRljtCxszdnQY
         0mONfA1lnVqbQO2m4rUp6Yov2vMWbHbWLo4O2GfxPVYVSdC+7yWWABGM/aWT8SRe4WZ6
         jI1IhrI7gb5VKLvzzEtlY30cioXSAVUMb9vQ1G/IK+/Nzh6Sn8wcjwZ6+/JRLTkgY0j8
         pFeh8IHx2YhicYN6/+tqywip4DvulkCzCFhYpGafyBeYbQXFheBYUGNglmmKzeoqwziW
         Z21ERy6FnCR6Cfo3O34P51FAWEHSTZ1pK3BbECFlg5Sem794xP3MIdDeBWiRO+zyzcvA
         Rfrw==
Received: by 10.182.235.46 with SMTP id uj14mr16765669obc.40.1352778302779;
 Mon, 12 Nov 2012 19:45:02 -0800 (PST)
Received: by 10.60.4.74 with HTTP; Mon, 12 Nov 2012 19:45:02 -0800 (PST)
In-Reply-To: <20121111221712.GB2774@arachsys.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209564>

On Sun, Nov 11, 2012 at 11:17 PM, Chris Webb <chris@arachsys.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> Implemented now. I'm not handling the 'tip' revision, but most likely
>> it's also the '.' revision. In this case a fake 'master' bookmark will
>> be created to track that revision.
>
> Hi Felipe. Sorry for the slow response, I've been snowed under with work and
> have only just got around to testing your latest version.
>
> The new remote-hg.track-branches=false option is great and does exactly what
> I was hoping for. For the benefit of the list archives, one natural way to
> use it is
>
>   git clone -c remote-hg.track-branches=false hg::foo
>
> when cloning the relevant repositories, if you don't want the setting
> globally for every hg-remote clone.

Cool :)

> During testing, I've seen some strange behaviour which I think is caused by
> using the . revision instead of tip:
>
> $ hg init h
> $ hg init h2
> $ ( cd h && touch foo && hg add foo && hg commit -m foo && hg push ../h2 )
> pushing to ../h2
> searching for changes
> adding changesets
> adding manifests
> adding file changes
> added 1 changesets with 1 changes to 1 files
> $ git clone hg::h g
> Cloning into 'g'...
> $ git clone hg::h2 g2
> Cloning into 'g2'...
> warning: remote HEAD refers to nonexistent ref, unable to checkout.
> $
>
> The reason for this is that by default . == null (not tip) in the repo h2
> which we pushed into from h. The hg equivalent of a bare repo typically has a
> null checkout like this. (Actually, the checkout of HEAD seems to break
> whenever . is different from tip, not just when it's null as in this example.)

Well, I thought in those cases we didn't want HEAD to be updated.
People can still use the repo and checkout whatever branch they want.
But '.' is not  really the equivalent of HEAD. Since there's no
equivalent, I think it makes sense to try first '.', and then 'tip'.
This means that we would never have a HEAD pointing to nowhere.

I've added a patch for that.

Cheers.
-- 
Felipe Contreras
