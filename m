Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6024620873
	for <e@80x24.org>; Mon, 14 Nov 2016 21:10:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753671AbcKNVJ5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Nov 2016 16:09:57 -0500
Received: from mail-wm0-f48.google.com ([74.125.82.48]:32995 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752729AbcKNVJz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Nov 2016 16:09:55 -0500
Received: by mail-wm0-f48.google.com with SMTP id c184so16837244wmd.0
        for <git@vger.kernel.org>; Mon, 14 Nov 2016 13:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:content-transfer-encoding:subject:message-id:date:to
         :mime-version;
        bh=IXwFdBH7+0VkKT7QJQMpCgoyQZDkXdwZmWHFj3nth0I=;
        b=urPT1cAKQI227tw2MeD/g9xlR+73hdNlqOWTKe2dQDG09WhgJ5TRqo2RR0CkVTIgBr
         VivbYYSki63xxpdJbJ9dlxNeoUaRW9I2FaRhcxb7mQKN/V50a4wHRlQDDsO6XsQAWTB5
         65yG9OEOXiMJy6fWQ+92ECy9dS2u1egUGnxKkRGzNLVH6toWzwQfdRe/4B2NrOMctakt
         V0VQ6xZ8PWlDGLoPTq607Hh/qdo4q7MdhUbouuM6BykRwmvaHxjxK6IdwTrRRxGVL544
         LQSKeKudq4BZiTAZqHWT9qufutPDIghihEcFUdb80YTUBqyLZP76qv50QTuaINX9EyVY
         66tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:content-transfer-encoding:subject
         :message-id:date:to:mime-version;
        bh=IXwFdBH7+0VkKT7QJQMpCgoyQZDkXdwZmWHFj3nth0I=;
        b=aFOB9qPnkgRYFFupC5q59tLE+v2neFBA6D8YVUn2k5DEuhYArSLUSUf7R2Crft1Aar
         neqJnplWLhESqbIzZF3qEBrYGg72/37OOoCiyPve5zNKNeKBqeYuyx9rFz2V4peBGtZP
         W6qrfcoSab7uJXbh2m2jY7KaNWezDxiUzkOp6dyZxwzeWEFjE4wJ4SKOlK1Se8jWtyxo
         7xXkCiBl8lCNT1BkN6q4S7cRvgDanHlNR3MyPTExLZ0Vh0MD6M4H0hJWK1OsYHOH07LV
         +Jp5jTGDiumsfbRiJm/aWKERc5h6TSb+HjEI3HyryoIpH+TAbfF9imkeDrV+zbDf83mx
         4jjg==
X-Gm-Message-State: ABUngvc8yR+q8d5OVMrXAX6AN7b1tz4lAkWPz4AhtkFbXhJzQpOXDqTXK134v9RVKoUTlw==
X-Received: by 10.28.209.7 with SMTP id i7mr364655wmg.62.1479157793751;
        Mon, 14 Nov 2016 13:09:53 -0800 (PST)
Received: from slxbook3.fritz.box (p5DDB4C1A.dip0.t-ipconnect.de. [93.219.76.26])
        by smtp.gmail.com with ESMTPSA id jq10sm30737275wjb.46.2016.11.14.13.09.52
        for <git@vger.kernel.org>
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 14 Nov 2016 13:09:53 -0800 (PST)
From:   Lars Schneider <larsxschneider@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Subject: RFC: Enable delayed responses to Git clean/smudge filter requests
Message-Id: <D10F7C47-14E8-465B-8B7A-A09A1B28A39F@gmail.com>
Date:   Mon, 14 Nov 2016 22:09:56 +0100
To:     Git Mailing List <git@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Git always performs a clean/smudge filter on files in sequential order.
Sometimes a filter operation can take a noticeable amount of time.=20
This blocks the entire Git process.

I would like to give a filter process the possibility to answer Git with
"I got your request, I am processing it, ask me for the result later!".

I see the following way to realize this:

In unpack-trees.c:check_updates() [1] we loop through the cache=20
entries and "ask me later" could be an acceptable return value of the=20
checkout_entry() call. The loop could run until all entries returned
success or error.

The filter machinery is triggered in various other places in Git and
all places that want to support "ask me later" would need to be patched=20=

accordingly.

--

Do you think this could be a viable approach?
Do you see a better way?

Thanks,
Lars


[1] =
https://github.com/git/git/blob/3ab228137f980ff72dbdf5064a877d07bec76df9/u=
npack-trees.c#L267

