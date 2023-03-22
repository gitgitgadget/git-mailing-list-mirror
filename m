Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5BD4C6FD1C
	for <git@archiver.kernel.org>; Wed, 22 Mar 2023 21:26:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjCVV01 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Mar 2023 17:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjCVV00 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2023 17:26:26 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B7A279A1
        for <git@vger.kernel.org>; Wed, 22 Mar 2023 14:26:25 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id i5so31663648eda.0
        for <git@vger.kernel.org>; Wed, 22 Mar 2023 14:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679520384;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+0KzoxPHDVZq8cg8E0dILYXtxPNhICc9EBnfxiR6gDQ=;
        b=WkKnzS8LERGg4tEDbpmqbDRW8IDUeez458VjR84Qtk0uSFOkoMgXIBBfxPbZJtUOWo
         +WmgfwbLDT07hgu3Tk0BBqMivKnPhxl19L3XpVJ6Tt2GKUC0tvtH7fnK67ToTKVbcvPm
         HIFLWZMb+7FJRZgoKoPcyxqD4Qvl3w7RoTe8R4fJQXzA4UcByptbxnsxLM21idUGmxye
         PRbC7ANobeEJWuI8pHwsQfDldNh5egHlD8eMJ8KqVqThgsy5yl1vJRbqbA8hhHfwMcee
         C1XWLdeqoi3yaSG1m9tCgteI4nJmOLKZ/fDYKiwj0rh/TFYTsORZd53RlVcO5EQdvq2d
         rLoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679520384;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+0KzoxPHDVZq8cg8E0dILYXtxPNhICc9EBnfxiR6gDQ=;
        b=r7p8+W8r+iEaw78rdevLkH+qBpyTlA3YKbmq4Vt+rolXQKV36b/1A1wkTHfFVjzjQy
         5rLjM3ElviuAS2lL9edvikw5JS3iI0rTUs9MzMJ0yXW+pcYNdZUVRLyeobUhlgxNKTrh
         qhPgTpnc9U89RgmWtuB71n5oWgxwa4J5SvnLZ8VBYnd6qXomRJgaq7/fHgEhS1Y2soOY
         7xR1jS5R9dAN6zzpT1JRRCs3px8DzRyyrKD7VW0kPVTC3HyVPGYM3QyBoeuvbLt3VCXs
         xSNDaIT4kkn61yGYegccWhd+WxCH5hhDm6lAkcPk1SxLDRjFBaVXNv/55j8OEScCftBx
         O8Ww==
X-Gm-Message-State: AO0yUKXitcoKMeb9o4OS44WcW/mPfElXxWVsgiAHfdWGdTfhP9nYt0ZF
        6xITJFodRWXfSfds9WRy6w0mRU7iQuWcmStyDbfpiTn+A7o=
X-Google-Smtp-Source: AK7set8oW3YUW6wmZPjb58JgaY23+29MrF2vrvUMUfoCLf9fSpKg4JPXecVOgR+8W/VkqvAp9boQwE6KgfcMPc6cQTQ=
X-Received: by 2002:a17:907:60cc:b0:93b:1ca6:6adc with SMTP id
 hv12-20020a17090760cc00b0093b1ca66adcmr2312121ejc.7.1679520383728; Wed, 22
 Mar 2023 14:26:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAMbUV8F8y62n5ud3AoWQak8J==Zrn7kzwTE7jCveVJEpfcqncg@mail.gmail.com>
 <CAPx1GvftGM2kpVL9JWWXrjyTRWs+6OxteoJDq9dgeOjuidUGwg@mail.gmail.com>
In-Reply-To: <CAPx1GvftGM2kpVL9JWWXrjyTRWs+6OxteoJDq9dgeOjuidUGwg@mail.gmail.com>
From:   Chris Torek <chris.torek@gmail.com>
Date:   Wed, 22 Mar 2023 14:26:12 -0700
Message-ID: <CAPx1GvfFrUQBDnJ9QYue91ScZb9ctB+tWv2S+pcprVC7dTgdxg@mail.gmail.com>
Subject: Re: Destructive pre-commit behaviour and "--all"
To:     =?UTF-8?Q?Jan_R=C3=BCegg?= <rggjan@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 22, 2023 at 1:00=E2=80=AFPM Chris Torek <chris.torek@gmail.com>=
 wrote:
[snip]
> Note that Git could be designed differently (with real databases
> that have roll-forward and roll-back options), but that's a much
> bigger change. ...

I realized on re-reading my reply here that there's an odd bit at
the end.  It's because I decided to simplify something away, but
that left the oddness: bigger change than what?  So I'll bring the
extra part back in.

For a `git commit` *without* `-a`, Git has a special case: after
it runs the pre-commit hook, it reloads *the* index, as there's
only the one index.  This makes it possible to run `git add`
successfully in a pre-commit hook.  But when using `--only`,
`--include`, or `--all` / `-a`, there are multiple index files.
Git therefore *doesn't* re-load "the" index.

It would in theory be possible for Git to load *the* index twice,
once before and once after the hook, and compare them to see what
changed, then perhaps try to use that change to update the
additional indices.  That would be a pretty big change, but if it
were done right, it might get what you want.

Chris
