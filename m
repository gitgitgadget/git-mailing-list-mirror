Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E95FE1F404
	for <e@80x24.org>; Sun, 15 Apr 2018 21:54:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751983AbeDOVyM (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Apr 2018 17:54:12 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:46425 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750960AbeDOVyL (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Apr 2018 17:54:11 -0400
Received: by mail-wr0-f195.google.com with SMTP id d1so20794399wrj.13
        for <git@vger.kernel.org>; Sun, 15 Apr 2018 14:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Xt6dvUXs9kza5vcCAhyp+Q8bPbTiMqz5731MXMqp974=;
        b=RlI7fnCpWLWJ1/8QIx2IfpjL8rH8Vau6nPPj0k/Ig06pW+ph4wqVBfbvT7loG+JYJC
         DuAAVxvhNbIKtdHgXDzMDe5UBxq8RW95ooI7uL9hX2bhdo4ZbKifl+TDnkzi7cFBgfpe
         S4fsg+wM2G74Cg7fHLjIL6qpnDOTk3qP41R/D1cxQSLevPJMVN9Gdc191wNaA+lEzTmL
         hXC17BUObQsqNh9qPA4JCK5E9eos1cWbCe5xEMpmms8ocRbMq7Za9ZvIu2EjYZbfH6Xd
         qhdy5MkcrEAYiMuLzWOoJqF8Nfye0ttZDoBhSLdEun+1SJuiJie6yAwhkKgpIoebP5Eg
         aHFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Xt6dvUXs9kza5vcCAhyp+Q8bPbTiMqz5731MXMqp974=;
        b=DI6q6TPuWQoUBiVnWOGwNDzzum6cz3Go42e1nb8moKnM1SP/W2yZTaSSlzW+dEX4Tw
         tQ6jXqCeak2BXnMahQ9aU+319WK6GaGg6QLwmmAExnVTCd8UKTHzzOSphlAG4Y32mDaf
         GzCJGA0j4E04T99sSfRcsb4mKg4ARjPPMRBwn2BJ+skxd7OfUM9odgMIeNQScNNAy8DZ
         JVL38uyYkzCy7/kvXqk82LPlpUASz8QfIpTMi6dJtOMlkLTxUQTapBPrwi8gl4EiGJET
         KK7HSbWTtoF5wxcTDKCkM/0lHQvyOIc9Bgse2Eau48di5crBS2EzOWr1QUGn0bWLnSf6
         vI5w==
X-Gm-Message-State: ALQs6tCYsNyAaoopgYmccw4X6cLBZ6LA8rTKnr9pbeZpSxhg8kfMB3O+
        8s2R1o3bAM5PrnndBwg4VLs=
X-Google-Smtp-Source: AIpwx4/73eTyYYJ52PwvbOmi4ZKlVp1Ty9+T+bQFHSFLE6STngONlgVChMQbHL8us9dtx2v6dElcVg==
X-Received: by 10.223.187.212 with SMTP id z20mr1535796wrg.51.1523829249834;
        Sun, 15 Apr 2018 14:54:09 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id b97sm9077216wrd.64.2018.04.15.14.54.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 15 Apr 2018 14:54:09 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kim Gybels <kgybels@infogroep.be>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] daemon: use timeout for uninterruptible poll
References: <20180412210757.7792-1-kgybels@infogroep.be>
        <20180412210757.7792-2-kgybels@infogroep.be>
Date:   Mon, 16 Apr 2018 06:54:08 +0900
In-Reply-To: <20180412210757.7792-2-kgybels@infogroep.be> (Kim Gybels's
        message of "Thu, 12 Apr 2018 23:07:56 +0200")
Message-ID: <xmqq36zw16gv.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kim Gybels <kgybels@infogroep.be> writes:

> The poll provided in compat/poll.c is not interrupted by receiving
> SIGCHLD. Use a timeout for cleaning up dead children in a timely manner.

I think you identified the problem and diagnosed it correctly, but I
find that the change proposed here introduces a severe layering
violation.  The code is still calling what is called poll(), which
should not have such a broken semantics.

The ideal solution would be to fix the emulation so that it also
properly works for reaping a dead child process, but if that is not
possible, another solution that does not break the API layering
would probably be to introduce our own version of something similar
to poll() that helps various platforms that cannot implement the
real poll() faithfully for whatever reason.  Such an xpoll() API
function we introduce (and implement in compat/poll.c) may take, in
addition to the usual parameters to reall poll(), the value of
live_children we have at this call site.  With that

 - On platforms whose poll() does work correctly for culling dead
   children will just ignore the live_children paramater in its
   implementation of xpoll()

 - On other platforms, it will shorten the timeout depending on the
   need to cull dead children, just like your patch did.

Thanks.


>
> Signed-off-by: Kim Gybels <kgybels@infogroep.be>
> ---
>  daemon.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/daemon.c b/daemon.c
> index fe833ea7de..6dc95c1b2f 100644
> --- a/daemon.c
> +++ b/daemon.c
> @@ -1147,6 +1147,7 @@ static int service_loop(struct socketlist *socklist)
>  {
>  	struct pollfd *pfd;
>  	int i;
> +	int poll_timeout = -1;
>  
>  	pfd = xcalloc(socklist->nr, sizeof(struct pollfd));
>  
> @@ -1161,8 +1162,13 @@ static int service_loop(struct socketlist *socklist)
>  		int i;
>  
>  		check_dead_children();
> -
> -		if (poll(pfd, socklist->nr, -1) < 0) {
> +#ifdef NO_POLL
> +		poll_timeout = live_children ? 100 : -1;
> +#endif
> +		int ret = poll(pfd, socklist->nr, poll_timeout);
> +		if  (ret == 0) {
> +			continue;
> +		} else if (ret < 0) {
>  			if (errno != EINTR) {
>  				logerror("Poll failed, resuming: %s",
>  				      strerror(errno));
