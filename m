Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34F04C433B4
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 21:47:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF0EC61076
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 21:47:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbhCaVr0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Mar 2021 17:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232532AbhCaVrN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Mar 2021 17:47:13 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF81EC061574
        for <git@vger.kernel.org>; Wed, 31 Mar 2021 14:47:12 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id ha17so10230347pjb.2
        for <git@vger.kernel.org>; Wed, 31 Mar 2021 14:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=xdh1x4An4MHbiPOW9EWnW630C2CEgnb0sbmcYJ1X2Xs=;
        b=agmwqHJ55/kcIuwevmP9fyvCrzci0frADnuiJWn2mMfZdusEdw4yD6BJaRpDGuKc0P
         aVCgvhojLXiYGBl/P8tz2AGlzljKUXHz2rS9v+qa+ZPurOy13516xqNyk5frLFYNhmLG
         ZzXq09+avfi1JcWK3aTIE9Ya/OG8bz8EG4bA1Ni8CP9Y/DMNuyu22b1mF+iJCg6atyQt
         rVctW4o5M8WfCoWmAx3LbOCZLOO9oZ+oI1Bjxb/GYRNQvlAFmosFenn/2B1oTeC0qROv
         Y4xndqksy1y6Nci3V1SGI7wT7V3iDY6EwjVVaXs2liuUp9ti15DS19x51Pe4ip9PhQYB
         97xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=xdh1x4An4MHbiPOW9EWnW630C2CEgnb0sbmcYJ1X2Xs=;
        b=KiFXuhDLQcQcRjLtvQxY1xNMBm0ulTk1A69mQ2xKVx/uO8QJqJsCje68Np9L5L7gc4
         aPAg4M9hk39LCZ3vp2kpRwboNPVVf6lSDMvtQpMmWZVGFb5GdJMKh03zMW06haSSs2Es
         hSXnV9MqLdNYwGYCDpa8WAzxSUGrAVLsjyk6TI1t0T8T92bxU6Ig1c8Id3xIUS1QblKr
         sK4Kvfj5l2kbKn4NLR7NL6ETVn1yrc2DSabVwHeF/A5ExFzCujYP1As2O+MbORRuc3sA
         hywBZrbqepw+zSLe73FTt/QiVESA6sKbrVpfcBjXg340u9U/iQlqeTYBAGJKeEYB2Nmi
         5hjA==
X-Gm-Message-State: AOAM531KdUh3FW29mXfXAUup8CFaGTuzFOsIwlhRIGL/vq2oe9fv0YZw
        XmkiPIKklFGYM5i1eWnzj2ZA/tc0PZCA4Q==
X-Google-Smtp-Source: ABdhPJwkW8au8dq4gkjGXEiiWeMrLkuXIgespNkQZ9iqpf2nwoMZ8rW/d8KcJF6y5rQNkX2Zr6S+zw==
X-Received: by 2002:a17:90a:c207:: with SMTP id e7mr5350205pjt.188.1617227232242;
        Wed, 31 Mar 2021 14:47:12 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:8953:f79c:c1c7:b282])
        by smtp.gmail.com with ESMTPSA id j2sm3640233pgh.39.2021.03.31.14.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 14:47:11 -0700 (PDT)
Date:   Wed, 31 Mar 2021 14:47:05 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v8 35/37] git-send-email: use 'git hook run' for
 'sendemail-validate'
Message-ID: <YGTt2cNwq3BlpB7n@google.com>
References: <20210311021037.3001235-1-emilyshaffer@google.com>
 <20210311021037.3001235-36-emilyshaffer@google.com>
 <87y2esg22j.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87y2esg22j.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 12, 2021 at 10:21:08AM +0100, Ævar Arnfjörð Bjarmason wrote:
> > +	my $target = abs_path($fn);
> > +	return "rejected by sendemail-validate hook"
> > +		if system(("git", "hook", "run", "sendemail-validate", "-a",
> > +				$target));
> 
> I see it's just moving code around, but since we're touching this:
> 
> This conflates the hook exit code with a general failure to invoke it,
> Perl's system().

Ah, at first I thought you meant "hook exit code vs. failure in 'git
hook run'" - but I think you are saying "system() can also exit
unhappily".

I had a look in 'perldoc -f system' like you suggested and saw that in
addition to $? & 127, it seems like I also should check $? == -1
("system() couldn't start the child process") and ($? >> 8) (the rc
from the child hangs out in the top byte). So then it seems like I want
something like so:

  system("git", "hook", "run", "sendemail-validate",
          "-j1", "-a", $target);

  return "git-send-email failed to launch hook process: $!"
          if ($? == -1) || ($? & 127))
  return "git-send-email invoked git-hook run incorrectly"
          if (($? >> 8) == 129);
  return "Rejected by 'sendemail-validate' hook"
          if ($? >> 8);

That seems really verbose, though. I guess ($? >> 8) includes -1 as well (since
0xFF... will meet that conditional), but do we care about the difference between
"system() couldn't run my thing" and "my thing returned upset"?

In this case, "my thing returned upset" - that is, $? >> 8 reflects an
error code from the hook exec - should already have some user output
associated with it, from the hook exec itself, but it's not guaranteed -
neither builtin/hook.c:run() nor hook.c:run_hooks() prints anything to
the user if rc != 0, because they're counting on either the hook execs
or the process that invoked the hook to do the tattling.

I think that means that it's a good idea to differentiate all these
things to the user:

 1. system() broke or your hook got a SIGINT (write a bug report or take
    out the infinite loop/memory violation from the hook you're
    developing)
 2. builtin/hook.c:run() wasn't invoked properly (fix the change you made
    to git-send-email.perl)
 3. your hook rejected your email (working as intended, fix the file you
    want to email)

I'd not expect users to encounter (1) or (2) so it seems fine to me to
include them; if (3) isn't present *and* the hook author did a bad job
communicating what failed, then I think the user experience would be
very confusing - even though they'd see some warning telling them their
patches didn't send, it wouldn't be clear whether it's because of an
issue in git-send-email or an issue with their patch.

Phew. I think I convinced myself that the wordy rc checking is OK. But I
am a perl noob so please correct me if I am wrong :)

 - Emily
