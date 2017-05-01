Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 677011F829
	for <e@80x24.org>; Mon,  1 May 2017 01:01:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S638277AbdEABBm (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Apr 2017 21:01:42 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35193 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S638275AbdEABBk (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Apr 2017 21:01:40 -0400
Received: by mail-pg0-f66.google.com with SMTP id c2so3664766pga.2
        for <git@vger.kernel.org>; Sun, 30 Apr 2017 18:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=J6TjFzhM0wRnYJzfZ33ZEQCtbrsSq75jB6cr/r1slcY=;
        b=F/QO/etHja0g8IecxGCrPT250jx8sToz+rmw3YXgX+DsKMBWitpOALT7Hv/1r8jZrj
         B3tFS/EBMIQQ1nLGK7SJLDXhBn9r6ZH6Yl9bK3Qb8RRQt2O8+6e2cHHXrYqbKukulywF
         oOyThdsO1evXhrP1P0htIphedNgCPL5fEGV6KAdFIpF60MQfYMxrsKZwkXbHLCedz5y2
         sv7BPslvI66z5rpG+p0Q49X/eo1E9+w7AIiXeTyTOle1KIlPYiZKUkRcm9TFuLdrA0KN
         tcuItscHUcCY6TpPvhxcFBQTzlvaV7l+NHWnx5wiUspwiDRg9UKSuHP/wBiNKpEBqmfN
         BtxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=J6TjFzhM0wRnYJzfZ33ZEQCtbrsSq75jB6cr/r1slcY=;
        b=Q89wYZSpbmyKQezWA9HbqRPjnW5Fu8GzRRIbUjYNBx0MJc+htMXB5+Zznscd63UI2o
         4BmJLgYbHIZFBjywPnkWnQVBwzM/AXQj3Kjsa0NWs9b7FGDapBKMrgtrxAXXpWqfGKpg
         JnbWSpBhmgGb4s+UHRteWx2k8bfEX5m1TtcRkAgi376QuiTxp8GYHq0v8qTxp7K5cZz6
         IOl8L3oGLmFaiiloQ6dzZXh5xsVoJFuvUNXOdXw3QGMluEiuhPEbbfUxvZwdpDRyogKy
         ewZV8worAk04rmANchbsunxThE6M3qMPIJSYdyfylDotZKmL+CJNT5Lrr3YkovTs00gW
         /xeg==
X-Gm-Message-State: AN3rC/7rUxlYQvKxC3yfibMEaTPMDjKn5zb3IQDrYlpqXjvnyAjix/mY
        gyOq7gQp/wRN7ifjN9E=
X-Received: by 10.84.169.67 with SMTP id g61mr24935727plb.81.1493600500211;
        Sun, 30 Apr 2017 18:01:40 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:216d:aa3e:248d:bf63])
        by smtp.gmail.com with ESMTPSA id l186sm41018pgd.42.2017.04.30.18.01.39
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 30 Apr 2017 18:01:39 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Marc Branchaud <marcnarc@xiplink.com>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 2/2] Have the diff-* builtins configure diff before initializing revisions.
References: <20170427205037.1787-1-marcnarc@xiplink.com>
        <20170427205037.1787-3-marcnarc@xiplink.com>
        <20170428080620.cbnreh5invwpasxr@sigill.intra.peff.net>
Date:   Sun, 30 Apr 2017 18:01:37 -0700
In-Reply-To: <20170428080620.cbnreh5invwpasxr@sigill.intra.peff.net> (Jeff
        King's message of "Fri, 28 Apr 2017 04:06:20 -0400")
Message-ID: <xmqqpoftjspa.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, Apr 27, 2017 at 04:50:37PM -0400, Marc Branchaud wrote:
>
>> Subject: [PATCH 2/2] Have the diff-* builtins configure diff before initializing revisions.
>>
>> This makes the commands respect diff configuration options, such as
>> indentHeuristic.
>> 
>> Signed-off-by: Marc Branchaud <marcnarc@xiplink.com>
>
> I think it would be helpful to future readers to explain what is going
> on here. I.e., the bit about calling diff_setup_done(), which copies the
> globals into the diff struct.
>
>...
>
>> +	git_config(git_diff_basic_config, NULL); /* no "diff" UI options */
>>  	init_revisions(&rev, prefix);
>>  	gitmodules_config();
>> -	git_config(git_diff_basic_config, NULL); /* no "diff" UI options */
>>  	rev.abbrev = 0;
>>  	precompose_argv(argc, argv);

This somehow made me worried at the first glance, but the matches
what is done by the Porcelain "git diff".  In other words, it was a
bug that the original called init_revisions() before doing the diff
configuration, and it does not have much to do with "now let's have
them honor indentHeuristic".  Even if we wanted to keep the indent
heuristic in the ui-config (not basic) section of the diff tweak
knobs, we should be applying this patch as a bugfix.

> It's somewhat odd to me that diff_files uses a rev_info struct at all.
> It doesn't traverse at all, and doesn't respect most of the options.
> There's a half-hearted attempt to reject some obviously bogus cases, but
> most of the options are just silently ignored.
>
> I think it's mostly a historical wart (especially around the fact that
> some diff options like combine_merges are in rev_info, which they
> probably should not be). Anyway, none of that is your problem, and is
> way outside the scope of this patch.

Yeah.  The underlying diff machinery was built to be easily usable
by revision traversal and that is probably the reason why we have
this entanglement that we probably could (and maybe we would want
to) detangle.  Surely not a theme of this topic.

Thanks.

