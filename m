Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3F7DC77B76
	for <git@archiver.kernel.org>; Mon, 17 Apr 2023 09:53:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbjDQJxy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Apr 2023 05:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjDQJxw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2023 05:53:52 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1DC86A6E
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 02:53:26 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id p8so25077149plk.9
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 02:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681725103; x=1684317103;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=0kM7UmJ5JeF+jqvkLKJSOm5So18AYUBjKnOwUU2lG7g=;
        b=QNRdbWj5ZDBeVHMSfRenbnWRkY2epBFgpRlh8+FSCVwfYYbwdOhfGa0rPjcWOfgn06
         GfVw90hA/KpcYCs/atU76HgbuqMZZjfqUspDwgu+KKn9vNPib2wJFijU/mAOxPI0wFCd
         CXZRMegwp8VeVt/wIqqfPn39mZVYkXRnE5Ty260d9P2CVb5zWRhvG2G0TrFPFsvRYDVG
         QMS0aO26kfVCYCNA2jUl4xRjmED0J1l32mHIhsoa1VIsdmmMfvw9kYxZKGckf9rAV6+7
         PG0ngRvQhpAFm8F34bDvexEQsWguMYjw2tTAbsV1Gos0mN06/7IDWZJ7oAlMzsfxuwjV
         /IJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681725103; x=1684317103;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0kM7UmJ5JeF+jqvkLKJSOm5So18AYUBjKnOwUU2lG7g=;
        b=dtoQJgxKDPG6MyKjbQ/CwwxKLyOafry+UGFR5XMYDxZXnb6+gs8AZ4YyFavIEHx6E9
         HLq0RBFK/sMFlNHuFlyBSAvRR07QhToj0CzAmW2krdSfT6TwwFnWLJEjGjUOTMtBgJ1/
         unmFD7I5hC2/vPtVfhjq9OZk5Dy9DZ6dri7UKCzpqBIhMXqkpMFWUP7GVU6tUhf0AXk9
         aBI2i9GDIpFb8dcJX3BhLjY8szYxhNviwbskdMmhFztz8hTQxvt/eHP77P3WcQN6z9WM
         ZDY4ERUFwt6kwZzF7L+KlUFl5Sw1sygIwlLHy8kbKPQDT4VeuBFA/lpc8lqttfHAQax3
         KZWQ==
X-Gm-Message-State: AAQBX9c68Zwa2mbOq4b09VEk9UQy2MjXXpNWSgNTLK+M88LCQAacVV29
        KkqUDQcqWSzg3ru4xkdi9jpMiNIk7qA=
X-Google-Smtp-Source: AKy350a+k4UqfIg0pEdhhWsUkZWdfd+PFsuy483wOfgbQem+91f7F2VHWy41os4VeAvGXKpPortg6w==
X-Received: by 2002:a17:903:11cc:b0:1a6:bbf4:ed79 with SMTP id q12-20020a17090311cc00b001a6bbf4ed79mr8119854plh.20.1681725103283;
        Mon, 17 Apr 2023 02:51:43 -0700 (PDT)
Received: from localhost (170.102.105.34.bc.googleusercontent.com. [34.105.102.170])
        by smtp.gmail.com with ESMTPSA id z18-20020a170902ee1200b0019f27fd7cecsm7299625plb.197.2023.04.17.02.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 02:51:42 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Thomas Bock <bockthom@cs.uni-saarland.de>, git@vger.kernel.org
Subject: Re: Weird behavior of 'git log --before' or 'git log --date-order':
 Commits from 2011 are treated to be before 1980
References: <7728e059-d58d-cce7-c011-fbc16eb22fb9@cs.uni-saarland.de>
        <20230415085207.GA656008@coredump.intra.peff.net>
Date:   Mon, 17 Apr 2023 02:51:42 -0700
Message-ID: <xmqqa5z6q1jl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> There may be also cases where the two diverge. Obviously having two
> parsers isn't ideal. I think sharing the code may involve a lot of work,
> though. The pretty-print parser is interested in pulling out more
> information, and is less focused on performance. Parsing commits is
> traditionally a hot path, as we historically had to parse every commit,
> even if we weren't showing it (including non-log operations like
> computing merge bases, reachability, and so forth).
>
> But that may not matter so much. One, we already inflate the whole
> commit object, not just the header. So even if we spend a few extra
> instructions on parsing, it may not be noticeable. And two, these days
> we often cache commit metadata in the commit-graph files, which avoids
> loading the commit message entirely (and thus this parsing) for most
> operations.

Makes readers wonder which parser is used to parse commit objects in
order to populate the commit-graph files.  If that step screws up,
we'd record a broken timestamp there X-<.



