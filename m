From: Dun Peal <dunpealer@gmail.com>
Subject: Re: $GIT_DIR/info/exclude fails to negate a pattern defined by core.excludesfile
Date: Mon, 13 Oct 2014 09:23:33 -0400
Message-ID: <CAD03jn5s2NzcSDdwZ_SYe1Q1uq8gt+meeJycEcmzAj3SbZOJ4w@mail.gmail.com>
References: <CAD03jn4md9YJZ3fFWmvjiO2KSztc-02QpznXO3LJeiZDz8YhrQ@mail.gmail.com>
	<CACsJy8Aj-_VhiiG9ogoABaGs69TQ+HyEnOVb75UT53W5+YcKVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git ML <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 13 15:23:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XdfbD-0001cs-1e
	for gcvg-git-2@plane.gmane.org; Mon, 13 Oct 2014 15:23:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754570AbaJMNXg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Oct 2014 09:23:36 -0400
Received: from mail-oi0-f49.google.com ([209.85.218.49]:39363 "EHLO
	mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754161AbaJMNXe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Oct 2014 09:23:34 -0400
Received: by mail-oi0-f49.google.com with SMTP id a3so12753975oib.8
        for <git@vger.kernel.org>; Mon, 13 Oct 2014 06:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Yihi36m6VmMP0UVtkj+IO2rOTI8JBIyfMwxXcbTWV1c=;
        b=Pv/LWIYoGaVQl27VK5WLHR5HxyGEp1YP6ubwQ/moNgjjBZmFkNfh4O1ZF9GIceMXuJ
         4Os5Dv4htF3F1OT66r2WuyEDZ2SQiLlXvIYydaAKQsa2Psf507cEF5+EtLfWXKoE/Dgq
         HCfPHqDcYyP1roSoIiSjV/Z055nB5dEIF3HInkr5Z3SKk7NSYqG8ltp2F52I3PwqOk7M
         RoRLEBEfxQc7WBDBvIkeWJpgKRbfcRn1qO8xNHwuRaD57mHoiEvDwedyDGCPfg/4JFDv
         nvdKVCJls8VxpJOHs4VGjM38YwBCi5MWOoZd2JUPAABMXXQ++K/3mxJVvDHFBHHY72JM
         hdPQ==
X-Received: by 10.60.44.168 with SMTP id f8mr2092316oem.51.1413206613788; Mon,
 13 Oct 2014 06:23:33 -0700 (PDT)
Received: by 10.76.33.66 with HTTP; Mon, 13 Oct 2014 06:23:33 -0700 (PDT)
In-Reply-To: <CACsJy8Aj-_VhiiG9ogoABaGs69TQ+HyEnOVb75UT53W5+YcKVg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Duy,

I'm not sure why the pattern would have to be as you describe - I'm
just looking to ignore `*.out` as a general configuration, and disable
it for one specific project, so it would seem a plain `!*.out` should
work.

In any case, I added a `.gitignore` file with the single pattern
`!*.out` at the root of the project, and now .out files are no longer
ignored for the project.

It's not an ideal solution because now all the other developers of the
project who do not have `*.out` in their `core.excludesfile` will have
an unnecessary pattern in their exclusion logic, but it does work as
expected.

Thanks, D.

On Sun, Oct 12, 2014 at 7:53 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Sun, Oct 12, 2014 at 9:58 AM, Dun Peal <dunpealer@gmail.com> wrote:
>> I have the pattern `*.out` defined in my `core.excludesfile`.
>> According to the documentation[1], patterns defined in
>> `$GIT_DIR/info/exclude` take precedence over `core.excludesfile`, so
>> for one particular project that needs to track some `.out` files, I
>> created `$GIT_DIR/info/exclude` with just one pattern: `!*.out`.
>>
>> Yet for some reason, `git status` still fails to report newly created
>> `.out` files for that project. Am I misunderstanding the
>> documentation?
>
> We process in groups, so rules in core.excludesfile are in one group,
> those in $GIT_DIR/info/exclude in another group. Negative patterns
> only has effects within their group, so !*out in .../exclude can't
> revert *.out in core.excludesfile. Probably implementation limitation,
> not by design..
>
> But even if we flatten them into one group, i'm not sure you can
> achieve that. The patterns would be
>
> !*.out
> *.out
>
> "!*.out" has nothing to revert because it's before "*.out".
> --
> Duy
