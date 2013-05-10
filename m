From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: git clone --depth and git describe
Date: Fri, 10 May 2013 17:48:16 +0700
Message-ID: <CACsJy8CsB06LTzGsEyM7FGeazq9BiYsbA4_JyiMa_SwPSMHV_Q@mail.gmail.com>
References: <201305100107.59115.sweet_f_a@gmx.de> <CACsJy8D=getgkDV9A57=_N+u-XPPy8Cxdx5W+QADnCiGZxFRWQ@mail.gmail.com>
 <201305101042.04232.sweet_f_a@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Ruediger Meier <sweet_f_a@gmx.de>
X-From: git-owner@vger.kernel.org Fri May 10 12:48:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uaksd-0001W9-KZ
	for gcvg-git-2@plane.gmane.org; Fri, 10 May 2013 12:48:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751576Ab3EJKss (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 May 2013 06:48:48 -0400
Received: from mail-oa0-f48.google.com ([209.85.219.48]:37405 "EHLO
	mail-oa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751141Ab3EJKsr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 May 2013 06:48:47 -0400
Received: by mail-oa0-f48.google.com with SMTP id i4so4613102oah.7
        for <git@vger.kernel.org>; Fri, 10 May 2013 03:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=rY7R9o7m2Me/UotEttGJn9QefOqzr3lIUKLY4QoaI8E=;
        b=zJ/Pr+7L2VzH21OM/DddlTzBNy/qvoQoNTwO+q2b9ZVC1qWLU4VxmIwbVBeZEFURp3
         chUjlwJXZJx27TGRfeKlPVibxDVvds1o8owUkSg9Rx+MtMr4gufeRYQmGIl2GAql30DQ
         Mfu23mAJGRFNc9ee+MvsZrp88WXz6NFdjQ/bgLn3dqO78wxgO73dfVafvOSon/anAIiP
         ghLOXbgumYTJz4i/jHHDjmZem55FJxxeV17rZ1TUvCVakmzX2xkYglQ8cLGAq7o5EZd3
         YTYXwpaEetN+uj5gMV8M1Mmr1+8067xKIBCtTwSRjau+32GR1L7DCmic9yr9Uhxjigy1
         HJCQ==
X-Received: by 10.182.224.162 with SMTP id rd2mr6549628obc.95.1368182926602;
 Fri, 10 May 2013 03:48:46 -0700 (PDT)
Received: by 10.76.180.138 with HTTP; Fri, 10 May 2013 03:48:16 -0700 (PDT)
In-Reply-To: <201305101042.04232.sweet_f_a@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223832>

On Fri, May 10, 2013 at 3:42 PM, Ruediger Meier <sweet_f_a@gmx.de> wrote:
> On Friday 10 May 2013, Duy Nguyen wrote:
>> On Fri, May 10, 2013 at 6:07 AM, Ruediger Meier <sweet_f_a@gmx.de>
> wrote:
>> > Hi,
>> >
>> > I have a use case where I'd like to improve performance using "git
>> > clone --depth". But I also need "git describe" working on that
>> > clone.
>> >
>> > So something like
>> >  git clone --depth=describable
>> > would be nice to have.
>>
>> What does --depth=describable do?
>
> I mean automatically getting the minimum depth which gives us the
> history back to the last (annotated) tag. So that "git describe" and
> possibly other project specific administrative scripts (like
> git-version-gen or gitlog-to-changelog) would work safely on that
> shallow clone.

That should be possible to do. But you need to define it more clearly
if you start working on it. If you set --depth=v1.7.0, but another
branch in the source repo does not cross v1.7.0, what should we get?
Full history of that branch?

Just thinking out loud. We could make git-describe work with fixed
depth (e.g. --depth=12). The server could be made to send the client
some extended sha-1 syntax to get to related tags from the cut points,
e.g. v1.7.0 = <cut point>~12^2~14^1~20. And git-describe could be
modified to make use of that information when it traverses down to the
cut point. But I'm not sure if it's worth doing.

> Or maybe --depth could just generally accept a revspec as argument
> instead of number only. This would be more useful anyway IMO. Then
> perhaps something like "last_tag" could be a general magic revspec,
> probably useful for many other git commands too.

revspec is probably overkill. Take a look at
shallow.c:get_shallow_commits(). "cut at the first found tag" should
be easy to do, I think.
--
Duy
