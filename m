Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EFCA5202DD
	for <e@80x24.org>; Wed, 12 Jul 2017 16:46:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753672AbdGLQqb (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Jul 2017 12:46:31 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34793 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753543AbdGLQqa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jul 2017 12:46:30 -0400
Received: by mail-pf0-f193.google.com with SMTP id c24so3864400pfe.1
        for <git@vger.kernel.org>; Wed, 12 Jul 2017 09:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=zw7kBsR9OIIOPAEElb+ieX78JlkPHaVG5RmwCTr21/Q=;
        b=TZV/1HK9abw5moAU8a3XHivSz9LqqrPua7jSXByCipow2VzVfMeY/iT4PhHR33snYk
         3yfwzHdJvdNIrXZpGHwcZiiLWoBPJm6eDINnc7aupltv4GSeG+mcsuf/AtBENMAPegAV
         8YfsazYnREMuNASmyvP9Csco1TEgdrr12HXa/BojJmTxCBWCfLBCiW8n80RhEuRsvwEG
         hRhjPIE/vJBt05T7s/qVn7cXbIrSdxpO+dHcVd0mCpHjVbWV+REH+ujrJTQFYtjz2skO
         XdP28XBsP0zhUDsiby5P9Qbg4t5U+hOls4hSLPS2F6hSlXZsvyDM5/S0IO+Z3sNg3m4d
         v8LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=zw7kBsR9OIIOPAEElb+ieX78JlkPHaVG5RmwCTr21/Q=;
        b=Nvx532gdu1OtcrBxhlF6zdxCdzPc2q+MOSzj0Kro3455nBHrMnbE6EvXQANC5UW8fC
         Bs7h8OvJ3B8yPBYKD0sLer8Zr4JojERlborzNGWYXRYPSHcSfuogF5E/py5LKj+iWrsq
         8kTlpE0pAI0gn0hQB4+ITEqDvZxImxnou30Q7Egm8H3rkYFHlKFGaBN1Io4XRm4oX5c/
         vaQA5iTaICdL+/uiDOlXh8ZwA+j6djQ3R6uJihM5nRoChLOoVb2Z7JTAOrQDQVNwBYwx
         we1BLRTdyjEf+LHhlG7P4ZPxEFo5ETb7Fo8eeK1jFg3wkBIa3SQXJaLJVPvOoOVSjv8q
         myVQ==
X-Gm-Message-State: AIVw110bOFpHdx/aRLq5Emzk4rIi4twwkkKKjxHjISDJB+gSqeLkHiuj
        IFANujh9ru2EHg==
X-Received: by 10.84.229.79 with SMTP id d15mr5251207pln.4.1499877989868;
        Wed, 12 Jul 2017 09:46:29 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:8c0d:cddc:dbb9:7a95])
        by smtp.gmail.com with ESMTPSA id h90sm8697305pfh.133.2017.07.12.09.46.25
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 12 Jul 2017 09:46:26 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Andreas Krey <a.krey@gmx.de>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Bryan Turner <bturner@atlassian.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: [PATCH] gc: run pre-detach operations under lock
References: <20170704075758.GA22249@inner.h.apk.li>
        <20170705082027.ujddejajjlvto7bp@sigill.intra.peff.net>
        <20170706133124.GB1216@inner.h.apk.li>
        <CAGyf7-FnaWM=XNb_Skb1qR4vu_jAw-5swkgWpEDQqwM0NNq3YQ@mail.gmail.com>
        <20170711044553.GG3786@inner.h.apk.li>
        <20170711072536.ijpldg4uxb5pbtdw@sigill.intra.peff.net>
        <20170711090635.swowex7yry7kqb7v@sigill.intra.peff.net>
Date:   Wed, 12 Jul 2017 09:46:25 -0700
In-Reply-To: <20170711090635.swowex7yry7kqb7v@sigill.intra.peff.net> (Jeff
        King's message of "Tue, 11 Jul 2017 05:06:35 -0400")
Message-ID: <xmqqvamx1u3i.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Instead, we can do something a bit simpler: take the lock
> only for the duration of the pre-detach work, then detach,
> then take it again for the post-detach work. Technically,
> this means that the post-detach lock could lose to another
> process doing pre-detach work. But in the long run this
> works out.

You might have found this part gross, but I actually don't.  It
looks like a reasonable practical compromise, and I tried to think
of a scenario that this would do a wrong thing but I didn't---it is
not like we carry information off-disk from the pre-detach to
post-detach work to cause the latter make decisions on it, so this
"split into two phrases" looks fairly safe.

