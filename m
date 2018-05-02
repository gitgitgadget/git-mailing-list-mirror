Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69EBD21847
	for <e@80x24.org>; Wed,  2 May 2018 02:47:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751069AbeEBCra (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 22:47:30 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34428 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750803AbeEBCr3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 May 2018 22:47:29 -0400
Received: by mail-wm0-f66.google.com with SMTP id a137so15552873wme.1
        for <git@vger.kernel.org>; Tue, 01 May 2018 19:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=UqAeiEOrXeWtdjA38qerH9O9AVVFnOmAQMKqjtPoCe4=;
        b=UPB0a2g0HnJmgO28jAKSjMbTveOisiV+yPQjgeLZjPMDfP0dKC9LTEiEPWESWF0K4h
         JisO42V0aA2oMrUjXcYdWATOzwK40mS3XWIeCE0/d6dsd3XmciZt6fEnZDKXLcg77t+2
         6pQqBWdKbhGQbQrZmdaY8f/BNJrZTJ9SaG/Xh5OeAd0aSOqvaMBtOacKvnnTK3Sqbw5T
         68gdjnVh0GJwINifKlu3ONXqzf1jDxa+fpBBwwNvD548UHodmg2H9zvFSzdk10c5bNAw
         7AQmwDTr6Gq2T1ir8tzJAUjayVi1TLkJ9YvEhAHII5aazy7XG0I6e2MkuO+PqP1jnBte
         LCPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=UqAeiEOrXeWtdjA38qerH9O9AVVFnOmAQMKqjtPoCe4=;
        b=rcxZ9czWuGqEVD9kqYiRG3xpeMM51Hxjn4qMLNFfw/4Pf0mSpTIexy0Yh8kS1JEzXt
         5C7RTz3Yn3qe/DJC12xMZQt228Th+ymi7hdZWIZibjyiRdEVB+K/gU6o3cfrcO2EYTPE
         ALdHRZKpzBygROPCfvp/UzZjIwjInf2HhkuQEhfCmGWaVeOeHwcQb+VNSeJGBvGk8aYb
         +B7L5CgDvf8/H2K9uRsElojGJkUn2Alfqxm2u9QCl14WpUqjrm0HERYhPHJfTzJIoc2U
         KGp4aorBNjq/VeZvOVhimGdFj73Pxbrtk+vDZTG9fN/ntHauj87W3iIWRz78oDJSkFaw
         PaOQ==
X-Gm-Message-State: ALQs6tC1f5yOqWNazlt2FQIXo/UC3qUEY8vBrmndNBdaZbKwVjj17HPu
        dp+s3PtHrBkM97fvUgnWN3E=
X-Google-Smtp-Source: AB8JxZpN4d5sM1xUWukVCz35I7FzkK5gObWudX8JX0JxeiRvUFyBRda9E04gYCUGd4KJOlg7p5FAUQ==
X-Received: by 10.28.69.154 with SMTP id l26mr12200933wmi.95.1525229248288;
        Tue, 01 May 2018 19:47:28 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id x65sm12964709wme.31.2018.05.01.19.47.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 01 May 2018 19:47:27 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Isabella Stephens <istephens@atlassian.com>
Cc:     sunshine@sunshineco.com, szeder.dev@gmail.com, git@vger.kernel.org,
        peff@peff.net, bturner@atlassian.com, jacob.keller@gmail.com
Subject: Re: [PATCH v4 1/2] blame: prevent error if range ends past end of file
References: <CAPig+cSH-y7ChDE_LW55M_wB=KhD7uJHXX=OvZ=1ri5KfYQ5Sg@mail.gmail.com>
        <20180426074502.78318-1-istephens@atlassian.com>
        <20180426074502.78318-2-istephens@atlassian.com>
        <xmqq7eot1nhl.fsf@gitster-ct.c.googlers.com>
        <25cd86ff-a5c0-a968-62d2-4365e5e17a81@atlassian.com>
        <xmqq36zh1jtj.fsf@gitster-ct.c.googlers.com>
        <dee9083d-0745-6b98-fe5e-fc19d2a5bb9a@atlassian.com>
Date:   Wed, 02 May 2018 11:47:26 +0900
In-Reply-To: <dee9083d-0745-6b98-fe5e-fc19d2a5bb9a@atlassian.com> (Isabella
        Stephens's message of "Fri, 27 Apr 2018 14:15:53 +1000")
Message-ID: <xmqqzi1iwz7l.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Isabella Stephens <istephens@atlassian.com> writes:

> This is the existing behaviour. -L10,-20 for example will blame the
> first 10 lines of a file, it will not fail. My patch doesn't change
> this. The case I am discussing is -L,-20 which at the moment blames
> the first line of the file. Trying to go backwards from the start of
> a file should be considered invalid, in my opinion, however I don't
> feel strongly about it - I don't expect this case is common in 
> practice.

I tend to think that -L,-20 is a sloppy spelling of -L1,-20
(i.e. anything omitted gets reasonable default, and for something
that specifies both ends, i.e. "<begin>,<end>", the beginning and
the end of the file would be such reasonable default, respectively),
and as such I would imagine that the user would expect the same
behaviour as -L1,-20.  If the longhand version gives only the first
line (i.e. show up to 20 lines ending at line #1), I'd say that
sounds sensible.

Or does -L1,-20 show nothing and consider the input invalid?  If so,
then sure, -L,-20 should also be an invalid input.

