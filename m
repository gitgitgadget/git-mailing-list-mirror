Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA2BEC77B6F
	for <git@archiver.kernel.org>; Tue, 11 Apr 2023 16:58:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbjDKQ6R (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Apr 2023 12:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjDKQ6N (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2023 12:58:13 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3268198A
        for <git@vger.kernel.org>; Tue, 11 Apr 2023 09:58:09 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id y11-20020a17090a600b00b0024693e96b58so7552641pji.1
        for <git@vger.kernel.org>; Tue, 11 Apr 2023 09:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681232289; x=1683824289;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9moQD8AWsW69T2x/7aY1eFaZ6SlaaBbLv8YiEsXBWJw=;
        b=JYAxdx2HWxM3VYMxVlU/QtJjiUzrx8lQaimLH2F8nYxk/ezbLvrJsVjGnv0MkTi5Sh
         yh+s4nZY4MugCmhU3IaVyn9TNORKCUnnoyJRGIJb3rJwk4qS3KTi9KcgVAOmtkp4Dnne
         e4koQpQTQO39CRgwncaK1cy+0DHc3VRdpKalHs/kz4il3K4qlqo6nI8KSfXySfZegD+r
         z2iO9P4moexmxe2FJj2ISjGOpZDbkbvpwTUT+R1gQAnBwNA91YwGvt+UDoA61kePDi/q
         P0TC0eWywfCOJlNI4N14pyL0Ge7GxCncpO2ZT++0V23QqUV2tIFGtbEXcKrasgIsIOQR
         EDtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681232289; x=1683824289;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9moQD8AWsW69T2x/7aY1eFaZ6SlaaBbLv8YiEsXBWJw=;
        b=iYcnN6ukEOcZm2BILn2d4StIk4NbfYrN8xPu5bo3Iqd5kny74WAw6guTNLgL7VISKE
         Zy6+ShAKfjFjipLxycvYykT2OfGsj3mkSUzKUeBozQKBr5zB4JIaVuxqgftk5OiXAPro
         3A3tNvCHlGo2WO5nz8Th8bt0v3erj6rHjz/ektqJ52YOZJaC0Jwkt9olQq4ALtDZQNIW
         VytCnAV3om5K7TaZrSUzO6Lih/94S3cr9PJ+88vcVlvwureGidOezgG+0yfST/uVk117
         ZGli9gxUXwOxxkex5JSUbRJ3Zl6DfVHbm+UQiks8Iz32S6Uk6E8xsYUZYBOt0y11hDN0
         Dl8g==
X-Gm-Message-State: AAQBX9eEVbMANn/I6lYIv54Ca+oOs9XgXvQgg/DT2D8UI2OtSy452SdP
        k5P7pgremNkDn+AQTQjKa7yLVzim9dI=
X-Google-Smtp-Source: AKy350ZNedL4WB+zaFuSyVe2CM2w3tD/nlChcq90O5pjV5/s9W6wD+8ia1euFQx/pRPoxPo7vj2jBA==
X-Received: by 2002:a05:6a20:c530:b0:eb:b8:bdc8 with SMTP id gm48-20020a056a20c53000b000eb00b8bdc8mr3152597pzb.57.1681232289131;
        Tue, 11 Apr 2023 09:58:09 -0700 (PDT)
Received: from localhost (254.80.82.34.bc.googleusercontent.com. [34.82.80.254])
        by smtp.gmail.com with ESMTPSA id t184-20020a635fc1000000b00513973a7014sm4478926pgb.12.2023.04.11.09.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 09:58:08 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Matthias Beyer <mail@beyermatthias.de>
Cc:     git@vger.kernel.org
Subject: Re: Bug with git-config includeIf
References: <3352350.44csPzL39Z@takeshi>
Date:   Tue, 11 Apr 2023 09:58:08 -0700
In-Reply-To: <3352350.44csPzL39Z@takeshi> (Matthias Beyer's message of "Tue,
        11 Apr 2023 18:05:18 +0200")
Message-ID: <xmqqr0sq9x0f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matthias Beyer <mail@beyermatthias.de> writes:

> [includeIf "gitdir:~/dev/work/"]
>     path = ~/config/git/gitconfig_work   
> ```
>
> That means, from my understanding, that all git repositories in ~/dev/work 
> should now have the work-related email address set.
>
> If I go to ~/dev/work/somerepo and `git config --get user.email` it indeed 
> shows the expected email address.

The pattern given to "gitdir:" ends with "/" and implicitly "**" is
added after it.  If "~/dev/work/somerepo" is a repository, going
there and "git rev-parse --git-dir" would say ".git" or
"~/dev/work/somerepo/.git", then the includeIf should trigger.

> But if I go to a subdirectory in that repository, the very same command shows 
> the private email address, and commits get written with that private email 
> address.

I use exactly the same configuration (not for working on this
project, though), and your symptom does not reproduce for me, which
puzzles me.  I go to an equivelent of your ~/dev/work/somerepo/subdir
and "git rev-parse --git-dir" would still report an equivalent of
your "~/dev/work/somerepo/.git", and my "git config --show-origin user.name"
does point at the value of "includeIf.gitdir:~/dev/work/.path".

I wonder what the difference of the set-up is.  

My ~/dev/work/somerepo/.git equivalent is a directory.  Perhas yours
is not?  That should not cause any difference and it is merely a
guess in the dark.

