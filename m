Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3285C54EBE
	for <git@archiver.kernel.org>; Thu, 12 Jan 2023 18:31:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240150AbjALSbi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Jan 2023 13:31:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234657AbjALSaq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2023 13:30:46 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84D7977ADD
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 10:04:24 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id n5so19640300ljc.9
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 10:04:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FJXeG+N9RR9a9eKfGzz4KVfkvNVDMbiAJsWntDNVfsE=;
        b=dWItSTiAw1PqTUJMWV7AxaS/QPPaay3saZPURynU0U7StBByoCV7JY2XG5dsLve6Z/
         O/JHl/Q/bCCsyNl4PKj/zz6IKw3Y7vWvKftsDGVvOOSQqddiqjMEwkxzBcHNxsnopnvk
         ZreIrAKO2nL0NCZ248D+f3J7qMbznQ1rL826/10BkFz9hMtm64Ki1rNxyBjcMgR4GyP7
         fgKStJeuchlO7pZk2C233hArUWRN728aDR3lu/5+gxcSLUR2oTQhiaVE0IO86YFUXAO1
         jbgQvz5PhGGLh84DnJfBcGQ1EUXI+VCMbx+M3aN0HrmzExdOLWdl81Si0HnRalDCHrSI
         GoFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FJXeG+N9RR9a9eKfGzz4KVfkvNVDMbiAJsWntDNVfsE=;
        b=ZTo/C3Ye/r0aGyGkF+YVWwmH0TS59Bo8QhMjzci+yQXpx7aco9H6WwPgWAeUHIJyri
         BiKJQDOCyMn+AwSx6F7yLwqgWO7Vzce0sMjRAjKft09xzLrHCjmeAprbjIRrpu0kgSom
         Sz8SK8vKaSTytba6iwoI+GzRVtP2l0MYgdXBHbREuJnARXmcLlAjDSYOuJgFDpDkNGn6
         5dWiZ45T2WyyUUSwUNhVGalzc9tj4Au1gstthuU0EyH86DNcK4dXS9KMKejoOWa3JOrr
         GmqjcIBDmIUsNYUq1RSbTLIU2oJDHj4MFCOxPnO0OtIuQO11mUbWfyprnd/eK8V0CqCM
         KzTg==
X-Gm-Message-State: AFqh2krlp8UFRIgoLTb366uABHKPxs0dWb0+foY62axWg2aoBxS53/C7
        cE++U92bro3svBn2xo0Iel/8Z/kqaC6Qx3VylbI=
X-Google-Smtp-Source: AMrXdXt618K/XjbobReXF1IdKPloe9LCALcGZRrvJ3xe2PbNRYAAA6LZGTCR0vCTi4ACuR5YWl13douzvjaPuNJlO2Q=
X-Received: by 2002:a2e:9b41:0:b0:27f:e221:293c with SMTP id
 o1-20020a2e9b41000000b0027fe221293cmr3977131ljj.163.1673546662682; Thu, 12
 Jan 2023 10:04:22 -0800 (PST)
MIME-Version: 1.0
References: <pull.1460.git.1673519809510.gitgitgadget@gmail.com>
 <230112.86pmbk0vvj.gmgdl@evledraar.gmail.com> <4e2bb2da-0c42-ae9c-2a05-9b23db55c2ce@dunelm.org.uk>
 <230112.86r0vzzp74.gmgdl@evledraar.gmail.com>
In-Reply-To: <230112.86r0vzzp74.gmgdl@evledraar.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 12 Jan 2023 10:04:10 -0800
Message-ID: <CABPp-BHz6JXAyRXoNkDjsme4U6g=9f5i_LyMOJ1A4qysirf7Jw@mail.gmail.com>
Subject: Re: [PATCH] rebase -i: allow a comment after a "break" command
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     phillip.wood@dunelm.org.uk,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Olliver Schinagl <oliver@schinagl.nl>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 12, 2023 at 9:20 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> On Thu, Jan 12 2023, Phillip Wood wrote:
>
> > On 12/01/2023 12:25, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> >> On Thu, Jan 12 2023, Phillip Wood via GitGitGadget wrote:
> >>
[...]
> >> But in this commit you extend it to "break", but we're going out of or
> >> way to e.g. extend this to "noop".
> >
> > I'm struggling to see why "noop" would need a comment - it only exists
> > to avoid an empty todo list and is not meant for general use (it's not
> > in the help added by append_todo_help() for this reason)
>
> I'm struggling to see why "break" needs a comment, why not just add it
> to the preceding line or something? But it seems some users like it :)
>
> So at that point, it seems easier to both explain & implement something
> that just consistently supports comment syntax, rather than overly
> special-casing it.

Personally, I think we should allow all lines in the todo script to
have trailing comments.

> > For "pick", "edit", "reword", "fixup" & "squash" we don't need a
> > comment mechanism as we ignore everything after the commit name. For
> > "reset" we ignore everything after the label. For "label" we could add
> > support for comments but I'm not sure it is that useful and we'd need
> > to be careful not to interpret a bad label name as a label + comment.
>
> I think there's been a couple of request to have changing the "argument"
> actually reword the $subject (I'm pretty such for "reword" that got as
> far as a patch, but I may be misrecalling).

Yes, there have been, but it's a bad idea (and it's not just me saying
that; Junio has also declared it as such).  I think it's mostly based
on confusion from us having ignored non-commented stuff on a line, and
we could avoid that confusion by just commenting out the commit
subject to make it clear we will ignore it and any changes to it.

> >> So I'd expect that just like the first for-loop in "parse_insn_line()"
> >> we'd check if strchr(bol, '#') returns non-NULL, and if so set eol to
> >> that result.
> >
> > That would break labels and commit names that contain a '#'
> >
> > If we think we're never going to want "break" to take an argument then
> > maybe we should just make it ignore the rest of the line like "reset
> > <label>".
>
> It's unfortunate that we do that, I think it's almost always better to
> just error out rather that silently ignore data, except for some
> explicit exceptions (such as comment syntax).

I agree.
