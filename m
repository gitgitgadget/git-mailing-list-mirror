Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1439E2018B
	for <e@80x24.org>; Mon, 18 Jul 2016 19:32:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751762AbcGRTcC (ORCPT <rfc822;e@80x24.org>);
	Mon, 18 Jul 2016 15:32:02 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:35253 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751799AbcGRTbv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jul 2016 15:31:51 -0400
Received: by mail-pa0-f46.google.com with SMTP id iw10so1250509pac.2
        for <git@vger.kernel.org>; Mon, 18 Jul 2016 12:31:50 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=M49IrmnCCWbqmXE8SD9SXMdzoZgiH3BBz/lOKUndewM=;
        b=yUKLqaJHrk5otT9lA3HjvlqmyylXxSw00ltfEZUionjCadE8ITRiUp1o7537+kXrwv
         g55LdInlMXkl2I7Xv8KSLzTBYWFCQXCfrh+c1curg38CGggnfrOdV6Oh5pffjb+aMsiq
         jktlIHoMh/vEVYpEKjUNum+oduVb085OPbHszZiprTNb6t9hGQIDC22ngg6a+QGR/8Q1
         3geJiNhGgBCesQ+iGBYoRjsiH46iqkMVS43i3M4fIZbIwupJVgEaHRMNVXWHyp+XdPZE
         yYeHfCOKIhZiiFzghy7xjnK/WBAxEKoAC7caVQUCBGPtyewOpXPYLwfv4LWWvPeHYvMS
         BQTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=M49IrmnCCWbqmXE8SD9SXMdzoZgiH3BBz/lOKUndewM=;
        b=gCBfvSguNWgVLfIYP7CmSw9sOKh9pl2JAFps+MnxbkM2W2BGlTG64QanzV+J0YtSvw
         kZCqeGRYCLl/v+o+c846l2yacXxyO0VttpCrz8rkY7aNkI0y1ucM/rkIq80+Jo+bqWw6
         Pslgl52icDEg0uWlCY3xOFjBOFRqekzN5qDvrukDtx/nYSzd2lacCBKnbOUFrWItFhov
         f/x+H64RG47GBCEpIVwKX9RLUyvnR4mwuie9JkQ17YxDzQVJ1QwNhzrVzdgwQ1JVaXWd
         jitjweiKhnLKoGrQ1R7R58Vv2EMHO/iCFB0Wnf3xron5mPP2/7T4QiHH4aJ9xnyakn/T
         GLsA==
X-Gm-Message-State: ALyK8tK0+bKshS6EpkL57wKQJOIeUSXf22OrUuCzQn754wIE1d2b61yArro41VDJ5ixpGw==
X-Received: by 10.66.123.42 with SMTP id lx10mr58066421pab.95.1468870310247;
        Mon, 18 Jul 2016 12:31:50 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b10:9154:f831:1491:8d12])
        by smtp.gmail.com with ESMTPSA id v126sm6834329pfb.60.2016.07.18.12.31.49
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 18 Jul 2016 12:31:49 -0700 (PDT)
Date:	Mon, 18 Jul 2016 12:31:47 -0700
From:	Jonathan Nieder <jrnieder@gmail.com>
To:	Jonathan Tan <jonathantanmy@google.com>
Cc:	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] fetch-pack: grow stateless RPC windows exponentially
Message-ID: <20160718193147.GC29326@google.com>
References: <1468867019-13086-1-git-send-email-jonathantanmy@google.com>
 <20160718185527.GB29326@google.com>
 <xmqq37n6kbib.fsf@gitster.mtv.corp.google.com>
 <CAGf8dgJVkkVwJ5aJCQBcYKw7F9g7u3pMsuJHedSGLG6PQk2Keg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGf8dgJVkkVwJ5aJCQBcYKw7F9g7u3pMsuJHedSGLG6PQk2Keg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jonathan Tan wrote:
> On Mon, Jul 18, 2016 at 12:10 PM, Junio C Hamano <gitster@pobox.com> wrote:

>> I'd understand if it were more like "aggressive exponential ->
>> conservative exponential" without linear phase when stateless_rpc is
>> in use, though.  I just do not quite understand the justification
>> behind the order of three phases introduced by this change.
>
> Adding conservative exponential phase after the aggressive exponential
> phase was the original intention, but the conservative exponential
> approach (e.g. n' = n * 11 / 10) is slower than the existing linear
> (n' = n + 1024) approach when n < 10240, so I added that intermediate
> phase to avoid a regression in the packet size growth.

You have full control of the growth function.  So how about aggressive
growth until 1024*10?

That is:

Current git:
  n < 1024: aggressive exponential
	16, 32, 64, 128, 256, 512, 1024
  1024 <= n: linear
	2048, 3072, 4096, 5120, ...

Initial proposal:
  n < 1024: aggressive exponential
	16, 32, 64, 128, 256, 512, 1024
  1024 <= n < 10240: linear
	2048, 307, 4096, 5120, ...
  10240 <= n: conservative exponential
	11264, 12390, ...

New proposal:
  n < 10240: aggressive exponential
	16, 32, 64, 128, 256, 512, 1024, 2048, 4096, 8192, 16384
  10240 <= n: conservative exponential
	18022, 19824, ...

That way, on one hand it would still never use a smaller window than
today and on the other hand the heuristic would be easier to
understand (only decelarating, instead of decelarating and then
accelerating again).

Thanks,
Jonathan
