Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D3F811F597
	for <e@80x24.org>; Tue, 31 Jul 2018 20:01:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732593AbeGaVn0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jul 2018 17:43:26 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37174 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732094AbeGaVnZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jul 2018 17:43:25 -0400
Received: by mail-wr1-f65.google.com with SMTP id q10-v6so17866097wrd.4
        for <git@vger.kernel.org>; Tue, 31 Jul 2018 13:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=4pPwrAaxfJ1csGi7c/kAr+OgdwYnjC3oDTFNszoISZA=;
        b=ejvrbOBs8h3y8yTX3VYXHEJZyKRVRg06fDRd917RCKIb0TjbhgQsiNe9JImWR7YB/z
         RCvkK6lhcP5sBlqxo9gxgJUaexxkdQYp0i47SI40G9CNhlrnAH7RNB5aR6Vhpozw6eZg
         2Xy2/sYhDmZSZ/AKanTXWB6ZfnXg3mIzhj9u78pcMd/dGzTG2KffVZaERCf/DuHE4A3J
         DjFvSDd6XiIfvy9fms+KIrKqRmUbne/wtBGrGw+K3H/YQr1opItLvkHJ2Xy8NI+jgtV3
         aS56NPtdoey3Fsa1ctl9p7DZfLWKa9fWniUF0sFEvJ/XFZCKGFy5eSzCYX6nzTTWHytZ
         c4ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=4pPwrAaxfJ1csGi7c/kAr+OgdwYnjC3oDTFNszoISZA=;
        b=NLS/fPXdFn229yhXovyH1Ysyh8BclPg7/ZS6JNkCBDJo/K2VLauAt665swl9fRD2UZ
         7iedWp/FiR7fceBVdRXADpv10kK3ZeLbebrZA3GK6YdEDOy1/OEQDnPi64NlgJw4r0xZ
         dCZm5BqQOJ4kMobLnXNhhRy2W3QUJXJyhEw7sA1p1Wo/DfO3wfzosZL9EoLUF8k2adQG
         gBjYHH25zJgglq7+vhQdwm4KweRE46gNcYNWtb7ga8x2cgxQ9C4TvS4wC17woiVO71/v
         aLMOGfPoSM7iwOKjWa9qL71aFgJKwxFUG7EI7lZS7Lif29gU/3QG5+nJiXZ1N2tAhK67
         iv1g==
X-Gm-Message-State: AOUpUlGFlM6QDGrJYyrg08pt2tGGNMslpKiIUeStkdz3ET+/qe5RPLYs
        joKpCfKkHVfw0Eflqqy+vy4=
X-Google-Smtp-Source: AAOMgpdDAkhcFeBzVacGyFSp9RAXr1WUWMp/erU7yu2IIKKbwtdjW61KFKcQKrXV13ofjt52qCB+vg==
X-Received: by 2002:adf:b202:: with SMTP id u2-v6mr22173546wra.19.1533067288476;
        Tue, 31 Jul 2018 13:01:28 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id m68-v6sm5317935wmb.10.2018.07.31.13.01.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 31 Jul 2018 13:01:27 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ben Peart <Ben.Peart@microsoft.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        "sunshine\@sunshineco.com" <sunshine@sunshineco.com>
Subject: Re: [PATCH v2] checkout: optimize "git checkout -b <new_branch>"
References: <20180724180122.29212-1-benpeart@microsoft.com>
        <20180731163909.19004-1-benpeart@microsoft.com>
Date:   Tue, 31 Jul 2018 13:01:27 -0700
In-Reply-To: <20180731163909.19004-1-benpeart@microsoft.com> (Ben Peart's
        message of "Tue, 31 Jul 2018 16:39:25 +0000")
Message-ID: <xmqq36vzb2eg.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ben Peart <Ben.Peart@microsoft.com> writes:

> The biggest change in this version was suggested in feedback to the last
> patch.  I have turned on the optimzation by default if sparse-checkout is
> not on so that most users do not have to set anything and they will get the
> benefit of the optimization.

Sounds like a good thing to do.

If we missed something in the logic of skip_merge_working_tree(),
the breakage may affect more unsuspecting people, which may or may
not be a bad thing---at least it would allow us to notice it sooner.

> +	When set to true, "git checkout -b <new_branch>" will not update the
> +	skip-worktree bit in the index nor add/remove files in the working
> +	directory to reflect the current sparse checkout settings.

This reads a lot clearer, at least to me, than the documentation
update in the previous round, by speaking in terms of what the
user-visible side effect of this setting would be.

Nicely done.  Thanks.
