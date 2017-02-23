Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17D45201B0
	for <e@80x24.org>; Thu, 23 Feb 2017 02:15:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933254AbdBWCPt (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Feb 2017 21:15:49 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35838 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932465AbdBWCPr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Feb 2017 21:15:47 -0500
Received: by mail-pg0-f67.google.com with SMTP id 1so2713160pgz.2
        for <git@vger.kernel.org>; Wed, 22 Feb 2017 18:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=QKeJlCqYmvLjEv6xyWQYjw9DbuQ+1n1BTs6G47IEdQY=;
        b=VbF+gwS+ysbGKLSxDaC6yKgoBGL1LixNvcEqsA8c1YsF7FMVCrAoC162HyePQjtslh
         MyNaDyuIC6RU2wckyAvgsG5GODQDoJQiRUxf9djo7fkqtzp4SORP1GenslKuQNWOTqjn
         MQmB2n7qFLL4qnuEPBaSwq92Pb1KsfIJGrjQWM1fb7dBkeqMPDdCQfeNlwIITRbIamsg
         LNDUjRcmIJH2smN2kLPtSFJ3xzUoWl1aZbNuF0V8otp1ECtp8QsNtMpXOkUXsNXbtmyz
         79SSDn/ineRtDfgQtHrZWxUA/92h8ejboCUe+8lc0lMYe+9pW/mb9b9bBxz+/t8LQc8X
         iUhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=QKeJlCqYmvLjEv6xyWQYjw9DbuQ+1n1BTs6G47IEdQY=;
        b=M323nZF9s3a22PrazGP1iriPkIFeL6H3QqIxwnoDutxO6iRjbYCVhMqV57MvrV3vvW
         lJjSoWqm8aa5yvIpRx1b4WiPXVVBgE5/jj48Y83QboyQbCASCvw27QhU8d5j8v0NiWp7
         4Jp1PEzbr6Rlzj92sRLHIBWi/KAu0NUvDuck+dS1ZGiWL2JVH1Sx5+W7aHb3hxD2OWVh
         hX06kkqNzdlpYrLLXkMnrZjDhTrhls4pcEl8x5+NElDXj2hXaeVOzfQ+SqYT5dANj6Zr
         6hDGhYcRPGcjUQ+o/XcMa5qrCvF4atnylKrqWQsYrIaVa7SGNekyUemgCiE9fYNxuPbn
         1nwA==
X-Gm-Message-State: AMke39kPqUktZ2id9ypZOuhy5kVcjOlu8K8W2Grc/+bjz0FcPRDIXUbYoF/UbmUhzOSEVQ==
X-Received: by 10.98.42.151 with SMTP id q145mr43023503pfq.175.1487816147050;
        Wed, 22 Feb 2017 18:15:47 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:21a0:716b:e013:d129])
        by smtp.gmail.com with ESMTPSA id f65sm5932048pfk.5.2017.02.22.18.15.46
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 22 Feb 2017 18:15:46 -0800 (PST)
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
Date:   Wed, 22 Feb 2017 18:15:45 -0800
In-Reply-To: <20170222234246.wjp3567vesdusiaf@sigill.intra.peff.net> (Jeff
        King's message of "Wed, 22 Feb 2017 18:42:46 -0500")
Message-ID: <xmqq60k1abzi.fsf@gitster.mtv.corp.google.com>
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

Yeah, http.<url>.emptyAuth that knows where it is going may be a lot
safer but a blanket http.emptyAuth does sound bad.
