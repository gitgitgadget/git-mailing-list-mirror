Return-Path: <SRS0=68ZU=2Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75155C2D0C0
	for <git@archiver.kernel.org>; Thu, 26 Dec 2019 22:37:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37C912080D
	for <git@archiver.kernel.org>; Thu, 26 Dec 2019 22:37:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B9d+efOH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbfLZWha (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Dec 2019 17:37:30 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44728 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbfLZWha (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Dec 2019 17:37:30 -0500
Received: by mail-pl1-f195.google.com with SMTP id az3so10955012plb.11
        for <git@vger.kernel.org>; Thu, 26 Dec 2019 14:37:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fx8pxOUGCO42S5kGKdjzdpXnky6xvEs8pa2W+lLEH3o=;
        b=B9d+efOH5jPks8sz60MYXpV5iB6gOH1monvsl6iYt1DGUrEZQTDk3VK6BagWxTc4Da
         XjVQ6r2PwIPDnvIGizw/6mm+lPU15ox/VBM7zQpo98g4MZAxzUb180uSOBpiLLdi4uOd
         UjOUuWj6sp90/rTLdiOo8mqWZEKZ5yDCatdGVJKuGe1ZgBmOF2DyHnjKjgIsqfHKWBO3
         4iv70ZWcQ3T4uIfNuI8lSUJ7dCjrWS+bZt2++ce/xtsqsAgInysv4zhZXu74Lz/1gScP
         9vkywcWCxYfVMkUqVQmHSEGln6uYAKEwvG6ws6yl9nkaq9CZSGhcUlaeumeC9390Dsp9
         LIbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fx8pxOUGCO42S5kGKdjzdpXnky6xvEs8pa2W+lLEH3o=;
        b=Ws0zFpEoT3LAEf43IvU0+44fE10vpoPZkvNsaynygq09ll8aXlKZ9vSAchX69/D1Bs
         ZddAiCBxPkR3CE4WlaIjNr8KsHz7coZGn8q1PUTLS8v2AzXaOEiP+h9wFDzLSxXeKdTJ
         o/Rt5GvI599fhwc9l6XbPk4KJFJT4zp0Uf6n/BBhKo2RvPNSt85Fw0Fqo3c0fcb/r/xF
         VaXtyyOwR8plmNidskegjd68EpD746tq9RNSDpns6DGpIG4zDr4nukHSa2e8Vi2mmYFg
         L4jToFPnB68dLWptgaPmYrborXS/yPrL2iYB8i6aDFOK/BO1QLOWmfKOelgXgF4Q7830
         m+pQ==
X-Gm-Message-State: APjAAAWkpSMI5EwlmExVmHOpyBUnREpfgNtAG9iq6thNt/jMPu8rrxdM
        PE7Plt/cIOTAuA8ZpPb2CSM=
X-Google-Smtp-Source: APXvYqwxuMnGL3s/EtF4gaWaGuHVp3zsAJYOOxX24twcnYjQrHXZbmpkClYzXqhctuydb+7YYoeJRQ==
X-Received: by 2002:a17:902:7c13:: with SMTP id x19mr49724840pll.236.1577399849394;
        Thu, 26 Dec 2019 14:37:29 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id b98sm11822883pjc.16.2019.12.26.14.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Dec 2019 14:37:28 -0800 (PST)
Date:   Thu, 26 Dec 2019 14:37:27 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/2] t/check-non-portable-shell: detect "FOO=
 shell_func", too
Message-ID: <20191226223727.GB186931@google.com>
References: <20191224005816.GC38316@google.com>
 <20191224010110.GF38316@google.com>
 <xmqqfth6lwgl.fsf@gitster-ct.c.googlers.com>
 <20191226195357.GA170890@google.com>
 <20191226195747.GC170890@google.com>
 <xmqq7e2ilu1j.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq7e2ilu1j.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> Just like assigning a nonempty value, assigning an empty value to a
>> shell variable when calling a function produces non-portable behavior:
>> in some shells, the assignment lasts for the duration of the function
>> invocation, and in others, it persists after the function returns.
>>
>> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
>> ---
>> If it would be useful for me to send a copy of the "Enable protocol v2
>> by default" series rebased on top of this, let me know.
>
> When rebased, t5552 passes (including the test lint) at the "request
> v0 explicitly for some tests" step now.
>
> The tip of "promote proto v2 to default" series fails at 5552.5
> with or without these two patches, though.

Oh, subtle.  With shells that leak variable assignments after a
function returns (such as bash when run as 'sh'), 5552.5 was running
with GIT_TEST_PROTOCOL_VERSION=0, masking the issue.

In protocol v2, there is no "stateful" mode: negotiation always uses
the stateless-rpc path, and the stateless-rpc path involves more care
to avoid chatter during negotiation (since request size increases with
each round).

This is why b1.c14 and b1.c9 don't show up in the v2 trace.  Processing
the trace with "git name-rev --stdin" yields

 packet:        fetch> want 184bd23dc533e1e63153e7e181411bd29acca918
 packet:        fetch> have f65fc9b4d5c1cb76494a7f8df0230d8d29a33e67 (tags/b8.c19)
 packet:        fetch> have 334d40a157dec5d93023976c30cd22b24bdc279a (tags/b7.c19)
[...]
 packet:        fetch> have e3496f08debed7528bd7e4c4a12b71d1a99d697f (tags/b1.c19)
 packet:        fetch> have e7bb01cb25bebd0341c9d62f4c7e929a99b6ed4b (tags/b8.c17)
 packet:        fetch> have 7f5656e94770d527d4f909fd5e2ea274ec63177a (tags/b7.c17)
[...]
 packet:        fetch> have 17639a004fe8511fe1de57dd9ddabf2ee0de902d (tags/b1.c17)
 packet:        fetch> 0000
 packet:        fetch< acknowledgments
 packet:        fetch< ACK e3496f08debed7528bd7e4c4a12b71d1a99d697f (tags/b1.c19)
 packet:        fetch< ACK 17639a004fe8511fe1de57dd9ddabf2ee0de902d (tags/b1.c17)

By comparison, with protocol v0 over stateful bidirectional
transports, there's an additional round-trip folded in:

 packet:        fetch> have f65fc9b4d5c1cb76494a7f8df0230d8d29a33e67 (tags/b8.c19)
 packet:        fetch> have 334d40a157dec5d93023976c30cd22b24bdc279a (tags/b7.c19)
[...]
 packet:        fetch> have e3496f08debed7528bd7e4c4a12b71d1a99d697f (tags/b1.c19)
 packet:        fetch> have e7bb01cb25bebd0341c9d62f4c7e929a99b6ed4b (tags/b8.c17)
 packet:        fetch> have 7f5656e94770d527d4f909fd5e2ea274ec63177a (tags/b7.c17)
[...]
 packet:        fetch> have 17639a004fe8511fe1de57dd9ddabf2ee0de902d (tags/b1.c17)
 packet:        fetch> 0000
 packet:        fetch> have a1d75daa2f482f89171f092778da506803e54531 (tags/b8.c14)
 packet:        fetch> have b2e9b68d2650b77283421888be8a950c18bab29d (tags/b7.c14)
[...]
 packet:        fetch> have b89f6499d7cee40ef422edb15433a10f82de0206 (tags/b1.c14)
 packet:        fetch> have e4190b433240834c895347214d29426a094f2fe2 (tags/b8.c9)
 packet:        fetch> have 5f1aa7f016defcf74e5e1d4991342987c9d4b447 (tags/b7.c9)
[...]
 packet:        fetch> have b76868e654ce45adb9e06f638e48a72556843361 (tags/b1.c9)
 packet:        fetch> 0000
 packet:        fetch< ACK e3496f08debed7528bd7e4c4a12b71d1a99d697f (tags/b1.c19) common
 packet:        fetch< ACK 17639a004fe8511fe1de57dd9ddabf2ee0de902d (tags/b1.c17) common

Patch coming in a moment to force v0 here with a comment.

Thanks,
Jonathan
