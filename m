Return-Path: <SRS0=3i0n=DJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 553A3C35257
	for <git@archiver.kernel.org>; Fri,  2 Oct 2020 22:44:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B93620719
	for <git@archiver.kernel.org>; Fri,  2 Oct 2020 22:44:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dhk5v9hp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725772AbgJBWoF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Oct 2020 18:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbgJBWoE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Oct 2020 18:44:04 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C490C0613D0
        for <git@vger.kernel.org>; Fri,  2 Oct 2020 15:44:04 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id 10so3677462qtx.12
        for <git@vger.kernel.org>; Fri, 02 Oct 2020 15:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=Vqar78DikLs+pm0uIbMol31G7AISu1RswHLJU1gOgLk=;
        b=dhk5v9hp5kjwsJzbgrSWONdvsJf6gpbnRVPqOJeCLzukaqy3T+oEEP+9SUtjTeqU/5
         jZpnbv7VhcqkehXy0jS2QXUZviKRuf/9rXD/XzRmXC+Z+42FoMVX3opTjzHAzQuXAzaT
         UHiWTcer7K2ZPGW5f+cHR35Y7sthbeY57pb6vFKpAKacvtjSKElZUHZhB1ks4WqRDGnU
         dfG2xn05QXhDHHrq5rytP8h1QohHZ+sZPRzwbrLksn9+T/dSuf3rxXo0T+f60ucBzsMT
         H6ATy3wtZaL4ZaE3bImKLkxf/XLtNvGcIcCQeJSm/yqB6FBtQ0lR+GydmEbdxd1/RAuT
         W7Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Vqar78DikLs+pm0uIbMol31G7AISu1RswHLJU1gOgLk=;
        b=cwiMfn9XRm3gn7/OZ/gfR6AhtqztbdnkXbzCmZrvWN0lJPOQmp/ZJid7r+/Bw73pe8
         YrqifXDHbynSTQmwF/hhp/ir35ShS4Ebm9yd1ZgTxUdyWDv1Mbx9gQdZuRU9OaCSNkYf
         /o6iwGa2IgoD18v3BrgxXNLGxy1nFIMNRm3ITQ8q4v6sr7CqBIN2Kp/VoCuJeg+smDdD
         NXk+GGS2vVrzqmLhVPszufrh/XddXtL1uEoE75BcqSpPpE3DH8Ago/0TjET+iYxB1vbB
         BLDp173sikfI2iUia8UNUQFaxFHJz327jNArgjCaAJqaHZ5b6ZI61uL0oww/IwEwxXqk
         yqDg==
X-Gm-Message-State: AOAM5334ZahS96p+cwIzxalmaxpayyfqXk7LypdP8m2fDKAHKUK0pj6p
        1MrZquVBAHRoOAKX/gZGyefSPqVWAHO/goj2
X-Google-Smtp-Source: ABdhPJyDu8OidCR6O/Rg0SLZKk+HNaJLTkNOuX8mt+eKzzALrvvl/oYokePiYZdJAxLka72PU4wfcA==
X-Received: by 2002:ac8:794c:: with SMTP id r12mr4601112qtt.162.1601678642909;
        Fri, 02 Oct 2020 15:44:02 -0700 (PDT)
Received: from [192.168.0.108] (d-65-175-178-104.nh.cpe.atlanticbb.net. [65.175.178.104])
        by smtp.gmail.com with ESMTPSA id t26sm2044862qkt.29.2020.10.02.15.44.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Oct 2020 15:44:02 -0700 (PDT)
Subject: Re: git blame --ignore-rev does not work
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Harrison McCullough <mccullough.harrison@gmail.com>,
        git@vger.kernel.org
References: <CAHLeu+x-z4ntmBezcVUWssZrCm03Md6ZR8-ZQmjkeB5YT89caQ@mail.gmail.com>
 <d805f025-fbfb-0249-a50c-ff857dc2e29d@web.de>
From:   Barret Rhoden <brho@google.com>
Message-ID: <3e9b34f9-f61e-f3f1-45a3-6352641e434a@google.com>
Date:   Fri, 2 Oct 2020 18:44:01 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <d805f025-fbfb-0249-a50c-ff857dc2e29d@web.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi -

On 10/2/20 5:40 PM, René Scharfe wrote:
[snip]
> I don't know if these revisions are not ignored due to bugs or because
> the feature just isn't strong enough, yet, but I would expect your
> particular case to be represented by at least one of these...

Correct.

When skipping a revision, the algorithm attempts to find another 
revision that could be responsible for the change.  But it might not be 
able to find anything.  Consider a commit that just adds a few lines to 
a file with only 'foo' and 'bar':

commit: "Adding Lines"
-------------
  foo
+No commit
+ever touched
+these lines
  bar

If we ignored that revision, which commit do we assign those lines to? 
If they were "similar" to the existing lines, then the algorithm might 
match.  But in general, we can't find 'correct' (as defined by a user) 
matches for arbitrary changes.

I usually run git with these settings:

[blame]
         ignorerevsfile = .git-blame-ignore-revs
         markIgnoredLines = true
         markUnblamableLines = true

Which points out when --ignore-revs is doing something.

Thanks,

Barret


