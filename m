Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D322E1F7D2
	for <e@80x24.org>; Mon,  5 Jun 2017 22:20:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751258AbdFEWUg (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Jun 2017 18:20:36 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:34324 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751195AbdFEWUf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jun 2017 18:20:35 -0400
Received: by mail-pf0-f175.google.com with SMTP id 9so88987886pfj.1
        for <git@vger.kernel.org>; Mon, 05 Jun 2017 15:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KnTZoCV3xhFoKrFv+9VtB+MsDiCaa7GW/9Y7NZpx8CQ=;
        b=WDQyzlGteOJ4p6mQbRXyXYnx4Gds3aqfVsOPoFxsT9ZpdxlZ95gRwIwqlwx03CGtfP
         hn6eYtJOJIIrlVvM4iqHdYBqjTTdKMGntmh2D0+5HPWd1vUPs1uFj1yGmJnBQKuHtW3q
         ea4U+HBAeI0Ktey5U8F0NIbE9A8j1cwx9MohbkFiKZt7vzhmXt1cDgN9xBM3WOtxjtJl
         MPHztL/qYUJx/WJvmu+ZyPj2R90GWPk486Zk7PB/bWSgrGSdZg/pSU9CZu/ZJo2ezk1S
         ufwdUt7GC4aM9c64jxt7yXlz5gxVxK/8xS0QJdyf2r6OqHFxnqdlTWxg4aVlKdtNVu3j
         emnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KnTZoCV3xhFoKrFv+9VtB+MsDiCaa7GW/9Y7NZpx8CQ=;
        b=qWUPxgtKc3aM1m6qHiOD6dE/hJeisaTcopUpZyQezm7+4toWZFu9Znt9641FISyS9n
         QIOfpUHUxvagi9BjA5fn0vAyx9fn9RtqGc+LeI9ZbqDtpzX/lzKJMX+U1i3ZlAc2wGFV
         3ZBn8ZgL8wZjn1eQs3r4MRJ3AjTOef7whRwYA5GFKN3GJ6xeIQmcS/HwbVYFSO9KLJ+H
         6qK0d0HWKqh2HVmJcR1ejXjSt659QZ6QO+zjaaBKmkUAZwc2aUeNd7g0BKuZrJAdzBlR
         FyWH60DTZu95MgliT/c4g+UVXTTlE79nWGZGaaSpyPKM3hCpYEd/+flysWEooppbsJRy
         kMog==
X-Gm-Message-State: AODbwcAYZ87iTYgfb86yirYkFtUO0NEQZr9CgrhAzIibLl8tvtiYwTzv
        l2e4l3rV8jEPVw==
X-Received: by 10.98.59.92 with SMTP id i89mr23038750pfa.122.1496701234874;
        Mon, 05 Jun 2017 15:20:34 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:402:154d:ee74:14ee:e338])
        by smtp.gmail.com with ESMTPSA id n22sm60916270pfa.123.2017.06.05.15.20.32
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 05 Jun 2017 15:20:33 -0700 (PDT)
Date:   Mon, 5 Jun 2017 15:20:31 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     bmwill@google.com, gitster@pobox.com, git@vger.kernel.org,
        pc44800@gmail.com, ramsay@ramsayjones.plus.com
Subject: Re: [PATCH] submodule foreach: correct $sm_path in nested submodules
 from a dir
Message-ID: <20170605222031.GB21733@aiede.mtv.corp.google.com>
References: <20170515183405.GA79147@google.com>
 <20170603003710.5558-1-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170603003710.5558-1-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

This patch seems to aim to do multiple things.  Initial thoughts:

Stefan Beller wrote:

[...]
> To ameliorate the situation, perform these changes
> * Document 'sm_path' instead of 'path'.
>   As using a variable '$path' may be harmful to users due to
>   capitalization issues, see 64394e3ae9 (git-submodule.sh: Don't
>   use $path variable in eval_gettext string, 2012-04-17). Adjust
>   the documentation to advocate for using $sm_path,  which contains
>   the same value. We still make the 'path' variable available,
>   though not documented.

Making sm_path part of the public API as described here sounds like a
good idea (as a separate patch), to avoid conflicting with $PATH on
Windows.  It's convenient that scripts have access to the private
variable 'sm_path'.  The 'path' variable would still need to be
documented as a deprecated synonym so people working with existing
scripts can know how to update them.

> * Clarify the 'toplevel' variable documentation.
>   It does not contain the topmost superproject as the author assumed,
>   but the direct superproject, such that $toplevel/$sm_path is the
>   actual absolute path of the submodule.

This is very confusing.  I suspect it's a bug.  Can we make 'toplevel'
point to the topmost superproject (as a separate path)?

> * The variable '$displaypath' was accessible but undocumented.
>   Rename it '$displaypath' to '$dpath'. Document what it contains.
>   Users that are broken by the behavior change of 'sm_path' introduced
>   in this commit, can switch from '$path' to '$dpath'.

What does dpath stand for?  Renaming the variable to $dpath means that
scripts trying to adapt to this change would not work with previous
versions of git.  Would it make sense to use $displaypath for this for
compatibility?

What is the intent behind the sm_path behavior change in this patch?
Stepping back, what kind of scripts is this interface meant to support
(e.g., what is an example script that used this interface that would
be affected), and is there a straightforward way to support those use
cases without breaking existing scripts except where necessary?

To summarize, the patch leaves me a bit confused.  I think it would be
best to have multiple patches that solve one problem at a time, which
would hopefully make the story clearer.

Thanks and hope that helps,
Jonathan
