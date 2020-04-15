Return-Path: <SRS0=MaRY=57=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 067D6C2BA19
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 13:10:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D87B020737
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 13:10:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J46feKF0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2897046AbgDONKW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Apr 2020 09:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2504445AbgDONKH (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 15 Apr 2020 09:10:07 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D86A6C061A0C
        for <git@vger.kernel.org>; Wed, 15 Apr 2020 06:10:05 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 198so2572219lfo.7
        for <git@vger.kernel.org>; Wed, 15 Apr 2020 06:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version;
        bh=fhmC6qslRDbboEErI55fdMPgviNVLP1zE5qqdVuicZw=;
        b=J46feKF0x1tmeq90yu1/Rjgi4XIrNldUFVYzrZArlY58a/1XB23ADupqA2yatboRLo
         Us5wsLkPAq9twb3o1Y0cOqLrpghnJ0qPj3hhwARSnqdwHSW/edMHSE/i0BX8A5peie8M
         F/+KzUC3UxDo+yLInazg+QyafK+tV8KiLeqZf3tuzL7OnHZMnbl6s9jn6mpaCM0zH1ex
         AlNwXDGPDPr5HaN3qLyq7R3cmCKIiIoIuhH9MGujJVqe6jkqo4s+9TnCeyvlW7HqStfY
         NBY4FMYHJbSQq/I6ppuI70nI+mf4P45dsGHKIOcK4Lb8Ypx+ODw9IBGM3nppVb64QE0s
         ok1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version;
        bh=fhmC6qslRDbboEErI55fdMPgviNVLP1zE5qqdVuicZw=;
        b=EVxaccGTxDdsA+ARls/l5582b5D4yOssHTYUNHlwa7UXEeolinTKa3CcyedqiQnEVc
         4QIRsepVYEArUlWBiq6kQ06/EOSH9R/djaKg9wdhLsY2KkNy+O0gTXyfqgkO+nzy9WjM
         g4Kx3o4EA8ZvXNoS74/VLYR1HH9CETcbToYFbMIi3ZiraxL7xHALPbAyMxAIdX0CzhJh
         2bDB+fmMKUGia2LD+GhXhvqKla6E+jPTFWsAi9g3hlJfHoyrE5CXBQztp/l6NLO9pRrA
         +XBInTswuqgXrIg1TBlkJq4hKOucuz09bsqnTgA6pPCGLA3Jv8KDVsO9xCpT71Hp5N47
         IBjg==
X-Gm-Message-State: AGi0PuZPLDI2D7Bs6RcYyEzzhbuNmmYrCqMSBfA+yWh26FpMDPqjjUBW
        UDfTDpPaKhDKcmOWIXJcEwpL4h6IHzFEPA==
X-Google-Smtp-Source: APiQypLbm9L0OriKC1p0P7N6SYx+Tf3zUkYg8ftRW7XAvvjgrlipDiXq1eEzzA3h+C22ie3Elu/Z1A==
X-Received: by 2002:a05:6512:3e2:: with SMTP id n2mr3122499lfq.129.1586956203932;
        Wed, 15 Apr 2020 06:10:03 -0700 (PDT)
Received: from real.local ([105.9.164.92])
        by smtp.gmail.com with ESMTPSA id 23sm11523261ljr.32.2020.04.15.06.10.01
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 06:10:03 -0700 (PDT)
From:   Keegan Carruthers-Smith <keegan.csmith@gmail.com>
To:     git@vger.kernel.org
Subject: git ls-remote and protocolv2
Date:   Wed, 15 Apr 2020 15:09:17 +0200
Message-ID: <m2k12g7v5u.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I would like to take advantage of protocol v2 in "git
ls-remote". However, it can't reasonably use it because the patterns for
ls-remote aren't prefix based patterns. See
https://public-inbox.org/git/20181031042405.GA5503@sigill.intra.peff.net/

This is behaviour I would like to implement. At Sourcegraph (were I
work) we use "git ls-remote HEAD" to test if a remote is reachable and a
valid git remote. Additionally we use it to get the symref for the
default branch.

There may be a better way to do this, but so far it seems ls-remote is
the most reliable. However, we don't get to take advantage of protocol
v2. A simple hack I did gives much better perf for our use case:

  diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
  index 6ef519514b..12d3af177a 100644
  --- a/builtin/ls-remote.c
  +++ b/builtin/ls-remote.c
  @@ -91,6 +91,8 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
   		}
   	}
   
  +	argv_array_push(&ref_prefixes, "HEAD");
  +
   	if (flags & REF_TAGS)
   		argv_array_push(&ref_prefixes, "refs/tags/");
   	if (flags & REF_HEADS)


What are the options to allow the use of protocol v2? The ideas I have
in mind are the following.

"--ref-prefixes" flag. This changes the behaviour of the patterns to
instead be ref prefixes so we can pass them as ref prefixes.

"--ref-prefix=PREFIX" flag. Can be passed in multiple times. Each PREFIX
is set as a ref prefix.

"refs/" prefix in pattern. If all patterns have a prefix of "refs/" pass
in the relevant prefixes to remote refs. This would be a breaking change
for the rare case of refs named like "refs/heads/refs/foo". You also
wouldn't be able to pass in the symref "HEAD" which is what I want for
my usecase.

I'm happy to implement any of these.

Cheers,
Keegan
