Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E96DCC4332F
	for <git@archiver.kernel.org>; Wed, 21 Dec 2022 15:58:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbiLUP60 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Dec 2022 10:58:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiLUP6Y (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Dec 2022 10:58:24 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D523913CF5
        for <git@vger.kernel.org>; Wed, 21 Dec 2022 07:58:23 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id bf43so24124128lfb.6
        for <git@vger.kernel.org>; Wed, 21 Dec 2022 07:58:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=newsbridge-io.20210112.gappssmtp.com; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BJs2SmilbRvHg0+c3lmtPbZ5TVp+cZeLiYWqUGRY0VA=;
        b=HY34dg+6PlV4g+OjWLmI6Weq2d6SlvmzLra0jRQeKNNQyzU0DTBpkuuuPoIC3IZYp5
         Dv4Xq/C0ZzmUEE92bwxgqxx6ApmKSPp2ZYsKGtKJuoTobup95YNXgLyCmnQeUwnvz3mC
         qSUJ7fq4Mw6VNk+C5/09BddByPn0y5+4IQDeVh+2Iztt6axL2fQWgJh8u6pa7J8UxqM2
         Ad28z9ApqoNdx+DHg+lkqHOLkPG3OMj0Da8zyXm2yqPXLwxAUw4bS4YPtU1UR9hhzP2+
         jkifx7BZt2oSUbo8e6OWj5GWu9XbotDQi9RwdWcIIryPzB5YywjP1zgtt252bCeud6cg
         e3Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BJs2SmilbRvHg0+c3lmtPbZ5TVp+cZeLiYWqUGRY0VA=;
        b=rOD9zFw+ShaY92HH21rKFw807NtYskm/30Ts77gFsWjgVJLU9Ae9V9Io85GyN1Cfn1
         lDG0eGOXvLKSJqvstNg6j8ydGDAIbGKN+H5Fpwi1xS9rT0OR6tliBZRsLW0TA2qO2L7z
         oowaPxWt9SiCA8VjstnJs1BlVr67uxqZPovIC2YCal44Z9F9jhULz65JvHfYiEzdSLW0
         oh/IhTKp8sISHHbxVmlE4f8QeEU2y+/MYS3+gKaEHNjL1n5ocVtoe4tGcQANGbeeaGFD
         XCtqXJrICW8FCWgCX0eNvp4vkjCANFNSbJ7SSXIPk61VHTAG/nIqbQ08bHHoUVDh/eXw
         poCA==
X-Gm-Message-State: AFqh2koZIT9u3EvbJFTyNyOaalFkIJCKjntLEclnqL1BC3sq25xek/na
        JygADRqH1YQVXS5gWdK37QXX0GOIgIRvjBR1mtLi9g==
X-Google-Smtp-Source: AMrXdXtcQehvf/9c0aFnghg1ldBhh8Elewllp95a38nRsl7XISk07Qc77XVrXCuwisV5YRE5YCRkfTRTbpdxNrHtJz4=
X-Received: by 2002:ac2:48bb:0:b0:4b1:753b:e677 with SMTP id
 u27-20020ac248bb000000b004b1753be677mr111495lfg.407.1671638302244; Wed, 21
 Dec 2022 07:58:22 -0800 (PST)
MIME-Version: 1.0
References: <CAOLx1BgQinzZBkHvvmDrGUedEyQa_7ZVsyVGmWjF4gYhxc3P+w@mail.gmail.com>
 <Y5u/E04V0QWQTDhu@tapette.crustytoothpaste.net> <CAOLx1Biwd9KzqipoEPaw0M2AecW7XfuyvNeVW4F59e696gMt-Q@mail.gmail.com>
 <CAOLx1Bi189tdo1Yn7njv9BjMzjuVOT8MSZH-bx8o-nS6gQpQTg@mail.gmail.com>
In-Reply-To: <CAOLx1Bi189tdo1Yn7njv9BjMzjuVOT8MSZH-bx8o-nS6gQpQTg@mail.gmail.com>
From:   Jean-Michel MERCIER <jeanmichel.mercier@newsbridge.io>
Date:   Wed, 21 Dec 2022 16:58:13 +0100
Message-ID: <CAOLx1BibKcxrPp3fyUbGXM-d_JZKot_MLznB9EXF3CkVKkHtZA@mail.gmail.com>
Subject: Re: feature-request: silently stops ssh-agent.exe when upgrading (windows)
To:     Jean-Michel MERCIER <jeanmichel.mercier@newsbridge.io>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone

Just for the record in the archive if anyone is finding this thread:
It has been handled :
https://github.com/git-for-windows/git/issues/4172
https://github.com/git-for-windows/build-extra/pull/453

Thanks

Jean-Michel

> On Fri, Dec 16, 2022 at 8:53 AM Jean-Michel MERCIER <jeanmichel.mercier@newsbridge.io> wrote:
>>
>> Hi Brian
>>
>> Many thanks for pointing me in the right direction.
>> Sorry for bothering
>>
>> Keep the great work and have a great end of year time
>>
>> Cheers
>>
>> Jean-Michel
>>
>> On Fri, Dec 16, 2022 at 1:43 AM brian m. carlson
>> <sandals@crustytoothpaste.net> wrote:
>> >
>> > On 2022-12-15 at 08:38:01, Jean-Michel MERCIER wrote:
>> > > Hello
>> >
>> > Hey,
>> >
>> > > I've looked in the public-inbox archive without finding any similar request.
>> > >
>> > > I believe it is a bit annoying that upgrading git-scm always generates
>> > > an error when ssh-agent.exe is still running. User than have to open
>> > > the Task Manager, find the task and kill it.
>> > >
>> > > Could you consider silently stopping ssh-agent during an upgrade, and
>> > > may be restarting it afterward ?
>> > > Most installer do that or at least offer the user to do it to allow
>> > > seamless upgrading.
>> >
>> > The Git project doesn't distribute any binaries at all, and it doesn't
>> > distribute OpenSSH.   It distributes source code for Git, and that's
>> > all.
>> >
>> > It sounds like you're using Git for Windows, which does distribute
>> > binaries, both of Git and OpenSSH.  If you have feedback for them,
>> > you'll probably want to use their issue tracker
>> > (https://github.com/git-for-windows/git/issues) and, if it hasn't
>> > already been reported, you can request a change there.
>> > --
>> > brian m. carlson (he/him or they/them)
>> > Toronto, Ontario, CA
