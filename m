Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49D121FCC7
	for <e@80x24.org>; Thu,  9 Feb 2017 23:25:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752408AbdBIXXa (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Feb 2017 18:23:30 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35593 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752811AbdBIXX3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Feb 2017 18:23:29 -0500
Received: by mail-pg0-f67.google.com with SMTP id 204so1454812pge.2
        for <git@vger.kernel.org>; Thu, 09 Feb 2017 15:23:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=T09+SkxJptUT7LFPOfTwp4ovn59HVwDZw+hYeSpGPQY=;
        b=gMzhEy77W0MQdX/C05kdZS09Z8F3WcrpiEg3gkjH9dX7MmT1b6tHp7Cec1C7zk7X/+
         P3D7xF5VXC/q3cUdeKaZ7rv9u5m3kZOyLf2rKNhCxRLXLzIGuka8/YyABgHun3rg/6Zi
         q89vM4NqjxFfmdFHWvzGBpPdkRa0ZHagwNB+vSamGKkExtcP66Q1IfsFGZce1WygXurV
         FW0Y6TQ9rT/duPQWhDMwoVGaMsx0iVkjV2FYjE5amu3HMRE5Ommy1VYn70G183N/Be71
         PuDXX3uFFP8jsgRB/sR0+mwf/5VGuje56WsxnHv7DMv/l5IULZ5xkAIceUcpa/Ht8cyY
         lm4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=T09+SkxJptUT7LFPOfTwp4ovn59HVwDZw+hYeSpGPQY=;
        b=nOF2Qa8gB3n10MA/12nJO5l/adhJLE5Ponpq087Pjd7JoW7ms7oQHbnPY7jtqxKTHY
         mA+dr9iNFMGbU+JI/HfdAWPG2SK3sY1ruUresjNcV/7mGdJorSYC2KA9HW8zXYOY2qZo
         bfxZCFjO06/pNxThtLzR+nf51dMUEV1DtXGyppgEv0Vv57utHOK+XHUOaz21JiH7RJtL
         S8rQnPz1IcbPl9F6WULZm8lohgI64yRy0vlxWhyv3RxXt/6NzoEaXQuxecjPYs9WQ7GQ
         6hs8WCVyd/X2rlQaRTZhN+OLH6JEqRPb33Kwoje1zvZ5xJKvCPQWx051H+/o85h4e96h
         v5Bg==
X-Gm-Message-State: AMke39mzH/FreFzqkV2LeFmOl22dA/Woyh0HE6RAUKAGs3QoO5BVpRA1ye1AtJn0P3Yztw==
X-Received: by 10.98.25.21 with SMTP id 21mr6459955pfz.46.1486680850026;
        Thu, 09 Feb 2017 14:54:10 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:704f:61dd:c9f4:9782])
        by smtp.gmail.com with ESMTPSA id l71sm31618864pga.13.2017.02.09.14.54.08
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 09 Feb 2017 14:54:09 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] rev-parse --git-path: fix output when running in a subdirectory
References: <50fe3ea3302c40f4c96eaa5a568837e3334f9dc4.1486555851.git.johannes.schindelin@gmx.de>
        <CACsJy8CigsWjAq5cmJ=cbBmj=DdJtHdMKxmoifftuz9+9kqJiQ@mail.gmail.com>
        <xmqqshnnnj6q.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1702092304250.3496@virtualbox>
Date:   Thu, 09 Feb 2017 14:54:08 -0800
In-Reply-To: <alpine.DEB.2.20.1702092304250.3496@virtualbox> (Johannes
        Schindelin's message of "Thu, 9 Feb 2017 23:11:14 +0100 (CET)")
Message-ID: <xmqqwpczm0vj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> I have no strong opinion for or against a "longer term" solution
>> that makes "rev-parse --git-path" behave differently from how it
>> behaves today, but I am not yet convinced that we can reach that
>> longer term goal without a transition period, as I suspect there are
>> existing users that know and came to expect how it behaves, based on
>> its today's behaviour.  Other than that I do not have suggestion on
>> this topic at the moment.

I think I was simply being silly (not merely "overcautious", but
just "silly") here.

There is no reason for people to use "--git-path" if they are not
preparing to work with secondary worktrees, because the whole point
of the feature is so that cases where "$(rev-parse --git-dir)/path"
does a wrong thing (e.g. end up referring to the main worktree thing
when you need to refer to your own, or vice versa).

> Given that
> ...
> it should be safe to assume that a transitional period is more likely to
> do more harm to our users than bring benefit.

In short, "--git-path as currently exposed to the end-users is
utterly broken and cannot have been used for anything sensible".  If
that is the case, let's just change that with an entry in the
release notes that states so (iow, there is no need for even a
backward compatibility notice, we just have an entry that says "this
was totally broken in such and such way, and now it is fixed to
behave this way").

That leaves what the right single-step behaviour change should be.
As I recall Duy said something about --common-dir and other things
Mike's earlier change also covered, I'd prefer to leave it to three
of you to figure out what the final patch should be.

Thanks.
