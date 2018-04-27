Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 341B71F424
	for <e@80x24.org>; Fri, 27 Apr 2018 00:50:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756991AbeD0Aud (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Apr 2018 20:50:33 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:45904 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756641AbeD0Auc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Apr 2018 20:50:32 -0400
Received: by mail-wr0-f195.google.com with SMTP id p5-v6so135728wre.12
        for <git@vger.kernel.org>; Thu, 26 Apr 2018 17:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=eAf94X3bTkMxHJCQKGp+zBWP3KfK4D4pD6bEiqm0Q0E=;
        b=sIqZWZir2+fFtc0CKbIAWEqY8rDjL0h3c/J5yNThfLw507JXNVkRnxfqciJSdiO62E
         DXWohenzbDHTfJaT8upduI50s+nN0ye+iO7TMTkCt+qiHSFWnU9wwz6rMiF078mDXrIv
         ATxHXFEtFufNkM553naosJEE38WZfA3jmz4oOqBIUoqhFwOcR0/VpDn7MezmUUlV1OxY
         WkFFm7lrx56etBjiKRFsDYdRIfvVsyFjqs7b7KCiL41EDLTvKa63VpJkz+/Fzl32FcTU
         x+ACfxb/8b4R0DH/gSwVQAP6lZkbTMacApdBYxOIRXze/nR/8GxjWNo7D50wSmCFYFDw
         Cgxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=eAf94X3bTkMxHJCQKGp+zBWP3KfK4D4pD6bEiqm0Q0E=;
        b=Ug7IzaX2GEUI4qxobAeszfbiw4RxMYLevC26pKh+6RDDNJX49GlHT7RslmfCf+uypx
         0yNlhnPq6ogIpdoHOZmfibPim8FMITnBXrSswL1MmAkpFxhgtiPMUFhfHVs1LIwG/foS
         jdgXGUZBpjQ+AlNEhH2Jt/OYstzDoudzw8eZ8EkMRZHAFsu9jg4VcuS1amCf5la7yO9V
         DXGeZym9alZmbo78oyh1EALPXdh+T/AdRnGfLB8PpqkQPMAlqphHbPVMcSUoHZQPulbj
         zan9Fbf5d3BR07UBcVOwz8se/hhFoaT9Xhxla95Kfcq++egTHXej0fzB5pwkPlVoqp2M
         Yz2w==
X-Gm-Message-State: ALQs6tAup8mzx5sPrqedrAuyWKvgxrqV5nqO40kMBgeeLUy19d1ZfUc0
        MxxWSEHjnXmuZF+bHGWbFqc=
X-Google-Smtp-Source: AB8JxZoBhLx6d0MoK0yE/pVSknP8IV8DuQT32ZYzrtq4xYYz1zqiHpCRJ1CsKe7GehWK1mtPg7EgeQ==
X-Received: by 2002:adf:9789:: with SMTP id s9-v6mr159584wrb.28.1524790231492;
        Thu, 26 Apr 2018 17:50:31 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id y100sm1593783wmh.2.2018.04.26.17.50.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 26 Apr 2018 17:50:30 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     istephens@atlassian.com
Cc:     sunshine@sunshineco.com, szeder.dev@gmail.com, git@vger.kernel.org,
        peff@peff.net, bturner@atlassian.com, jacob.keller@gmail.com
Subject: Re: [PATCH v4 1/2] blame: prevent error if range ends past end of file
References: <CAPig+cSH-y7ChDE_LW55M_wB=KhD7uJHXX=OvZ=1ri5KfYQ5Sg@mail.gmail.com>
        <20180426074502.78318-1-istephens@atlassian.com>
        <20180426074502.78318-2-istephens@atlassian.com>
Date:   Fri, 27 Apr 2018 09:50:30 +0900
In-Reply-To: <20180426074502.78318-2-istephens@atlassian.com>
        (istephens@atlassian.com's message of "Thu, 26 Apr 2018 17:45:01
        +1000")
Message-ID: <xmqq7eot1nhl.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

istephens@atlassian.com writes:

> diff --git a/line-range.c b/line-range.c
> index 323399d16..023aee1f5 100644
> --- a/line-range.c
> +++ b/line-range.c
> @@ -47,7 +47,7 @@ static const char *parse_loc(const char *spec, nth_line_fn_t nth_line,
>  			else if (!num)
>  				*ret = begin;
>  			else
> -				*ret = begin + num;
> +				*ret = begin + num ? begin + num : -1;

When parsing "-L<something>,-20" to grab some lines before the line
specified by <something>, if that something happens to be line #20,
this gives -1 to *ret.  If it is line #19, *ret becomes -1, and if
it is line #18 or before, *ret becomes -2, -3, ...

Is that what we really want here?  It is disturbing that only line
#19 and #20 are treated identically in the above example.  If it
were "if going backwards by -num lines from begin goes beyond the
beginning of the file, clip it to the first line", I would
understand it, but as written, I am not sure what the code is trying
to do.
