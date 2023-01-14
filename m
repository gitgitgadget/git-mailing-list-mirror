Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 312F1C3DA78
	for <git@archiver.kernel.org>; Sat, 14 Jan 2023 01:17:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbjANBRe (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Jan 2023 20:17:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbjANBRc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jan 2023 20:17:32 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB327EC9B
        for <git@vger.kernel.org>; Fri, 13 Jan 2023 17:17:30 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id d15so25106767pls.6
        for <git@vger.kernel.org>; Fri, 13 Jan 2023 17:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dpO+0G10fVQRsEQsZmqmwYByizXIiUIqEfC2p86dFDY=;
        b=StIELdJGYeWXqMnd3A4vBZOE7DheKMNdO/zFwuDyggnx+pS19eS4169aG05ik0T3Ab
         GMadh/Hto+mUfD+eKY1kWOZjzrBRW3UsxpvqJh2+fZooQxK7WmXz8PaNzAfxl4iwi/gO
         bAFYCZgQG2mSDGtXo+jX+fggSn0T/C3dE2LQGrWCpdrynuRf1roVtNVgFPrzqOEn7iWN
         HTBEWPiy98DAtQ/pAMJOnTLAEymuNgLGHRWt4EfzJLMOtLSHnz/54eR8pZmmzuMnOmF/
         +QheBSTJlqoQ/XzKDyIaMciqwnuHEKpM/s7h+owfACNCTP8KV3lYijnhCxNDvJlGr4Ha
         09ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dpO+0G10fVQRsEQsZmqmwYByizXIiUIqEfC2p86dFDY=;
        b=FwuvAbEEoTJ0vMY9HmpkyC+NDVxt6GtUdGz00TSggRCVCmsMS1WQM9YyKs2UOFXtcQ
         Txyotk4+diCA8NIbLiBIjB5GHwcN/T/wAOkhytpht6KqgIaejwVBQFIxyBV0Wpm0p3xQ
         S2YaOE3fbEyGBLrxWWNgqIB1SMw4ujb/dzbAYFRERpkfklETVOkcU0O9wxByuU8EOl4O
         EjtU1kIlh9fytXAslbkPxHm+VcTjMjybAwM/2Bmuvt4Tgd0DUqScHG4HzXMEe8Vw1cuL
         91nhxpORcvZpxdVWADSD/SAjkK1j+KnQosJyt+/XL1x4IexPzXjGhmw6xOcfZusf5JNz
         C9xw==
X-Gm-Message-State: AFqh2kpKGMOu/cuA/h7dduM71GQZ7Zv8SN8F8oLig3JYZPbEFOxUnQJ/
        9w0Q8LAQhqxC+Tv5TKenSM9loGx3nx0=
X-Google-Smtp-Source: AMrXdXvsZmAp+uS+xpa8pkGhvbIQa1/QI2osNpABuMux5wrycm+ZarvsH+TqwnPmzqoftvRXm3ApxA==
X-Received: by 2002:a17:90a:4882:b0:225:b3db:aaee with SMTP id b2-20020a17090a488200b00225b3dbaaeemr78056827pjh.0.1673659050253;
        Fri, 13 Jan 2023 17:17:30 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id t10-20020a17090a3e4a00b00217090ece49sm13056710pjm.31.2023.01.13.17.17.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 17:17:29 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Strawbridge, Michael" <Michael.Strawbridge@amd.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "Tuikov, Luben" <Luben.Tuikov@amd.com>
Subject: Re: [PATCH v5 2/2] send-email: expose header information to
 git-send-email's sendemail-validate hook
References: <20230110211452.2568535-1-michael.strawbridge@amd.com>
        <20230110211452.2568535-3-michael.strawbridge@amd.com>
Date:   Fri, 13 Jan 2023 17:17:29 -0800
In-Reply-To: <20230110211452.2568535-3-michael.strawbridge@amd.com> (Michael
        Strawbridge's message of "Tue, 10 Jan 2023 21:16:28 +0000")
Message-ID: <xmqqmt6loqxi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Strawbridge, Michael" <Michael.Strawbridge@amd.com> writes:

> +It takes these command line arguments:
> +1. the name of the file that holds the e-mail to be sent.
> +2. the name of the file that holds the SMTP headers to be used.
> +
> +The hook doesn't need to support multiple header names (for example only Cc
> +is passed).

I think you meant, by "multiple header names", "header names spelled
in different cases".

That may be a correct statement, but is more or less a useless one
that does not help hook writers.  Different people spell these
headers in different capitalization (for example, your message came
with "CC:" to various people, not "Cc:"), so the hook MUST know
which case the feature adds to its input, if it chooses not to
support different cases like "Cc:", "cc:", and "CC:".  IOW, "only Cc
is passed" is not something they need to hear as a mear example.
They need to be told what headers are given to them and in what
capitalization for all headers in the input to them.

> However, it does need to understand that lines beginning with
> +whitespace belong to the previous header.  The header information follows
> +the same format as the confirmation given at the end of send-email.

I suspect that many people (including me) disable the confirmation
and to them, the above description would not help.

In general, documentation should not depend on the reader having an
access to an environment where they can readily run commands and see
their output.

Thanks.
