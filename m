Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18E3EC61DA4
	for <git@archiver.kernel.org>; Thu, 23 Feb 2023 23:36:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbjBWXgu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Feb 2023 18:36:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjBWXgs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2023 18:36:48 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E01FA570A6
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 15:36:46 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id h17-20020a17090aea9100b0023739b10792so967526pjz.1
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 15:36:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=kJNgVXF6ubgbrXIbAdr6vP/yadzkuvg02qn8jdq9Pww=;
        b=O9o9BVeMnnMsyGRxr/YQRI/EQy8hQxHgzz66pcNnmXVgL6lDo7nTlsnZ2RrS11QwYk
         heQ/hG5yBN8+pJ/Z5lHHbIsvgaEmC8Ckm1cS/FFjgeg0bqp7x7/g8JkkpaSqIL19SP+n
         kplmLtgzKSBgWa/TBT7GLUYDtU8y4s/hyrjqZdzPl9fVu/1s96BiPVf04qTrLqs90Jrb
         5vDfpyPXQKtT3Ee/i0CfHtZnf3q9GSTd6ZRFaHzs/CfeDPHQO3px9IOwasSm5EXyq+bB
         qRjI5Cs49soylE/Wck7PYjRdfziBq0nBGa2/cD7oLKVXBvwJMGEvDNm3Zbomp6jF2rOT
         E9GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kJNgVXF6ubgbrXIbAdr6vP/yadzkuvg02qn8jdq9Pww=;
        b=azarMyrcnDA0ICt6hOpo70upit+d/GuIEocHRLw0AihWXU74OZbnlK15KfpAFwzdE6
         zQXyeYPuS0W5jGJp56Tl50iPI774pZAOa78O00kGqvzRr4eHZ+W3cGsAaQxHgKtaPvxV
         CMDjeAD1xf2t7riZ0MDd6rvut7IVsh/SgNsCyINhs84Vyu1S/tO8gOVD5g1ypV4bpgE3
         8nUJXdQoYEyremTy9ctkhylmSMSqmtvtcNHOrpt2+FbsM6PK2yx6YPTArgHVb9DDuSB1
         RT8SOz18qNvn5+fuGO1rz2DhuvwY1r5XhCF/oFQ3noXmt10mfmyOMCO3KaY8nroKfoo4
         nhWw==
X-Gm-Message-State: AO0yUKUyR5hVY1ruYwT8k7yOR95Tb7sJKCgaa8cFSxPUK2mIg1LU/R/C
        i3stxW4vTP7RroMdR3UB5gk3yeF3m+s=
X-Google-Smtp-Source: AK7set8YbN3wP8SXwnX0ZnB34JrZOuQC9NJggm5bo267gF9BsZJNFW7DlShcxKp91eFD3+rmEj9QGg==
X-Received: by 2002:a05:6a20:938a:b0:cb:27a7:9d42 with SMTP id x10-20020a056a20938a00b000cb27a79d42mr17373814pzh.61.1677195406235;
        Thu, 23 Feb 2023 15:36:46 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id v23-20020aa78097000000b0058d54960eccsm7344009pff.151.2023.02.23.15.36.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 15:36:45 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 03/16] t5541: simplify and move "no empty path
 components" test
References: <Y/dEYYWKy/o96vBG@coredump.intra.peff.net>
        <Y/dFN4GuCjqpIi2O@coredump.intra.peff.net>
Date:   Thu, 23 Feb 2023 15:36:45 -0800
Message-ID: <xmqqttzc3qeq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> before our test. But there's an even simpler solution: just make sure no
> doubled slashes appear in the log (fortunately, "http://" does not
> appear in the log itself).

Interesting ;-).

> As a bonus, this also lets us drop the check for the v0 protocol (which
> is otherwise necessary since v2 makes multiple requests, and
> check_access_log insists on exactly matching the number of requests,
> even though we don't care about that here).

Makes me wonder why we do not clear the log for each test, but OK.
