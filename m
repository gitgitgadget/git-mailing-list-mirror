Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58BF7C61DA3
	for <git@archiver.kernel.org>; Sat,  4 Mar 2023 01:16:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbjCDBQd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Mar 2023 20:16:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbjCDBQZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2023 20:16:25 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E4BA6512D
        for <git@vger.kernel.org>; Fri,  3 Mar 2023 17:15:47 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id h11-20020a17090a2ecb00b00237c740335cso3971851pjs.3
        for <git@vger.kernel.org>; Fri, 03 Mar 2023 17:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rOusmwfgt0tQUPlkwlNtllwu4rds+tiJgzCnWPqMZ/A=;
        b=JvJha5VTq5xFyux4rGoHywg+SpHAj3HV+jMu2bv4gJBdN4u6SxuVS/PJMggZuNpP9X
         MPdAzIWFkDfhGfjqN4PhOlAZnR/Yh76DVSQg5gobap8mOB3BRMo/pM8G2GcxpSmmvbVf
         XAKKJEjmbfKiccDmWRlu0O6FVP+fufyvxwuFntzqwlJXymwvl7f0tohzgnhpXgMf3+Pv
         /RUWItX6JqYkr3DuVigozT1as1MzdhXxr7xNpCjsnJLfdwqryNA2RwAE2CJVMmScR71R
         hFTi9ByO/8mP4SK4bCUr5Y3b7UNVSyHOuAYeCvJ3OtnBHLlvIZT0wC8D1ELfFeCv7RKL
         f2CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rOusmwfgt0tQUPlkwlNtllwu4rds+tiJgzCnWPqMZ/A=;
        b=pJEhgjjHGrj9gd1AGVeNPws06FRsTKIcnMdsGWmJTDF5+RMunbXLUCVrr+go+rao2P
         ZvBz0DxcfimzmDbLy9vVfOJ7kyUjfbQXFE+UJjBLsrvBDEMn5ceny21Ssh6lgKNFtvzn
         hhOYJvncNT9iMBIqcQtV1e4PW3rpJHZXqCZXwoRzh8W37PUJGaDONb8eSOrOaSWzbkOM
         sqxuVBSu9n5PFjSL64BvD7TIGCCgDoiWUrLpC146UNIT10/MaTXYn9pR1kGKJCjFD8tS
         soRkVuc48p/jnOCwVJML6NCEj98d4eEkz9LnhrmwFGYiZjNX4IrrBXRWHUicca2yErUm
         FFqA==
X-Gm-Message-State: AO0yUKWj0bIpl5umiFxG0eIVJSXY+OVuB41NkoFKGs4NY2AEz3GM8n/u
        8RCFUsohqT+ts4p2Rn2zq2c=
X-Google-Smtp-Source: AK7set+JaqKgqChJ5hO8IbDvoda4CjLw5kdBjftU4cFwVnZu7AWR8K2e8X/Pk25pkD3Kw61ZRP7XRg==
X-Received: by 2002:a17:90b:350f:b0:235:31e9:e793 with SMTP id ls15-20020a17090b350f00b0023531e9e793mr7905437pjb.13.1677892478277;
        Fri, 03 Mar 2023 17:14:38 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id c14-20020a17090a4d0e00b00230745a7744sm3816856pjg.52.2023.03.03.17.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 17:14:37 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Michael Henry <git@drmikehenry.com>, git@vger.kernel.org
Subject: Re: `git bundle create -` may not write to `stdout`
References: <80beb487-cd93-06ed-88cf-87a96a829ff6@drmikehenry.com>
        <Y/voNv1OQ1Cf/N5a@coredump.intra.peff.net>
        <xmqqv8jhcvrq.fsf@gitster.g>
        <ZAJ6oI3clNH2O3R7@coredump.intra.peff.net>
Date:   Fri, 03 Mar 2023 17:14:37 -0800
In-Reply-To: <ZAJ6oI3clNH2O3R7@coredump.intra.peff.net> (Jeff King's message
        of "Fri, 3 Mar 2023 17:54:24 -0500")
Message-ID: <xmqqa60tco76.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> (I do still think we don't want to push it down into prefix_filename(),
> because it gets used for paths and pathspecs given raw on the command
> line. It does make me wonder if there are places where OPT_FILENAME() is
> doing the wrong thing).

To be quite honest, I had the opposite reaction ;-)  At least for
OPT_FILENAME() thing, I think it is well known that you should work
around with "git cmd --opt ./-" if you do mean a file whose name
happens to be a single dash.  Teaching prefix_filename() the same
trick does not look _too_ bad.

There is a problem that commands that use prefix_filename() may not
be prepared to read from the standard input or write to the standard
output.  For some such callers it may be just the matter of
replacing an unconditional open() with

	-	fd = open(filename, O_RDONLY);
	+	if (!strcmp(filename, "-"))
	+		fd = 0;
	+	else
	+		fd = open(filename, O_RDONLY);

or something, but if some callers have fundamental reasons why they
do not want to work with the standard input, it may make sense to
treat "-" as a normal filename, and for them, blindly prefixing the
leading directory name would be much better than special casing "-".

So, I dunno.


