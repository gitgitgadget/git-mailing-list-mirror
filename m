Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87AD9C54EBD
	for <git@archiver.kernel.org>; Mon,  9 Jan 2023 20:22:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237580AbjAIUWF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Jan 2023 15:22:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237515AbjAIUV6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2023 15:21:58 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3195F5C1CB
        for <git@vger.kernel.org>; Mon,  9 Jan 2023 12:21:57 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id u9so23198556ejo.0
        for <git@vger.kernel.org>; Mon, 09 Jan 2023 12:21:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/9RLcM4Ur7FnS/4pBtReJJCrtWxkI52SDVtBwrPwnNg=;
        b=ZLMhIq8zpFkDGfzGgM1GIujyFsYhtPUgndp6qhMaL9fFTbYOSpWjMTu5QVrTDYOy5v
         /6yv2UrBPSSlWoEOFEOxLTIKWJtLZs7gROeEC07JdO50bulR0BsSc3Sv26/X9OVb4zk0
         KAcYYdfu5Ss+EsyLeJUF3P7ctF9stY+wTw8Hd4RO39E8d6JTwZ7MB1F4xDp0tBC0wYEE
         /k4qKe9GqGp0vloQEg/6fo/3lVtUFpchb9XH+cVOG8QBKOXYJEvO3OxL9Aip3tujqJAn
         VTkmBgGxG5U+EDnnsqIkFEjxnwXCZgDmUEkqqhIFyCk9kiIHdT86TyxzGllFj/ayRmio
         loAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/9RLcM4Ur7FnS/4pBtReJJCrtWxkI52SDVtBwrPwnNg=;
        b=bZaAiT4jfyDdYyBKvfOhULqW64TTwKeYzcqH2vAWVVibIqqhuirUMhvZInapoBtrsj
         lgQDoj1cenBC9UDmQJ2grRDbUmzDk/Bylb+TfPjY3zgdlr1OdClqHGkXa4dAXXgcCyLm
         lO5a44EHm/SLREXE6vlGrrlFxk4kzzyGZtjAghxq0Y4AA5kyTU92X0e0p3Y4CxrGcbbp
         oIVBmtLQhKAldt0qjFR8FPqQiqEUjfKOSHivEIINygzMMmVm4Yhv725LtVpHbpm5MK26
         CRX2WEWmLitnWYh3OHJpU0WSsWX6kKGLY4DCRKsH/gIhT4oNuUQrMzNKwAmwyrjHCVZX
         TCIQ==
X-Gm-Message-State: AFqh2kphADoZWRoidMTs2eDlp/6VZokqE7alM5eOL8NhQgtUsoeQKdLs
        BWuKCKX1PGCOSrJYTH1kzWmJEuPBCYJ4VApNvtvbLbK+6xM=
X-Google-Smtp-Source: AMrXdXug515mYf7kgNMfYXiG7+1hLRLWQPG33h0lFj4uJhVeM8IKKegKgTIOjNVGNuKMLgwoRqebywxuhX/cN0xN4hc=
X-Received: by 2002:a17:907:9909:b0:829:5c93:f150 with SMTP id
 ka9-20020a170907990900b008295c93f150mr3718208ejc.595.1673295715490; Mon, 09
 Jan 2023 12:21:55 -0800 (PST)
MIME-Version: 1.0
References: <CAHGBnuOcNb0niPThM9gtmoJui+bz1mmhKXjUn71P3Q53aM-HLA@mail.gmail.com>
 <18a11fc5-ab72-a66a-6bef-7e460c762a9c@jeffhostetler.com>
In-Reply-To: <18a11fc5-ab72-a66a-6bef-7e460c762a9c@jeffhostetler.com>
From:   Sebastian Schuberth <sschuberth@gmail.com>
Date:   Mon, 9 Jan 2023 21:21:44 +0100
Message-ID: <CAHGBnuMCBHME6jO9F+tU0sLHTTt+Rtp3ktGyYi2GHQHab+56ZA@mail.gmail.com>
Subject: Re: How to debug "fatal: external diff died, stopping at ..."?
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks Jeff, I meanwhile found out that the diff tool also crashes
independently of its use with Git, and was able to isolate the problem
a bit further using gdb.

-- 
Sebastian Schuberth

On Mon, Jan 9, 2023 at 9:07 PM Jeff Hostetler <git@jeffhostetler.com> wrote:
>
>
>
> On 1/9/23 8:35 AM, Sebastian Schuberth wrote:
> > Hi,
> >
> > similar to this [1] question on StackOverflow, ever since a
> > distribution upgrade of my Fedora Linux box (KDE spin, now on release
> > 37), my configured diff / merge tool (Beyond Compare 4) crashes with
> > "fatal: external diff died, stopping at ..." after displaying the diff
> > for the first file, for every operation I've tried so far (including
> > resolving merge conflicts). I've also posted to the Beyond Compare
> > forums [2], but the people from Scooter Software seem to be clueless
> > as well.
> >
> > Would anyone have an idea how to debug this?
> >
> > PS: I also tried to use an X11 instead of a Wayland session with KDE /
> > Plasma, but that did not help.
> >
> > [1]: https://askubuntu.com/questions/1437667/git-difftool-with-meld-broken-after-update-to-22-04-fatal-external-diff-died
> > [2]: https://forum.scootersoftware.com/forum/beyond-compare-4-discussion/linux-aa/88824-bc4-as-a-git-merge-tool-says-fatal-external-diff-died
> >
>
> You might try turning on Trace2 in Git and see if there is
> any extra info there on the child processes.
>
> $ GIT_TRACE2_PERF=1 git difftool ...
>
> or
>
> $ export GIT_TRACE2_PERF=/absolute/path/to/logfile
> $ git difftool ...
>
> There you'll be able to see all of the "child_start" and
> "child_exit" events for each process that Git starts (at
> the "d1" level (and grandchildren at the "d2" level)).
>
> Maybe that'll reveal something.
>
> https://devblogs.microsoft.com/devops/a-deep-dive-into-git-performance-using-trace2/
>
>
> Hope this helps,
> Jeff
