Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 02FA820254
	for <e@80x24.org>; Thu, 23 Feb 2017 23:50:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751533AbdBWXue (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Feb 2017 18:50:34 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:32906 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751487AbdBWXue (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2017 18:50:34 -0500
Received: by mail-pf0-f196.google.com with SMTP id p185so176413pfb.0
        for <git@vger.kernel.org>; Thu, 23 Feb 2017 15:50:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Wqymc+moEt5wJXV5eFfpHT/qHxobPMQnYx0g7VgGA1U=;
        b=BKzULyPUJRzK46sQEjwMKI/V6DP77j4tLr5qxyXEC4zJ+r1ZD1+3ssNjAmTbXTmn/9
         F6OmFTVQWAXJAIJktKPqzllTS/iZM80EJkxBNbGRfxJ0J4qWHQFWjpt7l+PtZ2QXUk7i
         fDUUl49q1VKisxj227bavl0hgNp1QoQiXN0VnhCxykYIzMqVjOrbcRSx16ugy/pN7wrQ
         6Q6vv6T4oXoG+pa3Hr1xwTBH8CFas6kc+1NDhvbxVSlQGw9nVmpTZMsJnbQfr2bnxsNJ
         4nAfP4rO8R/MJDcdR0emcho+p2zeCNDP1gzIhOJ3E9qgt3mWcjAqfL2spaDZMYntZxLh
         X+hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Wqymc+moEt5wJXV5eFfpHT/qHxobPMQnYx0g7VgGA1U=;
        b=IaNu/o7vew+HYnqrwQFi7ttk/TQYII1sHahUDaOxVditT6lIpVOo8RQxAoXrC7FMzQ
         Qn8TtJDVraqIQr8n04O8zhe6PRI4zP7dtJcUVuYzbhSPJWkj7zEy4rZXyDlWTOn51FEs
         bJ+ZvBo5aj6mxGFmw+V1R3ea5kUAc6ZgDFcyGiIutJaIe6wUfP4wFMPoStRHI5GQNO7h
         tcfgqMKePF9k9Ndpyige4NGG6a/fQLasbGqPw4medy0CEsmHJ13NMJaXEVWrxAzOuk9v
         utzXHtYmO7wi6ov23SaMmcZheO5rIaQERMaAHjOaShgTJvCE0Dgx7WAA6XcJaU/AGmq0
         iLbw==
X-Gm-Message-State: AMke39klmNnJMc4AidGfx0saFIX4J541Y5Rmbtpa0g/PTKkLl7YhbNtu+usA+zFxu11fuQ==
X-Received: by 10.98.57.23 with SMTP id g23mr5165704pfa.32.1487893801767;
        Thu, 23 Feb 2017 15:50:01 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:8829:f260:c132:141f])
        by smtp.gmail.com with ESMTPSA id r22sm6661590pfi.51.2017.02.23.15.50.00
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 23 Feb 2017 15:50:00 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, peff@peff.net, peartben@gmail.com,
        benpeart@microsoft.com
Subject: Re: [BUG] allowtipsha1inwant serves unreachable blobs if you know its hash
References: <20170223230358.30050-1-jonathantanmy@google.com>
Date:   Thu, 23 Feb 2017 15:50:00 -0800
In-Reply-To: <20170223230358.30050-1-jonathantanmy@google.com> (Jonathan Tan's
        message of "Thu, 23 Feb 2017 15:03:58 -0800")
Message-ID: <xmqqtw7k5uxj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> Adding "--objects" works, and all existing tests pass, except for the
> potential performance issue and the side effect that even fetching a
> reachable blob no longer works. This is due to a possible bug where a
> call like "git rev-list --objects $tree ^master" (where $tree is the
> tree object corresponding to master) prints out objects ...

The "reachable from this, excluding what is reachable from that"
notation was originally designed to work only on commits, and I
wouldn't be surprised if "$tree ^master" did not work as you expect
in the current implementation.

I agree that ideally it shouldn't show anything, but I suspect that
it would make it very expensive if done naively---we'd end up having
to call mark_tree_uninteresting() for all uninteresting commits, not
just for the commits at the edge of the DAG as we do right now.
