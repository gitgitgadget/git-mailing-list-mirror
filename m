From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: refspecs with '*' as part of pattern
Date: Mon, 6 Jul 2015 16:39:02 -0700
Message-ID: <CA+P7+xqaiKnFs1rThc3RMt=UJT4whmMdE9sBDtstbx6oxx08Xg@mail.gmail.com>
References: <CA+P7+xoosLG3J5uUVakzwYoxVARs-NH4BJBtsMgw2NB39vyE6A@mail.gmail.com>
 <xmqqzj38yjpg.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Daniel Barkalow <barkalow@iabervon.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 07 01:39:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCFyy-0004UL-KR
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jul 2015 01:39:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755610AbbGFXjY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jul 2015 19:39:24 -0400
Received: from mail-oi0-f53.google.com ([209.85.218.53]:36618 "EHLO
	mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751862AbbGFXjW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jul 2015 19:39:22 -0400
Received: by oiaf66 with SMTP id f66so97887789oia.3
        for <git@vger.kernel.org>; Mon, 06 Jul 2015 16:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=BWKJBBy0wLt7Y/fVX3PxwMbo3KpZhTR6r+jmhqUBxmE=;
        b=H5Rvp8x6TEyw8SqWJlJZsb08B8ohUGb1FqvCx1clQZEvnITclz9xcG0P8HfCbicdj2
         PnBOizPyerAnDy7J0HLzORwQT0Q4Xd3e1st0kEaCtSLVwH+FcRFZn2tah2o3+GDc+JnP
         FamG3hoX9DOsWOxgMYrKknbZ1rXwdekGJaH5ydIDiT+0IgGyAjdAzkqSgX9WoV7lblH7
         vM0qMJOg2YxyHylP0XNggL21L/JA7W43cdWicDJmZEZcUi12mACsuObggq8uH9QjlAem
         5K1Mpt6ww6TNXryyiwgiGKxtKg11uBGXz+/eITrHi/J+PvFD6OPk6oS13X6EWbmYXCu8
         SdKA==
X-Received: by 10.182.246.136 with SMTP id xw8mr1214544obc.29.1436225962161;
 Mon, 06 Jul 2015 16:39:22 -0700 (PDT)
Received: by 10.76.174.8 with HTTP; Mon, 6 Jul 2015 16:39:02 -0700 (PDT)
In-Reply-To: <xmqqzj38yjpg.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273470>

On Mon, Jul 6, 2015 at 4:01 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jacob Keller <jacob.keller@gmail.com> writes:
>
>> What is the reason for not allowing slightly more arbitrary
>> expressions? Obviously no more than one *...
>
> I cannot seem to be able to find related discussions around that
> patch, so this is only my guess, but I suspect that this is to
> discourage people from doing something like:
>
>         refs/tags/*:refs/tags/foo-*
>
> which would open can of worms (e.g. imagine you fetch with that
> pathspec and then push with refs/tags/*:refs/tags/* back there;
> would you now get foo-v1.0.0 and foo-foo-v1.0.0 for their v1.0.0
> tag?) we'd prefer not having to worry about.
>
>
>

That is what I assumed. Would some sort of fetch option you could set
in gitconfig be acceptable? Or possibly extending code to verify that
it doesn't do something too silly? Like extend it to verify that the
per-section path is actually the same?

Today you can get a similar issue with

refs/tags/*:refs/tags/foo/*

It just is easier to fix since they're all name-spaced into foo instead.

The issue I have is that I only want to download specific tag format,
instead of all tags.. Maybe there is a better way to handle this?

Basically, the automated build software that my team uses (I don't
have a choice here) generates tags like

scm_063015_050528

and then I re-generate human readable tags based on information so
they look like

driver-name-0-16-3

I don't want to ever pull scm_* tags because these are useless. I have
tried very much to change the behavior of the team running the build
software, but they refuse to budge (as this software works against
CVS/SVN etc, and supports some older work, and they don't want to
special case it if they can avoid it).

Basically, all I see in my git tags are useless scm tags, and I want
to not download them ever. (so that they don't show up as possible
refs at all)

Is there a possible better solution to this?

Regards,
Jake
