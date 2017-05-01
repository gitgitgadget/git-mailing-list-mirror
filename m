Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 710E41F829
	for <e@80x24.org>; Mon,  1 May 2017 01:16:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S638299AbdEABLv (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Apr 2017 21:11:51 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33908 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S638295AbdEABLu (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Apr 2017 21:11:50 -0400
Received: by mail-pg0-f67.google.com with SMTP id t7so14140652pgt.1
        for <git@vger.kernel.org>; Sun, 30 Apr 2017 18:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=wkcziYtKYFU5Izj7KsovHUROPt4V3aAR8M4RKqrm4WQ=;
        b=r5I312Wh9sTWcYb50WjOt+Uy/eLkkW2V/3ZfksKedG1Me4z8ZaE3hm2xjyM7UI0WZI
         vdZiwY+NpbdLQuv/vElcFBQyHwfvbFGaxj2/iQQHqG8vjC20YJkneDTizfbiUBpe9cVs
         JkRyJetJ/qTnT/u55SJV0PRv7SsSBug6D6HEKtv/DbmBpzIRyt0r0tCbeO8gEYpQUUiQ
         t84tRMiffaJsF9YG+UAx9ODPWMWmyqIO2yOerUUk9mWTZK3cvwDiqFw3JyIeR7sleiTi
         aDzxNzvLOEe9yfa2Bvpu9XKVZUNEne+1aYzkOHE+5vwtGSTg7Len0gRhP3SEMO3mmHwd
         KdQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=wkcziYtKYFU5Izj7KsovHUROPt4V3aAR8M4RKqrm4WQ=;
        b=i2ZUP5e+eFDfnXDjxWaMxMnJ0gGFN8YVkLvIDyokT4XD4FsVtoGjcUcxtGjgPOxgtn
         28kUhLV75V/hm1KwLZZK0nN6oucqXl+++9wLjt5Mz3Gm8sUsVgyIuKDeW7MsXeWoBWGJ
         swST5POBI2F9aNnWlraTEEdMdZm/SHGSaaECU4QB6Pq7QcN/MOMkLHC09I1ZhiMhUXwr
         DBWy8f7ntQGk4i0kYoQarJWZg2p1wnZM9O9wkulg094xqFIVqOzT8j6+XYsXQ4CCpdBo
         VHb15EAmkk1YXyrrVCzhLCOTKC2tH0G/FxU2Z+ssk14pF66nMxkVgbq12cwXgnxmIF05
         T9Ug==
X-Gm-Message-State: AN3rC/4+w/U+PLtxHMruvKbToFcpuZPT28RSLHdfI7Vym9kXFEOdHKOQ
        J37mYVGMdwtYrA==
X-Received: by 10.84.230.133 with SMTP id e5mr28710579plk.71.1493601109958;
        Sun, 30 Apr 2017 18:11:49 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:216d:aa3e:248d:bf63])
        by smtp.gmail.com with ESMTPSA id t18sm21388171pfg.31.2017.04.30.18.11.48
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 30 Apr 2017 18:11:48 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Marc Branchaud <marcnarc@xiplink.com>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv2 0/3] Make diff plumbing commands respect the indentHeuristic.
References: <20170427205037.1787-1-marcnarc@xiplink.com>
        <20170428223315.17140-1-marcnarc@xiplink.com>
        <20170429124052.yhgwofbbd5pkd24p@sigill.intra.peff.net>
        <20170429131439.ohgren3i7xr4tjex@sigill.intra.peff.net>
Date:   Sun, 30 Apr 2017 18:11:48 -0700
In-Reply-To: <20170429131439.ohgren3i7xr4tjex@sigill.intra.peff.net> (Jeff
        King's message of "Sat, 29 Apr 2017 09:14:40 -0400")
Message-ID: <xmqqlgqhjs8b.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> diff --git a/t/t4051-diff-function-context.sh b/t/t4051-diff-function-context.sh
> index 6154acb45..5f46c0341 100755
> --- a/t/t4051-diff-function-context.sh
> +++ b/t/t4051-diff-function-context.sh
> @@ -72,7 +72,7 @@ test_expect_success 'setup' '
>  
>  	# overlap function context of 1st change and -u context of 2nd change
>  	grep -v "delete me from hello" <"$dir/hello.c" >file.c &&
> -	sed 2p <"$dir/dummy.c" >>file.c &&
> +	sed "2aextra line" <"$dir/dummy.c" >>file.c &&

I've never used 'a' (or 'i') command of sed without having it
immediately followed by a backslash-newline in my scripts.  How
portable is this addition, I have to wonder.  Can BSD folks give it
a quick test?

Thanks.
