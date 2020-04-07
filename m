Return-Path: <SRS0=6awY=5X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4C78C2D0EC
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 18:42:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A17F620730
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 18:42:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p8K4ru8I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbgDGSmr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Apr 2020 14:42:47 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45330 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726702AbgDGSmq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Apr 2020 14:42:46 -0400
Received: by mail-pl1-f194.google.com with SMTP id t4so1550385plq.12
        for <git@vger.kernel.org>; Tue, 07 Apr 2020 11:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yM0vjQ9IushTG2yU9LnMEsGERIocfBcDyfcWcJhFVpY=;
        b=p8K4ru8I6ia7k9UCOWvK4NvmDOKnXN/yfY1iUkmINb+CBkNTryMJyG80we0PPOe9Jq
         rsD2+dYpC6Setf9VxlTvgraoGHUcfAhkiIUzEHivQPwhjMDbf6OkdaTeieG5KXZhehM5
         SBEZFo+XR3iXCXFTJov/Ak0IOxIKEqgzw3tSVTBHueWt3VQqDD343NcfXE8t3kUv5wt7
         t7R/5MKKlXtz13jRZEZHm0neelm8A677VDGzUc8POrrYBRwGJu1ux6Fn+q3Yt5YMa7u4
         IcOC7Kutu82LiFOsv2cHyjknyBJzXLzAaDCG1FP1ZTlUXb3s7lBQrbJ0S37ybgSHU2Lw
         K0lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yM0vjQ9IushTG2yU9LnMEsGERIocfBcDyfcWcJhFVpY=;
        b=t6EeuN+K4+jm7Ecbzlj/bjStEgAz/mzTs4oOXbX8R14rHrjFopA9qpODuZcbUlnm6Q
         I6RlYjHN4+01Fc3wo4ZdkxSZn0j1WFPr2RiacfeqnhBxJ7PXwEDryftuM/Z/EvRUOCB9
         M5RZ2yEtctFTuEWLBzDuV+a0GUdjJrbibC7HzU6ao/jw4uw9W5n9yHx/GDYNz+iXTv0a
         ZTUBVzDxIVw8d76WiOs4kqaXb+8fMAURiZ+KIpeJuuBI/muAJb75ERU7N0YEALHF4I9W
         aTDk2XO0lIg0Ah9FQE11IIo5gueQeAEakW/+Wpz/wRrL4BSmqDPoeloHhE2dtMkE5FCp
         o0sw==
X-Gm-Message-State: AGi0PuZFn70pW3NtodfYjHpyYooQcfyFItFchDjGZRtP+AP+Sk53G4iK
        1GbttyRYnZ2/rCd8TniDyE1xp49PBIQ=
X-Google-Smtp-Source: APiQypIN7f1o1xkV9mr2JVYLKNbyLXsrUE075Hyz2aL9dii1kPfF9YjmZQ7qxfPTAPFTgRESUh5DKQ==
X-Received: by 2002:a17:902:9a93:: with SMTP id w19mr3666917plp.277.1586284965728;
        Tue, 07 Apr 2020 11:42:45 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id w24sm2178053pjn.14.2020.04.07.11.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 11:42:44 -0700 (PDT)
Date:   Tue, 7 Apr 2020 11:42:40 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v12 3/5] bugreport: gather git version and build info
Message-ID: <20200407184240.GB137962@google.com>
References: <20200406224526.256074-1-emilyshaffer@google.com>
 <20200406224526.256074-4-emilyshaffer@google.com>
 <xmqqeet0urts.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqeet0urts.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 06, 2020 at 04:17:51PM -0700, Junio C Hamano wrote:
> Emily Shaffer <emilyshaffer@google.com> writes:
> 
> > It's not ideal to directly call 'git version --build-options' because
> > that output goes to stdout. Instead, wrap the version string in a helper
> > within help.[ch] library, and call that helper from within the bugreport
> > library.
> 
> This means that "git-bugreport" that can be a different binary from
> say "git-remote-curl" (or "git-version" for that matter) would still
> report whatever version string that was compiled into "bugreport".
> 
> Reporting the version of "bugreport" is *not* useless, and what this
> step adds to the report is good.  
> 
> But the version number of "bugreport" may not have much to do with
> the binary the end user is having trouble with, so we'd also want
> the version of the main part of "git", and other standalone "git"
> subprograms like "git-remote-curl", reported separately, probably
> together with $PATH, $GIT_EXEC_PATH and what appears in the
> directories listed on these environment variables.
> 
> If "git version --build-options" writes to its standard output
> stream, that is a good thing, as it makes it easy to spawn and read
> what it says via the run_command() API, and there is one less thing
> to worry about (it would be a bit more cumbersome if the output goes
> to the standard error stream).
> 
> As "git-remote-curl" would also be a separate binary, we'd have to
> use the same technique to report version number (and perhaps curl's
> library version and its configuration?), perhaps by teaching the
> subcommand a new option to dump such details to its standard output.
> 
> Using the same technique to report the version about the "git"
> itself would be consistent thing to do, as a preparation for future
> steps that reports the details about "git-remote-curl".

Sure. I will include a run_command() call to "git version
--build-options" (or is it --build-info?) in the same series where I
re-introduce the call to "git-remote-curl", since they will look pretty
similar; around that time I will clean up what "git-bugreport" reports
about its own version/build info, too.

To be clear, do you want me to include the output of get_compiler_info()
in "git version --build-options" when I do that change, too?

 - Emily
