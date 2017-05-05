Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B96C4207FF
	for <e@80x24.org>; Fri,  5 May 2017 17:52:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750879AbdEERww (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 May 2017 13:52:52 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:32805 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750796AbdEERwv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2017 13:52:51 -0400
Received: by mail-pg0-f68.google.com with SMTP id s62so1666230pgc.0
        for <git@vger.kernel.org>; Fri, 05 May 2017 10:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ekckiFS1vz0hl6aQDNuqDfygTMky+L6e57qW3PeTAnE=;
        b=raolZId8VX9tp0j1OWUfT20jFAE/0Td151Z2RIBwWjlO0VpA8yU80WZ7inKkOAAGKR
         KV8kkxxfv0iwze0+mOtHLyPw1Np7RA0j5VIVEQ528+D15nFyY97MLvVppcafMXgPLSJn
         xeP0YN/+HKsOg+gut3tgqxecUh0ZEXHa8B1py2Kn2KI1S72N4bCXhbzI9+9jS6IWsUAL
         6iMEM1R7c98mqrpuekDcy2EXtbRn9jU0nXvVkq9P79TCEf+RBajvHeftchU0FJlZt5pB
         H1ZaLe7UmRntVUom/FGLFm9LAidmyR+5QcJ8nExK34ERqUhRUaTLSrNx8RINSEdhB9ND
         ER8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=ekckiFS1vz0hl6aQDNuqDfygTMky+L6e57qW3PeTAnE=;
        b=MkaF13M2/u49+g0WasHkm6GrGgiqVHt9lAkyQjHHE6YvYXNYw2UQA5TNbQHjcdZoSt
         oZt7W/rp8aOAmvxu3T/LcRaz5+Ygri1WcgWXh/wsyJX2QoIy1OvtR8U79BV3lUoOAiLa
         nTuWN/D+BMBs7PLnEEbVMvrSSEzkDFQzP00XS8+tRgIHy2tY8/KJm38zcicQwX/ILmId
         zfVqIrLPpEgce6oqLcdfeOkLpJRVTfjxz7CBuXWE7bARFOkY0wxEsCZ5MSDH8QzQsJjb
         SW8sHDLcea+wjXfbe1lW1CHlco9Dd/+caZyr1fT0+/kvKjqpX38qTiO/78why4ybv4/O
         MKJw==
X-Gm-Message-State: AN3rC/5lNIz87TjlSiOmPuWGhYY5f96HvvF5H2Guhr3I1e/0CmD44jdi
        EeB/h048YbHJaw==
X-Received: by 10.98.9.130 with SMTP id 2mr18400737pfj.199.1494006771114;
        Fri, 05 May 2017 10:52:51 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:aca8:b828:d7c5:8258])
        by smtp.gmail.com with ESMTPSA id z22sm11391872pfg.117.2017.05.05.10.52.50
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 05 May 2017 10:52:50 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff Smith <whydoubt@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [RFC PATCH 07/10] Break out scoreboard a little better
References: <20170505052729.7576-1-whydoubt@gmail.com>
        <20170505052729.7576-8-whydoubt@gmail.com>
Date:   Fri, 05 May 2017 10:52:49 -0700
In-Reply-To: <20170505052729.7576-8-whydoubt@gmail.com> (Jeff Smith's message
        of "Fri, 5 May 2017 00:27:26 -0500")
Message-ID: <xmqqshkj6vim.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff Smith <whydoubt@gmail.com> writes:

This blank space is for you to explain what you mean by "a little
better".  What makes the result better?

It seems to do too many things in a single patch.  For example, I
guess it may be a good idea that you made various knobs like
"show_root" encapsulated in the scoreboard; that change can and
should be on its own single step.  It is unclear what the pupose of
blame-sort-final thing is, but even if that change were a good idea
(I am not saying I think it is a bad idea; I am saying I do not see
sufficient explanation to judge its goodness), it is a change that
is unrelated to moving "show_root" and friends into the scoreboard,
hence should be a separate patch.
