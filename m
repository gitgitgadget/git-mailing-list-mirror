Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FA14C05027
	for <git@archiver.kernel.org>; Sat, 11 Feb 2023 02:34:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbjBKCeq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Feb 2023 21:34:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjBKCep (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Feb 2023 21:34:45 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82C4F5DC0C
        for <git@vger.kernel.org>; Fri, 10 Feb 2023 18:34:44 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id s20so4740512pfe.2
        for <git@vger.kernel.org>; Fri, 10 Feb 2023 18:34:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vd9vUE/mYtJrOB/THD5a7tY9rRjq6/jm0PRXk93N6m8=;
        b=GDhlJxSRVBHJMCc1bI+uJTLzH4z9AmUCo4ZJhO6gsUS8g/OaJJHDR37uEx2QO+C9zn
         eTXp4FxdOD5Ki2CsXb1BOEGjV7yvu+lUvYGorDtydiCHuPjP74e7Cwlej4uIvsVMGTiv
         DOO6QYLNXv2rMEZ/BGtlKSIYqxCf91eKX/SJCL9aLIxTiLGGA8VyhYYN2J1Mm383Y3DD
         5yvT+8y/GG8BChaOpEaT35mDb7xe4kQzUeitiHD5peN5eAj0xhT3NKrF0y/L4MWZt9m9
         UED0M7xOFQcBefFHyVF1sDbTsHMDMTCPyjnqfzS/bd5m0D/qbrgHb01m0susn6R+kwkh
         0UNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Vd9vUE/mYtJrOB/THD5a7tY9rRjq6/jm0PRXk93N6m8=;
        b=u3gINA9DMBN7gZFA9tZlF82pqVHYW7cJiNPqkRwfeB2fe3nO+yYd56Gouwwhx3By6i
         LhxJW/iq3Ue1luvDngmuVooVzoaTr39x2N7s7OOaJoG0LttV8Mwf7QlHqNvAP5p/i7e9
         xfjZkPDC9UX7dvEXAt6UYRs2hAP8y6lcXLbnOUhmUg7K77lozGSoT/vFPb3VPkROCLJa
         2+OrkwzSJR/nUaAnEyWuIK6LQ7BCsvGibnc+NXMXAVTCcfkCcEREco+u5ZjF0Lmj3vfM
         nJxRp37tIZY94ARjyl+P8abxJvauZUcQD4+YH4Mv63c7u8/MpgLgrdX5pSHDBUUzFp7+
         g2MA==
X-Gm-Message-State: AO0yUKUNLhg+HdDYmUDSlfQ1lC8e3tRrtqRNgzuHPCcHEaySX/gMUMx8
        C04ScH6GKLnDnnH6AOs5ehDyJW5NyHQ=
X-Google-Smtp-Source: AK7set/6HI2PXSsAWXQ1nQr9+8y7dlie64WKuM5oZ2s/6vrr4wR+8gdsO9sOXynwBUdre0UvOekfQA==
X-Received: by 2002:aa7:9887:0:b0:5a8:71e7:accc with SMTP id r7-20020aa79887000000b005a871e7acccmr3083860pfl.30.1676082883916;
        Fri, 10 Feb 2023 18:34:43 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id c17-20020aa78e11000000b005813f365afcsm2320055pfr.189.2023.02.10.18.34.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 18:34:43 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Todd Zullinger <tmz@pobox.com>, git@vger.kernel.org
Subject: Re: t5559 breaks with apache 2.4.55
References: <Y8ztIqYgVCPILJlO@coredump.intra.peff.net>
        <Y81lQwG85+Skujja@pobox.com>
        <Y9Jmfg/jlSszVep4@coredump.intra.peff.net>
        <Y9YTsF4a8lL7uHm+@coredump.intra.peff.net>
        <xmqq357ems2h.fsf@gitster.g>
        <Y+b7bTs2vdXAe/ky@coredump.intra.peff.net>
Date:   Fri, 10 Feb 2023 18:34:43 -0800
In-Reply-To: <Y+b7bTs2vdXAe/ky@coredump.intra.peff.net> (Jeff King's message
        of "Fri, 10 Feb 2023 21:20:29 -0500")
Message-ID: <xmqqilg9exq4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I'm not sure this is really sufficient. As I was running t5559 over and
> over to test various versions, I noticed a few other cases that seemed
> to fail, some of them racily. So I'm a bit worried that the problem may
> be more extensive, and it is only that this particular test happened to
> trigger it reliably.

Yeah, I've seen not just t5559.30 (which is what the patch was
about) reliably fail, but t5559.25 fail only from time to time.
There may be others.

> In which case the right solution may be ditching t5559, or at the very
> least adding a knob or version check to disable it.

Yup.  Do we have an example of checking versions of mod_frob being
used from within our test suite?  I didn't locate one.

> So I'm tempted to just punt for now and see how often this bites people
> in the real world. And if it does become a problem, we'll have more data
> on what exactly should be changed.

OK, works for me.

Thanks.

