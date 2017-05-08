Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69F3A20188
	for <e@80x24.org>; Mon,  8 May 2017 01:58:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752150AbdEHB6t (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 May 2017 21:58:49 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34629 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751037AbdEHB6s (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 May 2017 21:58:48 -0400
Received: by mail-pg0-f66.google.com with SMTP id u187so8395375pgb.1
        for <git@vger.kernel.org>; Sun, 07 May 2017 18:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=rg4SWMJOCCjEKGI13plKS6aRwDFUc8S9BqmdH+6uMrc=;
        b=tAK/fyGPMMYuzVbEYalADJtCCUPu+HLzuwSL3EJcCpJQ4a/32AiGf4CmYIoRoO75KK
         c04kXBC0+lEh90Rt5DtB+dczPqUv2Gy8k0UoCGn67sGLeddnIdcLwcFijiiZZQMANg3u
         fj3Y5mfrj4/nTYgWlqPGCptFTLWe2Sawx8o4zIfbKYsi7U7O1h1ArTCZivDSltPN6NpH
         UH+KBU1N4PQ8JFQhP5kmyrUFXKHTZHnO8kufcOEuyKVQfd7KWOJuZgRvQsh948CMBv3T
         YkltE4Q5cFVkxXmYUIJaR5t4n6RAscweYJDU+heII0UFPzN8AIoYzEZmiolmK1HhM+xT
         4D8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=rg4SWMJOCCjEKGI13plKS6aRwDFUc8S9BqmdH+6uMrc=;
        b=K22TwrL/+s91snZtc6dfy8TxYdk8DjtDehC9x9sdbufjirRjRLA6DqWKXETQ35Xxc5
         7Erilc8t2zeSzf4dVRRRzicCxsyaQvwb99WwsfXez7D9knzWS2P35GZwxNavO+c6mmF1
         v+z3xyue7ldO2xNAlzm3f43RxT7bo61HcYnpo47Mmpwj1crPEqcULB5dB6LWUth6y4ca
         i0TVIC4kmP4eWPBKNifrkQEWI9EU//apjPjo+8U29boL/kLYlT11dnsFnzEBD5qjFLBB
         X3zyHtAnEStZ9eOqr8/+Ek0TEO2iK4de5TZYpPSDfg9rZt1FCVrbF7bxXIfvOvGInoDY
         pBbg==
X-Gm-Message-State: AN3rC/6unq35wZTslqF0hcB/z8Raqqg7tLrzpyO9Y5DOHwm2tw8FLJVu
        VpSpKclLD3BaKg==
X-Received: by 10.99.150.17 with SMTP id c17mr16043250pge.160.1494208727608;
        Sun, 07 May 2017 18:58:47 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:3011:642f:81a0:efbd])
        by smtp.gmail.com with ESMTPSA id g66sm14195265pgc.2.2017.05.07.18.58.46
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 07 May 2017 18:58:46 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ben Peart <peartben@gmail.com>
Cc:     git@vger.kernel.org, benpeart@microsoft.com,
        christian.couder@gmail.com, larsxschneider@gmail.com, peff@peff.net
Subject: Re: [PATCH v7 00/10] refactor the filter process code into a reusable module
References: <20170505152802.6724-1-benpeart@microsoft.com>
Date:   Mon, 08 May 2017 10:58:46 +0900
In-Reply-To: <20170505152802.6724-1-benpeart@microsoft.com> (Ben Peart's
        message of "Fri, 5 May 2017 11:27:52 -0400")
Message-ID: <xmqqfuggaz3d.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ben Peart <peartben@gmail.com> writes:

> Changes from V6 include:
>
> convert: remove erroneous tests for errno == EPIPE
>  - split into separate patch to fix a preexisting bug discovered in the review process

Thanks.


> pkt-line: Update packet_read_line() to test for len > 0
>  - split into separate patch to deal with errors that return negative lengths
>
> pkt-line: add packet_read_line_gently()
>  - update documentation to clarify return values
>  - update white space in function definition
>

I also see some style fixes applied to a few patches.  Thanks for
paying attention to details.

Will queue; during the pre-release freeze, new things would move
slowly, but let's see if we have more comments from others and then
merge it to 'next' soon after the 2.13 final.

Thanks.
