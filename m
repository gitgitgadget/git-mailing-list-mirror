Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 634D3202C1
	for <e@80x24.org>; Fri, 17 Mar 2017 07:04:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751031AbdCQHEe (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 03:04:34 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:35497 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751009AbdCQHEd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2017 03:04:33 -0400
Received: by mail-pf0-f181.google.com with SMTP id x63so30277470pfx.2
        for <git@vger.kernel.org>; Fri, 17 Mar 2017 00:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wXBmyEI78C3+wF0df0pXTkv4Qqwcx59XqD42cfNu/0M=;
        b=r2Fri21BbTYzqjOHB1Gg1a5YW3B2fqQ6/wcxsxkCEjubcploJ/VeibQVNRcRIgauxQ
         sB6s7HX1YvIAJgWOarUBwZLWaAL1HFZ5XEXi5aNZLiswVWKt77Byb4C9E/W3FCsl0N3/
         ecqV8Wl+W98KKISVItNT7XSL4w8oZLwqSRgFXxPsiVFPRlJKw3ZQWSQdROHo/24Gdpvz
         yCQRuBB0dyn7b1xESM3FL8RSPqvZOtT2UkhZIgyLWof9fM74EBUB7w2vNmFn3wzN/Xmd
         qutge8XN/+R1hhWHAw6Ix7V+3FwU586OaqvUelbAoMXPfC6FzHxRJxut264vBq3sR+zC
         MrGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wXBmyEI78C3+wF0df0pXTkv4Qqwcx59XqD42cfNu/0M=;
        b=kZQsitxoE5tVjWq89CIVruqBhOo5h589OOBmprdNXn3qEpO/vT4o9ZIpibQALMwqzj
         iS6f5/TXRCF6BIj/+aol2/QaYxOZ+/3t9UF97nwSybWOP9x/G5H1PtNiqNf4FEx6ZYkj
         4W7mw55pKdfc3blzSRVm7MWyonGDD7pYVSoJuP7p+ap4mkF4mFZBSUjOjUpfbrXm37v+
         JkRZx0SqPvY83Ehl9RQK1W0zIJTYvaTqH3yoAmyuGZ3UGOBNOWaivPmE/Ry1qxIrg2Y+
         qWb2o++J7n/E28ifv6uK9juCzPmD4DkSW1Luu3H/WKbcwXo2xeEb2ehnVSuimS2RCqlM
         IE3Q==
X-Gm-Message-State: AFeK/H3KOMkMzl9K4YBmAXFE4I+sNEgwx4BjZLF6DOFZMKl+YBu48P09xkjm0WcNJl+H+Chf
X-Received: by 10.98.25.202 with SMTP id 193mr14776056pfz.134.1489733905550;
        Thu, 16 Mar 2017 23:58:25 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b10:5992:ad5b:4930:50b4])
        by smtp.gmail.com with ESMTPSA id 79sm12544226pge.14.2017.03.16.23.58.23
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 16 Mar 2017 23:58:24 -0700 (PDT)
Date:   Thu, 16 Mar 2017 23:58:23 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH v4 03/10] submodule sync: skip work for inactive
 submodules
Message-ID: <20170317065823.GA101452@google.com>
References: <20170313214341.172676-1-bmwill@google.com>
 <20170316222952.53801-1-bmwill@google.com>
 <20170316222952.53801-4-bmwill@google.com>
 <CAGZ79kaP9ob+qvso=pV=PPaB5guaW18w297xA+bfDFASV0zibg@mail.gmail.com>
 <xmqq8to4a2xv.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq8to4a2xv.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/16, Junio C Hamano wrote:
> Stefan Beller <sbeller@google.com> writes:
> 
> > On Thu, Mar 16, 2017 at 3:29 PM, Brandon Williams <bmwill@google.com> wrote:
> >> Sync does some work determining what URLs should be used for a submodule
> >> but then throws this work away if the submodule isn't active.  Instead
> >> perform the activity check earlier and skip inactive submodule in order
> >> to avoid doing unnecessary work.
> >>
> >> Signed-off-by: Brandon Williams <bmwill@google.com>
> >> ---
> >
> >> +               # skip inactive submodules
> >> +               if ! git config "submodule.$name.url" >/dev/null 2>/dev/null
> 
> Just a style thing, but ">/dev/null 2>&1" is probably shorter and
> more idiomatic.
> 

Yeah you're right.  I was just moving around the code that was already
there.  But this line is removed in the next patch anyways so it
probably doesn't matter much.

-- 
Brandon Williams
