Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B4DA1F406
	for <e@80x24.org>; Sat, 12 May 2018 00:03:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751564AbeELADe (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 May 2018 20:03:34 -0400
Received: from mail-wr0-f173.google.com ([209.85.128.173]:44345 "EHLO
        mail-wr0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750858AbeELADc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 May 2018 20:03:32 -0400
Received: by mail-wr0-f173.google.com with SMTP id y15-v6so6787643wrg.11
        for <git@vger.kernel.org>; Fri, 11 May 2018 17:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=2GgAdSHNDvaTYc5smD+Ok7GQaSlYqFNH8xMNsoI009c=;
        b=cr4MkJikdcVngcHirsfBXHjw4CU3/BT3ndcclA6m5gVvvqQKVocN1JBPBUw+g3pMLb
         lRBQIp+BCkzWwDdyJDhzu+QH0otbNiA9jtXbdDG/X9xa/3oapl3b+qcEjLXJzNdq3Wvt
         LEe2bo750SyO8UL1La2q5NbgcheGXc+Ifq/YpoIWAKVbwexEdW0vIK/fu39qIL4EJe2H
         hO6K1hS+8rTqvwvNH/9r1yX1u8JsY26P+8m5IakALvKokiJV1bjrfcREtAuGl76LZwJ5
         Yp+stJSvRm86dN6mG3urK/LOsTn9HClRNBVlYPwFKA892JdnADvToxOHeLzHusZV1DWT
         34bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=2GgAdSHNDvaTYc5smD+Ok7GQaSlYqFNH8xMNsoI009c=;
        b=c2Z2LG0rxZ8AYaFH2tuRBFw4RJ7/gGm5swaB/caqNSjnDw0FrGi+6ffYbBwGZUWUqo
         4ke7ehDeRv7xquOWdZNCcYK9QfksFIZvPyGc8TFM6t5GYIO73HP4nC6fmm6vITwYbA6D
         mXZpe1nQN8A1HITi6sInWCCXRdGPfCuFQdbAMEQROI908BNCSrjESPQcsWlnWogCdxLd
         v3bxor0uQmKdO9GCj4p6WtdpuMpUgc4PRC+v/YL8obhBw8S2PyWbXMCo2TMU8g1rYSVc
         NfSSyT1mKNUuluDe7JIsWdpsPTSmI6zYm8LHsAdNReqxq0/eflPrL1GLdVuO/GA2dN9u
         aOzQ==
X-Gm-Message-State: ALKqPwfE+PQC187rtnuVTkFB6fz5/cnn4t1deIbCpaB6UuGyy7P5OcS7
        yX6a9Dk8GZDbGmZtFOJAqkU=
X-Google-Smtp-Source: AB8JxZobrpugjLsPdMmJmGCON13ga4uxlH+hAU9EWMEurHDWXLHVrZsOGWcNLPw/q4aM20OlEVs/Fg==
X-Received: by 2002:adf:a850:: with SMTP id l74-v6mr629076wrc.42.1526083410675;
        Fri, 11 May 2018 17:03:30 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id b16-v6sm4452586wrm.89.2018.05.11.17.03.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 May 2018 17:03:29 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org
Subject: Re: [PATCH] git-submodule.sh: try harder to fetch a submodule
References: <20180511231751.162855-1-sbeller@google.com>
        <20180511232840.GB41222@aiede.svl.corp.google.com>
Date:   Sat, 12 May 2018 09:03:29 +0900
In-Reply-To: <20180511232840.GB41222@aiede.svl.corp.google.com> (Jonathan
        Nieder's message of "Fri, 11 May 2018 16:28:40 -0700")
Message-ID: <xmqqmux5g2pa.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

>> HEAD is allowed by the protocol spec and would happen, if HEAD points at a
>> ref, that this user cannot see (due to ACLs for example).
>
> A more typical example would be if the ref simply doesn't exist (i.e.,
> is a branch yet to be born).

Indeed this is interesting.  At first glance I thought this was
about underlying "git clone" failing to grab things from a
repository with unborn HEAD, but that part works perfectly OK.  And
if this failed clone were a full-repository clone that tried to grab
even HEAD, then it is likely that we got the tip we need to populate
the submodule's working tree (or the remote is useless for that in
the first place).  So the "allow to try even harder" is probably a
good direction to go in.

>>  				# is not reachable from a ref.
>>  				is_tip_reachable "$sm_path" "$sha1" ||
>>  				fetch_in_submodule "$sm_path" $depth ||
>
> Is keeping the '||' at the end of this line intended?

Good question.  It used to be

	guard1 || action1 || die
	guard2 || action2 || die

Even after a successful exit from "action1", the code used to try
the second attempt, and the patch is removing the first die, making
the whole thing into

	guard1 || action1 ||
	guard2 || action2 || die

which suggests a grave regression, doesn't it?  "action1" (a whole
repository fetch) may not pull down the needed commit even the fetch
operation itself may succeed, in which case "guard2" notices that
the tip is still not here and "action2" (an exact SHA-1 fetch) tries
to pull down the exact thing as the last resort.

So it probably should be more like

	guard1 || action1 || warn
	guard2 || action2 || die

so that no matter what the outcome of the action1 is, the second set
gets executed.


