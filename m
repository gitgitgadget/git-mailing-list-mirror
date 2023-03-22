Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F946C6FD1C
	for <git@archiver.kernel.org>; Wed, 22 Mar 2023 09:15:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbjCVJPy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Mar 2023 05:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230394AbjCVJPt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2023 05:15:49 -0400
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CABCB5D76B
        for <git@vger.kernel.org>; Wed, 22 Mar 2023 02:15:47 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id r8-20020a4aa8c8000000b0053b6fd7bc8dso224657oom.4
        for <git@vger.kernel.org>; Wed, 22 Mar 2023 02:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679476546; x=1682068546;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XAUpBburE54d6pbHLNN3HI6nCR8KzhtkNI01ffxH/Ew=;
        b=lUe8v0zRqIKYrcGRExIExORcgkphF5ugR6LJRXbnhOVWvO13tLyI442vQ4yqLtg9+j
         2anAn41j2vPgOMWZWz0VsL3I0muPA9iDHc8/f8Q1u4JVSJxRfjnCbwDZuSwyprpUOmS6
         /qcCVK1y+0Jfj77bDFjAyLjuHP+Ik0AFvnkonD/2rBRazF8OZuCAi1s6o45bnreoRpTJ
         WhufMiX+zs4QVCMpB3ejDJuJoOsYwPD8ngMm6JXr1gCsDC3T8QPlT3WfxnZWyluE+yRi
         CQaysAO1yFwCxUzq2QOVr9+UhMhO2beIdPbypljqdK9/v4fMR7r10BBQ6z355fFtLBNF
         RJBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679476546; x=1682068546;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XAUpBburE54d6pbHLNN3HI6nCR8KzhtkNI01ffxH/Ew=;
        b=QPpT+32nwbwPiS/R2yzce5fe6uWBNBRbEb5b4tL64AI+1mUlUX7Vy3SQ/AIe0M9blf
         yeTRc3EX9hBJnh+eb1lSERgPV/iKQTJtNZKY4hPts5V5mt6JeyZqoC4p9aUSVwf4i3jO
         qB3J6CUJFgrg0EW0sTHkR1PYp08XHEX6BUr23XOPXDF++RTIs2MtN07cAja8tTvC2fhv
         atH0rX66hf1pw4Wr0aKbalYYfnPShIXyrH0ZDq0Q5GVhMKFfLkIs6zwUG+hxbOQ76/iP
         i0zuTMzxWyuKmUFSv3ejo9i2xsuuUGrV8+87l8kZCOuoSo5bEK9efGWSixy/D7w6lTuQ
         phpw==
X-Gm-Message-State: AO0yUKXme6VPVFfe7IWLx/gRnNQMh1sAm68Deh6SvUnFnrNzBinGxjYQ
        G9xu36xxKtVYW5/OL+bJplYD/mU73rk=
X-Google-Smtp-Source: AK7set+7sJiGIAxO0zA6k2X3fFfn+zA5kZqTIq+dSW7H0cU2utC6pBn9bFAXB8aVwziq7uLnpG+FQw==
X-Received: by 2002:a4a:d10d:0:b0:52d:73cd:db2e with SMTP id k13-20020a4ad10d000000b0052d73cddb2emr2921688oor.0.1679476546698;
        Wed, 22 Mar 2023 02:15:46 -0700 (PDT)
Received: from epic96565.epic.com (097-091-065-227.res.spectrum.com. [97.91.65.227])
        by smtp.gmail.com with ESMTPSA id p45-20020a4a95f0000000b0051fdb2cba97sm5814686ooi.7.2023.03.22.02.15.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 02:15:46 -0700 (PDT)
References: <94EFF553-E498-46D9-B14A-3500FEDEBB47@nearearth.aero>
User-agent: mu4e 1.9.22; emacs 30.0.50
From:   Sean Allred <allred.sean@gmail.com>
To:     Ward Hopeman <ward.hopeman@nearearth.aero>
Cc:     git@vger.kernel.org
Subject: Re: Feature Request: Ignore Tracked IDE files
Date:   Wed, 22 Mar 2023 04:10:26 -0500
In-reply-to: <94EFF553-E498-46D9-B14A-3500FEDEBB47@nearearth.aero>
Message-ID: <m0o7ol6ta7.fsf@epic96565.epic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Ward Hopeman <ward.hopeman@nearearth.aero> writes:
>     Request: Create an Ignore section that allows for minimal IDE
>     inclusion without impacting IDE settings for local users.
>
>     Reason for the request: Most engineering teams share some IDE
> settings when working on code. More often than not, local IDE changes
> force engineers to resort to using "git update-index --skip-worktree
> <file>=E2=80=9D to avoid the IDE settings files from showing up. It would=
 be
> nice to be able to identify IDE files that you want in the repository
> but not necessarily track all changes as most of them are not desired
> when individuals make those changes for local setup. But teams like to
> track and have available generic shareable configurations like tabs to
> space and line length etc. By making it a user configurable section of
> ignore it allows for future IDEs to be listed without impacting the
> way it works for common IDEs today.

It sounds like you are rather after 'public' vs 'private' IDE settings,
which would be a feature of the IDE -- not of Git -- and it seems a far
simpler model. Public settings are checked-in, private settings are not,
and private settings override public settings.

This is used by Visual Studio (IIRC) and possible in other tools (Emacs
I know for sure, though I can't imagine VS Code doesn't have this
concept by now). It's even the model used by Git itself for some things
(.gitignore vs. .git/info/exclude vs. core.excludesfile).

Are these alternative approaches not an option?

--
Sean Allred
