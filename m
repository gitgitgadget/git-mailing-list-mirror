Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BE2BC38142
	for <git@archiver.kernel.org>; Tue, 31 Jan 2023 15:09:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233028AbjAaPJ2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Jan 2023 10:09:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232781AbjAaPJP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jan 2023 10:09:15 -0500
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4B2853E7C
        for <git@vger.kernel.org>; Tue, 31 Jan 2023 07:06:53 -0800 (PST)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-4b718cab0e4so206696267b3.9
        for <git@vger.kernel.org>; Tue, 31 Jan 2023 07:06:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yOBI+wmZAHtZI52LLEBdgdNUjumyY11oe1rRk2PU//A=;
        b=Nl12PJo9rLHq/OYGMDsb6QMYVJCn3bwt10Ku9T9fkP8pipIR9oc8JZee/LzGnIgNB/
         TRErdVrhmR6nko95CkLliGOl76sb81JWQAlqIpEiJbxxGlTWHO8NxsKW/SsJy33f937U
         buJ5VIiCye8/FGOMR20NxTKjDBoLPcglMH++0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yOBI+wmZAHtZI52LLEBdgdNUjumyY11oe1rRk2PU//A=;
        b=yP6cbXh/2dFx3yn8gWx3A1zTXff99JxN8HNA1Vj9MLMWBw3Ie/cNhV8cmgyC1WxYOF
         hhud42hqYZVw7XbrDPIWqUO224uQEJuTSgI1Ku/LxiS9fzYM5P5mZZ7E0qr5C0mJ8eTu
         FwsklD11V682PMxkEglqLgutm4gNVhACBm3yEfEBG//xurK/Tq2erkVm0DFooO8wUfF1
         F99eFVTi2MeD8MPssY4LIsHmw8vInK0NCHJhsunl2Yr5lijFLoic4WnahVMz278wTpua
         gdFWdM01RuKbva4AqCSPIIkLivXuTwGLtoFkmRzdExfEQeMlRtqNbPIUahL/J8XW/P4h
         ii+w==
X-Gm-Message-State: AFqh2kqDL/xF3vzRIUcRn7NLTlXaOy5rGD+7lwyCJ4y0F19nyZZnWJ3L
        T6yqQqhIEME/ZniVJYZD5iYqNw==
X-Google-Smtp-Source: AMrXdXvHEnBvyOc0F7JcSvQZ6FGAZN/IQGTIKVHRury4GpOqgDsCIRK9Gbpxe3vnJJdDi4E+UJZdlA==
X-Received: by 2002:a05:7500:558a:b0:f2:6327:c031 with SMTP id z10-20020a057500558a00b000f26327c031mr2312251gac.18.1675177557575;
        Tue, 31 Jan 2023 07:05:57 -0800 (PST)
Received: from meerkat.local (bras-base-mtrlpq5031w-grc-30-209-226-106-7.dsl.bell.ca. [209.226.106.7])
        by smtp.gmail.com with ESMTPSA id 8-20020a05620a078800b0070383f1b6f1sm10191119qka.31.2023.01.31.07.05.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 07:05:56 -0800 (PST)
Date:   Tue, 31 Jan 2023 10:05:55 -0500
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Eli Schwartz <eschwartz93@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: Stability of git-archive, breaking (?) the Github universe, and
 a possible solution
Message-ID: <20230131150555.ewiwsbczwep6ltbi@meerkat.local>
References: <a812a664-67ea-c0ba-599f-cb79e2d96694@gmail.com>
 <Y9jlWYLzZ/yy4NqD@tapette.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y9jlWYLzZ/yy4NqD@tapette.crustytoothpaste.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 31, 2023 at 09:54:58AM +0000, brian m. carlson wrote:
> I'm one of the GitHub employees who chimed in there, and I'm also a Git
> contributor in my own time (and I am speaking here only in my personal
> capacity, since this is a personal address).  I made a change some years
> back to the archive format to fix the permissions on pax headers when
> extracted as files, and kernel.org was relying on that and broke.  Linus
> yelled at me because of that.
> 
> Since then, I've been very opposed to us guaranteeing output format
> consistency without explicitly doing so.  I had sent some patches before
> that I don't think ever got picked up that documented this explicitly.
> I very much don't want people to come to rely on our behaviour unless we
> explicitly guarantee it.

I understand your position, but I also think it's one of those things that
happen despite your best efforts to prevent it. :)

May I suggest adding a "git-archive --stable" that offers this guarantee,
simply as a matter of codifying the fact that the world has built
infrastructure around git's repeatable output. Maybe just for .tar (and
.tar.gz).

I know this complicates the code and makes it more "expensive" to maintain,
but it would be dramatically less expensive than changing the established
practices around the world.

-K
