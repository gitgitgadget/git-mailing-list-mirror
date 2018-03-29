Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BDD5A1F404
	for <e@80x24.org>; Thu, 29 Mar 2018 22:32:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752077AbeC2Wb6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Mar 2018 18:31:58 -0400
Received: from mail-wr0-f170.google.com ([209.85.128.170]:42861 "EHLO
        mail-wr0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751341AbeC2Wbz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Mar 2018 18:31:55 -0400
Received: by mail-wr0-f170.google.com with SMTP id s18so6649219wrg.9
        for <git@vger.kernel.org>; Thu, 29 Mar 2018 15:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=pfj8Q4LVboSRJHhBBV1xCa4I1FEXzd76Pkxuafin9Hs=;
        b=Njo0PbwnfUPonGKmWliNR4EvsjzwdpDjWqMDD/JsNzVWKcP7bwKwhj8ImlaE+opGiU
         TR1Tav3cU3EcoOWTEuCoM0oTg3/0adhvVs2b10TQmgs0xIOTCHxskQzWD4DNVxj2IENT
         LQrEVRq5xtjnirE99wthMkDKW4e4v2rP+oDb4WYsGgJ/C0N6F5oH+FuChdtwDbBxF35o
         sd5rHqSFFbGc5UWm+RT8e1ktr3355ogwjz3aZTmRC/XPHtPXVQBP8058otkA2Dvrf+b3
         qrxeOPyI2btUTQaOeEHRHlVCmjJDykqKsVxVw3cvAKHd5VfpvGH8NA8VOKbdIsDEkf1l
         DWFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=pfj8Q4LVboSRJHhBBV1xCa4I1FEXzd76Pkxuafin9Hs=;
        b=RVEgpuZLG1KC2wBg888sD5qsMO3S/zxsoDh/DKSivE26XhtChhh6oyg5dMJIdyOmAZ
         abWaQX3LNUyzn7Idiat+01bn9ZQ5Vc4A+HQO6rXWYPQ06Z9eZrIovwLMkiMhjmJJNnNm
         KIkY1G+rTgq24wm3tkaRhgKNNS3HYqV52R4FSZ+cjKNWS6VDfUIVCgAJeyWoVSNY97CA
         EstY3kMMcfzJmkE7YUJYGT5Hgz1Zm6ndmPg6pJxtoaBUkM0CKLPQwQdq5qZ7VYWoztUr
         jpCsGcLkuMYNg1clEaS6qStdV30m96S4pQhBo0XpS3oFQCz+Nk50sp4Wf0g4fxmVeakx
         Bg5w==
X-Gm-Message-State: AElRT7Hmx/jscYGDR0lKFCpxIEvsMAAuTcwI/lplhgRdXoJByWdcP33Q
        hCo27RN7YToylLN+P83wn8k=
X-Google-Smtp-Source: AIpwx4/vRq2l+joWtc8mZrOTXHWNJnodLD4BhsESJcWE1TRYY1FYsktlETuc7LptODi/kaxrxBe4mA==
X-Received: by 10.223.153.114 with SMTP id x105mr7708565wrb.108.1522362713608;
        Thu, 29 Mar 2018 15:31:53 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id d9sm5909812wmh.38.2018.03.29.15.31.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Mar 2018 15:31:52 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [RFC/PATCH] upload-pack: disable object filtering when disabled by config
References: <20180328203303.GA260688@aiede.svl.corp.google.com>
        <20180329215502.GK2939@sigill.intra.peff.net>
        <20180329220257.GA209272@aiede.svl.corp.google.com>
        <20180329221725.GM2939@sigill.intra.peff.net>
Date:   Thu, 29 Mar 2018 15:31:52 -0700
In-Reply-To: <20180329221725.GM2939@sigill.intra.peff.net> (Jeff King's
        message of "Thu, 29 Mar 2018 18:17:25 -0400")
Message-ID: <xmqq4lky5x9j.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I think I'd agree on it being a release blocker. Given that your fix is
> really a one-liner (3 of the lines are just changing the variable name,
> which I agree with), I'd be fine with applying it on top rather than
> reverting the original, even if it means delaying the release slightly.
> It seems like about the same amount of risk to me.

Yeah, I would say we should just apply the rfc/patch as-is directly
on 'master'.

Thanks.

