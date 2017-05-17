Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 85128201A7
	for <e@80x24.org>; Wed, 17 May 2017 21:16:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753720AbdEQVQu (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 May 2017 17:16:50 -0400
Received: from mail-pg0-f52.google.com ([74.125.83.52]:36370 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753478AbdEQVQt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2017 17:16:49 -0400
Received: by mail-pg0-f52.google.com with SMTP id x64so12610895pgd.3
        for <git@vger.kernel.org>; Wed, 17 May 2017 14:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=VExvg+pP9XUSwZd3uA2vik4Skua7abo01kxZuO/Q1yA=;
        b=Xlle1FDDoNar1OTa684VwHZG7vKlMWqpbjIsYnP/jATH/RLq0LjxypChkUEHecxCWu
         /7E94c4YYFQ7rwAztznqUWTaJcSlEA3iHihi1Vzt9nv8qu3H0nmf1uTHeKYX/wYijUVO
         35d6/7j+xygePragydL/wp/jBOUixfrbmuwdRv6oZFqLMhX8aw/W7+y9WdPNexDz5hLF
         BLFsMA/C/NNSSU7j8aC2MOREn+1oa8A6UNy4NHQROXa+/J8G5KJQIabYvP4QbbSFw9ct
         +3V3P1SKfq0lpZWKzT0nag3qAdik1vX6yz7sPY18LAXYQXkHuphArRj9hFHV2lbSVOr/
         mZog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=VExvg+pP9XUSwZd3uA2vik4Skua7abo01kxZuO/Q1yA=;
        b=l6jBlq39vVfhG8GgRHuQoTxcxmkilF4jcCZVPeTe9G1O3w75I7NgT6988a8+U4Xlqs
         brL6PLUaeGv4Havm1wkxyCb55cMffEK20RSi3smUHRYq8sDUP4tw/GDxYtpEtjgLB+kW
         lJ4TNTuAnn/KSrmuH5o2A4NCW/vIUewaQk/zfzZ4Ol47R3NTMFYNOMFPr2oOIa68h6Dw
         IaqhV5IATk6hsXg5mzPjDpBnjs5FCZwFVahe8lP7jhCmjn0GV/OKbl790m/9kHgfTAx+
         oFdi21hzhwXPibugi3mwuV89B85tIsidlfCfMh6OPms30jTofHzgAy00Ygj3Ps5wGZ80
         q7VQ==
X-Gm-Message-State: AODbwcCPeQX6PDlhD0/1EWWO0ul0DwxJpjzi1K3KzNtzjccB+QfjKNiv
        iG0XEqqr1sXV6MVDq7yuingJlN+/xfHQePjgGw==
X-Received: by 10.84.248.73 with SMTP id e9mr889743pln.76.1495055808235; Wed,
 17 May 2017 14:16:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.170.200 with HTTP; Wed, 17 May 2017 14:16:47 -0700 (PDT)
In-Reply-To: <xmqqefvoxeg7.fsf@gitster.mtv.corp.google.com>
References: <20170514040117.25865-1-sbeller@google.com> <20170517025857.32320-1-sbeller@google.com>
 <20170517025857.32320-12-sbeller@google.com> <xmqqefvoxeg7.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 17 May 2017 14:16:47 -0700
Message-ID: <CAGZ79kbrFacBvGsHo6A1o94sA=zB7g7q1z3hKGNi-msXnQVjVw@mail.gmail.com>
Subject: Re: [PATCHv2 11/20] diff.c: convert emit_rewrite_lines to use emit_line_*
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Brandon Williams <bmwill@google.com>,
        Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 16, 2017 at 10:03 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:

> The reason why we can lose the LF immediately after the incomplete
> line we found in the above loop is because the updated emit_line_0()
> adds LF if its input is an incomplete line?

No. Because there are no incomplete lines any more, as we complete
the line above via strbuf_addch(&sb, '\n');

In a buffered world, we need to think about what to buffer, and I think
we rather want to buffer all lines with the same line ending otherwise
the comparison function is harder. So in that case we'll rather

    line1="last line, but we added EOL\n"
    line2="\\ No newline at end of file\n"

because line1 could occur somewhere else as is with the \n.

>  Even before this series
> started, emit_line_0() was already prepared to see a complete or
> incomplete line and emit the "reset" color after the optional EOL
> bytes at the end, so emit_line() and emit_{add,del}_line() calls
> throughout the code can pass the body of the line with or without
> the EOL and right things will happen.  Sounds about right.

Yes the emit_line_0 will strip off \n if there is and output it after a
potential color reset.
