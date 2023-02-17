Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C3E0C61DA4
	for <git@archiver.kernel.org>; Fri, 17 Feb 2023 03:07:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbjBQDHp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Feb 2023 22:07:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbjBQDHn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2023 22:07:43 -0500
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E24C353816
        for <git@vger.kernel.org>; Thu, 16 Feb 2023 19:07:36 -0800 (PST)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-16a7f5b6882so4995205fac.10
        for <git@vger.kernel.org>; Thu, 16 Feb 2023 19:07:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zpAn2Z6XPTbfRI0WR4q9xDdeWBf0y9f9w81WEunfUIo=;
        b=MNGgWhcnKUDYTLGkqVpIjy2emkdOOXKPeumPGHPYfY+YbG1nTIhg1bOCzyFp9brfFw
         d1jniMf5gv3GNfTEEUNQiStUP0RvCMAu+nuZrB3/pyWR8b0CfjPnqtBaKHjmFqR+PlRt
         RNicV332CyxQSCLUz4KBu8WGK7hYkwnsjESoGFxi2pf6/+aH9oyA0iiX47iYvd3CYGg9
         uW8yMhsIQqp6hWlSGiX7dHR9aqJwgIoKohhh5mzGYtJY9yNptm6BtLqBe5jCCFQFubCV
         GoCu8m9po3pRZJ22xPBb3z+e1GNwzRQL+TJ2xjvdk1YwSMxqW2Z805BJsi5a/Rqg7o6C
         Vb0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zpAn2Z6XPTbfRI0WR4q9xDdeWBf0y9f9w81WEunfUIo=;
        b=cZW/cAN/iKRpoUlOASREQYN8s0p5DaT019jsPY2E8OaHLb3I56UcO1XP0Pn+1IWuQb
         Ye3sjJuRf+rLZSpKwsjTRj1/wc63hypSrEP9XoxuIkyUJKYj1daG+404h6i7rws4uExL
         3VZVZmEPiFQa3A6pi7p7SA0U/ctfz+vCwIF8l9xkQbdD9NtrqE1/2/0P7LActCtiNxI8
         C+UFaVaGu4XxdXkOg1E/Cv3FO0BNHcuHGR2Fzda2/oGr4fh7tGNaewuYN/qBqkdNOfZG
         L8NraDzxVURn1dzzowwjqxYEQ0k95mVbYQ8wbJ7aV3lc8Px3N+a2kVH1mctuNcPEqSe7
         xdmw==
X-Gm-Message-State: AO0yUKV1Ee1ZqKAcYBIyYAaXGYU+n271jcekE1vxzDVP2YZxwMYu7Ixl
        YNjSg1d5E0OW8bRXTA4NH2WVIKVx1/uZ5FY0kXPGvqND
X-Google-Smtp-Source: AK7set+6WsV4UELjZI1p63xNIrpQ4ZVkxoXpVSPYXjQeplz75AyDnjnrakku+TuK4tTbeQTkvWeWKjpPtHoCg7Av8dE=
X-Received: by 2002:a05:6870:bb12:b0:16a:cfba:d187 with SMTP id
 nw18-20020a056870bb1200b0016acfbad187mr16319oab.2.1676603255220; Thu, 16 Feb
 2023 19:07:35 -0800 (PST)
MIME-Version: 1.0
References: <20230216041432.1668365-1-alexhenrie24@gmail.com> <xmqqa61dpha9.fsf@gitster.g>
In-Reply-To: <xmqqa61dpha9.fsf@gitster.g>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Thu, 16 Feb 2023 20:07:24 -0700
Message-ID: <CAMMLpeTVvWN0aSB=uTfSoYgJ_CXNYy4tmskdQk5HmKOpB9e+OQ@mail.gmail.com>
Subject: Re: [PATCH] branch: introduce --(no-)has-upstream and --(no-)gone options
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, karthik.188@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 16, 2023 at 12:00 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Alex Henrie <alexhenrie24@gmail.com> writes:
>
> > GitHub and GitLab have features to create a branch using the web
> > interface, then delete the branch after it is merged. That results in a
> > lot of "gone" branches in my local clone, and I frequently find myself
> > typing `git branch -v | grep gone`. I don't want `git branch --merged`
> > because that would include branches that have been created for future
> > work but do not yet have any commits.
>
> I can see why it is a useful feature to filter or group branches by
> its remote tracking status, but I do not know if the design
> presented here is what we want.  "--has-upstream" (yes/no) is
> understandable, but "--no-has-upstream" is quite a mouthful and an
> awkward way to say "no configured upstream" ("--has-no-upstream"
> might be more palatable).  "--gone" does not even hint it is about
> the precense or absense of upstream ("Are we looking for a branch
> that is gone?  Perhaps in a future we may have logs of branches that
> have been deleted?") and will not "click" in readers' mind that it
> is about branches configured to track some branch at the remote that
> has been removed.
>
> Perhaps something like
>
>         --upstream=(configured|unconfigured|gone)
>
> may be easier to explain, understand, and possibly more extensible
> but I dunno.
>
> If most people use a single remote and track branches from the
> single remote, then --upstream=origin to select branches with
> upstream configured somewhere in origin would allow users who
> interact with multiple remotes to further limit by remote.  Or we
> could even go --upstream=refs/remotes/origin/* using ref matching
> rules to specify that chosen branches must have upstream configured
> to refs that match the pattern (your "--has-upstream" becomes a mere
> special case of doing "--upstream=*"), with a special token, e.g.
> "--upstream=no", that never matches a real ref, to select ones
> without any upstream configured.
>
> I do not know offhand how that line of UI design that allows future
> enhancement would mesh with the concept of "configured upstream no
> longer exists", but whatever UI we pick that is understandable,
> explainable and extensible, it should be made to work well with
> "gone", too.

Hi Junio, thank you for the feedback.

I intentionally avoided naming the new option --upstream to avoid
confusion with the -u and --set-upstream-to options. And as you
pointed out, --upstream=(configured|unconfigured|gone) would preclude
adding an optional argument to search for branches with a particular
upstream.

I don't know how we could make the negative options sound better. The
inverses of --merged and --contains are --no-merged and --no-contains
(which also sound a little weird, but are perfectly understandable),
and I think there's value in following the same pattern.

You have a good point that --gone makes it sound like the option
searches for locally deleted branches. How about --upstream-gone
instead?

-Alex
