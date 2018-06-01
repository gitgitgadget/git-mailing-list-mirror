Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A44B1F42D
	for <e@80x24.org>; Fri,  1 Jun 2018 01:23:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750842AbeFABXL (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 May 2018 21:23:11 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:43922 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750718AbeFABXJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 May 2018 21:23:09 -0400
Received: by mail-wr0-f194.google.com with SMTP id d2-v6so19261117wrm.10
        for <git@vger.kernel.org>; Thu, 31 May 2018 18:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=awZ6fcm/riy/dSlBh5AwugTADkQIlOcKLxcwJ/jrzJI=;
        b=mIhVjvi/5/efF8iBjuIsGuRcJ1X5TcFw8O2wOfXHHPgyNGW0/rvULYEMxEYGU595DQ
         +FexF5zG5OaudEJ3t1Kjc1R9f7lPKQ2+yygAyxyc5Kfmk/ZjmmiIMW1DI+4lX1hFBNsJ
         TeC9MJMd3OyN28Q078BZ64TFdsrRlBZMJmTQJZbtctK/fKRWNNyUe3qaQrM3G4e8OIgO
         J0JvcvJTHaMO1TPlXUxOzqFO8WSoqJ4wi9L4cb4JMDTCGhOATPNEY3ZLgya5fUSiZA3S
         0+3QowJRJI6KPhWGG8QXB+yZ8aRZURFB7JJU9hTWUQtaUXx053otfDObghQBkYivJys/
         k5yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=awZ6fcm/riy/dSlBh5AwugTADkQIlOcKLxcwJ/jrzJI=;
        b=tzrslNyCVU71oC9Jt8Q8WgWYjHK6UR/kCrhF2NlSyYXvudtYqVRYlxdbN8SiWtgQKH
         X8OaiG2tJORMk0b2klfljhgHlHzKWni08yW2+u2Ib2C/qlUZi9hz267Og6YEe1HMC4L3
         8pRwhhLl/NdmX+KR9bISF+TtHGJ8k4Cy6KY3kXPyglxH+8q2Zm7feCXj8DNxLbJfIuuw
         xSr9B/H0BnngDEPl7aw828koDrFB6sjF8h7xRBA61e1PLSNln4CcFF3MRQiMfPHa9BEf
         E1DML18P9kI9WPCoT9W1nmL8NmnFkejlxt5tDPBD1MYkHFSZ0+CS30CwO4T13auzYovi
         41lQ==
X-Gm-Message-State: ALKqPwfSndjxkrdq6mM3tlF7dunqEJ33JaIQuRVXoAVTn2N8Ez0GvYsc
        t+oXJiHF3PRZKa4IdRu4yxMSzQ2y
X-Google-Smtp-Source: ADUXVKK0ge52UdkCI+ZXQ7d0YaXAkP1W+nhcIszdmRyFfxGnlOqMM9qmoR2cWB1jI1YahlrieJvQng==
X-Received: by 2002:adf:a319:: with SMTP id c25-v6mr6431617wrb.189.1527816187869;
        Thu, 31 May 2018 18:23:07 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id g75-v6sm1351074wmd.15.2018.05.31.18.23.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 May 2018 18:23:06 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     istephens@atlassian.com
Cc:     git@vger.kernel.org, szeder.dev@gmail.com, peff@peff.net,
        bturner@atlassian.com, jacob.keller@gmail.com,
        sunshine@sunshineco.com
Subject: Re: [PATCH v6 2/2] log: prevent error if line range ends past end of file
References: <20180531050030.43364-1-istephens@atlassian.com>
        <20180531050030.43364-2-istephens@atlassian.com>
Date:   Fri, 01 Jun 2018 10:23:06 +0900
In-Reply-To: <20180531050030.43364-2-istephens@atlassian.com>
        (istephens@atlassian.com's message of "Thu, 31 May 2018 15:00:30
        +1000")
Message-ID: <xmqqo9gvb8qt.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

istephens@atlassian.com writes:

> From: Isabella Stephens <istephens@atlassian.com>
>
> If the -L option is used to specify a line range in git log, and the end
> of the range is past the end of the file, git will fail with a fatal
> error. This commit prevents such behaviour - instead we perform the log
> for existing lines within the specified range.
>
> This commit also fixes a corner case where -L ,-n:file would be treated
> as a log over the whole file. Now we treat this as -L 1,-n:file and
> blame the first line of the file instead.
>
> Signed-off-by: Isabella Stephens <istephens@atlassian.com>
> ---
>  line-log.c          | 8 +++++---
>  t/t4211-line-log.sh | 5 ++---
>  2 files changed, 7 insertions(+), 6 deletions(-)

Thanks.  Will queue.
