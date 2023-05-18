Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51E4EC77B73
	for <git@archiver.kernel.org>; Thu, 18 May 2023 23:23:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbjERXXh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 May 2023 19:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjERXXg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2023 19:23:36 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71EB9E49
        for <git@vger.kernel.org>; Thu, 18 May 2023 16:23:35 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-64d18d772bdso1518029b3a.3
        for <git@vger.kernel.org>; Thu, 18 May 2023 16:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684452215; x=1687044215;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rRwZhoIn9soWbiw+dBZU6ZR6twFqDtOO6TQg4wqj6x8=;
        b=daSKIikv8MOSU10vIdHxDRtCeOerPE+rrY/4RNl7Jfbp3TPW1snJY3gNYaAADp7LBs
         uQgvdUMvhDXMiGjx9Zfv/DhmtyMkDAynG/q1ah7dcAqViUXK9F83DeLmLL9SXMYfvBzG
         5hS43Ooq4h81asvDyDctuJjGnDnAnvzYM5L3cp6oJyv9gVuu+QeObsETas4t/FMhxb3n
         RLi0XGIjO1EViLSUQigJsre/tD5qMp6purVj3GEP1uUa4aPgh55GQRshzpyv6GuD5dSx
         TOm2jxRitjHVvOXKQ4GjpNUHT1dSNXlcoZr+yl/UMneK/CoCqnGtFZiTmW2cNFrGlXs0
         zYoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684452215; x=1687044215;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rRwZhoIn9soWbiw+dBZU6ZR6twFqDtOO6TQg4wqj6x8=;
        b=TcnJzYevQkCmvXVw5yFb29cynLg+ngX/tWQNpgRZjRNS+dUsqJntCcGLr5BBucqK26
         O9kfUBKiuSm63nVfe+XA7zqVTwfEB3fpta4AWh1ET6Zf4dhGj68gUnPdHN4pI7/gcYmN
         xVjzEGtU2cQYOaXjlubOnbnVvbdUKV79pjCKowBECAMFkc3nGVoJ1UWenBnYv7qbOy1f
         z/HQv6LDWvgppeqc6zj8yTH2b+PIkVKmYi69wkH9kkDAnQbQQNAt3Uy+RFiHZR4MilMn
         /0s27BneVjByrM+NTdlFBe9vsy9s042pVYOWHElUAhJtD8sgCjnibhwSVigAlGh6Ebps
         PKlg==
X-Gm-Message-State: AC+VfDxNucshUceIk/GAYVkWCwbjrweIPLIMOY12ANMl/bfNxREOj3nY
        ZvttBxzU7fPOMvkPc8wbEKA=
X-Google-Smtp-Source: ACHHUZ7V0XEvGjLPG3v2ZFenw5Hmbre9f5zdArdZnL2YaxPxTbAXzbVuVJ1+5NFzP6+0jh68hH93bA==
X-Received: by 2002:aa7:88d5:0:b0:647:24a2:2128 with SMTP id k21-20020aa788d5000000b0064724a22128mr588776pff.11.1684452214716;
        Thu, 18 May 2023 16:23:34 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id x53-20020a056a000bf500b0063d3801d196sm1853583pfu.23.2023.05.18.16.23.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 16:23:34 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Todd Zullinger <tmz@pobox.com>, git@vger.kernel.org,
        Matthew John Cheetham <mjcheetham@outlook.com>
Subject: Re: [BUG 2.41.0] t/lib-httpd/apache.conf incompatible with
 RHEL/CentOS 7
References: <ZGUlqu7sP7yxbaTI@pobox.com>
        <20230518184532.GC557383@coredump.intra.peff.net>
        <20230518192102.GA1514485@coredump.intra.peff.net>
        <xmqqpm6xs51l.fsf@gitster.g>
        <20230518231056.GA1752284@coredump.intra.peff.net>
Date:   Thu, 18 May 2023 16:23:33 -0700
In-Reply-To: <20230518231056.GA1752284@coredump.intra.peff.net> (Jeff King's
        message of "Thu, 18 May 2023 19:10:56 -0400")
Message-ID: <xmqqy1llql56.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Yeah, I agree what I wrote is a bit unclear. I think what I meant was
> "..recent enough that we'll still encounter older versions in the wild".
>
> But yours is even better, since you dug up the actual version it ships.
> Do you want to squash that into the commit message, or do you prefer a
> re-send?

Neither.  What you wrote was serviceable (and my comment was labeled
"nitpick" for that reason) even though it might have been a bit
unclear.

>> > +enable_cgipassauth () {
>> > +	# We are looking for 2.4.13 or more recent. Since we only support
>> > +	# 2.4 and up, no need to check for older major/minor.
>> > +	if test "$HTTPD_VERSION_MAJOR" = 2 &&
>> > +	   test "$HTTPD_VERSION_MINOR" = 4 &&
>> > +	   test "$(echo $HTTPD_VERSION | cut -d. -f3)" -lt 13
>> 
>> As HTTPD_VERSION comes from 
>> 
>> 	$LIB_HTTPD_PATH -v | sed -n 's|^Server version: Apache/\([0-9.]*\).*|p'
>> 
>> and parses a line like "Server version: Apache/2.4.6 (CentOS)",
>> unless somebody ships 2.4 without any digit after it, the above
>> should be safe ;-)
>
> Yep. I wondered about trying to be more paranoid here, but I think
> there's not much point until we see a real world example. The most
> likely outcome of a mis-parse is that we'd claim "this looks too old"
> and skip the t5536 tests, which seems OK (at least nobody gets an
> unexpected test failure, though it may mean that they simply gloss over
> the problem).

Yup, this will be in 'next' and will become part of -rc1.

Thanks.
