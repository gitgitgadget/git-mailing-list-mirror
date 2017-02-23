Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C2CD20254
	for <e@80x24.org>; Thu, 23 Feb 2017 20:37:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751351AbdBWUh3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Feb 2017 15:37:29 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35640 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751191AbdBWUh1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2017 15:37:27 -0500
Received: by mail-pg0-f68.google.com with SMTP id 1so251513pgz.2
        for <git@vger.kernel.org>; Thu, 23 Feb 2017 12:37:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=dgJiTj3tG6mpftNG/wKkTDiD4/uVh1ToLmCYgxx3Oc4=;
        b=LBEnFMwoVp+iOtTdW5Ly49w0o2L+z8uWilfjsbnDC1ZkaAWUYqRaoUIRQuIZjsgrVd
         DSil8Ruwd/iskX+u+OpW1v55o15yDu/YXn15oBWcM0WnPhDvB3JBl3DQUl4OYJMRzF2O
         9kYcyDWuh/odtDuLkvk8i7k5lNsjCA/JpmuK/gFjj9yVDD5MrJXoVvS6tMrulHjn31Wl
         /wFBvkd4CPld6hvLG3sqqkb+BRKgg7fdvEwrNbzZuQqkNRcRiDt4SOfOe5M8CJai41oS
         EeTuBiZtwtnmPw1DZS/LAUjHv1dU+6LiGzOENyLiAmi90u0eHJ92NTBBXdf2PA3ydso5
         eKlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=dgJiTj3tG6mpftNG/wKkTDiD4/uVh1ToLmCYgxx3Oc4=;
        b=JNBKZlYSeIXaAEjjmUrvGHZexaLF3DMSWE532AuktTbSGFDJ3OraiMgCw16OcdsyMf
         2B9xit8YS55wdjobqaaCoLodEm1JpAQiZOFrLaJ4BzV5ilhJ8KiWrQyvIk07DxQ85MAG
         F68GEUY5YeDY97NpJEJ9TtCURhoQYXm9uFez8WNYjzYPs1sO/myk4NZNJJ38UXF4t4SN
         Nb9ROOoyle5W1zPj4u4DFI17uN7jdta9psnh5Yf9VQlGhqY842dfFzCQedkFMYQ0tJiH
         ha++tW1cfwFGzXN1H9KI+qPP3GiVFF/u3iyXmJ32FzS5D3bXwc5s20KyWPmymJTZZuH7
         chPw==
X-Gm-Message-State: AMke39kgJQXOdNIHhbTUBfDaWQGeOQ/Ro8booezVXn0RfX0Zh/dmSK9qKtHyKkH7oEw0JQ==
X-Received: by 10.99.174.4 with SMTP id q4mr50734274pgf.186.1487882246906;
        Thu, 23 Feb 2017 12:37:26 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:8829:f260:c132:141f])
        by smtp.gmail.com with ESMTPSA id u75sm5808427pfk.3.2017.02.23.12.37.25
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 23 Feb 2017 12:37:26 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        David Turner <David.Turner@twosigma.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        "sandals\@crustytoothpaste.net" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] http(s): automatically try NTLM authentication first
References: <20170222173936.25016-1-dturner@twosigma.com>
        <xmqqpoiaasgj.fsf@gitster.mtv.corp.google.com>
        <97ab9a812f7b46d7b10d4d06f73259d8@exmbdft7.ad.twosigma.com>
        <xmqq8toyapu6.fsf@gitster.mtv.corp.google.com>
        <20170222213410.iak43asq775tzr42@sigill.intra.peff.net>
        <alpine.DEB.2.20.1702231806340.3767@virtualbox>
        <20170223194237.eckkpiqv7inuz7un@sigill.intra.peff.net>
Date:   Thu, 23 Feb 2017 12:37:25 -0800
In-Reply-To: <20170223194237.eckkpiqv7inuz7un@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 23 Feb 2017 14:42:37 -0500")
Message-ID: <xmqqlgsw7iey.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I suspect it isn't enough to help without 2/2. This will tell curl that
> the server does not do Negotiate, so it will skip the probe request. But
> Git will still feed curl the bogus empty credential.
>
> That's what 2/2 tries to fix: only kick in the emptyAuth hack when there
> is something besides Basic[1] to try. The way it is written adds an

In your [1] you wanted to mention that Digest would have the same
property as Basic, or something like that?

> extra "auto" mode to emptyAuth, as I wanted to leave "emptyauth=true" as
> a workaround in case the "auto" behavior does not work. And then I
> turned on "auto" by default, since that was what the discussion was
> shooting for.
>
> But if we are worried about turning on emptyAuth everywhere, the auto
> behavior could be tied to emptyauth=true (and have something like
> "emptyauth=always" to _really_ force it). I don't have an opinion there.

I do not have a strong opinion, either, but it sounds like that even
the "disable emptyAuth hack if the server is Basic only" variant
would be much better than setting emptyAuth on by default.  At least
the user whose issue was reported in Dscho's message would be fixed
by such a variant, I would think (i.e. talking to a server with no
Negotiate and emptyAuth set to true results in no attempt to give
the user a chance to tell who s/he is --- your 2/2 will turn
emptyAuth off in that case).


