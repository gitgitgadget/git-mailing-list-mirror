Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 606F3208EB
	for <e@80x24.org>; Mon,  6 Aug 2018 18:59:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732682AbeHFVJb (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Aug 2018 17:09:31 -0400
Received: from mail-wr1-f43.google.com ([209.85.221.43]:42334 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729861AbeHFVJb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Aug 2018 17:09:31 -0400
Received: by mail-wr1-f43.google.com with SMTP id e7-v6so13334801wrs.9
        for <git@vger.kernel.org>; Mon, 06 Aug 2018 11:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=EZLKmzZ5R3a3kdRSOfKE0wgPUWBEGr8YY3t1t13zp3M=;
        b=Vq4Aef129A7g6EfY8TkXoarhQ9aVIBQxCEYnx7Ertevdej3lSp9sAfa5RftqtpjBeN
         IgdtcxtV7x6gH9NmlqeveAJunDxIBv/8u/yZGGTyxwFvmV7ax1ZRePNpP3QX2HhFCzoX
         8e4FpcRAPFp9iO61+1XSedpJW5aAq0/7h09waJUkWeELVd7p5kpYzAfi433lTKnLtHU+
         zcRpQhgqOngfGZDQEG53m/gjCI2V/8TVwp+PqlRsofqrLMJPn8f2haXFO8cTKt49yZ7D
         jMD9Bwy9pDGXO7F86wLTh8r+dJptbsFDBq9i4jiTZCu5XlbJf0FXD2xlv7YOGBmumzZp
         Y6cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=EZLKmzZ5R3a3kdRSOfKE0wgPUWBEGr8YY3t1t13zp3M=;
        b=CtKVAdHnVNDkPM9Lhke0IAbuTNeJY+zsgE2Yh7VlPaAwBQ6VQLTk4sE1RO+I3qBWwE
         ylNyVinL1Cd4Q/li/1CPJT4r1X5ajpPN2Kn8YBcCy0tFkjMQCuiaHWdkZA/Q7XfEcFA/
         /K3H/AiVCvBOiRv3VFeIvVFe3KIa0/wkObzDasAJBE8M6HqF1MgFLjZw+V351FM9grYM
         L6n9eVXelcgZnwLKv7clZ6s150HvmtbOfKiF+B/ystvvgz0vfXFQWFSCPGuMHALU9psH
         WnIIXJuJcl16YsoSPdIG18Jy/iXF9tervt2yQaYh4/WNXflgyPaNgzlANs//baz30jyE
         cBeQ==
X-Gm-Message-State: AOUpUlFEZ82QrXfGuwzF/h4KD+EbpI/8phh8vmiuBxeOVYoKEWAQlxQm
        XhOWGtU3sCFWKz/5kIPIQiw=
X-Google-Smtp-Source: AAOMgpdsKZGOEfQHrQO410jj6bkYQ9978R+zW5O2VxhzSdzzr2tlncn3yafJ9z2GkmlbJkoVJ0Blwg==
X-Received: by 2002:adf:94e2:: with SMTP id 89-v6mr10215379wrr.48.1533581943064;
        Mon, 06 Aug 2018 11:59:03 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 8-v6sm16279797wmw.34.2018.08.06.11.59.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Aug 2018 11:59:02 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Ben Peart <Ben.Peart@microsoft.com>,
        Git Mailing List <git@vger.kernel.org>,
        Ben Peart <peartben@gmail.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 0/4] Speed up unpack_trees()
References: <20180729103306.16403-1-pclouds@gmail.com>
        <20180804053723.4695-1-pclouds@gmail.com>
        <xmqq7el3qywq.fsf@gitster-ct.c.googlers.com>
        <CACsJy8CzuxjjLyf637dtTHc1wK-UFVnNjwa0O300kYOWehz1vA@mail.gmail.com>
Date:   Mon, 06 Aug 2018 11:59:01 -0700
In-Reply-To: <CACsJy8CzuxjjLyf637dtTHc1wK-UFVnNjwa0O300kYOWehz1vA@mail.gmail.com>
        (Duy Nguyen's message of "Mon, 6 Aug 2018 17:59:28 +0200")
Message-ID: <xmqqr2jbnwy2.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> We require the unpacked entry from all input trees to be a tree
> objects (the dirmask thing), so if one tree has 't' as a file,

Ah, OK, this is still part of that "all the trees match cache tree
so we walk the index instead" optimization.  I forgot about that.

