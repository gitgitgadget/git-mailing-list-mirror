Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 204DF2022D
	for <e@80x24.org>; Thu, 23 Feb 2017 19:11:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751457AbdBWTLK (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Feb 2017 14:11:10 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33893 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751099AbdBWTLH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2017 14:11:07 -0500
Received: by mail-pg0-f65.google.com with SMTP id s67so39320pgb.1
        for <git@vger.kernel.org>; Thu, 23 Feb 2017 11:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=8CfzGvwTfVSm64vZzpSiNViwboPYWoqo6KT/YpdsTRY=;
        b=bo25/uJB/lB1kF4VE5E69r15hG4rt7sxfgND67OCvuxmILHuz6eWPGClzwZOMnmWfi
         W5r5kHmJOtlH8Sj3sDD7evk+0WlPqe6tyJ4FLXWlMNQSHiEH8snitb2wezs/724iDDmK
         RbDbKTcLuvVUHcItcaJH1LckWK+fRzKKjPJVhnYWCEI707AqnGWJhWKXJmNqtDaqAyhA
         WRp/Gy93tMxfbJc/b43aLzIA7ma2uXkleABcCQQBNDTVnR4p2nkpZ5mRYXqHS9RW+6hq
         5lHAh7/P4OyW4BRTbtBBe2gGryXRioPDga+s3n8PUe5DujMxx33HENJ5di3EUCyCzaBY
         OnVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=8CfzGvwTfVSm64vZzpSiNViwboPYWoqo6KT/YpdsTRY=;
        b=WfBM5OERpMeBSEhXtUcpnNw3/yR7VDwJthNd1/02u/s9kaI1J9NYOu73ggXYSC5oYc
         lIhC0s8/vuLLB9CucVZnqZrytPGW0Y0mOaKC3vQOVFy4qPbRFMqxVXYT91l+H3ueyVJV
         J4kk1ePY8xNmnTmbpQBSzBIJARZbcmPlGP2GhHNvmBgaofGX0rQZEBpDsKQNCnIAMTFu
         8EsupaNLjUIXBJEGhc/9ps3O9GBiScb1oeqP2hWJnYjJhnVFsAI7RGWftaXCKttQ71f4
         pitnwOIQyEgCjqGmWRSdeGHCLabToJ6FvS19QZlGKU3Lktcmd0J5ufEluBSUyjwAy19B
         KLcg==
X-Gm-Message-State: AMke39nO9gQ+iCU3skV3XT96mol94NseNMowKIZwDY6Qhe1Zxtj1aJ3GKevxb8749dhJQw==
X-Received: by 10.84.130.100 with SMTP id 91mr57121617plc.167.1487877066918;
        Thu, 23 Feb 2017 11:11:06 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:8829:f260:c132:141f])
        by smtp.gmail.com with ESMTPSA id h17sm11188815pfh.62.2017.02.23.11.11.05
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 23 Feb 2017 11:11:06 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        David Turner <David.Turner@twosigma.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] http(s): automatically try NTLM authentication first
References: <20170222173936.25016-1-dturner@twosigma.com>
        <xmqqpoiaasgj.fsf@gitster.mtv.corp.google.com>
        <97ab9a812f7b46d7b10d4d06f73259d8@exmbdft7.ad.twosigma.com>
        <20170222233419.q3fxqmrscosumbjm@genre.crustytoothpaste.net>
        <20170222234246.wjp3567vesdusiaf@sigill.intra.peff.net>
Date:   Thu, 23 Feb 2017 11:11:05 -0800
In-Reply-To: <20170222234246.wjp3567vesdusiaf@sigill.intra.peff.net> (Jeff
        King's message of "Wed, 22 Feb 2017 18:42:46 -0500")
Message-ID: <xmqq1suo90za.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Wed, Feb 22, 2017 at 11:34:19PM +0000, brian m. carlson wrote:
>
>> Browsers usually disable this feature by default, as it basically will
>> attempt to authenticate to any site that sends a 401.  For Kerberos
>> against a malicious site, the user will either not have a valid ticket
>> for that domain, or the user's Kerberos server will refuse to provide a
>> ticket to pass to the server, so there's no security risk involved.
>> 
>> I'm unclear how SPNEGO works with NTLM, so I can't speak for the
>> security of it.  From what I understand of NTLM and from RFC 4559, it
>> consists of a shared secret.  I'm unsure what security measures are in
>> place to not send that to an untrusted server.
>> 
>> As far as Kerberos, this is a desirable feature to have enabled, with
>> little downside.  I just don't know about the security of the NTLM part,
>> and I don't think we should take this patch unless we're sure we know
>> the consequences of it.
>
> Hmm. That would be a problem with my proposed patch 2 then, too, if only
> because it turns the feature on by default in more places.
>
> If it _is_ dangerous to turn on all the time, I'd think we should
> consider warning people in the http.emptyauth documentation.

I presume that we have finished discussing the security
ramification, and if I am not mistaken the conclusion was that it
could leak information if we turned on emptyAuth unconditionally
when talking to a wrong server, and that the documentation needs an
update to recommend those who use emptyAuth because they want to
talk to Negotiate servers to use the http.<site>.emptyAuth form,
limited to such servers, not a more generic http.emptyAuth, to avoid
information leakage?

If that is the case, let's take your 1/2 in the near-by thread
without 2/2 (auto-enable emptyAuth) for now, as Dscho seems to have
a case that may be helped by it.
