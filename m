Return-Path: <SRS0=m/64=4N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53168C35DF5
	for <git@archiver.kernel.org>; Tue, 25 Feb 2020 11:40:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E9F720CC7
	for <git@archiver.kernel.org>; Tue, 25 Feb 2020 11:40:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sI7IcGK0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730147AbgBYLk4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Feb 2020 06:40:56 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36866 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729178AbgBYLk4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Feb 2020 06:40:56 -0500
Received: by mail-lj1-f193.google.com with SMTP id q23so13680289ljm.4
        for <git@vger.kernel.org>; Tue, 25 Feb 2020 03:40:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=xw+kAFyrCa5sWHpnMua73sv79FHLbAJ3+WJDyA6eHho=;
        b=sI7IcGK0znppGHwLSdOKFj8/EPYygv8uQzQIbvcoWMjJ6rFgc/L0DXpGZKp6ab4WmQ
         /RIhGSoGdmJLtOFJuku/pVJ8xDotw2XXX0g7hg5QNm8REFizwce8AcV1aig19ia+PTSk
         pWlJwDUxr55rkmx9jjM5o1T788nO19iE1MqswrG8LntgV00IxQkyoWIO1VimCrPbYOIO
         RQ6KV9ejIeIl/FUMPOxo3s2KrcnIJPv2L83UqWCFOu9DgQIDwm5ZBYDpnzliWYYtQaoE
         ZfKuL6nu9LnKcVtT8KYtbSRURMJRaYgv64mXuHIUFqt1RM3ffvQDhFhibZhmM8cJ0GPZ
         +fOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=xw+kAFyrCa5sWHpnMua73sv79FHLbAJ3+WJDyA6eHho=;
        b=tQJJAntVwIH/PInjeSjvHhuaFc1JmcLR76qDJlywfpRZFhORYJ5FBPLuM4KPo5VlkU
         jaJ6v3coQJUICgAK7iwbtvJleT9Z+2RgvMsrMsNR1U4GxkQUOFUspqcXAS77hS7QJmHw
         IHFTDIMMmd/MVhsGmP5RLp7xHfpZod9lpMYzePUXEJ8GqHhSWefh3Bj5dsAH8MqehdFm
         7caI0hWsOyy8fybbTlctfEd23mdmogQBFdXHKILL0rHjTYVKD9t22fygw+ClgF7xB9Z4
         6HkLWM121lF2U3Y59n81jeurV0xh7HUWR1h4QTCMtNgdF2PVEzd3Zet80sNedbdHRefB
         zrFQ==
X-Gm-Message-State: APjAAAVaucXdjR74TkzT/Am9imaBIhn1B6sfrQhuJZ12WZrChX3ttXxz
        B0YpsP43DBoYlPm/xvcGYaz0m61yxvM=
X-Google-Smtp-Source: APXvYqycfMI0haXwQjxpDJGzEHEqn7gtZvhHAINq9PrxcA9WmPiO/bFQTewsSgduLDh8OtkdD0cM6g==
X-Received: by 2002:a2e:9716:: with SMTP id r22mr12052749lji.224.1582630854273;
        Tue, 25 Feb 2020 03:40:54 -0800 (PST)
Received: from Laptop-Acer-Aspire-F15 ([158.75.53.82])
        by smtp.gmail.com with ESMTPSA id e25sm7542392ljp.97.2020.02.25.03.40.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Feb 2020 03:40:53 -0800 (PST)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Garima Singh <garimasigit@gmail.com>
Cc:     Garima Singh via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Emily Shaffer <emilyshaffer@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Garima Singh <garima.singh@microsoft.com>
Subject: Re: [PATCH v2 07/11] commit-graph: write Bloom filters to commit graph file
References: <pull.497.git.1576879520.gitgitgadget@gmail.com>
        <pull.497.v2.git.1580943390.gitgitgadget@gmail.com>
        <39ee0610800d7d2d92785d392df941fc5a0b231b.1580943390.git.gitgitgadget@gmail.com>
        <86pneahaop.fsf@gmail.com>
        <de3f1f7e-0f2f-6c5d-6290-3ba5d37a0ea5@gmail.com>
Date:   Tue, 25 Feb 2020 12:40:49 +0100
In-Reply-To: <de3f1f7e-0f2f-6c5d-6290-3ba5d37a0ea5@gmail.com> (Garima Singh's
        message of "Mon, 24 Feb 2020 16:14:38 -0500")
Message-ID: <86sgiyc2ta.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Garima Singh <garimasigit@gmail.com> writes:
> On 2/19/2020 10:13 AM, Jakub Narebski wrote:
>> "Garima Singh via GitGitGadget" <gitgitgadget@gmail.com> writes:
[...]
>>> diff --git a/Documentation/technical/commit-graph-format.txt b/Document=
ation/technical/commit-graph-format.txt
>>> index a4f17441ae..22e511643d 100644
>>> --- a/Documentation/technical/commit-graph-format.txt
>>> +++ b/Documentation/technical/commit-graph-format.txt
>>> @@ -17,6 +17,9 @@ metadata, including:
>>>  - The parents of the commit, stored using positional references within
>>>    the graph file.
>>>=20=20
>>> +- The Bloom filter of the commit carrying the paths that were changed =
between
>>> +  the commit and its first parent.
>>> +
>>=20
>> All right.
>>=20
>> Should we also state that it is optional (meta)data?  This would be
>> first optional piece of data stored in commit-graph, I think.
>>=20
>
> However the entire commit graph file is non critical metadata since git c=
ommands
> work just fine without it, just slower. The same applies to the changed p=
ath
> bloom filters.=20
>
> Based on the definition of optional you are suggesting, edge data is opti=
onal
> because not every commit-graph has octopus merges.=20

Well, edge data (EDGE chunk) is optional in different way from Bloom
filter data.  The former depends on the repository (whether there are
octopus merges used), the latter is opt-in user choice (whether to run
`git commit-graph write` with the `--changed-paths` option, or in the
future equivalent config option).

To provide some advise that can be acted upon: perhaps it would be
better to start with "It can store", or end with "if requested" or
"optionally".  For example the change could look like the following
suggestion:


 The Git commit graph stores a list of commit OIDs and some associated
 metadata, including:
[...]
+- The Bloom filter of the commit carrying the paths that were changed betw=
een
+  the commit and its first parent, if requested.
+

Best,
--=20
Jakub Nar=C4=99bski
