Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A024D1FEB3
	for <e@80x24.org>; Mon,  9 Jan 2017 20:44:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936902AbdAIUol (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jan 2017 15:44:41 -0500
Received: from mail-it0-f51.google.com ([209.85.214.51]:32952 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932069AbdAIUok (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2017 15:44:40 -0500
Received: by mail-it0-f51.google.com with SMTP id c20so17957103itb.0
        for <git@vger.kernel.org>; Mon, 09 Jan 2017 12:44:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=jWdYcKDXkl39FbaAg+PFkcYkemQLHyJREC0biyf5viE=;
        b=pe639NRykOTpglj5i04gmnhy7XvPfntBOGrgg4BM4szZkjIF+P45n3t9dbVxui2ild
         fk7+3piVNBTU5uMS2fuEFjKCKdeMKw5dE7kSE9cDmOsl3KBuU95uhGs9U/FMZNoHiuGI
         5UCcPa1UuZ1ZKPRYhZkKHQcao50FLVPsWQftvwazfvGbAq+4LMC8bmH0ifqzT4JF7DoR
         5ws4e9JPB38sk5tjtSgH1Z9x6mQdzcd4g8uoukG9audqg7T1Rpppj8kW+/7phA4XwB63
         jN4mwhFaQ2mmOQovfGH29cGz5uV9eIBLKX9tmb65etHjGvg7jE6pEd2PkJ/893SzvYPy
         T5bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=jWdYcKDXkl39FbaAg+PFkcYkemQLHyJREC0biyf5viE=;
        b=X2PmErE0SbbENXh/PQJHh6qU6eRAv5kWaUNDF2y4ZIaWLL+gr8bwtInLfhry4YAvue
         2epkCAl8ybvS7yoyjebKvPXWBmr1mxOp2Pby6biCyuaLJDgoW5EP/xFbsjCRoZrrAv1f
         HyDY99y7No9zVDfVLZukKolSkoWBmjSR+CjpSBCgjGjj080w5MbJFITUsbVopDxiyXec
         hMxyK3LC4dWuJ00HJu7pGPRCE38huSa0rmbqlHtFNkx9ONCSfdLZLsxo1zd6BdnB0HxI
         c3FR7WIulVUTVkbH048qm0WXApNNmH4894uQiJacizLXnVetqRUoyfHLmBDukO0R3EIt
         cc2Q==
X-Gm-Message-State: AIkVDXLpnqoVz9e7r/a+xUbj4Qk5TN5M2NJyfLYNdqQBudUd/DXTjP53TqIF6vLq20+Mgjsqog99Ailk8tOCLXY7
X-Received: by 10.36.141.2 with SMTP id w2mr11037285itd.114.1483994678934;
 Mon, 09 Jan 2017 12:44:38 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.39.19 with HTTP; Mon, 9 Jan 2017 12:44:37 -0800 (PST)
In-Reply-To: <D10F7C47-14E8-465B-8B7A-A09A1B28A39F@gmail.com>
References: <D10F7C47-14E8-465B-8B7A-A09A1B28A39F@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 9 Jan 2017 12:44:37 -0800
Message-ID: <CAGZ79kYDPLDU5Dg_CTnpEX+D9bs6BUSSNTHkqpW2nY-b=e9+SQ@mail.gmail.com>
Subject: Re: RFC: Enable delayed responses to Git clean/smudge filter requests
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 14, 2016 at 1:09 PM, Lars Schneider
<larsxschneider@gmail.com> wrote:
> Hi,
>
> Git always performs a clean/smudge filter on files in sequential order.
> Sometimes a filter operation can take a noticeable amount of time.
> This blocks the entire Git process.
>
> I would like to give a filter process the possibility to answer Git with
> "I got your request, I am processing it, ask me for the result later!".
>
> I see the following way to realize this:
>
> In unpack-trees.c:check_updates() [1] we loop through the cache
> entries and "ask me later" could be an acceptable return value of the
> checkout_entry() call. The loop could run until all entries returned
> success or error.

Late to this thread, but here is an answer nevertheless.

I am currently working on getting submodules working
for working tree modifying commands (prominently checkout, but
also read-tree -u and any other caller that uses the code in
unpack-trees.)

Once the submodules are supported and used, I anticipate that
putting the files in the working tree on disk will become a bottle neck,
i.e. the checkout taking way too long for an oversized project.

So in the future we have to do something to make checkout fast
again, which IMHO is threading. My current vision is to have checkout
automatically choose a number of threads based on expected workload,
c.f. preload-index.c, line 18-25.

> The filter machinery is triggered in various other places in Git and
> all places that want to support "ask me later" would need to be patched
> accordingly.

I think this makes sense, even in a threaded git-checkout.
I assume this idea is implemented before threading hits checkout,
so a question on the design:

Who determines the workload that is acceptable?
From reading this email, it seems to be solely the filter that uses
as many threads/processes as it thinks is ok.

Would it be possible to enhance the protocol further to have
Git also mingle with the workload, i.e. tell the filter it is
allowed to use up (N-M) threads, as it itself already uses
M out of N configured threads?

(I do not want to discuss the details here, but only if such a thing
is viable with this approach as well)

Thanks,
Stefan
