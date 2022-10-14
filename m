Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B30FC4332F
	for <git@archiver.kernel.org>; Fri, 14 Oct 2022 08:48:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbiJNIsy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Oct 2022 04:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbiJNIsw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2022 04:48:52 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15EBBA3ABD
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 01:48:51 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id r14so5919735edc.7
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 01:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks.biz; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uDzk75+vguEAE4ki3NALCRxZmEVjrJl4C2zVdr3wb3g=;
        b=ZHCll4AqVNe1jsLCK18tWNq1GaGXk4zt2nvLlaLOqhJTHZcVO5Ec44PIatYDY0GA91
         HHBnJJge9gjLPcMxciqrT3yKhDL5QE9sBWM4hM9DeCh9D7PSAP77vxfo7YbzES0fEkmJ
         5WGX7OQiUwWPX3kjWgYIbfI411Q9aimnthnR4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uDzk75+vguEAE4ki3NALCRxZmEVjrJl4C2zVdr3wb3g=;
        b=EvxO/fgmdqZfqG2Kuxt0LFSNyUmI7pGc3HFWkJ2k2JvJwiIaKICrKt9PBPq47QRfEa
         vpMB+7L0II8QKze+/eEOIb2JCT3RHjOd3IYN5dsmyzpkT5hMNULZd2ul2c2/0vh+bK9v
         KunHVukMzGqkPqqKqRDSxya46O6PTSH6XTPyz4vbSERhTGNudWr+A2o3W/F5j6I4gIHS
         K7dC7i7BIWNLpKdlNCZYtmVKCdstwb36htJL8WufGTdvrindWoC5TeP3WPbntHl22LuZ
         dePBU+PiAA+tYZBqePRBHnhevDFu8LlQ9PsOLarBdeRL+krx89davgdY4slezEtWBjsM
         /D+A==
X-Gm-Message-State: ACrzQf1tv1KkIH4x+vl25i680w2+rBBzmGBUvMwUShON32Uz40aSM89S
        fgV4/hMsI8qkt4oryZ4vKQq9FeefdgJRhQZeI2+sPWDGHvDfbBB2
X-Google-Smtp-Source: AMsMyM7mx2HIFIitLSekONf79kf3Bm0YSm2Cv6ZJVIJ/a3fWP+CbPuiabyB7fdF+mddymmUaDqVVVg1r/4bPfdwqrjk=
X-Received: by 2002:a50:ec15:0:b0:458:a612:f751 with SMTP id
 g21-20020a50ec15000000b00458a612f751mr3376013edr.111.1665737329572; Fri, 14
 Oct 2022 01:48:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAPMMpogcnwJDUazw82OB0DvdgvNS6hpUN9Qs69ppTFb1QFbLSg@mail.gmail.com>
 <220930.86r0ztufwd.gmgdl@evledraar.gmail.com> <YznhYzWztkPc9pJk@tapette.crustytoothpaste.net>
 <CAPMMpojy8OMxYT0WuZCOZjwvufmVucvoHPtvLHatopXvuk9K5Q@mail.gmail.com> <CABPp-BHaMCcLjdx2m4CALZQiTRQy_LovWfbdrga6XWhQJhoxWQ@mail.gmail.com>
In-Reply-To: <CABPp-BHaMCcLjdx2m4CALZQiTRQy_LovWfbdrga6XWhQJhoxWQ@mail.gmail.com>
From:   Tao Klerks <tao@klerks.biz>
Date:   Fri, 14 Oct 2022 10:48:37 +0200
Message-ID: <CAPMMpojvDj7Yc27HKQU4seSqg5Tx61RY3LOgMfkK=a0J25QYQw@mail.gmail.com>
Subject: Re: icase pathspec magic support in ls-tree
To:     Elijah Newren <newren@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 14, 2022 at 9:41 AM Elijah Newren <newren@gmail.com> wrote:
>
>
> How exactly would case-insensitive matching in ls-tree help you here?

I just attempted to demonstrate in response to Torsten's email; the
assumption was that I could list the added files' paths in a
case-insensitive pathspec, and thereby get all duplicates fast and
efficiently, for reasonably-sized commits.

(new refs and very large commits would still need a full-tree dupe scan)

> Can't you write a hook without such capability that rejects such
> collisions?

It is possible, but far less convenient and I'm not confident that my
shell scripting abilities will get me to a good place.

That said, having thought about your point, my shell scripting
abilities are more likely to get me to a good place than attempting to
add icase pathspec magic support to ls-tree :)

>
> > I don't see this being something I can take on in my spare time, so
> > for now I suspect I'll have to do a full-tree duplicate-file-search on
> > every ref update, and simply accept the 1-second update hook
> > processing time/delay per pushed ref :(
>
> I don't see why you need to do full-tree with existing options, nor
> why the ls-tree option you want would somehow make it easier to avoid.
> I think you can avoid the full-tree search with something like:
>
> git diff --diff-filter=A --no-renames --name-only $OLDHASH $NEWHASH |
> sed -e s%/[^/]*$%/% | uniq | xargs git ls-tree --name-only $NEWHASH |
> \
>    sort | uniq -i -d
>
> The final "sort | uniq -i -d" is taken from Torsten's suggestion.
>
> The git diff ... xargs git ls-tree section on the first line will
> provide a list of all files (& subdirs) in the same directory as any
> added file.  (Although, it has a blind spot for paths in the toplevel
> directory.)

The theoretical problem with this approach is that it only addresses
case-insensitive-duplicate files, not directories.

Directories have been the problem, in "my" repo, around one-third of
the time - typically someone does a directory rename, and someone else
does a bad merge and reintroduces the old directory.

That said, what "icase pathspec magic" actually *does*, is break down
the pathspec into iteratively more complete paths, level by level,
looking for case-duplicates at each level. That's something I could
presumably do in shell scripting, collecting all the interesting
sub-paths first, and then getting ls-tree to tell me about the
immediate children for each sub-path, doing case-insensitive dupe
searches across children for each of these sub-paths.

ls-tree supporting icase pathspec magic would clearly be more
efficient (I wouldn't need N ls-tree git processes, where N is the
number of sub-paths in the diff), but this should be plenty efficient
for normal commits, with a fallback to the full search

This seems like a sensible direction, I'll have a play.
