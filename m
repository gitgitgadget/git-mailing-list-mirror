Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDFEEC433EF
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 02:29:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C564460E97
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 02:29:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234984AbhKICc2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Nov 2021 21:32:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbhKICc0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Nov 2021 21:32:26 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61740C061570
        for <git@vger.kernel.org>; Mon,  8 Nov 2021 18:29:41 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id x15so39322682edv.1
        for <git@vger.kernel.org>; Mon, 08 Nov 2021 18:29:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=9Ox1kL3WvJjICXk9jozkP9DxLvAiw6CYT/AE2RN3Pks=;
        b=gkw6CZ0I5Gei4e21ne56+ru2b8RSsmXHX7fVkCgvCFj74IZJewUZwssVAu1RBckd3b
         KLxiXWqK8HWO/xu2PbPGDFgDuAgWAn9wsVi0wjkNVRUAGsdOn1WGNcIr890cNeg6WWMk
         RSd06qrVhKyJCZo9CcHzaS7ZZPPspFtwkuAciAzKKqi10ku010JWPaQD87DBGHOIFa8H
         IUuas+27Z0YRFH4IjmBKCrCGqf52nYxBa6BCWtybmB21krlN+0P6ttG/AbvdrrpvePTY
         RbQoXIl0Qkwv8J8umooyD5YyX0C+gzZLlQmRG8Nmc5nSKH2buQfSLbMhNTJ31mJKOQeT
         nlHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=9Ox1kL3WvJjICXk9jozkP9DxLvAiw6CYT/AE2RN3Pks=;
        b=5Kxul3yLTjX7VN1NTRMCwb7JTx5axD2YLYCdOZHN0YvrDempAVgVFn3BEailV6eHHJ
         kiWadC/h/AWn4sTqqK8i40lolUo/Ykq41BESnAnkEWw48Zq/M2DzQkHbWZVOOdRYrKp1
         l74toJTcAJYLgkbEbae3R4V/OG4D6GQbHfJUROGUGtUtuDhV5JanexexVR0avNKWBSA4
         90l6wmpCyM7gmoh/KbL3EP7o7HJFFMG31Kulw1ed/YAA4rnfuQKzDDY9x1pVQl++qPGx
         RK4MBU131QCwrmIFaCrJClO78+20Ac1512AxcWTG57SEc5qFvQiGOiSUxtY9hzlsbXUf
         uOfA==
X-Gm-Message-State: AOAM531WOvKy/7vBi9UHu7F8fZkcnzL+g/mNYjGH9HFAxswTj7iW7G6F
        MWtpxF/m2/GMdMvHIcyirOY=
X-Google-Smtp-Source: ABdhPJwosXeStwS+aM9Jq582G+V+w9NSxm1BtjXVioYeQGQ7pkt1fCfnD/UACiCrkhLWpKh1I48k3g==
X-Received: by 2002:a05:6402:1d48:: with SMTP id dz8mr5312323edb.86.1636424979897;
        Mon, 08 Nov 2021 18:29:39 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id ne33sm8905223ejc.6.2021.11.08.18.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 18:29:39 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mkGtH-001Jni-3V;
        Tue, 09 Nov 2021 03:29:39 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>, git@vger.kernel.org
Subject: Re: [Summit topic] Server-side merge/rebase: needs and wants?
Date:   Tue, 09 Nov 2021 03:15:50 +0100
References: <nycvar.QRO.7.76.6.2110211129130.56@tvgsbejvaqbjf.bet>
 <nycvar.QRO.7.76.6.2110211147490.56@tvgsbejvaqbjf.bet>
 <YYlqpuzv+bmZaFzz@nand.local>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.6
In-reply-to: <YYlqpuzv+bmZaFzz@nand.local>
Message-ID: <211109.861r3qdpt8.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Nov 08 2021, Taylor Blau wrote:

> I was discussing this with Elijah today in IRC. I thought that I sent
> the following message to the list, but somehow dropped it from the CC
> list, and only sent it to Elijah and Johannes.
>
> Here it is in its entirety, this time copying the list.
>
> n Thu, Oct 21, 2021 at 01:56:06PM +0200, Johannes Schindelin wrote:
>>  5.  The challenge is not necessarily the technical challenges, but the =
UX for
>>      server tools that live =E2=80=9Cabove=E2=80=9D the git executable.
>>
>>      1. What kind of output is needed? Machine-readable error messages?
>>
>>      2. What Git objects must be created: a tree? A commit?
>>
>>      3. How to handle, report, and store conflicts? Index is not typical=
ly
>>         available on the server.
>
> I looked a little bit more into what GitHub would need in order to make
> the switch. For background, we currently perform merges and rebases
> using libgit2 as the backend, for the obvious reason which is that in a
> pre-ORT world we could not write an intermediate result without having
> an index around.
>
> (As a fun aside, we used to expand our bare copy of a repository into a
> temporary working directory, perform the merge there, and then delete
> the directory. We definitely don't do that anymore ;)).
>
> It looks like our current libgit2 usage more-or-less returns an
> (object_id, list<file>) tuple, where:
>
>   - a non-NULL object_id is the result of a successful (i.e.,
>     conflict-free) merge; specifically the oid of the resulting root
>     tree
>
>   - a NULL object_id and a non-empty list of files indicates that the
>     merge could not be completed without manual conflict resolution, and
>     the list of files indicates where the conflicts were
>
> When we try to process a conflicted merge, we display the list of files
> where conflicts were present in the web UI. We do have a UI to resolve
> conflicts, but we populate the contents of that UI by telling libgit2 to
> perform the same merge on *just that file*, and writing out the file
> with its conflict markers as the result (and sending that result out to
> a web editor).
>
> So I think an ORT-powered server-side merge would have to be able to:
>
>   - write out the contents of a merge (with a tree, not a commit), and
>     indicate whether or not that merge was successful with an exit code
>
>   - write out the list of files that had conflicts upon failure
>
> Given my limited knowledge of the ORT implementation, it seems like
> writing out the conflicts themselves would be pretty easy. But GitHub
> probably wouldn't use it, or at least not immediately, since we rely
> heavily on being able to recreate the conflicts file-by-file as they are
> needed.
>
> Anyway, I happened to be looking into all of this during the summit, but
> never wrote any of it down. So I figured that this might be helpful in
> case folks are interested in pursuing this further. If so, let me know
> if there are any other questions about what GitHub might want on the
> backend, and I'll try to answer as best I can.

That's very informative, thanks.

Not that "ort" won't me much better at this, but FWIW git-merge-tree
sort of gets most of the way-ish to what you're describing already in
terms of a command interface.

I.e. I'm not the first or last to have (not for anything serious)
implement a dry-run bare-repo merge with something like:

    git merge-tree origin/master git-for-windows/main origin/seen >diff
    # Better regex needed, but basically this
    grep "^\+<<<<<<< \.our$" diff && conflict=3Dt

So with some parsing of that command output you can get a diff with one
side or the other applied.

From there it's a matter of applying the patch, and from there you'd get
blobs/trees. which is painful from just having a diff & no index, so
it's a common use-case of libgit2 for just such basic usage.

But to the extent that we were talking about plumbing interfaces
wouldn't basically a git-merge-tree on steroids (or extension thereof)
do, i.e.:

 * Ask it to merge X heads, returns whether it worked or not
 * ... and can return a diff with conflict markers like this
 * ... for just some <pathspec>
 * ... maybe with the conflict already "resolved" one way or the other?
 * ... optionally, after some markers write one/both sides, spew out the
   relevant tree/blob OIDs
 * ... which again, could be limited by the <pathspec> above.

I'm thinking of something that basically works like git for-each-ref --form=
at=3D"". So:

    git merge-tree --format=3D"..." <heads> -- <pathspec>

Where that <format> can be custom \0-delimited (or whatever) sections of
payload that could have whatever combination of the above you'd need. I
think git-for-each-ref is probably the best example we've got of a
plumbing interface in this category, i.e. being able to extract
arbitrary payloads via format specifiers & "path" (well, ref)
limitation.

Elijah probably has much better ideas already, I'm just spitballing.=20

But if something like that worked it would be mostly a matter of
stealing code from for-each-ref and the like, and then the <handwaiving>
mapping that to ORT callbacks somehow.

And then it could even learn a --batch mode, which with those formats
could allow calling it without paying the price for command
re-invocation, something like the update-ref/proposed cat-file interface
discussed in another thread at [1].

1. https://lore.kernel.org/git/211106.86k0hmgc8q.gmgdl@evledraar.gmail.com/
