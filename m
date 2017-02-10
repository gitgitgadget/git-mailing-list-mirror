Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 649781FC46
	for <e@80x24.org>; Fri, 10 Feb 2017 21:04:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932148AbdBJVEM (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Feb 2017 16:04:12 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34450 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932102AbdBJVEL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Feb 2017 16:04:11 -0500
Received: by mail-pg0-f66.google.com with SMTP id v184so3898742pgv.1
        for <git@vger.kernel.org>; Fri, 10 Feb 2017 13:04:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=EdT6sS3MRuq1ESbW5nAQ7esFXs4wWOXFwT+t6zj5whc=;
        b=mASR/EpKr1Q2BmvcMGFqsvMXHv8p4grEcWC5+QmYQiM8xDlXtEdkE5bYchE4rWQq5C
         ET66A1ThvusgTZacflUHb5NhyQD8qXkcubD143kr8kTnvoXVRc3gVtgkITmMPMEwWwa2
         6cGOOqLFW4VISwYIhGnws5CMw0r5d2KxRPUNJIloADS6wkrAwsbciLenD8gXF7j+thG2
         I2cdpy5jXi+De6nTX65bgvoGiic40UdLFjk19LXifz+Wg84fXoeHNwdI5SU3ObQl6z6G
         5ZcSd93caED0PAo+Umd71cO51RRcpO+bNpAyNhIH9FU0vsLa6s4x3OdWxOE7Inz0cski
         gikA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=EdT6sS3MRuq1ESbW5nAQ7esFXs4wWOXFwT+t6zj5whc=;
        b=CxRco95QjLgFm374OP/R8dzMqhUXghHSw7p8MoEI3wpM8hyIq+7bXnhOQfM87i2J2B
         7cPBE3UNNJSYuzNLOJhIukKydhh852H7Pqfyzo8P48RWOdwhOzTThSeXZBj4YeklEeG0
         JTEyzT8Y0FEmOqxSPPLm1HKCZm6WTLO5Fvl1gbbrvCg1fHpcc7ReX2lFcOoJ7vKlXHTG
         clpAMr32hw+ZIJ8bZ+eI9VTEEalk36AfO2gtsiT51OuLcFzkrlJ9v+hFeIWaKh0Y7bO7
         /hQ2EP09fPn/iDEC2LmBu2zqomgKVl61JVzyk3j2mK0xGie1pDG4Uh9w6Odlu92+qao6
         +CPA==
X-Gm-Message-State: AMke39lnUSJjAeqoUoGbPkiuDFQBuT0CIopQbUBeD5hsyJocCBQdAi8yGAxAZrOvk9yi4Q==
X-Received: by 10.98.201.135 with SMTP id l7mr12329307pfk.67.1486760650763;
        Fri, 10 Feb 2017 13:04:10 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:8499:2e0a:2c80:2b60])
        by smtp.gmail.com with ESMTPSA id x2sm7309445pfa.71.2017.02.10.13.04.09
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 10 Feb 2017 13:04:10 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     David Turner <David.Turner@twosigma.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        "pclouds\@gmail.com" <pclouds@gmail.com>
Subject: Re: [PATCH v3] gc: ignore old gc.log files
References: <20170210192019.13927-1-dturner@twosigma.com>
        <20170210200838.kuwpldsgzvkjlmri@sigill.intra.peff.net>
        <7852bf6688ed487097d4f997ac72dcba@exmbdft7.ad.twosigma.com>
        <20170210205138.5nnexap32pkbjjrk@sigill.intra.peff.net>
Date:   Fri, 10 Feb 2017 13:04:09 -0800
In-Reply-To: <20170210205138.5nnexap32pkbjjrk@sigill.intra.peff.net> (Jeff
        King's message of "Fri, 10 Feb 2017 15:51:38 -0500")
Message-ID: <xmqqlgtdkbau.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I dunno. This seems like a lot of manual scrambling to try to overcome
> unlikely errors just to make our stderr heard (and we'd still fail in
> some cases). It seems like:
>
>   if (fstat(...)) {
> 	/* weird, fstat failed; try our best to mention it */
> 	error_errno("unable to fstat gc.log.lock");
> 	commit_lock_file(&log_lock));
>   } else if (st.st_size) {
> 	/* we have new errors to report */
> 	commit_lock_file(&log_lock);
>   } else {
> 	/* no new errors; clean up old ones */
> 	unlink(git_path("gc.log"));
> 	rollback_lock_file(&log_lock);
>   }
>
> would be sufficient.

Yeah, that should be sufficient.
