Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7F0F1FA7B
	for <e@80x24.org>; Thu, 22 Jun 2017 19:03:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753457AbdFVTDe (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Jun 2017 15:03:34 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34841 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752392AbdFVTDd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2017 15:03:33 -0400
Received: by mail-pf0-f195.google.com with SMTP id s66so4250104pfs.2
        for <git@vger.kernel.org>; Thu, 22 Jun 2017 12:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ogwGkRJq8ietkdhAQ7H3thZpbzmn/2jVur5sTFTpqa8=;
        b=vDPuQCmVU0Lp15ela2nReScXRnEp8DxtEu+0tZ/X69Zn+rKTkiVcHL/tcoKvLw/4H9
         H60UyeGF3PUNIp7vLrdhIz5ZB/rZKlwQNQ8eI+xnvJSS9U5JgCzfqDSJzJSfT6pmEhLK
         8XGfYTRGdOfI7fWkrI5h3ElkB4L77WVmW3G58a51AzICWCPCFnNrBu0/KvIfMM+m619F
         xcgSCJvnSwo8XIoqmML01mPTk1bZN/R0y2+BCwiVqq9g+mscKTNwZybKJLOSnreIlQYW
         KOOET6cVqWPZWUkie1ckUEadbQl+AmtGghSqNJnxWqlmtan4JclVYnyEEV4UlDcfXC9S
         1zUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=ogwGkRJq8ietkdhAQ7H3thZpbzmn/2jVur5sTFTpqa8=;
        b=RapW78qkZw5pnvtm+20qqO4UmzkiqRhBJAfllJmRfPlk3bdOAAbvYpvZqYBoG9gJdI
         QJJym3Qi8L6rd4YfZwH/r9RlgYVUN5CDoDvjFhkeCYQQBq77QgZ4Df20bnuKO++QiGpH
         5dNyPOX+72vtn6jMgogBUJP1ikR8YvFRATxAGOZ4Xes2ysMzlJCQx2DMNwjfh0nSYNOK
         xyzkKK6ZwLvezgNecNJlc/EVupUPk3Ki3XUnOv6ABKrSS9KJHpV/X19OWv/g/44MIYaB
         oudCpzFYcsRS77KcmtteW8bT+HtvBwPDriqAw1TwfHfh8L5GuebSN+wzzqbe4WiQ97NU
         2UdA==
X-Gm-Message-State: AKS2vOwt31iiXC2EJ00MwEncfpceWvVmvvaHVioWW5FBQfVr05ja/lUr
        KjCVzjpXVDVV+w==
X-Received: by 10.84.232.135 with SMTP id i7mr4558579plk.300.1498158213165;
        Thu, 22 Jun 2017 12:03:33 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:20f6:6e44:6707:50bd])
        by smtp.gmail.com with ESMTPSA id 67sm5373635pfa.83.2017.06.22.12.03.32
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 22 Jun 2017 12:03:32 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Kyle Meyer <kyle@kyleam.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Sahil Dua <sahildua2305@gmail.com>
Subject: Re: Truncating HEAD reflog on branch move
References: <20170621213924.wh43i2h7v2zwihq3@genre.crustytoothpaste.net>
        <xmqqpodxm2t8.fsf@gitster.mtv.corp.google.com>
        <87efud7xjd.fsf@kyleam.com>
        <20170622151603.rrh2j7zsotyt2jxe@sigill.intra.peff.net>
        <xmqqziczkh4k.fsf@gitster.mtv.corp.google.com>
        <20170622184516.kq3y7nxwohm3coq4@sigill.intra.peff.net>
Date:   Thu, 22 Jun 2017 12:03:31 -0700
In-Reply-To: <20170622184516.kq3y7nxwohm3coq4@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 22 Jun 2017 14:45:16 -0400")
Message-ID: <xmqqvannkfp8.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I don't think this is quite right, though. We've decremented "recno"
> after assigning the old pointer to "reflog". So in the existing code,
> "reflog" in that second conditional pointing to the _next_ entry (or
> previous, really, since we are going in reverse order).
>
> So I think you'd need to look at commit->reflog again (after checking
> that we didn't go past the start of the array).

Perhaps.  I did the illustration that way simply because I was not
sure if the current "the entry was NULL from something new, so skip
and look at the previous entry's new" was correct to begin with.

