Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD,
	UNPARSEABLE_RELAY shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ADD7F1F404
	for <e@80x24.org>; Thu,  1 Mar 2018 17:23:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033393AbeCARXh (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Mar 2018 12:23:37 -0500
Received: from mail-wr0-f172.google.com ([209.85.128.172]:45116 "EHLO
        mail-wr0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033238AbeCARXg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Mar 2018 12:23:36 -0500
Received: by mail-wr0-f172.google.com with SMTP id p104so7374320wrc.12
        for <git@vger.kernel.org>; Thu, 01 Mar 2018 09:23:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=RmagcYc5sQsdujXAQqpPFfGIV5K/3Ifwf3IUPWvCXak=;
        b=iFncmUDX02GcxZsUalvJ6RqBCOKN7nBspxteIOk05TT0GSM51hE01HCDJjm7xngWts
         IJ9FNddWNR2cF8EKMg9JRSshqAouMt3bt4zqn9WqefgQaWbtfubZurFT2HO/M9pz896q
         mgoxi1GoevcSbCrnz4izaje27Zy5XmaX1ClqLqzhf5+Pb2eci3xP9+bUzekMNRfZv6VI
         ewnEVUUYswTiK/uiQBr7hf4NbwRHunkxiWI4eTGwu0GCbpIv4oICOKRJicHTic6jJIZe
         4LHyLt1D2FqSpA+tfF7k4K01z76fFyjDzehk4E2yoKXWdks9YMydMGESQMFmaAjm1D06
         kvNA==
X-Gm-Message-State: APf1xPD2a0lVhFThmahrwQDd5tkEgzLGJJS+cZFDnWaCaVYjDuU+IK3f
        0MXtRZ9oRqIQyHmCo/RQ5dmDEA==
X-Google-Smtp-Source: AG47ELvolMLXgJtPRYb/UGz0vG9cmlXjMjay9A+Dbi6XNt80gYCsKxzoqZ2KuNed7sjLnKHmQLAdwA==
X-Received: by 10.223.135.232 with SMTP id c37mr2344263wrc.168.1519925014463;
        Thu, 01 Mar 2018 09:23:34 -0800 (PST)
Received: from juno.home.vuxu.org ([2001:4ca0:0:f224:a288:b4ff:fea1:ce50])
        by smtp.gmail.com with ESMTPSA id x190sm6453713wme.27.2018.03.01.09.23.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Mar 2018 09:23:33 -0800 (PST)
Received: from localhost (juno.home.vuxu.org [local])
        by juno.home.vuxu.org (OpenSMTPD) with ESMTPA id cf9472b3;
        Thu, 1 Mar 2018 17:23:33 +0000 (UTC)
From:   Leah Neukirchen <leah@vuxu.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH] color: respect the $NO_COLOR convention
References: <87zi3reoez.fsf@gmail.com>
        <xmqqefl3iuvx.fsf@gitster-ct.c.googlers.com>
Date:   Thu, 01 Mar 2018 18:23:33 +0100
In-Reply-To: <xmqqefl3iuvx.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Thu, 01 Mar 2018 09:10:58 -0800")
Message-ID: <87efl3emlm.fsf@vuxu.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Leah Neukirchen <leah@vuxu.org> writes:
>
>> NO_COLOR (http://no-color.org/) is a comprehensive approach to disable
>> colors by default for all tools:
>
> The list of software that supports that "convention" is, eh,
> respectable.  Is it really a "convention" yet, or yet another thing
> the user needs to worry about?

You are right in calling this out an emerging new thing, but the
second list of that page proves that it will be useful to settle on a
common configuration, and my hope is by getting a few popular projects
on board, others will soon follow.  It certainly is easy to implement,
and rather unintrusive.  Users which don't know about this feature are
completely unaffected.

>>  	if (color_stdout_is_tty < 0)
>>  		color_stdout_is_tty = isatty(1);
>>  	if (color_stdout_is_tty || (pager_in_use() && pager_use_color)) {
>
> According to no-color.org's FAQ #2, NO_COLOR should affect only the
> "default" behaviour, and should stay back if there is an explicit
> end-user configuration (or command line override).  And this helper
> function is called only from want_color() when their is no such
> higher precedence setting, which is in line with the recommendation.
>
> Which is good.

Yes, I took care of that.  Should this also be tested?  It doesn't
quite fit into the setting of t4026-color.sh I think.

Thanks,
-- 
Leah Neukirchen  <leah@vuxu.org>  http://leah.zone
