Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8FA451F803
	for <e@80x24.org>; Thu, 10 Jan 2019 22:54:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729578AbfAJWyd (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Jan 2019 17:54:33 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44123 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727634AbfAJWyd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jan 2019 17:54:33 -0500
Received: by mail-wr1-f66.google.com with SMTP id z5so13188275wrt.11
        for <git@vger.kernel.org>; Thu, 10 Jan 2019 14:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=qzeV6HflCV8KEf9vaDI5saCwSVTSeXJpQMGL7TdiLRI=;
        b=pH/ftPqD5NYMJZz5XpSdtmdrYPsK1I3CJTG47MYHcWuSuuX2Tc/i1EjB5eV7sAEaVS
         ucU/9bklKGvy2b9iVl8UY7yrk0kmqahte61bXfm59bWpdYJt+MCKVb9/hv0scYaE/aOj
         ia71KEaRrCIx26S6lHXAVuPCl91uO4WPvPX7Bfe1KWpuB0DaetwjPCzr5Jg/+hq6Y011
         MldcqH4LSN3DUDCINF1WnkFtwYjW2MYxcPvIb85gNAZS+dfNQVDOQ2MgXGilAcvD1+cW
         OUXMmtM08iKHOTN6SszT+g8rwyE77wQvNgaL0VErkTmyALAJMZQljygYa+BxPLMeowRf
         KfXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=qzeV6HflCV8KEf9vaDI5saCwSVTSeXJpQMGL7TdiLRI=;
        b=NSdtrTNQUycr+0zq5gU8TVDlOe5FBTsVlq/1G5uRV2E3piFDAuqPrVRdS78h+ZrGAZ
         f7/WaMTubWgWLkwnBJgQXZjcf4LgHvHtndr/ME2+S9xZKhwREN0Z6hbsKWWxsFCt1C1K
         E3JVjHhuQwK0gOmjiYnxRONiLyd5gKx8SPLFVIHLtLxAAZ2fxw/Khv35E3PRJ6+BRN+2
         H2VRtm7nva5234iwK9JMM/DC5ctVZk2HwXZcE9pxT3lFVv+2KUThSDUqdPHM/GyX3dXw
         tBpV98IS+4sCrvGTwz8V+2G1T1QfBFNwmbDfhcsPiaF6U+qKC+q/FJM05W4QndSl4yGe
         chtg==
X-Gm-Message-State: AJcUukd+XdqX+6XY/NdgFFALh6Ozf+HozOX6Pv0nysfgCGY6l5FbeUFp
        HbGzQZizxt4J7nGwBTcPVqk=
X-Google-Smtp-Source: ALg8bN5kN7BQ3j90JC/g92cUANxWa4D+FeUTGXwmchZRsikXDcKR+YLZw9RplTXC8Caq/ntc3v2LhQ==
X-Received: by 2002:a5d:470b:: with SMTP id y11mr10993142wrq.16.1547160871393;
        Thu, 10 Jan 2019 14:54:31 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id y138sm23920484wmc.16.2019.01.10.14.54.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 Jan 2019 14:54:30 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     steadmon@google.com, git@vger.kernel.org, avarab@gmail.com
Subject: Re: [PATCH] upload-pack: teach deepen-relative in protocol v2
References: <20190110212857.58772-1-jonathantanmy@google.com>
        <20190110221132.52443-1-jonathantanmy@google.com>
Date:   Thu, 10 Jan 2019 14:54:30 -0800
In-Reply-To: <20190110221132.52443-1-jonathantanmy@google.com> (Jonathan Tan's
        message of "Thu, 10 Jan 2019 14:11:32 -0800")
Message-ID: <xmqqwoncyvh5.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

>> > This, when applied on top of ecbdaf08991, seems to break t5702.30,
>> > at least for me.
>> > 
>> > Tip of 'pu' in today's push-out will be broken as it has this patch
>> > merged.
>> > 
>> > Can somebody take a look?
>> 
>> I can reproduce this. I'll investigate this further. In the meantime,
>> feel free to remove this from pu.
>
> The test failure is caused by a bug I fixed in [1]. I've verified that
> if I apply [1] first, then this, all tests pass. If you do include this
> patch in some branch, it should be dependent on [1], but I understand if
> you'd like reviewers to look at both this and [1] first.
>
> I thought I tested this without something that fixes the issue fixed by
> [1] and it passed, but apparently that's not true.
>
> [1] https://public-inbox.org/git/20190110193645.34080-1-jonathantanmy@google.com/

OK, that means that it would be the cleanest to make them into
two-patch series, I guess.

Let's requeue these two and see what happens.

Thanks.

